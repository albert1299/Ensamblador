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
    msj db 10,"Ingese el directorio del archivo a crear",10
    len_msj equ $ - msj

    msj1 db 10,"Archivo creado",10
    len_msj1 equ $ - msj1

section .bss
    d_archivo resb 50

section .text
    global _start

_start:
    escribir msj, len_msj
    leer d_archivo, 60
    
    mov eax, 8
    mov ebx, d_archivo
    mov ecx, 0x1FF ; definimos el permiso 777
    int 80h

    escribir msj1, len_msj1

    mov eax, 1
    int 80h
