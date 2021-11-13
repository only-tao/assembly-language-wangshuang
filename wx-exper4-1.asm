assume cs:code
code segment
    mov ax,0020h
    mov ds,ax
    mov bx,0
    mov cx,63
s:
    mov [bx],bl;
    inc bx;
    loop s
    mov ax,4c00h
    int 21h
code ends
end
; assume cs:code
; code segment
;     mov ax,0ffffh
;     mov d