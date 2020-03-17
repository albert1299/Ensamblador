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
    msj db "Lectura del archivo:", 10
    len equ $ - msj
    msj1 db 10,"Se ha guardado el resultado en el archivo ",10
    len1 equ $ - msj1
    resultado db 10,"-=0 veces",10,"-=0 veces",10,"-=0 veces",10,"-=0 veces",10,"-=0 veces",10,"-=0 veces",10,"-=0 veces",10,"-=0 veces",10, "-=0 veces",10, "-=0 veces",10
    len_resultado equ $ - resultado

    patharchivo db "/home/albert/Documentos/Ensamblador/evaluacion_5/MoraTorres_Albert.txt",0
    lenpatharchivo equ $ - patharchivo

    mensaje_error db "Error en el archivo",10
    len_error equ $ - mensaje_error


    
section .bss
    idarchivo1 resd 1 ;para el archivo que se lee
    contenido1 resb 10 ;para guardar el contenido del archivo leido
    tamano resb 1
    arreglo_inicio resb 1
    valor_actual resb 1 
    acumulado resb 2
    idarchivo2 resd 1 ;para el archivo en donde se guardara el resultado

section .text
	global _start

_start: 
	
; lectura del archivo 1
;abrir archivo
	mov eax, 5   ; servicio para abrir el archivo
	mov ebx, patharchivo  ; direccion del archivo
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
	mov edx, 20
	int 80H
	
    ;presenta el contenido del primer archivo
	escribir contenido1, 20
	
    ;cierra el archivo
	mov eax, 6  		  ; servicio para abrir el archivo
	mov ebx, [idarchivo1]  ; direccion del archivo
	mov ecx, 0			  ;modo de acceso, read only=0
	mov edx, 0  		  ; permisos del archivo
	int 80H

    mov esi, 0
    mov ecx, 20


inicializar:
    mov edx, 0
    mov eax, 1
    mov [acumulado], eax

ciclo_principal:
    push ecx
    push edx
    add edx, '0'
    mov ebx, edx
    mov esi, ecx
    dec esi
    mov edx, 0

conteo_nro:
    mov al, [contenido1 + esi]
    dec esi
    cmp al, bl
    je incrementar_cont
    loop conteo_nro
    jmp resultados

incrementar_cont:
    add dl, 1
    loop conteo_nro

resultados:
    mov esi, [acumulado]
    mov [resultado+esi], bl
    add esi, 2
    add dl, '0'
    mov [resultado+esi], dl
    mov ecx, [acumulado]
    add ecx, 10
    mov [acumulado], ecx
    pop edx
    inc edx
    pop ecx
    cmp edx, 10
    je presentar
    jmp ciclo_principal

presentar: 
    escribir resultado, len_resultado
    jmp salir

error:
    escribir mensaje_error, len_error

salir:
    mov eax, 1
    int 80h