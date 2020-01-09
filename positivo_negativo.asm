section .data
    msj_negativo db "Es negativo", 10
    len_negativo equ $ - msj_negativo
    msj_positivo db "Es positivo", 10
    len_positivo equ $ - msj_positivo

section .bss

section .text
    global _start
_start:
    mov ax, 3
    mov bx, 6
    sub ax, bx
    js negativo
    jmp positivo

negativo:
    mov eax, 4
    mov ebx, 2
    mov ecx, msj_negativo
    mov edx, len_negativo
    int 80h
    jmp salir

positivo:
    mov eax, 4
    mov ebx, 2
    mov ecx, msj_positivo
    mov edx, len_positivo
    int 80h
    jmp salir

salir:
    mov eax, 1
    int 80h
