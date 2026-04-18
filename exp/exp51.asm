include irvine32.inc
.data
data	word 8 dup(?);长为8
p		word 8 dup(?);偶数数组
no		word ?;偶数个数
;2Byte 16bit
.code
makep proc;偶数数组存储
	push ebp
	mov ebp, esp
	push ebx
	push edx
	push esi
	push edi
	mov ebx, [ebp+8];data
	mov edx, [ebp+12];p
	
	xor esi, esi
	xor edi, edi
	addeven:
		cmp esi, 8
		jnb extad
		
		mov ax, [ebx+esi*2];取原数组第esi个元素，索引根据元素大小做字节偏移
		test ax, 1
		jnz noteven;判断偶数
		mov [edx+edi*2], ax;按字存入目标数组第edi个元素
		inc edi
		
		noteven:
		inc esi
		jmp addeven
		
	extad:
	mov ecx, edi;带出偶数个数
	pop edi
	pop esi
	pop edx
	pop ebx
	leave
	ret 8;弹出相应参数，注意大小
makep endp
main proc
	xor esi, esi
	readdata:;读取原数组
		cmp esi, 8
		jnb extrd
		
		call ReadInt
		mov data[esi*2], ax
		
		inc esi
		jmp readdata
		
	extrd:;堆栈先后顺序 ebp eip data p
	push offset p
	push offset data
	call makep
	
	xor esi, esi
	writep:;输出偶数数组
		cmp esi, ecx;ecx存偶数个数
		jnb extwt
		
		movzx eax, p[esi*2]
		call WriteDec
		mov al, " "
		call WriteChar
		
		inc esi
		jmp writep
	extwt:;输出偶数个数
		call Crlf
		mov eax, ecx
		call WriteDec
		call Crlf
	exit
main endp
end main