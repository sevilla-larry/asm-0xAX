[absolute 0]
person:

 .name resb 10

 .age resb 1
person_size equ ($-person)
[warning push]
[warning -other]
[section .text]
[warning pop]


[section .data]

 newline: db 0xA

 p: 
..@5.strucstart:

times (person.name-person)-($-..@5.strucstart) db 0
db "Alex"

times (person.age-person)-($-..@5.strucstart) db 0
db 25
times person_size-($-..@5.strucstart) db 0


[section .text]

[global _start]


_start:


 mov rax, 1

 mov rdi, 1


 mov rsi, p + person.name


 mov rdx, 4

 syscall


 mov rax, 1

 mov rdi, 1


 mov rsi, newline


 mov rdx, 1

 syscall


 mov rax, 60

 mov rdi, 0

 syscall
