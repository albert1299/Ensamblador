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
	msj db "Ingrese un número: "
	len equ $ - msj
	new_line db '',10

section .bss
	numero resb 2

section .text
	global _start

_start :
	;ingrese número
    escribir msj, len
    leer numero, 1


imprimir:
	escribir numero, 1
    escribir new_line, 1

	mov eax, [numero]
	sub eax, '0'
	dec eax	
	mov ecx, eax
	add eax, '0'
	mov [numero], eax	

	cmp ecx, 0
	jz salir
	jmp imprimir

salir:
	mov eax, 1
	int 80h