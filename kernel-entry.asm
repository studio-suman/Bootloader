[bits 32]

global start

[extern kmain]

start:              ;clears the interrupts
    call kmain      ;send processor to continue execution of Kmain function in C code 

jmp $