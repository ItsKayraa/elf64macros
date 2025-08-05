SYS_WRITE   equ 1
SYS_EXIT    equ 60
STDOUT      equ 1

; SYS_WRITE | SYS_OUT // printf <message>, <messagelen>
%macro printf 2
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mpv rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro printl 2
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mpv rsi, %1
    mov rdx, %2
    syscall

    sub rsp, 8
    mov byte [rsp], 0x0A

    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, 1
    syscall

    add rsp, 8
%endmacro

; SYS_EXIT // exit <value>
%macro exit 1
    mov rax, SYS_EXIT
    mov rdi, %1
    syscall
%endmacro