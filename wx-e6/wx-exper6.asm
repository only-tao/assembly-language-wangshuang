assume cs:code,ds:data,ss:stack
data segment
    db '1. display      '
    db '2. brows        '
    db '3. replace      '
    db '4. modify       '
data ends
stack segment
    dw 0,0,0,0,0,0,0,0
stack ends
code segment
start:
    mov ax,data
    mov ds,ax
    mov bx,0

    mov ax,stack
    mov ss,ax
    mov sp,14

    mov cx,4
s:
    push cx
    mov si,0
    mov cx,3
s1: 
    mov al,[bx+si+3]
    and al,11011111b
    mov [bx+si+3],al
    inc si
    loop s1
    
    add bx,16
    pop cx
    loop s

    mov ax,4c00h
    int 21h


code ends
end start