section .data
    asterisco db '*'
    nueva_linea db 10,''
    espacio db ' '

section .test
    global _start
_start:
    mov ecx, 9
    
l1: 
    push ecx
    push ecx                             ;  ,9,9
    push ecx
    call imprimir_linea ;
    pop ecx ;3
    
    mov ebx, 10
    sub ebx, ecx
    mov ecx, ebx

l2:
    push ecx
    call imprimir_espacio
    pop ecx
    loop l2
    pop ecx

l3: 
    push ecx
    call imprimir_asterisco
    pop ecx
    loop l3

    pop ecx
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

imprimir_espacio:
    mov eax, 4
    mov ebx, 1
    mov ecx, espacio
    mov edx, 1
    int 80h
    ret

salir:
    mov eax, 1
    int 80h
