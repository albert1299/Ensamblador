; Por: Albert Mora
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
    msj1 db 10,"Ingrese el primer número (dividendo):",10
	len1 equ $ - msj1 

	msj2 db "Ingrese el segundo número (divisor):",10
	len2 equ $ - msj2

    msj3 db 10,"Cociente: ",10
	len3 equ $ - msj3 

	msj4 db 10,"Residuo",10
	len4 equ $ - msj4

	msj5 db 10,"No se puede dividir, divisor mayor que el dividendo",10
	len5 equ $ - msj5

	nueva_linea db 10,""

section .bss
    num1 resb 1
	num2 resb 1
    cociente resb 1
    residuo resb 1

section .text
    global _start

_start:
    ; Ingresar el numero 1
	escribir msj1, len1
	leer num1, 2

    ; Ingresar el numero 2
	escribir msj2, len2
	leer num2, 2

    mov cl, 0
	mov al, [num1]
	mov bl, [num2]
	sub al, '0'
	sub bl, '0'
    cmp al, bl ; Comparar los numeros ingresados
    jg incrementar ; Hacer resta si al mayor que bl incrementado cl
    je incrementar ; Hacer resta si al igual que bl incrementado cl
	jmp error ; Presentar mensaje de error si al al menor a bl

restar:
	sub al, bl ; 
    cmp al, bl ; Comparar al con el divisor
    jg incrementar ; Hacer resta si al mayor que bl incrementado cl
    je incrementar ; Hacer resta si al igual que bl incrementado cl
    jmp presentar ; Presentar resultados: cl = cociente; al = residuo 

incrementar:
	inc cl ; Incrementar en 1
    jmp restar

presentar:
	add cl, '0' ; Convertir el valor de cl de decimal a ascii
    mov [cociente], cl
	add al, '0' ; Convertir el valor de al de decimal a ascii
    mov [residuo], al
    escribir msj3, len3
	escribir cociente, 1
    escribir msj4, len4
	escribir residuo, 1
	escribir nueva_linea, 1
	jmp salir

error:
	escribir msj5, len5

salir: 
    mov eax, 1
    int 80h