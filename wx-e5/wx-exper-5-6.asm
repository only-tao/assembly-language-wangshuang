assume cs:code
a segment
    dw 1,2,3,4,5,6,7,8,9,0ah,0bh,0ch,0eh,0fh,0ffh
a ends; push the 8 of a reversely to b
b segment
    dw 0,0,0,0,0,0,0,0
b ends
code segment
start:
    mov ax,a
    mov ds,ax
    mov bx,0

    mov ax,b
    mov ss,ax
    mov sp,16

    mov cx,8
reverse:
    mov ax,[bx]
    push ax
    add bx,2
    loop reverse
    mov ax,4c00
    int 21h
code ends
end start