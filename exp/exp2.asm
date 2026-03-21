include irvine32.inc
.data
dat word 2,-3,1,13,-4,-21,5,1   ;有符号数组
max word ?
LEN equ lengthof dat            ;数组长度符号常量
.code
main proc
mov esi,0;数组地址偏移量
mov ecx,LEN-1                   ;两两比较，循环次数减一
mov ax,dat[esi];初始化
again:
    add esi,2                   ;右操作数地址偏移量
    cmp ax,dat[esi]             ;前后元素比较
    jge next                    ;大于等于
    mov ax,dat[esi]             ;小于取大
    next:
        dec ecx                 ;计数器自减
        cmp ecx,0
        jnz again               ;非零继续循环
mov max,ax                      ;回存最大值
movsx eax,ax                    ;有符号数扩展符号位
call WriteInt                   ;有符号数输出
call Crlf
exit
main endp
end main