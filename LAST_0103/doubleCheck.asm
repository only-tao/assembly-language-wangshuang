;计算X+Y=Z

;X=001565A0H，Y=0021B79EH，运算的结果Z=00371D3EH。

DATA SEGMENT
MES DB  'The result is:$'
XL  DW 65A0H
XH  DW 0015H
YL  DW 0B79EH
YH  DW 0021H
DATA ENDS
CODE SEGMENT
   ASSUME CS:CODE,DS:DATA
START: 
    MOV AX,DATA
  MOV DS,AX
  MOV  DX,OFFSET MES  ;显示信息

  MOV  AH,09H
  INT   21H

  MOV   AX,XL   
  ADD   AX,YL  ;Y低位数值与X低位数值相加  
  MOV   BX,AX   ;BX中存放结果的低16位

  MOV   AX,XH
  ADC   AX,YH   ;Y高位数值与X高位数值相加
  MOV  CX,AX    ;CX中存放结果的高16位

   ;显示结果

    MOV DH,CH

    CALL SHOW

    MOV DH,CL

    CALL SHOW

    MOV DH,BH

    CALL SHOW

    MOV DH,BL

    CALL SHOW 

    MOV AX,4C00H

    INT  21H 

SHOW PROC NEAR; print dh [.... ....]
    push cx
    PUSH DX
    PUSH AX
    mov cl,4
    mov ch,4
    MOV AL,DH
    AND AL,0F0H;取高4位
    SHR AL,cl
    CMP AL,0AH ;是否是A以上的数
    JB C2; <A
    ADD AL,07H
C2:   
    ADD AL,30H
    MOV DL,AL ;show character 
    MOV AH,02H
    INT 21H
    MOV AL,DH
    AND AL,0FH ;取低4位

  CMP AL,0AH

  JB C3

  ADD AL,07H

C3:   ADD AL,30H

  MOV DL,AL ;show character 

  MOV AH,02H

  INT 21H

  POP AX
  POP DX
  pop cx
  RET
SHOW   ENDP
CODE ENDS
END   START
