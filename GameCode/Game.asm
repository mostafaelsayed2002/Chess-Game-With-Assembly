EXTRN Print:FAR

PUBLIC imgFilename,MODE,XSTART,YSTART


.model small
.STACK 64
.DATA 

XSTART DW 0
YSTART DW 0
COUNTCX DB 0
COUNTDX DB 0
CHECK DW 0



MODE DB 0
imgFilename DB 'GG', 0

.CODE 
MAIN PROC FAR 

  MOV AX , @DATA
  MOV DS , AX


;//////////////
mov AX,4F02h ;/
mov BX,103h  ;/  graph 800*600  256 colors
INT 10h      ;/
;//////////////

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MOV imgFilename[0],'G'
MOV imgFilename[1],'1'
MOV XSTART,525
MOV YSTART,75
CALL PRINT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MOV XSTART,0
MOV YSTART,0




MOV XSTART ,0
MOV YSTART,150

    MYLOOP:
    CALL PRINT
    ADD XSTART,75
   
    MOV AX,CHECK
    MOV BL,2
    DIV BL
    CMP AH,0
   JNE DRAWBACKGROUND2
   MOV imgFilename[0],'G'
   MOV imgFilename[1],'2' 

 
   JMP GO
   DRAWBACKGROUND2:
   MOV imgFilename[0],'G'
   MOV imgFilename[1],'1'
 
   GO:
   INC COUNTCX
   CMP COUNTCX,7
   JE MYLOOP
   INC CHECK
  
   CMP COUNTCX,8
  
   JNE MYLOOP

   MOV COUNTCX ,0 
   MOV XSTART,0
   ADD YSTART,75
   INC COUNTDX 
   CMP COUNTDX ,6

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






;MOV imgFilename[0],'G'
;MOV imgFilename[1],'1'
;MOV imgFilename[2],0
;MOV MODE,2
;
;
;MYOUTTER:
;MOV COUNTINNER,8
;
;MYINNER:
;CALL PRINT
;ADD XSTART,75
;ADD XEND,75
;INC CHECK
;
;MOV AX,CHECK
;MOV BL,2
;DIV BL
;CMP AH,0
;JNE ODD
;MOV imgFilename[0],'G'
;MOV imgFilename[1],'1'
;MOV imgFilename[2],0
;JMP GO
;ODD:
;MOV imgFilename[0],'G'
;MOV imgFilename[1],'2'
;MOV imgFilename[2],0
;GO:
;
;
; 
;DEC COUNTINNER
;JNZ MYINNER
;MOV XSTART,0
;MOV XEND,75
;ADD YSTART,75
;ADD YEND,75
;DEC COUNTOUTTER
;JNZ MYOUTTER

