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
    msj1 db 10,"Ingrese el primer número"
	len1 equ $ - msj1 

	msj2 db "Ingrese el segundo número"
	len2 equ $ - msj2

    msj3 db 10,"Número mayor"
	len3 equ $ - msj3 

	msj4 db "Número menor"
	len4 equ $ - msj4

section .bss
    num1 resb 1
	num2 resb 1

section .text
    global _start

_start:
    ; Ingrese el numero 1
	escribir msj1, len1
	leer num1, 2

    ; Ingrese el numero 2
	escribir msj2, len2
	leer num2, 2

    mov al, [num1]
    mov bl, [num2]
    sub al, '0'
	sub bl, '0'
    cmp al, bl
    jg mayor ;(zf = 0) (cf=0)
    jmp menor
 
mayor:
    escribir msj3, len3
    jmp salir

menor:
    escribir msj4, len4

salir: 
    mov eax, 1
    int 80h
