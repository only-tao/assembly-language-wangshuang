DATAS SEGMENT
    A db 100 dup(?);第一个数
    B db 100 dup(?) ;第二个数
    count db ?;记录最大位数
    temp db ?;进位标志位
    len1 db 0;记录A的位数
    len2 db 0;B的位数
DATAS ENDS
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov es,ax
    xor ax,ax
in1:   ;A数组的输入
    mov ah,1
    int 21h
    sub al,'0' ; 输入的信息到al    01号21中断
    cmp al,0;判定输入的字符是否是0-9
    jl @F ; x<0 bad
    cmp al,9
    jg @F ; x>9 bad
    push ax ; storage the number
    inc len1 ; 输一个数，长度加1
    jmp in1 ; 又输入一次
@@:

    mov dl,10

    mov ah,2

    int 21h

    mov dl,13

    mov ah,2

    int 21h

    lea di,A

    mov cl,len1

@@:  ;将数组A倒置

    pop ax

    mov [di],al

    inc di

    loop @B

    xor ax,ax

in2:   ;输入B数组

    mov ah,1

    int 21h

    sub al,'0' ;判定输入的字符是否是0-9

    cmp al,0

    jl @F

    cmp al,9

    jg @F

    push ax

    inc len2

    jmp in2

@@:

    mov dl,10

    mov ah,2

    int 21h

    mov dl,13

    mov ah,2

    int 21h

    lea si,B

    mov cl,len2

@@:    ;将数组A倒置

    pop ax

    mov [si],al

    inc si

    loop @B

    mov bl,len1

    mov al,len2

    mov count,bl  ;比较出最大位数，并将位数小的数组在高位补0，直到位数相等

    cmp bl,al

    jz sa

    jg xy

    mov count,al

    sub al,bl

    mov cl,al

@@:

    mov [di],0

    inc di

    loop @B

    jmp sa

xy:

    sub bl,al

    mov cl,bl

@@:

    mov [si],0

    inc si

    loop @B

sa:

    mov cl,count

    lea di,A

    lea si,B

    mov temp,0;设置进位标志

    clc

fg:   ;2个数组add

    mov bl,[si]

    cmp temp,1

    clc

    jnz p3

    stc

p3:

    mov temp,0

    adc bl,[di]

    cmp bl,10

    jl p2

    sub bl,10

    mov temp,1

p2:

    push bx

    inc di

    inc si

    loop fg

    cmp temp,1

    jnz p1

    mov bl,1 ;最高位有进位，加1位并置1

    push bx

    inc count

p1:

    mov cl,0

@@:  ;清除前面多余的0

    pop ax

    inc cl

    cmp cl,count

    jz @F

    cmp al,0

    jz @B

@@:

    push ax

    dec cl

    sub count,cl

    mov cl,count

@@:  ;结果输出

    pop dx

    add dl,'0'

    mov ah,2

    int 21h

    loop @B

    MOV AH,4CH

    INT 21H

CODES ENDS

END START