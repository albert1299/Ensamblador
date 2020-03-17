%macro escribir 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro

section .data
   path db "/home/albert/Documentos/Ensamblador/carpeta2",0
    archivo db "/home/albert/Documentos/Ensamblador/carpeta2/archivo_new2.txt",0
    mensaje_error db "error en el archivo",10
    len_error equ $ - mensaje_error

section .bss
    texto resb 35
    idarchivo resb 1

section .text
    global _start
_start:
    ;****** crea la carpeta
    mov eax, 39 ;subrutina
    mov ebx, path ;ruta(Direccion)
    mov ecx, 0x1FF ; perimisos de 777 octal, de lectura, escritura y ejecuccion 
    int 80h

    mov eax, 3
    mov ebx, 2 
    mov ecx, texto
    mov edx, 35
    int 80h

    mov eax, 8 ;subrutina
    mov ebx, archivo ;ruta(Direccion)
    mov ecx, 2 ;Acceso
    mov edx, 0x1FF ;permiso 
    int 80h

    test eax, eax
    jz error
    mov dword [idarchivo], eax


    mov eax, 4
	mov ebx, [idarchivo]
	mov ecx, texto
	mov edx, 35
	int 80h

    jmp salir

error:
    escribir mensaje_error, len_error

salir:
    mov eax, 1
    int 80h
