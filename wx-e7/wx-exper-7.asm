assume cs:codesg,ds:table,es:data

data segment
  db '1975', '1976', '1977', '1978', '1979', '1980', '1981'
  db '1982', '1983', '1984', '1985', '1986', '1987', '1988'
  db '1989', '1990', '1991', '1992', '1993', '1994', '1995'

  dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479
  dd 140417, 197514, 345980, 590827, 803530, 1183000, 1843000
  dd 2759000, 3753000, 4649000, 5937000

  dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258
  dw 2793, 4037, 5635, 8226, 11542, 14430, 15257, 17800
data ends

table segment
  db 21 dup ('year summ ne ?? ')
table ends

codesg segment
start:  
    mov ax,table
    mov ds,ax
    mov bx,0

    mov ax,data
    mov es,ax
    mov cx,21
s: ; [bx].0[si]   [bx].4[]
; add bx,84
; idata add by 4
; si from 0 to 3

; 
    mov si,0; 0 5 a d 直接看除以5=?   idata/5*84 
    mov [bx].0[di], ; ds*16 + (bx+1) + (idata/5*84) + ()
    loop s
codesg ends
