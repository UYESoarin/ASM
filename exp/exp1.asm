include irvine32.inc
.data
dat dword 1024,1309
sum dword ?
.code
main proc
mov eax,[dat]
add eax,[dat+4]
mov sum,eax
call WriteDec
exit
main endp

end main