data segment   
        mess1 db 'ehljdsf',0dh,0ah,'$'
        crlf     db     0dh,0ah,'$'
        mess2 label  byte
        max1 db 21
        act1 db ?
        str db 21 dup(0)
data ends 
code segment
        assume cs:code,ds:data
start:
        mov ax,data
        mov ds,ax

        ; mov bx,0

        lea dx,mess1;ehljdsf','$'
        mov ah,09h
        int 21h

        lea dx,mess2
        mov ah,0ah
        int 21h

        lea dx,crlf
        mov ah,09
        int 21h

        mov ah,01
        int 21h

lea dx,crlf
        mov ah,09
        int 21h
        add aZ
        MOV DL,al; 02号中断 打印字符
        MOV AH,2
        INT 21H

        mov al,act1
        mov ah,0
        mov si,ax
        mov str[bx+si],'$';末尾加上'$'

        lea dx,str
        mov ah,09H;打印 str[...]
        int 21h

        mov ax,4c00H
        int 21h
code ends
end start