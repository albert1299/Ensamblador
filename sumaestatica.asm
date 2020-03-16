section .data
	mensaje db "El resultado es: ", 10; directiva de datos
	len equ $-mensaje 

	new_linea db 10
	len_new_linea equ $ - new_linea

section .bss
	suma resb 1; resb: directiva de datos para almacenar espacio en memoria sin inialización

section .text
	global _start
_start:
	mov eax, 6
	mov ebx, 3
	add eax, ebx
	add eax, '0'


	mov [suma], eax; direccionamiento indirecto 

	mov eax, 4
	mov ebx, 1
	mov ecx, mensaje
	mov edx, len
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, suma
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, new_linea
	mov edx, len_new_linea
	int 80h

	mov eax, 1
	int 80h

;Transformar de # a cadena se suma '0'. add registro, '0'
;Transformar de cadena a # se resta '0', sub registro, '0'


