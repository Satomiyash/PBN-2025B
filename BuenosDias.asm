.model small
    .data
   
    arreglo1 db 75h,65h,6Eh,6Fh,73h,20h
   
    .code     
    mov bl,42h ;inmediato (B)
    mov al,bl ;por registro

    
    mov ah,2h 
    mov dl,al
    int 21h   ;Imprime "B"
                           
    mov ax,@data
    mov ds,ax 
    
    mov al,[0] ;indice 0 del arreglo(75h) (directo)
    
    mov ah,2h 
    mov dl,al
    int 21h   ;imprime "u"
    
    mov bx,1
    mov al,[bx] ;indice 1 del arreglo(65h) (de registro indirecto)
    
    mov ah,2h 
    mov dl,al
    int 21h   ;imprime "e"
               
    mov si,1
    mov bx,1
    mov al,[bx+si] ;indice (1+1 = 2) del arreglo (6Eh) (base mas indice)
    
    mov ah,2h 
    mov dl,al
    int 21h   ;imorime "n"
    
    mov bx,2
    mov al,[bx+1] ;indice (2+1 = 3) del arreglo (6Fh) (relativo por registro)
    
    mov ah,2h 
    mov dl,al
    int 21h   ;imprime "o"
            
    mov si,4
    mov al,arreglo1[si] ;indice (3) del arreglo (73h) (relativo base mas indice)
    
    mov ah,2h 
    mov dl,al
    int 21h   ;imprime "s"
    
    mov bx,1
    mov si,2
    mov al,[bx+2*si] ;(1+2*2 = 5) del arreglo (20h) (indice escalado)  
    
    mov ah,2h 
    mov dl,al
    int 21h   ;imprime espacio
    
    mov si,0
    mov (si),64h ;mueve 64h a el indice 0 del arreglo  (relativo base + indice)
    
    mov al,[0] ;guarda en al lo que se encuentra en el indice 0 del registro
    mov ah,2h 
    mov dl,al
    int 21h   ;imprime "d"
    
    mov ax,69h
    mov (1),ax ;mueve 69h al indice 1 del arreglo (directo)
    
    mov al,[1]  ;guarda en al lo que se encuentra en el indice 1 del registro
    mov ah,2h 
    mov dl,al
    int 21h   ;imprime "i"
    
    mov bx,2 
    mov ax,61h
    mov (bx),ax  ;mueve 61h al indice 2 del arreglo (indirecto por registro)
                        
    mov al,[2]   ;guarda en al lo que se encuentra en el indice 2 del registro
    mov ah,2h 
    mov dl,al
    int 21h   ;imprime "a"  
    
    mov bx,1
    mov si,1 
    mov ax,73h
    mov (bx+si+1),ax  ;mueve 73h al indice 3 del arreglo (base mas indice)
    
    mov al,[3]   ;guarda en al lo que se encuentra en el indice 3 del registro
    mov ah,2h 
    mov dl,al
    int 21h   ;imprime "s"
    
    mov si,2
    mov bx,1
    mov ax,20h
    mov (bx+1*si),ax  ;mueve 20h al indice 4 del arreglo (indice escalado)              

    mov al,[4]   ;guarda en al lo que se encuentra en el indice 4 del registro
    mov ah,2h 
    mov dl,al
    int 21h   ;imprime espacio 
    
    mov bl,0Fh ;Inmediato (corazon) 
    mov al,bl ;por registro

    
    mov ah,2h 
    mov dl,al
    int 21h   ;Imprime "sol"