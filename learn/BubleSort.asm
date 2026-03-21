include irvine32.inc
.data
array 	byte 5, 1, 3, 2, 1, 8, 13, 2 dup(0)
LEN		equ lengthof array
space	byte ' ', 0

.code
main proc
	mov esi, 0
	outer:
		cmp esi, LEN-1
		jnb exitouter
		
		mov edi, 0
		mov ecx, LEN-1
		sub ecx, esi
		inner:
			cmp edi, ecx
			jnb nextouter
			
			mov al, array[edi]
			mov bl, array[edi+1]
			cmp al, bl
			jbe nextinner
			swap:
				mov array[edi], bl
				mov array[edi+1], al
				
			nextinner:
				inc edi
				jmp inner
		nextouter:
			inc esi
			jmp outer
	exitouter:
	mov esi, 0
	mov edx, offset space
	mov ecx, LEN
	printLoop:
		movzx eax, array[esi]
		call WriteDec
		call WriteString
		inc esi
		loop printLoop
	call Crlf
	exit
main endp
end main