data segment
str1 db 'Happy   '
str2 db 'Love    '
str3 db 'Marriage'
str4 db 'Hate    '
data ends
code segment
	assume cs: code, ds: data
main proc far
start:
;以下程序实现接收单个字符输入，
;统计数据段中已有4个字符串中包含有输入字符的串的个数并显示出来
	push ds
	sub ax, ax
	push ax
	mov ax, data
	mov ds, ax
	mov es, ax			; 1)
	
	mov ah, 01h			; 2) 输入到al
	int 21h
	mov bx, 0
	mov dl, 0
search:
	mov cl, 3			; 3)
; ! al 存数 !!!
	push bx
    push ax
	; shl bx, cl         ; bx左移cl位   bx = bx*8
    ; 不能用 mul, 否则al 就改变了
    mov ax,0
    mov cx,ax
    mov bl,8
    mul bl ; ax*bx
    mov bx,ax
	pop ax
    ;当bx=001时,bx左移3位 
    ;即 001<<3 => 100 => 8 ,从第八位开始查找
	lea di, [bx]		; 4) 查找到当前的位置ds[bx]
	mov cx, 8			; 5)  查找长度cx=8 (一个string长度就是8)
	cld
    repnz scasb			; 6)区域由ES:DI及CX指定。字符由AL指定。
                        ; 如果找到ES:DI指向该字符，ZF=1，否则，ZF=0
                        ;扫描DS:DI所指字符是否与AL中字符匹配，
                        ;若不匹配，则零标志ZF=0，DI++，CX--直到找到匹配的字符或者找遍整个指定的区域（即CX为0为止）
	jne next
	inc dl ; 找到了指定的字符
next:
	pop bx				; 7)
	inc bx
	cmp bx, 4 ; 第四个字符串已经比完了就到add dl,'0'
	jnz search ; 
	
	add dl, '0'			; 8)
	mov ah, 02h			; 9)
	int 21h
	ret
main endp
code ends
end start
