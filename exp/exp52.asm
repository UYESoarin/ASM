include irvine32.inc
.data
tab		dword 8 dup(?);长为8
x		dword 13;比较数13
min		dword ?;绝对值大于x的最小负奇数
temp	dword ?;共享变量传参
;4B 32bit
.code
readtab proc;数组赋值过程
	push esi
	xor esi, esi
	read:
		cmp esi, lengthof tab
		jnb ext
		
		call ReadInt
		mov tab[esi*4], eax;带比例系数的变址寻址
		
		inc esi
		jmp read
	ext:
	pop esi
	ret
readtab endp
find proc;求min过程：堆栈传参
; **堆栈顺序由低到高**: ebp esp tab len
	push ebp
	mov ebp, esp
	push ebx
	push ecx
	push edx
	push esi
	
	mov ebx, [ebp+8];tab
	mov ecx, [ebp+12];len
	xor esi, esi;idx
	mov eax, 7FFFFFFFh;初始比较值
	
	findmin:
		cmp esi, ecx
		jnb ext
		
		mov edx, [ebx+esi*4]
		cmp edx, 0;判断负数
		jnl notnom
		test edx, 1;判断奇数
		jz notnom
		push edx
		neg edx
		cmp edx, temp;判断绝对值大于x
		pop edx
		jle notnom
		cmp edx, eax;判断值最小
		jge notnom
		mov eax, edx;都符合时取值
		
		notnom:
		inc esi
		jmp findmin
		
	ext:
	cmp eax, 7FFFFFFFh;未得到符合的数
	jne done
	xor eax, eax;eax带出结果
	done:
	pop esi
	pop edx
	pop ecx
	pop ebx
	leave
	ret 8
find endp
main proc
	mov eax, x
	mov temp, eax;temp=x
	call readtab
	push lengthof tab
	push offset tab
	call find
	mov min, eax
	neg eax
	call WriteInt
	call Crlf
	exit
main endp
end main