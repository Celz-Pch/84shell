bits 64

section .data
    msg db "sh-1.0$ "
    len equ $-msg

    not_found db "Command not found.", 10
    len_notfound equ $-not_found

section .bss
    buf resb 128
    cmd_path resb 256
    argv resq 2

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

    mov rcx, rax
    mov rbx, cmd_path

    mov byte [rbx], '/'
    mov byte [rbx + 1], 'b'
    mov byte [rbx + 2], 'i'
    mov byte [rbx + 3], 'n'
    mov byte [rbx + 4], '/'
    lea rdi, [rel buf]
    lea rbx, [rbx + 5]

    jmp copy_loop

copy_loop:
    cmp rcx, 0
    je  _done_exec
    mov dl, [rdi]
    cmp dl, ' '
    je _done_exec
    cmp dl, 10
    je _done_exec
    mov [rbx], dl
    inc rbx
    inc rdi
    dec rcx
    jmp copy_loop

_done_exec:
    mov byte [rbx], 0
    lea rax, [rel cmd_path]
    mov [rel argv], rax
    mov qword [rel argv + 8], 0

    mov rax, 57
    syscall

    cmp rax, 0
    je _exec
    jl _fork_error

    mov rdi, rax
    xor rsi, rsi
    xor rdx, rdx
    xor r10, r10
    mov rax, 61
    syscall

    jmp _start

_exec:
    mov rax, 59
    lea rdi, [rel cmd_path]
    lea rsi, [rel argv]
    xor rdx, rdx
    syscall
    
    mov rax, 1
    mov rdi, 1
    lea rsi, [rel not_found]
    mov rdx, len_notfound
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