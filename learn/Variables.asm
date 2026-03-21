include irvine32.inc

.data
bvar		byte 12h, 34h
wvar		word 5678h
dvar		dword 9abcdef0h
org	$+10

array		word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
arrSize		equ $-array
arrLen		equ arrSize/2


.code
main proc
	;operatorDisp
	mov eax, dword ptr array
	mov ebx, type bvar
	mov ecx, type wvar
	mov edx, type dvar
	mov esi, lengthof array
	mov edi, sizeof array
	mov ebp, arrSize
	call DumpRegs
	
	;Adressing
	mov esi, offset bvar
	mov al, bvar
	mov ah, bvar+1
	mov bx, wvar[2]
	mov ecx, arrLen
	mov edx, $
	mov edi, dvar
	call DumpRegs
	exit
main endp
end main