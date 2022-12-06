EXTRN Print:FAR
PUBLIC imgFilename,MODE


.model small
.STACK 64
.DATA 

MODE DB 0
imgFilename DB 'mostafa.bin', 0

.CODE 
MAIN PROC FAR 

  MOV AX , @DATA
  MOV DS , AX


mov imgFilename[0],'g'
mov imgFilename[1],'r'
mov imgFilename[2],'e'
mov imgFilename[3],'e'
mov imgFilename[4],'n'
mov imgFilename[5],'1'
mov imgFilename[6],'.'
mov imgFilename[7],'b'
mov imgFilename[8],'i'
mov imgFilename[9],'n'
mov imgFilename[10],0

CALL Print 

mov imgFilename[0],'W'
mov imgFilename[1],'k'
mov imgFilename[2],'i'
mov imgFilename[3],'n'
mov imgFilename[4],'g'
mov imgFilename[5],'.'
mov imgFilename[6],'b'
mov imgFilename[7],'i'
mov imgFilename[8],'n'
mov imgFilename[9],0
CALL Print 










   ; Press any key to exit
   MOV AH , 0
   INT 16h
   ;Change to Text MODE
    MOV AH,0          
    MOV AL,03h
    INT 10h 
    ;return control to operating system
    MOV AH , 4ch
    INT 21H




MAIN ENDP
END MAIN    




