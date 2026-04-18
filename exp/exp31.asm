include irvine32.inc
.data
tab		byte 7, 2, 13, 1, 09, 0, 32, 21
dat		byte 09;学号末两位（102401309）
no		byte ?
.code
main proc
	;初始化，索引与次数置零
	xor dl, dl
	mov ecx, lengthof tab;记录循环次数
	xor esi, esi
	mov al, dat
	again:
		cmp tab[esi], al
		je ext1
		inc esi
		inc dl
		dec ecx
		cmp ecx, 0
		jne again
		;搜索成功/次数越界进入
		ext1:
			cmp ecx, 0
			jne found
			Nfound:
				mov no, 0ffh
				jmp ext2
			;ecx!=0搜索成功，记录索引
			found:
				mov no, dl
				jmp ext2
	ext2:
		movzx eax, dl
		call WriteDec
	exit
main endp
end main