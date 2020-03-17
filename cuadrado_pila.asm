%macro escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    msj db '*'
    msj2 db 10,''

section .bss
    num resb 1


section .text
    global _start

_start:
    mov ebx, 5

iniciar:
    mov ecx, 5
    dec ebx

principal:
    cmp ecx, 0
    jz principal_2 ;cuando sea igual se activa la bandera de cero ecx=0
    jmp imprimir_horizontal

imprimir_horizontal:
    dec ecx
    push ecx
    push ebx
    escribir msj, 1
    pop ebx
    pop ecx
    jmp principal

principal_2:
    escribir msj2, 1
    mov ebx, [esp-8]
    add ebx, '0'
    mov [num], ebx
    mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 1
	int 80h
    jmp salir
    cmp ebx, 0
    jz salir
    jmp iniciar
    
salir:
    mov eax, 1
    int 80h