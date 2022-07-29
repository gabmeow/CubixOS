;boot.asm
[ORG 0x7c00]

KERNEL_LOCATION equ 0x1000

CODE_SEG equ code_descriptor - GDT_Start
DATA_SEG equ data_descriptor - GDT_Start

mov [BOOT_DISK], dl

; SETTING UP STACK
xor ax, ax
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp

mov bx, KERNEL_LOCATION
mov dh, 2

; READ FROM THE DISK
mov ah, 2
mov al, 1           ; sectors to read
mov ch, 0           ; cylinder number
mov cl, 2           ; sector number
mov dh, 0           ; head number
mov dl, [BOOT_DISK]   ; drive number saved in a variable
int 0x13

mov ah, 0x0
mov al, 0x3
int 0x10

cli
lgdt [GDT_descriptor
mov eax, cr0
or eax, 1
mov cr0, eax
jmp CODE_SEG:start_protetcted_mode

GDT_Start:
    null_descriptor:
        dd 0        ; set to 0
        dd 0        ; se to 0
    code_descriptor:
        dw 0xffff   ; first 16 bits
        dw 0        ; 16 +
        db 0        ; 8 = 24
        db 0b10011010
        ; p, p, t Type flags
        db 0b11001111
        ; Other flags + limit (last four bits)
        db 0        ; last 8 bits
    data_descriptor:
        dw 0xffff   ; first 16 bits
        dw 0        ; 16 +
        db 0        ; 8 = 24
        db 0b10010010
        ; p, p, t Type flags
        db 0b11001111
        ; Other flags + limit (last four bits)
        db 0        ; last 8 bits

GDT_End:

GDT_descriptor:
    dw GDT_End - GDT_Start - 1
    dd GDT_Start

[BITS 32]
start_protetcted_mode:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ebp, 0x90000
    mov esp, ebp

    jmp KERNEL_LOCATION

BOOT_DISK:
    db 0

times 510-($-$$) db 0
db 0x55
db 0xAA
