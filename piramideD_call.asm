section .data
		asterisco db '*'
		nueva_linea db 10,''

section .text
		global _start
_start:
		mov ecx, 9
		mov ebx, 1
l1:
	push ecx
	push ebx
	push ebx
	call imprimir_enter
	pop ecx

l2:
	push ecx
	call imprimir_asterisco
	pop ecx
	loop l2

	pop ecx
	inc ecx
	push ecx

	pop ebx
	pop ecx

	loop l1

	mov eax, 1
	int 80h

imprimir_asterisco:
	mov eax, 4
	mov ebx, 1
	mov ecx, asterisco
	mov edx, 1
	int 80h
	ret
	
imprimir_enter:
	mov eax, 4
	mov ebx, 1
	mov ecx, nueva_linea
	mov edx, 1
	int 80h
	ret


	