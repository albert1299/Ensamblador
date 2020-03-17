;lectura de archivos

%macro escribir 2
	mov eax, 4
	mov ebx, 1
	mov ecx, %1
	mov edx, %2
	int 80h
%endmacro


section .data
    archivo db "/home/albert/Documentos/Ensamblador/borra/lectura.txt",0
    mensaje_error db "error en el archivo",10
    len_error equ $ - mensaje_error

section .bss
    texto resb 80
    idarchivo resb 1

section .text
    global _start:
_start:
    mov eax, 5 ;se convoca una subrutina de lectura al SO
    mov ebx, archivo
    mov ecx, 0 ;modos de acceso
    ; R-only = 0, W-only = 1, RDWR =2
    mov edx, 0 ;permisos

    int 80h

    test eax, eax ; bandera zero = 0
    jz error
    mov dword [idarchivo], eax

    mov eax, 3
    mov ebx, [idarchivo]
    mov ecx, texto
    mov edx, 80
    int 80h

    escribir texto, 80

    ;cerrar archivo:
    mov eax, 6
    mov ebx, [idarchivo]
    mov ecx, 0
    mov edx, 0
    int 80h

    jmp salir


error:
    escribir mensaje_error, len_error

salir:
    mov eax, 1
    int 80h

    



