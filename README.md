# Cubix
## What is Cubix?
Cubix is an open source operating system created the first of July 2022, we're still building it and we hope you'll like it

## Why Cubix?
Because it's easy to use, simple and perfect.

# CHANGELOG
- Previous:
  - Added a partial fix for the buffer
- Changes:
  - Added and fixed the buffer
  - Changed the text
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
- [ ] Hard disk reading
- [ ] CD/DVD reading

# How to boot?
LINUX:
- 1st command: nasm boot.asm -f bin -o boot.bin
- 2nd command: qemu-system-i386 -hda boot.bin
