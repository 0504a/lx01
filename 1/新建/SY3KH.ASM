ORG   0000H
      SETB P3.7
   	  SETB P3.6
   	  MOV P0, #3FH
      MOV P2, #3FH
      MOV TMOD, #61H		//0110 0001 T1为计数器8位自动重装载,T0为16位定时器
   	  MOV TH1,#0C4H
      MOV TL1,#0C4H	 //59
      SETB TR1
LOOP4:MOV R0, #50					 //50*10ms==500ms。
LOOP1:MOV TH0, #0BBH
   	  MOV TL0, #00H
      SETB TR0
LOOP2:JBC TF0, LOOP3
	  SJMP LOOP2
LOOP3:DJNZ R0,LOOP1
      CPL P3.6
      CPL P3.7
      MOV A, TL1
      SUBB A, #0C4H
	  MOV R2,A
	  MOV A,#03CH
	  SUBB A,R2
      MOV R1,A
      MOV B,#10
      DIV AB
      MOV DPTR,#TAB
      MOVC A,@A+DPTR
      MOV P2,A
      MOV A,B
      MOVC A,@A+DPTR
      MOV P0,A
      MOV R1,A
      CPL A
      MOV P1,A
      SJMP LOOP4
TAB:DB 3FH, 06H, 5BH, 4FH, 66H, 6DH, 7DH, 07H, 7FH, 6FH
END


