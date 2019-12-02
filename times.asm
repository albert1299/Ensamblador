section .data
	msj db 'Desplegar los asteriscos 9 veces' ,10
	len equ $ - msj
	asterisco times 9 db 10, '*'
	len_asterisco equ $ - asterisco

section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msj
	mov edx, len
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, asterisco
	mov edx, len_asterisco
	int 80h

	mov eax, 1
	int 80h
	
