# Cubix
## What is Cubix?
Cubix is an open source operating system created the first of July 2022, we're still building it and we hope you'll like it

## Why Cubix?
Cubix is being developed by 1 guy, appreciate all his hard work by downloading the system.
- [x] Easy to use

# CHANGELOG
- Previous:
  - Added Kernel
- Changes:
  - Added new-line text
- Coming in the future:
  - Full command-line UI (On the way :) )
- [-- Last version: 001A5 --]
- [x] Tested

## ROADMAP
- [x] Easy to use
- [ ] Graphic interface
- [x] Command-line interface
- [ ] Floppy disk reading
- [ ] USB reading
- [x] Hard disk reading
- [x] CD/DVD reading

# How to boot?
LIBRARIES:
 - nasm (x86)
 - C (gcc)

LINUX BOOT WITH QEMU:
- 1st command: nasm boot.asm -f bin -o boot.bin
- 2nd command: gcc -ffreestanding -m32 -g -c kernel.c -o  kernel.o
- 3rd command: ld -T NUL -o kernel.tmp -Ttext 0x1000 kernel_entry.o kernel.o
- 4th command: objcopy -O binary -j .text  kernel.tmp kernel.bin
- 5th command: cat boot.bin kernel.bin > os.bin
- 6th command: qemu-system-x86_64 -drive format=raw,file=os.bin,index=0,if=floppy, -m 128M
