EXTRN imgFilename:BYTE
EXTRN MODE:BYTE

PUBLIC Print

.MODEL SMALL
.STACK 64
.DATA 

imgWidth  EQU 75
imgHeight EQU 75
imgFilehandle DW ?
imgData DB imgWidth*imgHeight dup(0) ; EVERY ELEMNT IS 96*96PIXAL

.CODE 

Print PROC FAR 

  MOV AX , @DATA
  MOV DS , AX






    CALL OpenFile
    CALL ReadData
	
    LEA BX , imgData ; BL contains index at the current drawn pixel
	
    MOV CX,0 ;COL 
    MOV DX,0   ;ROW
    MOV AH,0ch
	


; Drawing loop

   CMP MODE,0 ;;WHITE
    JNE DRAWBLACK
    drawLoopW:
    MOV AL,[BX]
    CMP AL,00H
    JE NODRAWB
    INT 10h 
    NODRAWB:
    INC CX
    INC BX
    CMP CX,imgWidth
    JNE drawLoopW 
	
    MOV CX , 0
    INC DX
    CMP DX , imgHeight
    JNE drawLoopW
    JMP EXIT 
    DRAWBLACK:



   CMP MODE,1 ;;BLACK
   JNE DRAWGREEN
    drawLoopB:
    MOV AL,[BX]
    CMP AL,0FH
    JE NODRAWW
    INT 10h
    NODRAWW: 
    INC CX
    INC BX
    CMP CX,imgWidth
    JNE drawLoopB 
	
    MOV CX , 0
    INC DX
    CMP DX , imgHeight
    JNE drawLoopB
    JMP EXIT 

   DRAWGREEN:
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


    EXIT:

    call CloseFile
    

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