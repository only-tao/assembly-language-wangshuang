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
   mov bx,8
   mov ax,b
   mov es,ax
    mov cx,8
    mov ax,cc
    mov ss,ax
    mov sp,8
cycle:
    mov ax,0
   add al,es:[bx]
   add al,[bx]
    ; mov ss
    ; mov cc:[bx],ax
   sub bx,1;
   loop cycle
   mov ax,4c00
   int 21h
code ends
end start