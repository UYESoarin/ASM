include irvine32.inc
.data
string		byte 31 dup(?), 0;31缓冲区 + 1结束符
maxlen		equ lengthof string-1;一个结束符
.code
main proc
	mov edx, offset string
	mov ecx, maxlen
	call ReadString;入口：edx输入字符串、ecx最大输入字符数；出口：eax字符串实际长度, string修改，edx指向string
	mov ecx, eax;数组大小转存ecx
	call tolower
	call WriteString
	call Crlf
	exit
main endp

tolower proc
	;寄存器传参
	push eax
	push ecx;字符串实际长度
	push edx;字符串首地址
	push esi;索引
	xor esi, esi
	;先判断后循环
	convert:
		cmp esi, ecx
		jnb ext
		
		movzx eax, byte ptr [edx+esi];byte类型零扩展赋值，占32位内8位(al)，即mov al, [edx+esi]
		cmp al, 'A'
		jb next
		cmp al, 'Z'
		ja next
		add eax, 'a'-'A';97-65=32
		mov [edx+esi], al
		
		next:
			inc esi
			jmp convert
	ext:
	pop esi
	pop edx
	pop ecx
	pop eax
	ret
tolower endp

end main