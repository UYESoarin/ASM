include irvine32.inc

.data
;Array
const1 		byte 100, 100d, 01100100b, 64h, 'd'
const1Len	equ $-const1

;StringArray
const4		byte '01234567689', 'abcxyz', 'ABCXYZ', 0

prompt1		byte '十进制 = ', 0
prompt2		byte '十六进制 = ', 0
prompt3		byte 'ASCLL = ', 0

.code
main proc
	mov edx, offset const4
	call WriteString
	call Crlf
	
	mov ecx, const1Len
	mov esi, 0
	traverse:
		;Index
		mov eax, esi
		inc eax
		call WriteDec
		call Crlf
		
		;DEC
		mov edx, offset prompt1
		call WriteString
		movzx eax, const1[esi]
		call WriteDec
		call Crlf
		
		;HEX
		mov edx, offset prompt2
		call WriteString
		;movzx eax, const1[esi]
		call WriteHex
		call Crlf
		
		;ASCLL
		mov edx, offset prompt3
		call WriteString
		mov al, const1[esi]
		call WriteChar
		call Crlf
		
		inc esi
		loop traverse
		
	exit
main endp
end main
