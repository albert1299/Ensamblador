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
    msj1 db 10,"Ingrese un caracter",10
    len1 equ $ - msj1
    msj2 db "Es un numero",10
    len2 equ $ - msj2
    msj3 db "Es una consonante",10
    len3 equ $ - msj3
    msj4 db "Es un caracter especial",10
    len4 equ $ - msj4
    msj5 db "Es una vocal",10
    len5 equ $ - msj5

section .bss
    carac resb 1
    espacio resb 1

section .text
    global _start
_start:


ingresar:
    escribir msj1, len1
    leer carac, 1
    mov eax, [carac]

    mov ebx, 58
    cmp eax, ebx
    jb es_numero

    mov ebx, 64
    cmp eax, ebx
    jg es_consonante

    
es_numero:
    mov ebx, 48
    cmp eax, ebx
    jb es_especial
    escribir msj2, len2
    jmp ingresar
    
es_consonante:
    mov ebx, 91
    cmp eax, ebx
    je es_especial
    jg es_especial
    mov ebx, 65 ;para A
    cmp eax, ebx
    je es_vocal
    mov ebx, 69 ;para E
    cmp eax, ebx
    je es_vocal 
    mov ebx, 73 ;para I
    cmp eax, ebx
    je es_vocal
    mov ebx, 79 ;para O
    cmp eax, ebx
    je es_vocal
    mov ebx, 85 ;para U
    cmp eax, ebx
    je es_vocal
    escribir msj3, len3
    jmp ingresar

es_especial:
    escribir msj4, len4
    jmp ingresar

es_vocal:
    escribir msj5, len5
    jmp ingresar

salir:
    mov eax, 1
    int 80h