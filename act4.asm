       .model
        .stack
        .data
        u1 db 0                                     ;unidades del primer numero
        d1 db 0                                     ;decenas del primer numero
        c1 db 0                                     ;centenas de primer numero
        u2 db 0                                     ;unidades del segundo numero
        d2 db 0                                     ;decenas del segundo numero
        c2 db 0                                     ;centenas del segundo numero
        carry db 0                                  ;variable auxiliar para el acarreo
        msg db 'Sumador de dos numeros','$'                       ;titulo        
        msg1 db 10,13,10,13,17,'Ingrese el primer numero: ','$'   ;Mensaje 1 para el usuario
        msg2 db 10,13,17,'Ingrese el segundo numero: ','$'        ;Mensaje 2 para el usuario
        result DB 10,13,10,13,17,'El resultado es: 0000$'         ;Resultado
        .code
        
        mov ax,data
        mov ds,ax 
                 
        mov ah,09h
        lea dx,msg 
        int 21h       ;Muestra el titulo
        
        mov ah,09h    ;Muestra el mensaje 1
        lea dx,msg1  
        int 21h  
        
        mov ah,01h       ;Introduzco las centenas
        int 21h       
        sub al,30h       ;ASCII --> numero
        mov c1,al
        
        mov ah,01h       ;Introduzco las decenas
        int 21h       
        sub al,30h       ;ASCII --> numero
        mov d1,al    
        
        mov ah,01h       ;Introduzco las unidades
        int 21h       
        sub al,30h       ;ASCII --> numero
        mov u1,al 
        
        mov ah,09h
        lea dx,msg2    ;Muestra el mensaje 2
        int 21h  
        
        mov ah,01h       ;Introduzco las centenas
        int 21h       
        sub al,30h       ;ASCII --> numero
        mov c2,al
        
        mov ah,01h       ;Introduzco las decenas
        int 21h       
        sub al,30h       ;ASCII --> numero
        mov d2,al    
        
        mov ah,01h       ;Introduzco las unidades
        int 21h       
        sub al,30h       ;ASCII --> numero
        mov u2,al 
        
        mov si,offset result + 26  ;Apunta al final del buffer +26 por todo el texto que contiene el resultado
        MOV [SI], '$' ; Agregar terminador de cadena 
        
        dec si ; se le decrementa 1 para comenzar a escribir el resultado en el espacio reservado de las unidades (000_)
        
        xor ax,ax ;Borra lo que haya en ax
        mov bl,u1 ;Guarda en bl lo que hay en las unidades del 1er numero
        mov al,u2 ;Guarda en al lo que hay en las unidades del 2do numero
        add al,bl ;Suma las unidades (al+bl), resultado guardado en al
        mov bl,10 ;Guarda 10 en bl
        div bl    ;Divide lo que hay en ax(suma de unidades)/bl(10), el cociente lo guarda en ah, el residuo en al
        add ah,30h ;numero --> ASCII
        
        mov [si],ah  ;Guarda el residuo en el indice de las unidades del resultado (el ultimo 0, 000_)
        mov carry,al ;Guarda el cociente en una variable auxiliar carry  
        
        dec si   ;se le decrementa 1 para comenzar a escribir el resultado en el espacio reservado de las decenas (00_0)
        
        xor ax,ax ;Borra lo que haya en ax
        mov bl,d1 ;Guarda en bl lo que hay en las decenas del 1er numero
        mov al,d2 ;Guarda en al lo que hay en las decenas del 2do numero
        add al,bl ;Suma las decenas (al+bl), resultado guardado en al
        add al,carry ;Suma el acarreo de la suma anterior
         
        mov bl,10 ;Guarda 10 en bl
        div bl    ;Divide lo que hay en ax(suma de decenas y acarreo)/bl(10), el cociente lo guarda en ah, el residuo en al
        add ah,30h ;numero --> ASCII
        
        mov [si],ah  ;Guarda el residuo en el indice de las decenas del resultado (el penultimo 0, 00_0)
        mov carry,al ;Guarda el cociente en una variable auxiliar carry
        
                
        dec si ;se le decrementa 1 para comenzar a escribir el resultado en el espacio reservado de las centenas (0_00)
        
        xor ax,ax ;Borra lo que haya en ax
        mov bl,c1 ;Guarda en bl lo que hay en las centenas del 1er numero
        mov al,c2 ;Guarda en al lo que hay en las centenas del 2do numero
        add al,bl ;Suma las centenas (al+bl), resultado guardado en al
        add al,carry ;Suma el acarreo de la suma anterior
         
        mov bl,10  ;Guarda 10 en bl
        div bl     ;Divide lo que hay en ax(suma de centenas y acarreo)/bl(10), el cociente lo guarda en ah, el residuo en al
        add ah,30h ;numero --> ASCII
        add al,30h ;numero --> ASCII
        
        mov [si],ah ;Guarda el residuo en el indice de las centenas del resultado (el antepenultimo 0, 0_00)
        dec si      ;se le decrementa 1 para comenzar a escribir el resultado en el espacio reservado de las unidades de millar (_000)
        mov [si],al ;Guarda el cociente en el indice de las unidades de millar del resultado (el anteantepenultimo 0, _000) 
        
        MOV DX, offset result            ; Mostrar en pantalla
        MOV AH, 09h
        INT 21h

        mov ah, 4Ch   ;Termina el programa
        int 21h

        





