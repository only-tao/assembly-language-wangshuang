datarea segment 

  str label BYTE
  max1 db 20
  use db ? 
  str_ db 20 dup(?)
  
  crlf db 0dh,0ah,'$'
datarea ends

code segment
    assume cs:code,ds:datarea
start:
    mov ax,datarea
    mov ds,ax
c10:
    lea dx,str
    mov ah,0ah
    int 21h

    lea dx,crlf
    mov ah,09h
    int 21h
    
    lea bx,use
    mov BYTE PTR al,[bx]; 注意只能是 byte 而不是 word, 因为设置str的就是byte
    mov ah,0
    mov bx,ax
    mov str_[bx],'$'; str_ 末尾加上 '$'
    ; 输出字符串
    lea dx,str_
    mov ah,09
    int 21h

    mov ax,4c00h
    int 21h
code ends
end start

