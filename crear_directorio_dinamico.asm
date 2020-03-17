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
    msj db 10,"Ingese el directorio o carpeta a crear",10
    len_msj equ $ - msj

    msj1 db 10,"Carpeta o directorio creado",10
    len_msj1 equ $ - msj1

section .bss
    path resb 50

section .text
    global _start

_start:
    escribir msj, len_msj
    leer path, 50
    

    mov eax, 39 ; serivicio para crear un directorio
    mov ebx, path ; define la ruta del servicio
    mov ecx, 0x1FF ; definimos el permiso 777
    int 80h

    escribir msj1, len_msj1

    mov eax, 1
    int 80h


