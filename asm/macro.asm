;; Definition of the PRINT macro.
%macro PRINT 2
        ;; Specify the number of the system call (1 is `sys_write`).
        mov rax, 1
        ;; Set the first argument of `sys_write` to 1 (`stdout`).
        mov rdi, 1
        ;; Set the second argument of `sys_write` to the reference of the string to print.
        ;; The reference will be stored in the first argument of the macro.
        mov rsi, %1
        ;; Set the third argument of `sys_write` to the length of the string to print.
        ;; The reference will be stored in the second argument of the macro.
        mov rdx, %2
        ;; Call the `sys_write` system call.
        syscall
%endmacro

;; Definition of the EXIT program
%macro EXIT 1
        ;; Specify the number of the system call (60 is `sys_exit`).
        mov rax, 60
        ;; Set the first argument of `sys_exit` to the first argument of the macro.
        mov rdi, %1
        ;; Call the `sys_exit` system call.
        syscall
%endmacro

;; Define a "person" structure
struc person
        ;; Person name
        .name resb 10
        ;; Person age
        .age  resb 1
endstruc

;; Definition of the .data section.
section .data
        ;; ASCII code of the new line symbol ('\n').
        newline: db 0xA
        ;; Instance of the person structure.
        p: istruc person
                ;; Person name
                at person.name, db "Alex"
                ;; Person age
                at person.age,  db 25
        iend

;; Definition of the .text section.
section .text
        ;; Reference to the entry point of our program.
        global _start

;; Entry point of the program.
_start:
        ;; Print the person name defined by the `p`
        PRINT p + person.name, 4
        ;; Print new line message with the length 1.
        PRINT newline, 1
        ;; Exit from the program. The 0 status code is success.
        EXIT 0
