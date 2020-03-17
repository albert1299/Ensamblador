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
    msj1 db "Ingrese el primer número: "
    len_msj1 equ $ - msj1 

    msj2 db "Ingrese el segundo número: "
    len_msj2 equ $ - msj2

    msj3 db "El resultado de la resta es: "
    len_msj3 equ $ - msj3

    msj4 db "El resultado de la resta es: -"
    len_msj4 equ $ - msj4

    new_line db 10,""

section .bss
    num1 resb 1
    num2 resb 1
    resta resb 1

section .text
    global _start
_start:
    escribir msj1, len_msj1
    leer num1, 2

    escribir msj2, len_msj2
    leer num2, 2

    mov al, [num1]
    mov bl, [num2]
    sub al, '0'
    sub bl, '0'
    sub al, bl
    js signo
    add al, '0'
    mov [resta], al

    escribir msj3, len_msj3
    escribir resta, 1
    escribir new_line, 1 
    jmp salir

signo:
    mov al, [num2]
    mov bl, [num1]
    sub al, '0'
    sub bl, '0'
    sub al, bl
    add al, '0'
    mov [resta], al
    escribir msj4, len_msj4
    escribir resta, 1
    escribir new_line, 1 

salir:
    mov eax, 1
    int 80h











