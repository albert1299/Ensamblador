section .data
    numero1 db '518'
    numero2 db '197'
    resultado db '   '
    len_resultado equ $ - resultado

section .text
    global _start
_start:
    mov esi, 2
    mov ecx, 3
    clc ; Desactiva el bit de la bandera carry

proceso_resta:
    mov al, [numero1 + esi]
    ;mov ah, [numero2 + esi]
    ;adc al, ah

    sbb al, [numero2 + esi]
    aas ;ajuste al sistema bcd
    pushf
    or al, 30h
    popf

    mov [resultado+esi], al
    dec esi
    loop proceso_resta

    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, len_resultado
    int 80h


    mov eax, 1
    int 80h