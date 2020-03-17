section .data
    asterisco db '*'
    nueva_linea db 10,''

section .test
    global _start
_start:
    mov ecx, 9
    ;mov ebx, 9
    
l1: 
    push ecx
    ;mov ebx, ecx
    push ecx
    call imprimir_linea ;
    pop ecx ;3

l2: 
    push ecx
    call imprimir_asterisco
    pop ecx
    loop l2

    pop ecx
    ;pop ebx
    ;mov ecx, ebx
    loop l1
    jmp salir

imprimir_linea:
    mov eax, 4
    mov ebx, 1
    mov ecx, nueva_linea
    mov edx, 1
    int 80h
    ret

imprimir_asterisco:
    mov eax, 4
    mov ebx, 1
    mov ecx, asterisco
    mov edx, 1
    int 80h
    ret

salir:
    mov eax, 1
    int 80h
