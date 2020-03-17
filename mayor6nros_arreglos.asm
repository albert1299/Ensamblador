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
    msj1 db "El número mayor es: "
    len1 equ $ - msj1
    msj2 db 10,""
    len2 equ $ - msj2
    msj3 db "El número menor es: "
    len3 equ $ - msj3


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


comparar:
    push esi
    ;jmp presentar_push
    mov esi, arreglo
    mov al, [esi]
    pop esi
    cmp al, [esi+1]
    jb mover 
    jmp incrementar


mover:
    mov cl, [esi]
    mov al, [esi+1]
    mov [esi+1], cl
    push esi
    mov esi, arreglo
    mov [esi], al
    pop esi
    jmp incrementar
    
incrementar:
    add esi, 1
    add edi, 1
    cmp edi, 5
    jb comparar
    je presentar_mayor

presentar_mayor:
    mov esi, arreglo
    mov edi, len_arreglo

    mov al, [esi]
    add al, '0'
    mov [numero], al

    escribir msj1, len1
    escribir numero, 1
    escribir msj2, len2


    mov esi, arreglo
    mov edi, 0


comparar_2:
    push esi
    mov esi, arreglo
    mov al, [esi]
    pop esi
    cmp al, [esi+1]
    jg mover_2
    jmp incrementar_2

mover_2:
    mov cl, [esi]
    mov al, [esi+1]
    mov [esi+1], cl
    push esi
    mov esi, arreglo
    mov [esi], al
    pop esi
    jmp incrementar_2
    
incrementar_2:
    add esi, 1
    add edi, 1
    cmp edi, 5
    jb comparar_2
    je presentar_menor

presentar_menor:
    mov esi, arreglo
    mov edi, len_arreglo

    mov al, [esi]
    add al, '0'
    mov [numero], al

    escribir msj3, len3
    escribir numero, 1
    escribir msj2, len2

salir: 
    mov eax, 1
    int 80h

