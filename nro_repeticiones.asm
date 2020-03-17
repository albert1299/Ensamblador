; muestra cuantas veces se repite un numero entre varios nros, leyendo en nro que se desea buscar
; guarda el resultado en un archivo. Primero crear el txt con los numeros, hasta 10 numeros
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
    msj1 db 10,"Ingrese el numero que desea conocer cuantas veces se repite: ", 10
    len1 equ $ - msj1
    msj2 db 10,"Se ha guardado el resultado en el archivo ",10
    len2 equ $ - msj2
    resultado db 10,"El numero ingresado se repite   veces",10
    len_resultado equ $ - resultado

    patharchivo db "/home/albert/Documentos/Ensamblador/archivos_txt/nro_10digitos.txt",0
    lenpatharchivo equ $ - patharchivo

    pathresultado db "/home/albert/Documentos/Ensamblador/archivos_txt/veces_repetido.txt",0
    lenpathresultado equ $ - pathresultado 

    mensaje_error db "Error en el archivo",10
    len_error equ $ - mensaje_error

    
section .bss
    idarchivo1 resd 1 ;para el archivo que se lee
    contenido1 resb 10 ;para guardar el contenido del archivo leido
    n1 resb 1 ;para leer el numero ingresado por el usuario
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

    ; solicita un numero para luego buscarlo
    escribir msj1, len1
    leer n1, 2

    mov esi, 0
    mov ecx, 0

contador_total:
    mov al, [contenido1 + esi]
    cmp al, 58
    jb es_numero
    jmp definir_variables

es_numero: 
    cmp al, 47
    jb definir_variables
    je definir_variables
    inc ecx
    inc esi
    jmp contador_total
    

definir_variables:
    sub esi, 1 ;para el arreglo
    ;ecx tiene el valor del total de nros en el archivo.txt
    mov dl, 0 ;contador para las veces que se repite
    cmp ecx, 9
    jg decrementar_variable
    jmp conteo_nro
    
decrementar_variable:
    sub ecx, 1
    sub esi, 1

conteo_nro:
    
    mov al, [contenido1 + esi]

    mov bl, [n1]
    dec esi
    cmp al, bl
    je incrementar_cont
    loop conteo_nro
    jmp resultados

incrementar_cont:
    add dl, 1
    loop conteo_nro

resultados:
    mov esi, 31

    add dl, '0'
    mov [resultado+esi], dl

    escribir resultado, len_resultado

    ;****** creacion del archivo
    mov eax, 8 ;servicio para crear y escribir en el archivo
    mov ebx, pathresultado ;direccion del archivo
    mov edx, 2 ;modo de acceso, write and rad = 2
    mov ecx, 0x1FF ;permisos de 777 octal
    int 80h

    test eax, eax
    jz error
    mov dword [idarchivo2], eax

    ;****** escribimos el resultado en el archivo
    mov eax, 4
    mov ebx, [idarchivo2] ; entrada estandar
    mov ecx, resultado
    mov edx, 38
    int 80h

    ;****** imprimir segundo mensaje indicando que se han guarado el resultado en el archivo
    escribir msj2, len2

    mov eax, 6
    mov ebx, [idarchivo2]
    mov ecx, 0
    mov edx, 0
    int 80h

    jmp salir

error:
    escribir mensaje_error, len_error

salir:
    mov eax, 1
    int 80h
