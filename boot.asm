;boot.asm
[ORG 0x7c00]

mov ah, 0 ; puts 0 in ah
int 0x16  ; asks for input

mov al, [char] ; moves CHAR in al

mov ah, 0x0e
mov bx, variableName

printString:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    inc bx
    jmp printString

end:
    jmp $

variableName:
    db "Hello world!", 0

char:
    db 0                         

times 510-($-$$) db 0
db 0x55
db 0xAA
