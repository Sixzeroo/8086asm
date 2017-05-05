stack	segment stack
	dw 512 dup(?)
stack	ends
data	segment
	S9 DB 0dh,0ah,'Run again?(y\n)',0dh,0ah,'$'
  	S8 DB 0dh,0ah,'Please enter one number(1-7)',0dh,0ah,'$'
	ADDRTABLE DW L1,L2,L3,L4,L5,L6,L7 
	S1 DB 0dh,0ah,'Monday',0dh,0ah,'$'
	S2 DB 0dh,0ah,'Tuesday',0dh,0ah,'$'
	S3 DB 0dh,0ah,'Wednesday',0dh,0ah,'$'
	S4 DB 0dh,0ah,'Thursday',0dh,0ah,'$'
	S5 DB 0dh,0ah,'Friday',0dh,0ah,'$'
	S6 DB 0dh,0ah,'Staurday',0dh,0ah,'$'
	S7 DB 0dh,0ah,'Sunday',0dh,0ah,'$'
data	ends
code	segment 
	assume cs:code,ds:data,ss:stack
start:	
	mov ax,data
	mov ds,ax
	mov dx,offset S8
	mov ah,9
        int 21h;
	MOV AH,1
	INT 21H
	cmp al,'1'
	jb start
	cmp al,'7'
	ja start
	and ax,000fh
	dec ax
	shl ax,1	
	mov bx,ax
	JMP ADDRTABLE[BX]
L1:
	mov dx,offset S1
        jmp start1
L2:
	mov dx,offset S2
	jmp start1
L3:
	mov dx,offset S3
	jmp start1
L4:
	mov dx,offset S4
        jmp start1
L5:
	mov dx,offset S5
	jmp start1
L6:
	mov dx,offset S6
        jmp start1
L7:
	mov dx,offset S7
        jmp start1
start1:
        mov ah,9
        int 21h;
	mov dx,offset S9
        mov ah,9
        int 21h;
	MOV AH,1
	INT 21H
	cmp al,'y'
	jz start
 	mov ah,4ch
	int 21h
code	ends
	end start

