;NOmbre: ALbert Mora

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
    msj1 db 10,"Ingrese el primer número: "
    len_msj1 equ $ - msj1

    msj2 db "Ingrese el siguiente número: "
    len_msj2 equ $ - msj2
    nueva_linea db 10,""
    
    

section .bss
    num1 resb 1


section .text
    global _start
_start:
    
    escribir msj1, len_msj1
    leer num1, 2

    mov eax, [num1]
    push eax

    mov ebx, 1

comparar:
    cmp ebx, 4
    jg presentar
    jmp ingresar_num

ingresar_num:  
    push ebx
    escribir msj2, len_msj2
    leer num1, 2
    pop ebx
    pop eax
    mov ecx, [num1]
    cmp eax, ecx
    jg colocar
    jmp cambiar

colocar: 
    push eax
    push ecx
    pop ebx
    inc ebx
    jmp comparar

cambiar: 
    mov ebx, eax
    mov eax, ecx
    mov ecx, ebx
    push eax
    push ecx
    pop ebx
    inc ebx
    jmp comparar

presentar:
    pop eax
    add eax, '0'
    escribir eax, 1
    pop ebx
    add ebx, '0'
    escribir ebx, 1
    pop ecx
    add ecx, '0'
    escribir ecx, 1
    pop edx
    add edx, '0'
    escribir edx, 1



salir:
    mov eax, 1
    int 80h



