%macro escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    msj db 'x'

section .text
    global _start

_start:
    mov ecx, 9

principal:
    cmp ecx, 0
    jz salir ;cuando sea igual se activa la bandera de cero ecx=0
    jmp imprimir

imprimir:
    dec ecx
    push ecx
    escribir msj, 1
    pop ecx
    jmp principal

salir:
    mov eax, 1
    int 80h



