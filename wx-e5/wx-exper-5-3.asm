assume cs:code,ss:cc
a segment
    db 1,2,3,4,5,6,7,8
a ends
b segment
    db 1,2,3,4,5,6,7,8
b ends
cc segment
    db 0,0,0,0,0,0,0,0
cc ends
code segment
start:
    mov ax,a
    mov ds,ax
    
    mov bx,0
    mov cx,8
    
    mov ax,cc
    mov es,ax
    
    mov ax,b
    mov ss,ax
    mov sp,0
cycle:
    mov ah,0
    mov al,ds:[bx]
    mov dl,ss:[bx]
    add al,dl
    mov es:[bx] ,al
    ; push ax;
;    add sp,1
;    mov ss:[bx],ax
    ; mov cc:[bx],ax
    inc bx;
    loop cycle

    mov ax,4c00
    int 21h
code ends
end start