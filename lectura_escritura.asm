; para poder leer lo escrito poner en consola: chmod 777 -R notas_examen.txt
; para leer lo escrito por consola sudo cat prueba_archivo.txt

%macro escribir 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro

section .data
    archivo db "/home/albert/Documentos/Ensamblador/prueba_archivo.txt",0
    mensaje_error db "error en el archivo",10
    len_error equ $ - mensaje_error

section .bss
    texto resb 35
    idarchivo resb 1

section .text
    global _start
_start:
    mov eax, 3
    mov ebx, 2 
    mov ecx, texto
    mov edx, 35
    int 80h

    mov eax, 8 ;subrutina
    mov ebx, archivo ;ruta(Direccion)
    mov ecx, 1 ;Acceso
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


