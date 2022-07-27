# Cubix
## What is Cubix?
Cubix is an open source operating system created the first of July 2022, we're still building it and we hope you'll like it

## Why Cubix?
Because it's easy to use, simple and perfect.

# CHANGELOG
- Previous:
  - The OS can now read from the disk
- Changes:
  - Added Kernel
- Coming in the future:
  - Full command-line UI (On the way :) )
- [-- Last version Alpha 0.01 --]
- [x] Tested

## ROADMAP
- [ ] Easy to use
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
