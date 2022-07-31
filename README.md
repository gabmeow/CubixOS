# Cubix
## What is Cubix?
Cubix is an open source operating system created the first of July 2022, I'm still building it and I hope you'll like it

## Why Cubix?
When I was a kid i always dreamed to create an operating system, finally, this dream became true, it's not easy to create this type of thing but I did it! If you want to support my work download it and give it a try! I'm sure that it's not like Windows or Linux but remember that this is 1 month of work!
- [x] Easy to use

# CHANGELOG
- Previous:
  - Added keyboard driver
- Changes:
  - Modified keyboard driver
- Coming in the future:
  - Full kernel input
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
- [x] Keyboard driver
- [ ] Memory driver
- [ ] Inputs
- [ ] Shell 

# How to boot?
YOU NEED:
 - nasm (x86)
 - C (gcc)

LINUX BOOT WITH QEMU:
- 1st command: nasm boot.asm -f bin -o boot.bin
- 2nd command: gcc -ffreestanding -m32 -g -c kernel.c -o  kernel.o
- 3rd command: ld -T NUL -o kernel.tmp -Ttext 0x1000 kernel_entry.o kernel.o
- 4th command: objcopy -O binary -j .text  kernel.tmp kernel.bin
- 5th command: cat boot.bin kernel.bin > os.bin
- 6th command: qemu-system-x86_64 -drive format=raw,file=os.bin,index=0,if=floppy, -m 128M
