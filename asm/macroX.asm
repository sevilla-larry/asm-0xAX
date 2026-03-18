%line 28+1 macro.asm
[absolute 0]
%line 28+0 macro.asm
person:
%line 29+1 macro.asm

 .name resb 10

 .age resb 1
person_size equ ($-person)
%line 33+0 macro.asm
[warning push]
[warning -other]
[section .text]
[warning pop]
%line 34+1 macro.asm


[section .data]

 newline: db 0xA

 p: 
%line 40+0 macro.asm
..@5.strucstart:
%line 41+1 macro.asm

times (person.name-person)-($-..@5.strucstart) db 0
%line 42+0 macro.asm
db "Alex"
%line 43+1 macro.asm

times (person.age-person)-($-..@5.strucstart) db 0
%line 44+0 macro.asm
db 25
%line 45+1 macro.asm
times person_size-($-..@5.strucstart) db 0


[section .text]

[global _start]


_start:

%line 3+1 macro.asm

 mov rax, 1

 mov rdi, 1


 mov rsi, p + person.name


 mov rdx, 4

 syscall
%line 56+1 macro.asm

%line 3+1 macro.asm

 mov rax, 1

 mov rdi, 1


 mov rsi, newline


 mov rdx, 1

 syscall
%line 58+1 macro.asm

%line 19+1 macro.asm

 mov rax, 60

 mov rdi, 0

 syscall
