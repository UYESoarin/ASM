include irvine32.inc
.data
buf		dw 1234h;四位十六进制数，word型16bit
mas		db 4 dup(?);byte存转化得8bitASCLL码
.code
main proc
	;堆栈传参
	push buf;movzx eax, word ptr buf且push eax
	push offset mas
	;堆栈存储字长32bit，push8字节
	call decbin
	exit
main endp

decbin proc
	;现场保护
	push ebp
	mov ebp, esp;栈帧保留入栈地址
	
	push eax
	push ebx;数组元素地址
	push ecx;计数器
	push edx;存buf数值
	push esi;原变址索引
	
	mov ebx, [ebp+8]
	xor esi, esi
	mov ecx, 4h
	again:
		mov dx, [ebp+12];buf==[ebp+12]注意顺序
		rol dx, 4;循环左移4bit，取最高一位十六进制数到dl低4位
		mov [ebp+12], dx;
		
		and dl, 0Fh;低4位比较前屏蔽高4位
		cmp dl, 0ah
		jb num;分是否大于十处理
		add dl, 7
		num:
			add dl, 30h
			mov [ebx+esi], dl;结果数组元素赋值
			movzx eax, byte ptr [ebx+esi]
			;push eax
			call WriteInt
			call Crlf
			;pop eax
		inc esi
		dec ecx
		cmp ecx, 0
		jne again
	;恢复现场
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
	leave;mov esp, ebp 同时 pop ebp
	ret 8;平衡堆栈并返回
decbin endp

end main