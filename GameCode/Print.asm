EXTRN imgFilename:BYTE

PUBLIC Print

.MODEL SMALL
.STACK 64
.DATA 

imgWidth  EQU 96
imgHeight EQU 96
imgFilehandle DW ?
imgData DB imgWidth*imgHeight dup(0) ; EVERY ELEMNT IS 96*96PIXAL

.CODE 

Print PROC FAR 

  MOV AX , @DATA
    MOV DS , AX

;//////////////
mov AX,4F02h ;/
mov BX,105h  ;/  graph 1024x768  256 colors
INT 10h      ;/
;//////////////

    CALL OpenFile
    CALL ReadData
	
    LEA BX , imgData ; BL contains index at the current drawn pixel
	
    MOV CX,0
    MOV DX,0
    MOV AH,0ch
	
; Drawing loop
    drawLoop:
    MOV AL,[BX]
    INT 10h 
    INC CX
    INC BX
    CMP CX,imgWidth
    JNE drawLoop 
	
    MOV CX , 0
    INC DX
    CMP DX , imgHeight
    JNE drawLoop

	
    ; Press any key to exit
    MOV AH , 0
    INT 16h
    
    call CloseFile
    
    ;Change to Text MODE
    MOV AH,0          
    MOV AL,03h
    INT 10h 

    ; return control to operating system
    MOV AH , 4ch
    INT 21H




Print ENDP








OpenFile PROC 

    ; Open file

    MOV AH, 3Dh
    MOV AL, 0 ; read only
    LEA DX,imgFilename
    INT 21h
    ; you should check carry flag to make sure it worked correctly
    ; carry = 0 -> successful , file handle -> AX
    ; carry = 1 -> failed , AX -> error code
    MOV [imgFilehandle], AX
    RET

OpenFile ENDP

ReadData PROC
    MOV AH,3Fh
    MOV BX, [imgFilehandle]
    MOV CX,imgWidth*imgHeight ; number of bytes to read
    LEA DX, imgData
    INT 21h
    RET
ReadData ENDP 


CloseFile PROC
	MOV AH, 3Eh
	MOV BX, [imgFilehandle]
	INT 21h
	RET
CloseFile ENDP



END Print