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
	msj1 db 10,"Ingrese un lado del cuadrado: "
	len1 equ $ - msj1 

	msj2 db "Ingrese la base del rectangulo: "
	len2 equ $ - msj2

    msj3 db "Ingrese la altura del rectangulo: "
	len3 equ $ - msj3

    msj4 db "Ingrese el radio del circulo: "
	len4 equ $ - msj4

	mensaje db "El area del cuadrado es: "
	len5 equ $-mensaje

    mensaje2 db "El area del rectangulo es: "
	len6 equ $-mensaje2

    mensaje3 db "El área del circulo es: "
	len7 equ $-mensaje3

    mensaje4 db "Selecciona una opción: ",10, "1. Cuadrado",10, "2. Rectángulo",10, "3. Círculo",10, "4. Salir",10  
	len8 equ $-mensaje4


    new_line db 10,""


section .bss
    opcion resb 1
	lado resb 1
    base resb 1
    altura resb 1
    radio resb 1
    acuadrado resb 1
    arectangulo resb 1
    acirculo resb 1

section .text
	global _start
_start:



    
; Seleccionar una opción
menu:
	escribir mensaje4, len8
	leer opcion, 2
    mov al, [opcion]
    sub al, '0'

	cmp al, 1
		je cuadrado

	cmp al, 2
		je rectangulo
	
	cmp al, 3
		je circulo

	cmp al, 4
		je salir

cuadrado:

    ; Ingrese el numero 1
	escribir msj1, len1
	leer lado, 2

    ;Proceso de multiplicación:
	mov al, [lado]
	mov bl, [lado]
	sub al, '0'
	sub bl, '0'
	mul bl
	add al, '0'
	mov [acuadrado], al

;Imprime multiplicacion
	escribir mensaje, len5
	escribir acuadrado, 1
	escribir new_line, 1

    jmp menu

rectangulo:

    ; Ingrese la base
    escribir msj2, len2
	leer base, 2

    ; Ingrese la altura
	escribir msj3, len3
	leer altura, 2

    ;Proceso de multiplicación:
	mov al, [base]
	mov bl, [altura]
	sub al, '0'
	sub bl, '0'
	mul bl
	add al, '0'
	mov [arectangulo], al

;Imprime area del rectangulo
	escribir mensaje2, len6
	escribir arectangulo, 1
	escribir new_line, 1

    jmp menu

circulo:

    ; Ingrese el radio
	escribir msj4, len4
	leer radio, 2

    ;Proceso para calcular el area del circulo:
	mov al, [radio]
	mov bl, [radio]
	sub al, '0'
	sub bl, '0'
	mul bl
    mov bl, 3
    mul bl
	add al, '0'
	mov [acirculo], al

;Imprime area del circulo
	escribir mensaje3, len7
	escribir acirculo, 1
	escribir new_line, 1

    jmp menu

salir:
	mov eax, 1
	int 80h