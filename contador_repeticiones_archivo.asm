%macro escribir 2
    mov eax, 4
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80H
%endmacro

section .data
	msj_archivo1 db 10,'Lectura del archivo:', 10
	len1 equ $-msj_archivo1

	msj_repeticiones db 10,'Numero de repeticiones: ', 10
	len2 equ $-msj_repeticiones

	msj_resultado db '0=0 veces, 0=0 veces, 0=0 veces, 0=0 veces, 0=0 veces, 0=0 veces, 0=0 veces, 0=0 veces, 0=0 veces, 0=0 veces'
	len_resultado equ $-msj_resultado

	salto_linea db " ", 10
	len_salto db $-salto_linea

	path1 db "/home/albert/Documentos/Ensamblador/archivos_txt/numeros.txt", 0
	path2 db "/home/albert/Documentos/Ensamblador/archivos_txt/resultado_repeticiones.txt", 0

	cadena db  "          "
    len_cadena equ $-cadena

section .bss
	texto1 resb 30
	texto2 resb 30
	idarchivo1 resd 1
	idarchivo2 resd 1
	aux1 resb 20
	aux2 resb 20

	aux3 resb 1
	
	cont resb 30
	numero resb 20
	ind resb 10

section .text
	global _start

_start: 
	


	mov al, 0
	mov [cont], al
	mov [ind], al

;                 LECTURA DEL ARCHIVO
;~****************apertura del archivo****************
	mov eax, 5   ; servicio para abrir el archivo
	mov ebx, path1  ; direccion del archivo
	mov ecx, 0  ;modo de acceso, read only=0
	mov edx, 0  ; permisos del archivo
	int 80H
	
	;~ test == and --> el test solo modifica el estado de las banderas y define un 0
	test eax, eax
	jz salir
	
	;~ **********archivo sin excepciones************
	mov dword [idarchivo1], eax ; respaldo el id del archivo
	escribir msj_archivo1, len1
	
	; lee el contenido del archivo
    mov eax, 3
	mov ebx, [idarchivo1] ;entrada estandar
	mov ecx, texto1
	mov edx, 10
	int 80H
	
	escribir texto1, 10
	
;~****************cierre del archivo****************
	mov eax, 6  		  ; servicio para abrir el archivo
	mov ebx, [idarchivo1]  ; direccion del archivo
	mov ecx, 0			  ;modo de acceso, read only=0
	mov edx, 0  		  ; permisos del archivo
	int 80H

        
  	mov al, 0

ciclo1:
    mov [aux1], al
    cmp al, len_cadena
    jz salir
    mov bl, 0


ciclo2:
    mov [aux2], bl
    cmp bl, len_cadena
    jz finCiclo1

    mov cl, [texto1 + eax]
    mov dl, [texto1 + ebx]

    cmp cl, dl
    jz contador
    
finCiclo2:
    mov bl, [aux2]
    mov al, [aux1]; recuperamos el valor de eax
    inc bl
    jmp ciclo2


finCiclo1:

	call guardarResultado
	mov bl, 0
	mov [cont], bl

    mov al, [aux1]
    inc al
    jmp ciclo1

salir:
	;escribir msj_resultado, len_resultado
	call escribirTexto
    mov eax, 1
    mov ebx, 0
    int 80H

contador:
	mov [numero], dl

	mov al, [cont]
	inc al
	mov [cont],al
    jmp finCiclo2

guardarResultado:
	mov al, [cont]
	mov ecx, [ind]
	mov bl, [numero]
	mov [msj_resultado + ecx], bl
	inc ecx
	inc ecx
	add al, '0'
	mov [msj_resultado + ecx], al 

	add ecx, 9

	mov [ind], ecx

	ret

escribirTexto:
;                 ESCRITURA EN EL ARCHIVO
	mov eax, 8   ; servicio para crear y escribir en archivos
	mov ebx, path2  ; direccion del archivo
	mov ecx, 2  ;modo de acceso, read write=1
	mov edx, 200H  ; permisos del archivo
	int 80H
	
	;~ test == and --> el test solo modifica el estado de las banderas y define un 0
	test eax, eax  
	jz salir
	
	;~ **********archivo sin excepciones************
	mov dword [idarchivo2], eax ; respaldo el id del archivo
	escribir msj_repeticiones, len2

	escribir msj_resultado, len_resultado
	
	mov eax, 4 
	mov ebx, [idarchivo2]  
	mov ecx, msj_resultado	  
	mov edx, len_resultado	  
	int 80H

	
	
;~****************cierre del archivo****************
	mov eax, 6  		  ; servicio para abrir el archivo
	mov ebx, [idarchivo2]  ; direccion del archivo
	mov ecx, 0			  ;modo de acceso, read only=0
	mov edx, 0  		  ; permisos del archivo
	int 80H
	ret