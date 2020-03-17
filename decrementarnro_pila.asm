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
    msj1 db 10,"Ingrese un número: "
    len_msj1 equ $ - msj1
    msj2 db 10,''

section .bss
    num resb 1


section .text
    global _start

_start:
    escribir msj1, len_msj1
    leer num, 1
    mov ecx, [num]
    sub ecx, '0'

principal:
    cmp ecx, 0
    js salir
    jmp imprimir

imprimir:
    push ecx
    add ecx, '0'
    mov [num], ecx
    escribir num, 1
    escribir msj2, 1
    pop ecx
    dec ecx
    jmp principal

salir:
    mov eax, 1
    int 80h