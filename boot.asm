;boot.asm
[ORG 0x7c00]

mov ah, 0       ; input
int 0x16

mov al, [buffer]    ; actually stores it

mov ah, 0x0e
mov bx, helloTxt    ;prints


printString:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    inc bx
    jmp printString

end:
    jmp $

helloTxt:
    db "Cubix", 13, 10   ; 0 = stop reading - 13, 10 = continue

versionTxt:
    db "V 001", 13, 10
spaceTxt:
    db "", 0

;char:
;    db 0

buffer:                         ; STORE INPUT DATA              
    times 10 db 0
    mov bx, buffer
    mov [bx], al
    inc bx

times 510-($-$$) db 0
db 0x55
db 0xAA
