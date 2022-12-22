bits 32

;multiboot spec
section             .text
    align           4
    dd              0x1BADB002          
    dd              0x00
    dd              - (0x1BADB002+0x00)

global start
extern kmain        ;this is will be shell C code (kernel.c)

start:
    cli             ;clears the interrupts
    call kmain      ;send processor to continue execution of Kmain function in C code
    hlt             ;halt the cpu from processing 
