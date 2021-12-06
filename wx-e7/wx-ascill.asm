;输出字符串 与 crlf ah09 int21h
data segment
    basi db 'BasIc','$'
    info db 'infoRmAtiON','$'
    crlf db 0dh,0ah,'$'
    tt label byte 
    numm db 10
    use db ?
    tts db 10 dup(0)
    ; => tt db 11,?,10 dup(?),'$'
data ends
code segment
    assume cs:code,ds:data

start:
    mov ax,data
    mov ds,ax
    mov bx,0
    mov cx,5
c10: 
    mov al,[bx]
    and al,11011111B
    mov [bx],al; BIG to small
    inc bx;
    loop c10
    mov cx,11
    inc bx
e10:; 直接顺着就好了
    mov al,[bx]
    or al,00100000B
    mov [bx],al
    inc bx;
    loop e10
f10:; print all
    ; lea dx,basi
    mov dx,offset basi
    mov ah,09
    int 21h

    lea dx,crlf
    mov ah,09
    int 21h

    ; mov bx,5
    lea dx,info
    mov ah,09
    int 21h
    
    lea dx,crlf
    mov ah,09
    int 21h

    lea dx,tt
    mov ah,0ah
    int 21h

    lea dx,crlf
    mov ah,09
    int 21h

    ; mov bx,0; ??? 
    ; mov si,0; ??? 
    lea bx,tts
    mov [bx+10],'$'
    mov al,[bx-1]
    mov ah,0
    add al,1
    mov [bx-1],al ;???????????????

    lea dx,tts
    mov ah,09
    int 21h


    mov ax,4c00h
    int 21h
code ends
end start