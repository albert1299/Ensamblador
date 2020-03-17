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
    msj1 db "Ingrese un número del 1 al 9 para determinar si es primo",10
    len_msj1 equ $ - msj1

    msj2 db "Es primo",10
    len_msj2 equ $ - msj2

    msj3 db "No es primo",10
    len_msj3 equ $ - msj3

section .bss
    num resb 1
    contado resb 1

section .text
    global _start
_start:
    escribir msj1, len_msj1
    leer num, 2

    mov bl, 0
    mov al, [num]
    sub al, '0'
    mov dl, al
    mov cl, 0

incrementar_contador:
    mov al, dl ;5 
    inc bl     ;1 - 2 - 3 - 4 - 5
    div bl  ;5/1 - 5/2 - 5/3 - 5/4 - 5/5
    cmp ah, 0 ; ah:0
    je incrementar_primo
    jmp incrementar_contador

incrementar_primo:
    inc cl ;1 - 2
    cmp bl, dl ; 5>5
    jg presentar
    je presentar
    jmp incrementar_contador

presentar:
    cmp dl, 4
    jg restar_contador
    jmp igual_contador

restar_contador:  
    sub cl, 1
    cmp cl, 2
    jg no_primo
    je si_primo
    jmp no_primo

igual_contador:
    cmp cl, 2
    jg no_primo
    je si_primo
    jmp no_primo

no_primo:
    ;add cl, '0'
    ;mov [contado], cl
    escribir msj3, len_msj3
    ;escribir contado, 1
    jmp salir 

si_primo:
    escribir msj2, len_msj2
    jmp salir 

salir:
    mov eax, 1
    int 80h



