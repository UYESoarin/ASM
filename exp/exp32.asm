include irvine32.inc
.data
tab		byte 1, 13, 21, 1, 2, 8, 3, 5, 34
dat		byte lengthof tab dup(?)
LEN		equ lengthof tab
space	byte ' ', 0
.code
main proc
	;异地排序，将tab内容复制到dat，先判断后循环
	xor ebx, ebx
	Assign:
		cmp ebx, LEN
		jnb extA
		;同索引ebx，若ebx<=LEN-1，则复制
		mov al, tab[ebx]
		mov dat[ebx], al
		
		inc ebx
		jmp Assign
		
	extA:
	;冒泡循环，先循环后判断
	mov ecx, LEN
	sub ecx, 1;ecx=LEN-1
	again1:
		mov edi, ecx;存储本轮循环次数
		xor ebx, ebx;从0索引
		again2:
			;比较前后元素，若递增则交换
			mov al, dat[ebx]
			cmp al, dat[ebx+1]
			jae next
			
			xchg al, dat[ebx+1]
			mov dat[ebx], al
			;滑动索引+内层继续判断
			next:
				inc ebx
				dec ecx
				cmp ecx, 0
				jne again2
		;循环次数自减+外层继续判断
		mov ecx, edi
		dec ecx
		cmp ecx, 0
		jne again1
		jmp extBS
	;跳出排序并打印
	extBS:
		mov edx, offset space
		mov esi, 0
		Traverse:
			cmp esi, LEN
			jnb extT
			
			movzx eax, dat[esi]
			call WriteDec
			call WriteString
			
			inc esi
			jmp Traverse
	extT:
		call Crlf
	exit
main endp
end main