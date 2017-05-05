stack	segment stack
	dw 512 dup(?)
stack	ends
data	segment
s1		db 0dh,0ah,'Please input X',0dh,0ah,'$'
s2		db 0dh,0ah,'Please input Y',0dh,0ah,'$'
s3		db 0dh,0ah,'The result(Z) is',0dh,0ah,'$'
X		dw 4
Y		dw 5
z		dw ?
		dw ?
nozero	dw 0    ;判断标志变量
data	ends

subseg	segment
assume	cs:subseg,ds:data
fun		proc	far
	push bp
	mov bp,sp
	push ax    ;保存现场
	push bx
	push cx
	push dx

	mov ax,[bp+8]
	mov bx,[bp+6]
	imul bx
	mov bx,ax
	mov cx,dx
	mov ax,[bp+8]
	cwd
	add bx,ax
	adc cx,dx
	mov ax,[bp+6]
	cwd
	sub bx,ax
	sbb cx,dx
	mov [bp+10],bx
	mov [bp+12],cx
	
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	ret	4
fun		endp
subseg	ends

code	segment 
	assume cs:code,ds:data,ss:stack
start:	
	mov ax,data
	mov ds,ax
input1:
	mov dx,offset s1
	mov ah,9
	int 21h
	mov ah,1
	int 21h
	sub al,30h
	xor bx,bx
	mov bl,al
	mov ah,1
	int 21h
	cmp al,0dh
	jz jump1
	sub al,30h
	mov cl,al
	xor ax,ax
	mov al,bl
	mov bl,10
	imul bl
	add al,cl
	mov bx,ax
jump1:
	mov X,bx
input2:
	mov dx,offset s2
	mov ah,9
	int 21h
	mov ah,1
	int 21h
	sub al,30h
	xor bx,bx
	mov bl,al
	mov ah,1
	int 21h
	cmp al,0dh
	jz jump2
	sub al,30h
	mov cl,al
	xor ax,ax
	mov al,bl
	mov bl,10
	imul bl
	add al,cl
	mov bx,ax
jump2:
	mov Y,bx

	sub sp,4
	push X
	push Y
	call fun
	pop Z
	pop Z+2
	mov dx,offset s3
	mov ah,9
	int 21h
	mov bx,Z
	call outd
	mov ah,4ch
	int 21h

;输出数字函数,数放在bx中
outd proc near
	push cx
	mov cx,10000
    call decdiv
	mov cx,1000
	call decdiv
	mov cx,100
	call decdiv
	mov cx,10
	call decdiv
	mov cx,1
	call decdiv
outdexit:
	pop cx
	ret
decdiv proc near     ;除以一个10的倍数，判断是否为0然后进行输出
	mov ax,bx
	mov dx,0
	div cx
	mov bx,dx
	mov dl,al
	cmp dl,0
	jne dispdigit
	cmp nozero,0
	jne dispdigit
	jmp decdivexit
dispdigit:
	mov nozero,1
	add dl,30h
	mov ah,2
	int 21h
decdivexit:
	ret
decdiv endp
outd endp

code	ends
	end start
