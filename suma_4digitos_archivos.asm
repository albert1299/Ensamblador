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
    msj db "Lectura del primer archivo:", 10
    len equ $ - msj
    msj1 db 10,"Lectura del segundo archivo: ", 10
    len1 equ $ - msj1
    msj2 db 10,"Se ha guardado el resultado de la suma en el archivo ",10
    len2 equ $ - msj2
    msj3 db 10,"El resultado de la suma es: ",10
    len3 equ $ - msj3
    resultado db "    "
    len_resultado equ $ - resultado

    pathsumando1 db "/home/albert/Documentos/Ensamblador/archivos_txt/sumando1.txt",0
    lenpathsumando1 equ $ - pathsumando1

    pathsumando2 db "/home/albert/Documentos/Ensamblador/archivos_txt/sumando2.txt",0
    lenpathsumando2 equ $ - pathsumando2 

    pathresultado db "/home/albert/Documentos/Ensamblador/archivos_txt/resultado_suma_4digitos.txt",0
    lenpathresultado equ $ - pathresultado 

    mensaje_error db "Error en el archivo",10
    len_error equ $ - mensaje_error

    
section .bss
    idarchivo1 resd 1
	idarchivo2 resd 1
    contenido1 resb 4
    contenido2 resb 4
    idarchivo3 resd 1

section .text
	global _start

_start: 
	
; lectura del archivo 1
;abrir archivo
	mov eax, 5   ; servicio para abrir el archivo
	mov ebx, pathsumando1  ; direccion del archivo
	mov ecx, 0  ;modo de acceso, read only=0
	mov edx, 0  ; permisos del archivo
	int 80H
	
	;~ test == and --> el test solo modifica el estado de las banderas y define un 0
	test eax, eax
	jz salir
	
	; archivo sin excepciones
	mov dword [idarchivo1], eax ; respaldo el id del archivo
	escribir msj, len
	
	; lee el contenido del archivo
    mov eax, 3
	mov ebx, [idarchivo1] ;entrada estandar
	mov ecx, contenido1
	mov edx, 10
	int 80H
	
    ;presenta el contenido del primer archivo
	escribir contenido1, 4
	
    ;cierra el archivo
	mov eax, 6  		  ; servicio para abrir el archivo
	mov ebx, [idarchivo1]  ; direccion del archivo
	mov ecx, 0			  ;modo de acceso, read only=0
	mov edx, 0  		  ; permisos del archivo
	int 80H


    ; lectura del archivo 2
    ;abrir archivo
	mov eax, 5   ; servicio para abrir el archivo
	mov ebx, pathsumando2  ; direccion del archivo
	mov ecx, 0  ;modo de acceso, read only=0
	mov edx, 0  ; permisos del archivo
	int 80H
	
	;~ test == and --> el test solo modifica el estado de las banderas y define un 0
	test eax, eax
	jz salir
	
	; archivo sin excepciones
	mov dword [idarchivo2], eax ; respaldo el id del archivo
	escribir msj1, len1
	
	; lee el contenido del archivo
    mov eax, 3
	mov ebx, [idarchivo2] ;entrada estandar
	mov ecx, contenido2
	mov edx, 4
	int 80H
	
    ;presenta el contenido del segundo archivo
	escribir contenido2, 4
	
    ;cierra el archivo
	mov eax, 6  		  ; servicio para abrir el archivo
	mov ebx, [idarchivo2]  ; direccion del archivo
	mov ecx, 0			  ;modo de acceso, read only=0
	mov edx, 0  		  ; permisos del archivo
	int 80H

    ;realizar suma entre los valores de ambos archivos
    mov esi, 3 
    mov ecx, 4
    clc ; Desactiva el bit de la bandera carry

proceso_suma:
    mov al, [contenido1 + esi]

    adc al, [contenido2 + esi]
    aaa
    pushf
    or al, 30h
    popf

    mov [resultado+esi], al
    dec esi
    loop proceso_suma

    escribir msj3, len3
    escribir resultado, len_resultado

    ;****** creacion del archivo
    mov eax, 8 ;servicio para crear y escribir en el archivo
    mov ebx, pathresultado ;direccion del archivo
    mov edx, 2 ;modo de acceso, write and rad = 2
    mov ecx, 0x1FF ;permisos de 777 octal
    int 80h

    test eax, eax
    jz error
    mov dword [idarchivo3], eax

    ;****** escribimos el resultado de la suma en el archivo
    mov eax, 4
    mov ebx, [idarchivo3] ; entrada estandar
    mov ecx, resultado
    mov edx, 4
    int 80h

    ;****** imprimir segundo mensaje indicando que se han guarado los datos en el texto
    escribir msj2, len2

    mov eax, 6
    mov ebx, [idarchivo3]
    mov ecx, 0
    mov edx, 0
    int 80h

    jmp salir

error:
    escribir mensaje_error, len_error

salir:
    mov eax, 1
    int 80h
