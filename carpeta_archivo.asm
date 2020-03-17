; para poder leer lo escrito poner en consola: chmod 777 -R notas_examen.txt
; para leer lo escrito por consola sudo cat prueba_archivo.txt
;crea la carpeta, archivo estaticamente
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
    msj db 10,"Ingrese un texto hasta de 100 caracteres",10
    len equ $ - msj

    msj2 db 10,"Datos guardados en el archivo",10
    len2 equ $ - msj2

    msj3 db 10,"Carpeta creada con exito",10
    len3 equ $ - msj3

    mensaje_error db "Error en el archivo",10
    len_error equ $ - mensaje_error

    pathcreate db "/home/albert/Documentos/Ensamblador/carpeta_final",0
    lenpathcreate equ $ - pathcreate

    pathwrite db "/home/albert/Documentos/Ensamblador/carpeta_final/archivo_final.txt",0
    lenpath equ $ - pathwrite

section .bss
    texto resb 90
    idarchivowrite resd 1

section .text
    global _start
_start:
  
    ;****** imprimir primer mensaje solicitando que se escriba el texto en el archivo
    escribir msj, len

    ;****** se ingresa por teclado el texto
    leer texto, 90

    ;****** crea la carpeta
    mov eax, 39 ;subrutina
    mov ebx, pathcreate ;ruta(Direccion)
    mov ecx, 0x1FF ; perimisos de 777 octal, de lectura, escritura y ejecuccion 
    int 80h

    ;****** muestra el mensaje indicando que la carpeta sea creado con extio
    escribir msj3, len3

    ;****** escritura de archivo
    mov eax, 8 ;servicio para crear y escribir en el archivo
    mov ebx, pathwrite ;direccion del archivo
    mov edx, 2 ;modo de acceso, write and rad = 2
    mov ecx, 0x1FF ;permisos de 777 octal
    int 80h

    test eax, eax
    jz error
    mov dword [idarchivowrite], eax

    ;****** escribimos el texto en el archivo
    mov eax, 4
    mov ebx, [idarchivowrite] ; entrada estandar
    mov ecx, texto
    mov edx, 90
    int 80h

    ;****** imprimir segundo mensaje indicando que se han guarado los datos en el texto
    escribir msj2, len2

    mov eax, 6
    mov ebx, [idarchivowrite]
    mov ecx, 0
    mov edx, 0
    int 80h

    jmp salir

error:
    escribir mensaje_error, len_error

salir:
    mov eax, 1
    int 80h