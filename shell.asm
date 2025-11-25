bits 64

section .data
    msg db "sh-1.0$ "
    len equ $-msg

section .bss
    buf resb 128
section .text
    global _start
    _start:
        mov rax, 1
        mov rdi, 1
        lea  rsi, [rel msg]
        mov rdx, len
        syscall

        mov rax, 0
        mov rdi, 0
        lea rsi, [rel buf]
        mov rdx, 128
        syscall

        mov rax, 1
        mov rdi, 1
        lea rsi, [rel buf]
        syscall
    
    jmp _start