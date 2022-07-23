;boot.asm
[org 0x7c00]
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
    db "Hello world", 0

buffer:                             ; !I HAVE NO CLUE IF THIS IS CORRECT OR NOT!
    times 10 db 0
    mov bx, buffer
    mov [bx], al
    inc bx                          ; Buffer ends here

times 510-($-$$) db 0
db 0xaa55
