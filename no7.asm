    INTNO EQU 1CH
    USEINT = 1

    DATA SEGMENT
      OLDISR DW ?,?
      TIMER DB 100
      COUNTER DW 0
      ISDONE DB 0
    DATA ENDS
    
    CODE SEGMENT
      ASSUME CS:CODE,DS:DATA
START:
      MOV AX,DATA
      MOV DS,AX
      
      MOV AX,0
      MOV ES,AX
      
      ;PROTECT
	  ;保存原来的中断向量
      CLI
      MOV AX, ES:[INTNO*4]
      MOV OLDISR[0],AX
      MOV AX,ES:[INTNO*4+2]
      MOV OLDISR[2], AX
      STI
    
      ;SET NEW ISR
	  ;设置新的中断 DS:DX 为中断的入口地址
      PUSH DS
      MOV AX, SEG ISR
      MOV DS,AX
      MOV DX, OFFSET ISR
      MOV AL, INTNO
      MOV AH, 25H
      INT 21H
      POP DS

    ;WAIT HERE
WAITHERE:
    CMP ISDONE,1
    JNZ WAITHERE
  
                                        
EXIT:     
      ;恢复原来的中断
      CLI
      MOV AX,OLDISR[0]
      MOV ES:[INTNO*4],AX
      MOV AX,OLDISR[2]
      MOV ES:[INTNO*4+2],AX
      STI
        
      MOV AX,4C00H
      INT 21H
      
ISR PROC FAR
        PUSH DX
        PUSH AX
        
        MOV AX,DATA
        MOV DS,AX

        STI               ;便于中断嵌套

       ;COUNT HERE
        INC TIMER
AGAIN:
        CMP TIMER, 1000/55  ;18
        JB DONE
        MOV TIMER,0


        ;carriage
        MOV AH,2
        MOV DL,13
        INT 21H

        ;print time
        MOV AX,COUNTER

        MOV DL,10
        DIV DL
        MOV DH,AH
        MOV DL,AL
        MOV AH,2
        ADD DL,30H
        INT 21H
        MOV DL,DH
        ADD DL,30H
        INT 21H
        
		inc COUNTER
		cmp COUNTER,60
		jb DONE
        mov ISDONE,1
        
DONE:
        PUSHF
        CALL DWORD PTR OLDISR

        CLI
        POP AX
        POP DX
        IRET             ;中断返回
ISR ENDP


CODE ENDS
      END START
