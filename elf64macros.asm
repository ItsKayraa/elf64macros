SYS_READ     equ 0
SYS_WRITE    equ 1
SYS_OPEN     equ 2
SYS_CLOSE    equ 3
SYS_STAT     equ 4
SYS_FSTAT    equ 5
SYS_LSTAT    equ 6
SYS_EXIT     equ 60
SYS_CLONE    equ 56
SYS_FORK     equ 57
SYS_VFORK    equ 58
SYS_EXECVE   equ 59
SYS_WAIT4    equ 61
SYS_UNLINK   equ 87
SYS_GETPID   equ 39
SYS_GETPPID  equ 110
SYS_NANOSLEEP equ 35

STDIN        equ 0
STDOUT       equ 1
STDERR       equ 2

NEWLINE equ 0x0A

; DEFAULTS

; SYS_WRITE | SYS_OUT // printf <message>, <messagelen>
%macro printf 2
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mpv rsi, %1
    mov rdx, %2
    syscall
%endmacro

; SYS_WRITE | SYS_OUT + NEWLINE // printf <message>, <messagelen>
%macro printl 2
    printf %1, %2

    ; print newline
    sub rsp, 8
    mov byte [rsp], NEWLINE 

    printf rsp, 1

    add rsp, 8
%endmacro

; SYS_EXIT // exit <value>
%macro exit 1
    mov rax, SYS_EXIT
    mov rdi, %1
    syscall
%endmacro

; SYS_WRITE | STDOUT // printch <char>
%macro printch 1
    printf %1, 1
%endmacro

; SYS_READ | STDIN // scan <buffer>, <bufferlen>
%macro scan 2
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

; SYS_READ | STDIN // scanq <question>, <questionlen>, <buffer>, <bufferlen>
%macro scanq 4
    printf %1, %2

    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, %3
    mov rdx, %4
    syscall
%endmacro

; SYS_OPEN // open <pathname>, <flags>, <mode>
%macro open 3
    mov rax, SYS_OPEN
    mov rdi, %1
    mov rsi, %2
    mov rdx, %3
    syscall
%endmacro

; SYS_CLOSE // close <fd>
%macro close 1
    mov rax, SYS_CLOSE
    mov rdi, %1
    syscall
%endmacro

; SYS_STAT // stat <pathname>, <statbuf>
%macro stat 2
    mov rax, SYS_STAT
    mov rdi, %1
    mov rsi, %2
    syscall
%endmacro

; SYS_FSTAT // fstat <fd>, <statbuf>
%macro fstat 2
    mov rax, SYS_FSTAT
    mov rdi, %1
    mov rsi, %2
    syscall
%endmacro

; SYS_LSTAT // lstat <pathname>, <statbuf>
%macro lstat 2
    mov rax, SYS_LSTAT
    mov rdi, %1
    mov rsi, %2
    syscall
%endmacro

; SYS_CLONE // clone <flags>, <child_stack>
%macro clone 2
    mov rax, SYS_CLONE
    mov rdi, %1
    mov rsi, %2
    syscall
%endmacro

; SYS_FORK // fork (no parameters)
%macro fork 0
    mov rax, SYS_FORK
    syscall
%endmacro

; SYS_VFORK // vfork (no parameters)
%macro vfork 0
    mov rax, SYS_VFORK
    syscall
%endmacro

; SYS_EXECVE // execve <filename>, <argv>, <envp>
%macro execve 3
    mov rax, SYS_EXECVE
    mov rdi, %1
    mov rsi, %2
    mov rdx, %3
    syscall
%endmacro

; SYS_WAIT4 // wait4 <pid>, <wstatus>, <options>, <rusage>
%macro wait4 4
    mov rax, SYS_WAIT4
    mov rdi, %1
    mov rsi, %2
    mov rdx, %3
    mov r10, %4
    syscall
%endmacro

; SYS_NANOSLEEP // sleep <seconds>
%macro sleep 1
    mov qword [timespec_struct], %1
    mov qword [timespec_struct + 8], 0

    mov rax, SYS_NANOSLEEP
    lea rdi, [timespec_struct]
    xor rsi, rsi
    syscall
%endmacro

; SYS_UNLINK // unlink <pathname>
%macro unlink 1
    mov rax, SYS_UNLINK
    mov rdi, %1
    syscall
%endmacro

; SYS_GETPID // getpid (no parameters)
%macro getpid 0
    mov rax, SYS_GETPID
    syscall
%endmacro

; SYS_GETPPID // getppid (no parameters)
%macro getppid 0
    mov rax, SYS_GETPPID
    syscall
%endmacro