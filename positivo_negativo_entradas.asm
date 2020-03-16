%macro escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro leer 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    msj_1 db "Ingrese el primer número", 10
    len_msj_1 equ $ - msj_1
    msj_2 db "Ingrese el segundo número", 10
    len_msj_2 equ $ - msj_2
    msj_negativo db "El resultado de la resta es negativo", 10
    len_negativo equ $ - msj_negativo
    msj_positivo db "El resultado de la resta es positivo", 10
    len_positivo equ $ - msj_positivo

section .bss
    a resb 1
    b resb 1

section .text
    global _start
_start:
    escribir msj_1, len_msj_1
    leer a, 2
    escribir msj_2, len_msj_2
    leer b, 2
    mov al, [a]
    sub al, '0'
    mov bl, [b]
    sub bl, '0'
    sub al, bl
    js negativo
    jmp positivo

negativo:
    escribir msj_negativo, len_negativo
    jmp salir

positivo:
    escribir msj_positivo, len_positivo
    jmp salir

salir:
    mov eax, 1
    int 80h