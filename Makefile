all:	run

run:	image.bin
	qemu-system-i386 -fda $<

image.bin:	boot.asm
	nasm -f bin -o $@ $< 
