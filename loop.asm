section .data
    msj db ". Saludos",10
    len equ $ - msj

section .bss
    num resb 1

section .text
    global _start
_start:
    mov ecx, 9
    ;mov ebx, 9

ciclo:
    push ecx
    ; imprimir numero
    add ecx, '0'
    mov [num], ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 1
    int 80h
    ; imprimir mensaje
    mov eax, 4
    mov ebx, 1
    mov ecx, msj
    mov edx, len
    int 80h
    pop ecx
    loop ciclo

    mov eax, 1
    int 80h