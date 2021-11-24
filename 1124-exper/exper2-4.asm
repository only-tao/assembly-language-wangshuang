datasg segment
    mess1 db 'Input name:','$'
    mess2 db 'Enter Sentence:','$'
    mess3 db 'Match at location:','$'
    mess4 db 'No match.',13,10,'$'
    mess5 db 'H of the sentence',13,10,'$'
    mess6 db 13,10,'$'
    use_tab db '1'
    tel_tab db 50 dup(28 dup(' ')),'$'
    keyword label byte
        max1 db 20
        act1 db ?
        kw db 20 dup(?)
    sentence label byte
        max2 db 120
        act2 db ?
        sen db 120 dup(?)
datasg ends
    ; lea dx,mess1
    ; mov ah,09
    ; int 21h         ;调用09号中断输出mess1
codesg segment
    assume cs:codesg,ds:datasg,es:datasg
main proc far   ;
start:
    push ds
    xor ax,ax
    push ax
    mov ax,datasg   ; datasg 会随机给他分配一个地址，然后我们将其送入ds (数据段)
    mov ds,ax
    mov es,ax
    lea ax,use_tab
    mov bx,ax
    mov [bx],'1'
    
    lea ax,use_tab
    mov bx,ax
    mov dl,[bx]
    mov ah,02 
    int 21h

    call code2seg; print tips
    call input_name
    call stor_name
    mov ax,4c00h    
    int 21h
exit: 
    ret
main endp
code2seg proc near ;! print mess1
    lea dx,mess1
    mov ah,09
    int 21h
    lea dx,mess6    ;换行/回车
    mov ah,09
    int 21h
return: 
    ret
code2seg endp

input_name proc near
    ; read the input name 
    lea dx,keyword
    mov ah,0ah
    int 21h         ;调用0a号中断进行keyword的输入
    lea dx,mess6    ;换行/回车
    mov ah,09
    int 21h   
    mov bl,keyword+1 ; 输出keyword 中的内容看看
    mov bh,0
    lea si,keyword+2; data
    mov [si+bx],'$'
    lea dx,keyword+2; keywork+2 is really the DATA
    mov ah,09  
    int 21h
                        ; 2号中断 是逐个显示字符
    lea dx,mess6    ;换行/回车
    mov ah,09
    int 21h
input_return:
    ret
input_name endp     

stor_name proc near; 将 keyword 存入 tel_tab
    
stor_return:    
    ret
stor_name endp
codesg ends
end start
