; word 2
; dword 4
; qword 8
; tbyte 10

section .data
	msj db 'Desplegar los asteriscos 9 veces' ,10
	len equ $ - msj

section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msj
	mov edx, len
	int 80h

	mov [msj], dword 'HOLA'

	mov eax, 4
	mov ebx, 1
	mov ecx, msj
	mov edx, len
	int 80h

	mov [msj + 15], dword '****'

	mov eax, 4
	mov ebx, 1
	mov ecx, msj
	mov edx, len
	int 80h

	
