#include <stdio.h>
#include <string.h>

int main() {
        char* str = "Hello World\n";
        long len = strlen(str);
        int ret = 0;

        __asm__("movq $1, %%rax \n\t"     // rax = 1 - Specify the number of the system call (1 is `sys_write`).
                "movq $1, %%rdi \n\t"     // rdi = 1 - Set the first argument of `sys_write` to 1 (`stdout`).
                "movq %1, %%rsi \n\t"     // rsi = str - Set the second argument of `sys_write` to the reference of the `str` variable.
                "movq %2, %%rdx \n\t"     // rdx = len(str) - Set the third argument of `sys_write` to the length of the `str` variable's value.
                "syscall"                 // Call the `sys_write` system call.
//              : "=r" (ret)              // Return the result in the `ret` variable.     good
                : "=g" (ret)              // Return the result in the `ret` variable.     safe
                : "g" (str), "g" (len)    // Put `str` and `len` variables in any general operand (memory, register, or immediate, if possible)
//              : "rax", "rdi", "rsi", "rdx", "rcx", "r11", "memory"                    giving errors
        );

/*
        error %rbp
        __asm__ volatile (
                ".intel_syntax noprefix;" // Switch to Intel/NASM style
                "mov rax, 1;"             // sys_write
                "mov rdi, 1;"             // fd 1 (stdout)
                "mov rsi, %1;"            // buffer address
                "mov rdx, %2;"            // count
                "syscall;"                // invoke kernel
                "mov %0, rax;"            // move return value to 'ret'
                ".att_syntax;"            // Switch back to AT&T for the compiler
                : "=r" (ret)              // %0: Output (using a register)
                : "g" (str), "g" (len)    // %1, %2: Inputs
//                : "rax", "rdi", "rsi", "rdx", "rcx", "r11" // Clobbered registers
            );

        error %rbp
            asm volatile (
                ".intel_syntax noprefix     \n\t"
                "mov rax, 1                 \n\t"
                "mov rdi, 1                 \n\t"
                "mov rsi, %1                \n\t"
                "mov rdx, %2                \n\t"
                "syscall                    \n\t"
                ".att_syntax prefix"          // important: switch back!
                : "=r" (ret)
                : "g" (str), "g" (len)
//                : "rax", "rdi", "rsi", "rdx", "rcx", "r11"
            );
*/

printf("Bytes written: %d\n", ret);
        return 0;
}
