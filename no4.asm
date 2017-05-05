stack	segment stack
	dw 512 dup(?)
stack	ends
data	segment
Str		db 50
		db ?
		db 50 dup(?)
Str1	db 'asm'
Str2	db 'YES','$'
Str3	db 'NO','$'
data	ends
code	segment 
	assume cs:code,ds:data,ss:stack,es:data
start: 
	mov ax,data
	mov ds,ax
	mov es,ax

	mov dx,seg Str   ;输入字符串
	mov ds,dx
	mov dx,offset Str
	mov ah,0ah
	int 21h

	;加上$
	mov al,[Str+1]     ;获得字符个数
	xor ah,ah
	mov si,ax
	mov Str[si+2],'$'
	mov dl,0ah
	mov ah,2
	int 21h

	mov dx,offset [Str+2]
	mov ah,9
	int 21h

	mov dl,0ah
	mov ah,2
	int 21h

	lea si,Str   ;检测是否含有asm字符串
	lea di,Str1
	mov bx,si
	mov dx,di
	mov ah,48
next:
	mov cx,3
	repz cmpsb        ;判断字符串是否相等，ZF
	jz out2
	inc bx
	mov si,bx
	mov di,dx
	dec ah
	jnz next

out1:
	mov dx,offset Str3
	mov ah,9
	int 21h
	jmp exit

out2:
	mov dx,offset Str2
	mov ah,9
	int 21h

exit:
	mov ah,4ch
	int 21h
code	ends
	end start
