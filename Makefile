# $@ = target file
# $< = first dependency
# $^ = all dependencies

# First rule is the one executed when no parameters are fed to the Makefile

COMPILER = gcc
LINKER = ld
ASSEMBLER = nasm
CFLAGS = -m32 -fno-pie -ffreestanding -c
ASFLAGS = -f elf32
LDFLAGS = -Tlink.ld
EMULATOR = qemu-system-i386
EMULATOR_FLAGS = -kernel

OBJS = obj/kasm.o obj/kc.o obj/idt.o obj/isr.o obj/kb.o obj/screen.o obj/string.o obj/system.o obj/util.o obj/shell.o
OUTPUT = winos/boot/kernel.bin

all:	run

kernel.bin: $(OBJS)
	ld -m elf_i386 -Ttext 0x1000 -o $@ $^ --oformat binary --ignore-unresolved-symbol _GLOBAL_OFFSET_TABLE_ --entry start
	cp $@ myOS/boot/$@


mbr.bin: mbr.asm
	$(ASSEMBLER) $< -f bin -o $@

obj/kasm.o: kernel-entry.asm
	$(ASSEMBLER) $(ASFLAGS) $< -o $@

obj/kc.o:	kernel.c
	gcc $(CFLAGS) $< -o $@
		
obj/idt.o:idt.c
	$(COMPILER) $(CFLAGS) $< -o obj/idt.o 

obj/kb.o:kb.c
	$(COMPILER) $(CFLAGS) $< -o obj/kb.o

obj/isr.o:isr.c
	$(COMPILER) $(CFLAGS) $< -o obj/isr.o

obj/screen.o:screen.c
	$(COMPILER) $(CFLAGS) $< -o obj/screen.o

obj/string.o:string.c
	$(COMPILER) $(CFLAGS) $< -o obj/string.o

obj/system.o:system.c
	$(COMPILER) $(CFLAGS) $< -o obj/system.o

obj/util.o:util.c
	$(COMPILER) $(CFLAGS) $< -o obj/util.o
	
obj/shell.o:shell.c
	$(COMPILER) $(CFLAGS) $< -o obj/shell.o

myOS.iso:
	grub-mkrescue -o myOS.iso myOS/

# qemu-system-i386 -boot d -m 512 -cdrom $@

os-image.bin: mbr.bin kernel.bin
	cat $^ > $@

run: os-image.bin
	qemu-system-i386 -fda $<

clean:
	$(RM) *.bin *.o *.dis *iso