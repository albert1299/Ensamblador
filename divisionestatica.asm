%macro escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    msj1 db "Operacion de división de 8 bits"
    len equ $ - msj1

    msj2 db 10,"El cociente es: "
    len2 equ $ - msj2

    msj3 db 10,"El residuo es: "
    len3 equ $ - msj3

    new_line db 10,""


section .bss
    residuo resb 1
    cociente resb 1

section .text
    global _start

_start:
    

    mov ax, 6
    mov bl, 4
    div bl
    add al, '0'
    mov [cociente], al
    add ah, '0'
    mov [residuo], ah
    

    escribir msj1, len
    escribir msj2, len2 ;El cociente es:
    escribir cociente, 1
    escribir msj3, len3 ;El residuo es:
    escribir residuo, 1
    escribir new_line, 1

    mov eax, 1
    int 80h





