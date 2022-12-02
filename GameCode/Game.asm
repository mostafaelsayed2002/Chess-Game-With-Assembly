EXTRN Print:FAR
PUBLIC imgFilename


.model small
.STACK 64
.DATA 

imgFilename DB 'mostafa.bin', 0

.CODE 
MAIN PROC FAR 

  MOV AX , @DATA
  MOV DS , AX

    CALL Print   
 
 CALL Print 


MAIN ENDP
END MAIN    




