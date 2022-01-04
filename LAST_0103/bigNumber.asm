DATAS SEGMENT
    A db 100 dup(?);第一个数
    B db 100 dup(?) ;第二个数
    count db ?;记录最大位数
    carry db ?;进位标志位
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
    jl endInputA ; x<0 bad
    cmp al,9
    jg endInputA ; x>9 bad
    push ax ; storage the number
    inc len1 ; 输一个数，长度加1
    jmp in1 ; 又输入n次
endInputA:; end input A
    lea di,A
    mov cl,len1 ; 循环次数设置 set loop times 
c10:  ;将数组A倒置
    pop ax               ; 一个loop 实现复制
    mov [di],al ; di->A     A[di] <= al
    inc di    ; 12345    =>   54321 in A
    loop c10  ;previous @@  计算的时候正常算就好了
    ; 真tm sb !!!! @S@B@F@U@C@K@
    xor ax,ax
in2:   ;输入B数组
    mov ah,1
    int 21h
    sub al,'0' ;判定输入的字符是否是0-9
    cmp al,0
    jl endInputB
    cmp al,9
    jg endInputB
    push ax
    inc len2 ;几乎是相同的功能只是，换了len2,in2 !!!! 
    jmp in2
endInputB:; process B[]
    lea si,B; 一个使用 di,一个使用si, 这是需要记住的? si,di只是存储了地址而已
    mov cl,len2
e10:;将数组B倒置
    pop ax
    mov [si],al
    inc si
    loop e10
    ;! begin add the two number
    mov bl,len1
    mov al,len2; B
    mov count,bl  ;比较出最大位数，并将位数小的数组在高位补0，直到位数相等
    cmp bl,al
    jz sa ; bl = al
    jg xy ; bl > al
    mov count,al; al > bl now len(B)>len(A)
    sub al,bl
    mov cl,al; loop times
@@:
    mov [di],0 ; A 的最后一位的next(实际上是倒着的)  A -- len1 -- di -- 
    inc di  ;A高位补0, 
    loop @B
    ;A = 12345+00 
    ;B = 1234567
    ;  
    jmp sa; 已经有了相同的位数，但是现在还是反的，可以进行运算了
xy:

    sub bl,al

    mov cl,bl

@@:

    mov [si],0

    inc si

    loop @B

sa:
    mov cl,count; 相同的位数 -> 每次运算的轮数
    lea di,A
    lea si,B
    mov carry,0;设置进位标志
    clc;CF清零
fg:;2个数组add ! count one
    mov bl,[si]
    cmp carry,1
    clc
    jnz p3; 无进位则to p3 |  carry=1 ?  =1 -> next
    stc; cf=1?
p3:
    mov carry,0
    adc bl,[di]; bl=bl+[di] ; here use CF  !!!!!!!!!!!!!!!!!!!
    cmp bl,10 ; (16进制的+,但是不重要)
    jl p2 ; no carry 
    sub bl,10
    mov carry,1; 再进一个10
p2:
    push bx ;00bl 结果入栈，
    inc di
    inc si; next position
    loop fg; loop up ↑
;*********end add two***********
    cmp carry,1; 最高位的进位1!!!
    jnz p1; not == 1,jump p1
    ; carry==1 ↓
    mov bl,1 ;最高位有进位，加1位并置1
    push bx;bx go to stack
    inc count; len ++;
p1:
    mov cl,0
e15:  ;清除前面多余的0(真的需要这一步???)
    pop ax; answer to ax !!! 
    inc cl
    cmp cl,count
    jz f10; 如果已经存完了,cl==count,jump to f10
    cmp al,0
    jz e15 ; 此位==0,back ???  应该是从最开始的不为0的数开始!!!
f10:  
    push ax ; 再存回去
    dec cl  ;TODO don't know about it !!! 
    sub count,cl
    mov cl,count ;?有几个还是几个 ???
print:  ;结果输出  还是倒的,no problem
    pop dx
    add dl,'0'
    mov ah,2    ; 02号 int 21 interrupt  out character
    int 21h
    loop print

    MOV AH,4CH
    INT 21H
CODES ENDS
END START
