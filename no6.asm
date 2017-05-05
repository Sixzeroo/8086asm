stack segment stack
	dw 512 dup(?)
stack ends
data	segment
sum		db ?
max		db ?
min		db ?
ave		dw ?
data	ends

code	segment
	assume cs:code,ds:data,ss:stack

getmin macro x,y,z
	push ax
	push bx
	push cx
	push dx
	mov al,x
	mov bl,y
	mov cl,z
	cmp al,bl
	ja cmp1
	cmp al,cl
	ja cmp2
	mov dl,al
	jmp out
cmp1:
   cmp bl,cl
   ja cmp2
   mov dl,bl
   jmp out
cmp2:
	mov dl,cl
	jmp out
out:
	add dl,30h
	mov ah,2
	int 21h
	pop dx
	pop cx
	pop bx
	pop ax

endm

start:
	mov ax,data
	mov ds,ax
	getmin 3,5,6

	mov ah,4ch
	int 21h
code ends
	end start

