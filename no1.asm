stack	segment stack
	dw 512 dup(?)
stack	ends
data	segment
X	dw 2
Y	dw 3
Z	dw -1
v	dw 10
S	dw 720
sum1	dw ?
sum2	dw ?
data	ends
code	segment 
	assume cs:code,ds:data,ss:stack
start:
	mov ax,data
	mov ds,ax
	mov ax,X
	mov bx,Y
	imul bx
	mov bx,ax
	mov cx,dx
	mov ax,Z
	cwd
	add bx,ax
	adc cx,dx
	mov ax,S
	cwd
	sub bx,ax
	sbb cx,dx
	mov ax,V
	cwd
	sub ax,bx
	sbb dx,cx
	mov bx,X
	idiv bx
	mov sum1,ax    ;…Ã
	mov sum2,dx    ;”‡ ˝
	mov ah,4ch   ;÷–∂œ
	int 21h
code	ends
	end start
