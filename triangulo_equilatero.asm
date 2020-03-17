section .data
    msj1 db "*"
    len_msj1 equ $ - msj1
    msj2 db " "
    len_msj2 equ $ - msj2
    msj3 db "",10
    len_msj3 equ $ - msj3

section .bss
    num resb 2

section .text
    global _start
_start:

    ;definir nro de filas
    mov ecx, 25
    mov ebx, ecx
    sub ebx, 1
    mov edx, 1
   
ciclo_1:
    push ecx
    push ebx
    push edx
    mov ecx, ebx

    cmp ecx, 0
    je salir

ciclo_2:
    push ecx
    call imprimir_espacio
    pop ecx
    loop ciclo_2

    pop ecx
    push ecx

ciclo_3:
    push ecx
    call imprimir_asterisco
    pop ecx
    loop ciclo_3

    call saltar_linea

    pop edx
    add edx, 2
    pop ebx
    sub ebx, 1
    pop ecx
    loop ciclo_1


imprimir_espacio:
    mov eax, 4
	mov ebx, 1
	mov ecx, msj2
	mov edx, len_msj2
	int 80h
    ret

imprimir_asterisco:
    mov eax, 4
	mov ebx, 1
	mov ecx, msj1
	mov edx, len_msj1
	int 80h
    ret

saltar_linea:
    mov eax, 4
	mov ebx, 1
	mov ecx, msj3
	mov edx, len_msj3
	int 80h
    ret


salir:
    mov eax, 1
    int 80h
