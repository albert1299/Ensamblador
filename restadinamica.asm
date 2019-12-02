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
	msj1 db 10,"Ingrese el primer número: "
	len1 equ $ - msj1 

	msj2 db 10,"Ingrese el segundo número: "
	len2 equ $ - msj2

	mensaje db "El resutlado es: "
	len equ $-mensaje

	new_line db 10,""

section .bss
	n1 resb 1
	n2 resb 1
	resta resb 1

section .text
	global _start
_start:

; Ingrese el numero 1
	escribir msj1, len1
	leer n1, 2

; Ingrese el numero 2
	escribir msj2, len2
	leer n2, 2


;Proceso de resta:
	mov al, [n1]
	mov bl, [n2]
	sub al, '0'
	sub bl, '0'
	sub al, bl
	add al, '0'
	mov [resta], al

; Imprime division
	escribir mensaje, len
	escribir resta, 1
	escribir new_line, 1

	mov eax, 1
	int 80h