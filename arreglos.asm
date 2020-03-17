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
    msj db "Ingrese 6 números:", 10
    len equ $ - msj
    msj1 db "El número mayor es: ", 10
    len1 equ $ - msj1

    ; definir el arreglo
    arreglo db 0,0,0,0,0,0
    len_arreglo equ $ - arreglo
    
section .bss
    numero resb 2

section .text
    global _start
_start:

    escribir msj, len

    ; asignacion del arreglo en las posiciones efectivas
    mov esi, arreglo
    mov edi, 0

ingresar:
    leer numero, 2

    ;asignacion de un numero en el arreglo
    mov al, [numero]
    sub al, '0'
    mov [esi], al

    ;incrementar una posicio en el arreglo
    add esi, 1
    add edi, 1

    ;comparar para el salto
    cmp edi, len_arreglo
    jb ingresar

    mov esi, arreglo
    mov edi, 0
presentar:
    mov al, [esi]
    add al, '0'
    mov [numero], al

    escribir numero, 1

    add esi, 1
    add edi, 1

    cmp edi, len_arreglo
    jb presentar

salir: 
    mov eax, 1
    int 80h


