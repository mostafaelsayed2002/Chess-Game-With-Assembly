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


;//////////////
mov AX,4F02h ;/
mov BX,103h  ;/  graph 800*600  256 colors
INT 10h      ;/
;//////////////


mov imgFilename[0],'g'
mov imgFilename[1],'r'
mov imgFilename[2],'e'
mov imgFilename[3],'e'
mov imgFilename[4],'n'
mov imgFilename[5],'2'
mov imgFilename[6],'.'
mov imgFilename[7],'b'
mov imgFilename[8],'i'
mov imgFilename[9],'n'
mov imgFilename[10],0
MOV MODE ,2
CALL Print 

mov imgFilename[0],'w'
mov imgFilename[1],'k'
mov imgFilename[2],'i'
mov imgFilename[3],'n'
mov imgFilename[4],'g'                   ;; MODE 0 ==>FOR PRINT WHITE PIC
mov imgFilename[5],'.'                   ;; MODE 1 ==>FOR PRINT BLACK PIC
mov imgFilename[6],'b'                   ;; MODE 2 ==>FOR PRINT SOLID SQUARE (GREEN1,GREEN2) PIC   
mov imgFilename[7],'i'
mov imgFilename[8],'n'
mov imgFilename[9],0
MOV MODE ,1                       
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




