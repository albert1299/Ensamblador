section .data
    msj1 db 'Ingrese el total de numeros a generar', 10
    len_msj1 equ $ - msj1

    msj2 db '0'
    len_msj2 equ $ - msj2



section .bss
    numero resb 2

section .test
    global _start
_start:

    ;Ingresar n
    mov eax, 4
    mov ebx, 1
    mov ecx, msj1
    mov edx, len_msj1
    int 80h

    ;Leer n
    mov eax, 3
    mov ebx, 0
    mov ecx, numero
    mov edx, 1
    int 80h

    ;presentar 0
    mov eax, 4
    mov ebx, 1
    mov ecx, msj2
    mov edx, len_msj2
    int 80h

    mov eax, 0
    mov ebx, 1 
    mov ecx, [numero]
    sub ecx, '0'

    sub ecx, 1

l1:
    push ecx
    push eax
    push ebx
    add eax, ebx
    push eax
    add eax, '0'
    mov [numero], eax
    call imprimir
    pop eax
    pop ecx
    pop ebx
    pop ecx
    loop l1

    jmp salir

imprimir:
    mov eax, 4
    mov ebx, 1
    mov ecx, numero
    mov edx, 1
    int 80h
    ret

salir:
    mov eax, 1
    int 80h
