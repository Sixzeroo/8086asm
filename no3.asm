stack segment stack
	dw 512 dup(?)
stack ends
data segment
sum dw ?
min db 100
max db 0
ave dw ?
table db 2h,3h,1h,1h,1h,5h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h,1h
data ends
code segment
	assume cs:code,ds:data,ss:stack
start:
	mov ax,data
	mov ds,ax
	mov si,offset table	
	mov cx,50 
	xor ax,ax

start1:
	add al,[si]
	inc si
	loop start1
	mov sum,ax

	xor cx,cx
	mov cl,50
	idiv cl
	mov ave,ax
	mov bx,ave

	mov dl,bl
	add dl,30h
	mov ah,2
	int 21h

	mov dl,'.'
	mov ah,2
	int 21h

	mov dl,bh
	add dl,30h
	mov ah,2
	int 21h

	mov dl,' '
	mov ah,2
	int 21h

	mov si,offset table
	mov cx,50
	xor dl,dl

start2:
	mov dl,[si]
	inc si
	cmp dl,max
	jb next2    ;不更新最大值
	mov max,dl
next2:
	loop start2

	;求最小值
	mov si,offset table
	mov cx,50
	xor bl,bl
start3:
	mov dl,[si]
	cmp dl,min
	ja next3
	mov min,dl
next3:
	loop start3

	mov al,max ;输出最大值
	xor ah,ah
	mov bh,10
	div bh
	mov dl,al
	mov bl,ah
    mov ah,2
	add dl,30h
	int 21h

	mov dl,bl
	add dl,30h
	mov ah,2
	int 21                                    

	mov dl,' '
	mov ah,2
	int 21h

	mov al,min   ;输出最小值
	xor ah,ah
	mov bh,10
	div bh

	mov dl,al
	mov bl,ah
	add dl,30h
	mov ah,2
	int 21h

	mov dl,bl
	add dl,30h
	mov ah,2
	int 21h

exit:
	mov ah,4ch
	int 21h

code	ends
	end start


