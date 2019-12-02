section .data
	mensaje db "Hola ensamblador"
	tamano equ $-mensaje

section .text
	global _start;

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, mensaje 
	mov edx, tamano 
	int 80H ;Interrupción 

	mov eax, 1
	int 80H

	;Para ejecutar:
	;- Ir a la carpeta
	;ls
	;nasm -f elf primer_programa.asm 
	;ld -m elf_i386 -s-o primer primer_programa.o
	;./primer
