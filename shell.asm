bits 64

section .data
    msg db "sh-1.0$ "
    len equ $-msg
    path db "/bin/ls", 0
    argv dq path, 0

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

        cmp rax, 0
        je _exit

        mov rax, 57
        syscall

        cmp rax, 0
        je _exec
        jl _fork_error

        mov rdi, rax
        xor     rsi, rsi
        xor     rdx, rdx
        xor     r10, r10
        mov     rax, 61
        syscall

        jmp _start

    _exec:
        mov rax, 59
        lea rdi, [rel path]
        lea rsi, [rel argv]
        xor rdx, rdx
        syscall
        
        mov rax, 60
        mov rdi, 1
        syscall

    _exit:
        mov rax, 60
        mov rdi, 0
        syscall

    _fork_error:
        mov     rax, 60
        mov     rdi, 1
        syscall