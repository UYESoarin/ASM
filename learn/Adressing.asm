include irvine32.inc

.data
a		dword 5
b		dword 8
count	dword 25
value	dword 100
arr		dword 10, 20, 30
arr2	dword 100 dup(?)
buf		dword 100 dup(?)
countArr	dword 10, 20, 30, 40
srcmsg	byte 'Try your best, why not.', 0
dstmsg	byte sizeof srcmsg dup(?)

msg1	byte '直接寻址：', 0
msg2	byte '寄存器加法：', 0
msg3	byte '寄存器间接寻址（字符串复制）：', 0
msg4	byte '寄存器相对寻址（arr[1]）：', 0
msg5	byte '符号偏移（count[1]）：', 0
msg6	byte '带比例变址（arr2[35]）：', 0
msg7	byte '复合变址（buf[35]）：', 0
msg8	byte '指针解引用：', 0
msg9	byte '复制结果', 0

.code
main proc
	;立即数寻址
	mov eax, 5;
	call WriteInt
	call Crlf
	
	
	;直接寻址
	mov edx, offset msg1
	call WriteString
	
	mov eax, count
	call WriteInt
	call Crlf
	
	
	;寄存器寻址与加法
	mov edx, offset msg2
	call WriteString
	
	mov eax, a
	add eax, b
	call WriteInt
	call Crlf
	
	
	;寄存器间接寻址（字符串复制）
	mov edx, offset msg3
	call WriteString
	
	mov ecx, lengthof srcmsg
	mov esi, offset srcmsg
	mov edi, offset dstmsg
	copy:
		mov al, [esi]
		mov [edi], al
		inc esi
		inc edi
		loop copy
	
	mov edx, offset msg9
	call WriteString
	mov edx, offset dstmsg
	call WriteString
	call Crlf
	
	
	;寄存器相对寻址（arr[1]）
	mov edx, offset msg4
	call WriteString
	
	mov ebx, offset arr
	mov eax, [ebx+4];[arr+4]
	call WriteInt
	call Crlf
	
	
	;符号偏移（count[1]）
	mov edx, offset msg5
	call WriteString
	
	mov eax, countArr[4]
	call WriteInt
	call Crlf
	
	
	;带比例变址（arr2[35]）
	mov edx, offset msg6
	call WriteString
	
	mov ebx, offset arr2
	mov esi, 35
	mov dword ptr [ebx+esi*4], 999
	mov eax, [ebx+esi*4]
	call WriteInt
	call Crlf
	
	
	;复合变址(buf[35])
	mov edx, offset msg7
	call WriteString
	
	mov ebx, offset buf
	mov edx, 0Ch
	mov dword ptr [ebx+edx+80h], 777
	mov eax, [ebx+edx+80h]
	call WriteInt
	call Crlf
	
	
	;指针解引用
	mov edx, offset msg8
	call WriteString
	mov ebx, offset value
	mov eax, [ebx]
	call WriteInt
	call Crlf
	
	exit
main endp
end main