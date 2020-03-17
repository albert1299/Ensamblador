%macro escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    msj db 10,"Carpeta o directorio creado",10
    len_msj equ $ - msj

    path db '/home/albert/Escritorio/mora',0
    len_path equ $ - path   

section .text
    global _start

_start:
    mov eax, 39 ; serivicio para crear un directorio
    mov ebx, path ; define la ruta del servicio
    mov ecx, 0x1FF ; definimos el permiso 777
    int 80h

    escribir msj, len_msj

    mov eax, 1
    int 80h


