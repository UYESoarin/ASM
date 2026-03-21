include irvine32.inc

.data
msg byte 'hello, world', 13, 10, 0

.code
main proc
    mov edx, offset msg
    call writestring
    exit;ret from proc
main endp

end main