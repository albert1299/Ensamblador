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
    msj1 db "Ingrese el límite del contador: "
    len_msj1 equ $ - msj1

    new_line db 10,""

section .bss
    num resb 1
    actual resb 1

section .text
    global _start
_start:
    escribir msj1, len_msj1
    leer num, 2

    mov al, 0

presentar:
    add al, '0'
    mov [actual], al
    escribir actual, 1
    escribir new_line, 1

    mov al, [actual]
    sub al, '0'
    inc al
    mov [actual], al
    mov bl, [num]
    sub bl, '0'
    cmp al, bl 
    jg salir
    jmp presentar

salir:
    mov eax, 1
    int 80h
