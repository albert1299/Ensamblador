section .data
    msj1 db "Ingrese un caracter ",10
    len_msj1 equ $ - msj1
   
    nueva_linea db 10,''
    es_numero db "numero"
    len_es_numero equ $ - es_numero
    es_consonante db "consonante"
    len_es_consonante equ $ - es_consonante
    es_especial db "especial"
    len_es_especial equ $ - es_especial    
    es_vocal db "vocal"
    len_es_vocal equ $ - es_vocal    
section .bss
    num resb 2

section .text
    global _start
_start:
   
inicio:
;pedir caracter y leerlo
     call enter
     call imprimir_mensaje
     call leer_caracter
proceso:
     mov eax,[num]
     cmp eax,65
     je  imprimir_vocal
     cmp eax,69
     je imprimir_vocal
     cmp eax,73
     je imprimir_vocal
     cmp eax, 79
     je imprimir_vocal
     cmp eax, 85
     je imprimir_vocal
     cmp eax,47
     jg numero
     jmp consonante
numero:
     cmp eax,58
     jl imprimir_numero
     ;jmp consonante
consonante:
     cmp eax, 64
     jg si_cons
     jmp imprimir_especial
si_cons:
     cmp eax,91
     jl imprimir_consonante
     jmp imprimir_especial
leer_caracter:
    mov eax, 3
    mov ebx, 1
    mov ecx, num
    mov edx,1
    int 80H
    ret
imprimir_mensaje:
    mov eax, 4
    mov ebx, 2
    mov ecx, msj1
    mov edx,len_msj1
    int 80H
    ret

enter:
     
    mov eax, 4
    mov ebx, 2
    mov ecx, nueva_linea
    mov edx,1
    int 80H
    ret

imprimir_numero:
     
    mov eax, 4
    mov ebx, 2
    mov ecx, es_numero
    mov edx,len_es_numero
    int 80H
    call enter
    call imprimir_mensaje
    call leer_caracter
    jmp inicio
    ;jmp salir
imprimir_consonante:
    mov eax, 4
    mov ebx, 2
    mov ecx, es_consonante
    mov edx,len_es_consonante
    int 80H
    call enter
    jmp inicio
     ;jmp salir
imprimir_especial:
    mov eax, 4
    mov ebx, 2
    mov ecx, es_especial
    mov edx,len_es_especial
    int 80H
    call enter
    jmp inicio
     ;jmp salir
imprimir_vocal:
    mov eax, 4
    mov ebx, 2
    mov ecx, es_vocal
    mov edx,len_es_vocal
    int 80H
    call enter
    jmp inicio
     ;jmp salir
salir:
    call enter
    mov eax,1
    int 80h