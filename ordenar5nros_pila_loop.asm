section .data
    msj1 db "Ingrese 5 números",10
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

    mov eax, 4
	mov ebx, 1
	mov ecx, msj1
	mov edx, len_msj1
	int 80h

    mov ecx, 5
    push ecx
    mov eax, 3
    push eax

    mov ebx, [esp-8]
    cmp ebx, 5
    je salir
    jmp imprimir

    add eax, '0'
    mov [num], eax

imprimir:
    mov eax, 4
	mov ebx, 1
	mov ecx, msj1
	mov edx, len_msj1
	int 80h




salir:
    mov eax, 1
    int 80h

