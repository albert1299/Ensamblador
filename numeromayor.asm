
section .data
    msj1 db 10,"Número mayor"
	len1 equ $ - msj1 

	msj2 db "Número menor"
	len2 equ $ - msj2

section .text
    global _start
_start:
    mov al, 7
    mov bl, 6
    cmp al, bl
    jg mayor ;(zf = 0) (cf=0)
    jmp menor
 
mayor:
    mov eax, 4
    mov ebx, 1
    mov ecx, msj1
    mov edx, len1
    int 80h
    jmp salir

menor:
    mov eax, 4
    mov ebx, 1
    mov ecx, msj2
    mov edx, len2
    int 80h

salir: 
    mov eax, 1
    int 80h
