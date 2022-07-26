;boot.asm
[ORG 0x7c00]
mov [BOOT_DISK], dl

; SETTING UP STACK
xor ax, ax
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp

mov bx, 0x7e00

; READ FROM THE DISK
mov ah, 2
mov al, 1           ; sectors to read
mov ch, 0           ; cylinder number
mov cl, 2           ; sector number
mov dh, 0           ; head number
mov dl, [BOOT_DISK]   ; drive number saved in a variable
int 0x13
; PRINT

; mov ah, 0x0e              ; Prints the A that the disk read.
; mov al, [0x7e00]
; int 0x10

mov ah, 0x0e
mov bx, helloTxt    ;prints

;mov ah, 0       ; input
;int 0x16

;mov al, [char]    ; actually stores it

printString:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    inc bx
    jmp printString

end:
    jmp $

tstTxt:
    db "TST", 0

helloTxt:
    db "Cubix", 13, 10   ; 0 = stop reading - 13, 10 = continue

versionTxt:
    db "V 001", 13, 10
spaceTxt:
    db "", 13, 10

char:
    db 0

setZero:
    db 0

BOOT_DISK:
    db 0

buffer:                         ; STORE INPUT DATA              
    times 10 db 0
    mov bx, buffer
    mov [bx], al
    inc bx

times 510-($-$$) db 0
db 0x55
db 0xAA
times 512 db "A"
