EXTRN Print:FAR
PUBLIC imgFilename,MODE,XSTART,YSTART,XEND,YEND


.model small
.STACK 64
.DATA 

XSTART DW 0
YSTART DW 0
XEND   DW 75
YEND   DW 75
COUNTCX DB 0
COUNTDX DB 0
CHECK DW 0



MODE DB 0
imgFilename DB 'mostafa.bin', 0

.CODE 
MAIN PROC FAR 

  MOV AX , @DATA
  MOV DS , AX


;//////////////
mov AX,4F02h ;/
mov BX,105h  ;/  graph 800*600  256 colors
INT 10h      ;/
;//////////////


MOV XSTART,0
MOV XEND,75
MOV YSTART,0
MOV YEND,75
MOV imgFilename[0],'G'
MOV imgFilename[1],'1'
MOV imgFilename[2],0
MOV MODE,2

    MYLOOP:
    CALL PRINT
    ADD XSTART,75
    ADD XEND,75
   
    MOV AX,CHECK
    MOV BL,2
    DIV BL
    CMP AH,0
   JNE DRAWBACKGROUND2
   MOV imgFilename[0],'G'
   MOV imgFilename[1],'2' 
   MOV imgFilename[2],0
 
   JMP GO
   DRAWBACKGROUND2:
   MOV imgFilename[0],'G'
   MOV imgFilename[1],'1'
   MOV imgFilename[2],0
   GO:
   INC CHECK
   INC COUNTCX
   CMP COUNTCX,8
  
   JNE MYLOOP


   MOV COUNTCX ,0
   MOV XSTART,0
   MOV XEND,75
   ADD YEND,75
   ADD YSTART,75
   INC COUNTDX
   CMP COUNTDX ,8

    JNE MYLOOP





                                         ;; MODE 0 ==>FOR PRINT WHITE PIC
                                         ;; MODE 1 ==>FOR PRINT BLACK PIC
                                         ;; MODE 2 ==>FOR PRINT SOLID SQUARE (GREEN1,GREEN2) PIC   






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




