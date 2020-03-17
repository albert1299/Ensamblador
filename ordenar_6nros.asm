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
    msj4 db " "
    len4 equ $ - msj4

    ; definir el arreglo
    arreglo db 0,0,0,0,0,0
    len_arreglo equ $ - arreglo
    
section .bss
    numero resb 2

section .text
    global _start
_start:
    escribir msj, len
    mov esi, arreglo
    mov edi, 0

ingresar:
    leer numero, 2
    ;asignacion de un numero en el arreglo
    mov al, [numero]
    sub al, '0'
    mov [esi], al

    ;incrementar una posicion en el arreglo
    add esi, 1
    add edi, 1

    ;comparar para el salto
    cmp edi, len_arreglo
    jb ingresar
    
    mov ecx, len_arreglo
    
for1:
    mov esi, arreglo
    mov edi, 0

for2:
    mov al, [esi]
    cmp al, [esi+1]
    jg mover
    jmp incrementar

mover:
    mov bl, [esi+1]
    mov [esi], bl
    mov [esi+1], al
    jmp incrementar

incrementar:
    add esi, 1
    add edi, 1
    cmp edi, 5
    jb for2
    loop for1

    mov esi, arreglo
    mov edi, 0

    jmp recorrer

presentar_menor:
    escribir msj3, len3
    escribir numero, 1 
    escribir msj2, len2
    jmp incrementar_2

presentar_mayor:
    escribir msj1, len1
    escribir numero, 1 
    escribir msj2, len2
    jmp incrementar_2

recorrer:
    mov al, [esi]
    add al, '0'
    mov [numero], al

    cmp edi, 0
    je presentar_menor
    cmp edi, 5
    je presentar_mayor

incrementar_2:
    add esi, 1
    add edi, 1
    cmp edi, len_arreglo
    jb recorrer

    mov esi, arreglo
    mov edi, 0

presentar:
    mov al, [esi]
    add al, '0'
    mov [numero], al

    escribir numero, 1
    escribir msj4, len4 

    add esi, 1
    add edi, 1

    cmp edi, len_arreglo
    jb presentar

salir:
    mov eax, 1
    int 80h
