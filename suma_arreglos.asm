;este ejercicio se trata se la suma de los numeros de 2 arreglos estaticos
;la sumatoria de los valores del primer arreglo se compara con la sumatoria del segundo y se presenta cual de las 2 sumatorias es mayor
%macro escribir 2 
	mov eax, 4 
	mov ebx, 1
	mov ecx,%1
	mov edx,%2
	int 80h
%endmacro

section .data
	msj_mayor db 10,"El mayor es el PRIMER arreglo",10
	len_mayor equ $-msj_mayor
	msj_mayor1 db 10,"El mayor es el SEGUNDO arreglo",10
	len_mayor1 equ $-msj_mayor1
	msj_enter db 10,"",10
	msj_arr1 db 10,"La suma del primer arreglo es..",10
	len_arr1 equ $-msj_arr1
	msj_arr2 db 10,"La suma del segundo arreglo es..",10
	len_arr2 equ $-msj_arr2
	
	arreglo db 1,2,3,2
	len_arreglo equ $-arreglo
	arreglo1 db 1,4,3,1
	len_arreglo1 equ $-arreglo1
	
section .bss
	suma1 resb 1
	suma2 resb 1
	respuesta resb 1
	
section .text
		global _start

_start:

imprimir:		
	push ecx
	mov al, [arreglo+ecx]
	add al,[suma1]
	
	mov [suma1],al
	
	mov al, [arreglo1+ecx]
	add al,[suma2]
	mov [suma2],al
	

	pop ecx
	inc ecx
	cmp ecx, len_arreglo
	jb imprimir

 	mov al,[suma1]
	add al,'0'
	mov [suma1],al
		
	mov al,[suma2]
	add al,'0'
	mov [suma2],al
	
	escribir msj_arr1, len_arr1
	
	mov eax, 4
	mov ebx, 1
	mov ecx, suma1
	mov edx, 1
	int 80h 
	
	escribir msj_arr2, len_arr2
	
	mov eax, 4
	mov ebx, 1
	mov ecx, suma2
	mov edx, 1
	int 80h 

	
	mov al,[suma1]
	mov bl, [suma2]
	cmp  al, bl
	jb mayor
	mov eax, 4
	mov ebx, 1
	mov ecx, msj_mayor
	mov edx, len_mayor
	int 80h 
	
	jmp salir
mayor:
	mov eax, 4
	mov ebx, 1
	mov ecx, msj_mayor1
	mov edx, len_mayor1
	int 80h 
salir:
	mov eax,1
	mov ebx,0
	int 80h