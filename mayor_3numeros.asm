section .data
	msj_1 db 'Ingresar valor',10
	len_1 equ $-msj_1
	msj_p db 'Primero mayor',10
	len_p equ $-msj_p
	msj_s db 'Segundo mayor',10
	len_s equ $-msj_s
	msj_t db 'Tercero mayor',10
	len_t equ $-msj_t
section .bss
		n1 resb  5
		n2 resb  5
		n3 resb  5
section .text
	global _start
	
_start:
	
 ;primer número   
	mov eax,4
	mov ebx,1
	mov ecx,msj_1
	mov edx,len_1
	int 80h
	
	mov eax, 3 
	mov ebx, 2
	mov ecx, n1	
	mov edx, 5
	int 80h
	
	
	
;segundo numero 
	mov eax,4
	mov ebx,1
	mov ecx,msj_1
	mov edx,len_1
	int 80h
	
	
	mov eax, 3 
	mov ebx, 2
	mov ecx, n2	
	mov edx, 5
	int 80h
	
	
;tercer numero
	mov eax,4
	mov ebx,1
	mov ecx,msj_1
	mov edx,len_1
	int 80h
	
	mov eax, 3 
	mov ebx, 2
	mov ecx, n3	
	mov edx, 5
	int 80h	
	
	
	
;///////////////////////////	
	mov eax,[n1]
	mov ebx,[n2]
	mov ecx,[n3]

	
	cmp eax,ebx
	jg compare
	jmp compare2
	


compare:
	cmp eax,ecx
	jg pmayor
	jmp tmayor
	
compare2:
	cmp ebx,ecx
	jg smayor
	jmp tmayor

	
pmayor:
	mov eax,4
	mov ebx,1
	mov ecx,msj_p
	mov edx,len_p
	int 80h

	mov eax,1
	int 80h

smayor:
	mov eax,4
	mov ebx,1
	mov ecx,msj_s
	mov edx,len_s
	int 80h

	mov eax,1
	int 80h
	
tmayor:
	mov eax,4
	mov ebx,1
	mov ecx,msj_t
	mov edx,len_t
	int 80h

	mov eax,1
	int 80h