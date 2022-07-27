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
mov al, 1           ; sectors to read;boot.asm
2
[ORG 0x7c00]
3
mov [BOOT_DISK], dl
4
​
5
; SETTING UP STACK
6
xor ax, ax
7
mov es, ax
8
mov ds, ax
9
mov bp, 0x8000
10
mov sp, bp
11
​
12
mov bx, 0x7e00
13
​
14
; READ FROM THE DISK
15
mov ah, 2
16
mov al, 1           ; sectors to read
17
mov ch, 0           ; cylinder n;boot.asm
2
[ORG 0x7c00]
3
mov [BOOT_DISK], dl
4
​
5
; SETTING UP STACK
6
xor ax, ax
7
mov es, ax
8
mov ds, ax
9
mov bp, 0x8000
10
mov sp, bp
11
​
12
mov bx, 0x7e00
13
​
14
; READ FROM THE DISK
15
mov ah, 2
16
mov al, 1           ; sectors to read
17
mov ch, 0           ; cylinder number
18
mov cl, 2           ; sector number
19
mov dh, 0           ; head number
20
mov dl, [BOOT_DISK]   ; drive number saved in a variable
21
int 0x13
22
; PRINT
23
​
24
; mov ah, 0x0e              ; Prints the A that the disk read.
25
; mov al, [0x7e00]
26
; int 0x10
27
​
28
mov ah, 0x0e
29
mov bx, helloTxt    ;prints
30
​
31
;mov ah, 0       ; input
32
;int 0x16
33
​
34
;mov al, [char]    ; actually stores it
35
​
36
printString:
37
    mov al, [bx]
38
    cmp al, 0
39
    je end
40
    int 0x10
41
    inc bx
42
    jmp printString
43
​
44
end:
45
    jmp $
46
​
47
tstTxt:
48
    db "TST", 0
49
​
50
helloTxt:
51
    db "Cubix", 13, 10   ; 0 = stop reading - 13, 10 = continue
52
​
53
versionTxt:
54
    db "V 001", 13, 10
55
spaceTxt:
56
    db "", 13, 10
57
​
58
char:
59
    db 0
60
​
61
setZero:
62
    db 0
63
​
64
BOOT_DISK:
65
    db 0
66
​
67
buffer:                         ; STORE INPUT DATA              
68
    times 10 db 0
69
    mov bx, buffer
70
    mov [bx], al
71
    inc bx
72
​
73
times 510-($-$$) db 0
74
db 0x55
75
db 0xAA
76
times 512 db "A"
77
umber
18
mov cl, 2           ; sector number
19
mov dh, 0           ; head number
20
mov dl, [BOOT_DISK]   ; drive number saved in a variable
21
int 0x13
22
; PRINT
23
​
24
; mov ah, 0x0e              ; Prints the A that the disk read.
25
; mov al, [0x7e00]
26
; int 0x10
27
​
28
mov ah, 0x0e
29
mov bx, helloTxt    ;prints
30
​
31
;mov ah, 0       ; input
32
;int 0x16
33
​
34
;mov al, [char]    ; actually stores it
35
​
36
printString:
37
    mov al, [bx]
38
    cmp al, 0
39
    je end
40
    int 0x10
41
    inc bx
42
    jmp printString
43
​
44
end:
45
    jmp $
46
​
47
tstTxt:
48
    db "TST", 0
49
​
50
helloTxt:
51
    db "Cubix", 13, 10   ; 0 = stop reading - 13, 10 = continue
52
​
53
versionTxt:
54
    db "V 001", 13, 10
55
spaceTxt:
56
    db "", 13, 10
57
​
58
char:
59
    db 0
60
​
61
setZero:
62
    db 0
63
​
64
BOOT_DISK:
65
    db 0
66
​
67
buffer:                         ; STORE INPUT DATA              
68
    times 10 db 0
69
    mov bx, buffer
70
    mov [bx], al
71
    inc bx
72
​
73
times 510-($-$$) db 0
74
db 0x55
75
db 0xAA
76
times 512 db "A"
77

mov ch, 0           ; cylinder number
mov cl, 2           ; sector number
mov dh, 0           ; head number
mov dl, [BOOT_DISK]   ; drive number saved in a variable
int 0x13

mov ah, 0x0
mov al, 0x3
int 0x10

cli
lgdt [GDT_descriptor]
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
