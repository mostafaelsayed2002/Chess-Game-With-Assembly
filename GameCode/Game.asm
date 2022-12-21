.286
EXTRN Print:FAR
EXTRN PrintGrid:FAR
EXTRN PRINTB:FAR
PUBLIC imgFilename,MODE,XSTART,YSTART,XSTARTB,YSTARTB,MODEB


.model small
.STACK 512
.DATA

SHAPESTORAGE    DB  'Y','Y' 
PLACESTORAGEX    DW 0  
PLACESTORAGEY    DW 0 

SHAPESTORAGEB    DB  'Y','Y' 
PLACESTORAGEXB    DW 0  
PLACESTORAGEYB   DW 0 

  XSTARTB      DW 0
  YSTARTB      DW 0


  XSTART      DW 0
  YSTART      DW 0
  MODE        DB 2
  COUNT       DB 4
  MODEB        DB 2

SIZE_XY         DB 75
rowNo           DB 0
columnNo        DB 0
place           DW 0

placeB           DW 0

XOLD DW 0
XNEW DW 0
YOLD DW 0
YNEW DW 0
;; for queen /BISHOP/ROOK
IsQueen DB 0
IsQUEENB DB 0

;;================
XKILLED DW 625
YKILLED DW 0
;;================


;;==========
RANDOMPLACE DW 96 




imgFilename DB 'G1', 0


                ; 'G','L','W','R',       'G','D','W','H',       'G','L','W','S',       'G','D','W','Q',       'G','L','W','K',       'G','D','W','S',       'G','L','W','H',       'G','D','W','R',

                ; 'G','D','W','P',       'G','L','W','P',       'G','D','W','P',       'G','L','W','P',       'G','D','W','P',       'G','L','W','P',       'G','D','W','P',       'G','L','W','P',

                ; 'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',

                ; 'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',

                ; 'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',

                ; 'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',

                ; 'G','L','B','P',       'G','D','B','P',       'G','L','B','P',       'G','D','B','P',       'G','L','B','P',       'G','D','B','P',       'G','L','B','P',       'G','D','B','P',

                ; 'G','D','B','R',       'G','L','B','H',       'G','D','B','S',       'G','L','B','Q',       'G','D','B','K',       'G','L','B','S',       'G','D','B','H',       'G','L','B','R',
                 
STATE0       DB         'G','L','W','R'  ,'G','D','W','H'  ,'G','L','W','S'  ,'G','D','W','Q'  ,'G','L','W','K'  ,'G','D','W','S' ,'G','L','W','H'  ,'G','D','W','R'

STATE1       DB         'G','D','W','P'  ,'G','L','W','P'  ,'G','D','W','P'  ,'G','L','W','P'  ,'G','D','W','P'  ,'G','L','W','P' ,'G','D','W','P'  ,'G','L','W','P'

STATE2       DB         'G','L','X','X'  ,'G','D','X','X'  ,'G','L','X','X'  ,'G','D','X','X'  ,'G','L','X','X'  ,'G','D','X','X' ,'G','L','X','X'  ,'G','D','X','X'

STATE3       DB         'G','D','X','X'  ,'G','L','X','X'  ,'G','D','X','X'  ,'G','L','X','X'  ,'G','D','X','X'  ,'G','L','X','X' ,'G','D','X','X'  ,'G','L','X','X'

STATE4       DB         'G','L','X','X'  ,'G','D','X','X'  ,'G','L','X','X'  ,'G','D','X','X'  ,'G','L','X','X'  ,'G','D','X','X' ,'G','L','X','X'  ,'G','D','X','X'

STATE5       DB         'G','D','X','X'  ,'G','L','X','X'  ,'G','D','X','X'  ,'G','L','X','X'  ,'G','D','X','X'  ,'G','L','X','X' ,'G','D','X','X'  ,'G','L','X','X'

STATE6       DB         'G','L','B','P'  ,'G','D','B','P'  ,'G','L','B','P'  ,'G','D','B','P'  ,'G','L','B','P'  ,'G','D','B','P' ,'G','L','B','P'  ,'G','D','B','P'

STATE7       DB         'G','D','B','R'  ,'G','L','B','H'  ,'G','D','B','S'  ,'G','L','B','Q'  ,'G','D','B','K'  ,'G','L','B','S' ,'G','D','B','H'  ,'G','L','B','R'



TIME0        DB         'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0 ,'X','X','X',0  ,'X','X','X',0

TIME1        DB         'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0 ,'X','X','X',0  ,'X','X','X',0

TIME2        DB         'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0 ,'X','X','X',0  ,'X','X','X',0

TIME3        DB         'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0 ,'X','X','X',0  ,'X','X','X',0

TIME4        DB         'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0 ,'X','X','X',0  ,'X','X','X',0

TIME5        DB         'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0 ,'X','X','X',0  ,'X','X','X',0

TIME6        DB         'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0 ,'X','X','X',0  ,'X','X','X',0

TIME7        DB         'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0  ,'X','X','X',0 ,'X','X','X',0  ,'X','X','X',0
                                  
ENTERNAME  DB 'PLEASE ENTER YOUR NAME:', 13 ,10 ,'$'
ENTERKEY  DB 'PLEASE ENTER KEY TO CONTINUE:', 13 ,10 ,'$'
  InDATA db 30,?,30 dup('$')



ENTERF1  DB 'TO START CHATING PRESS F1', 13 ,10 ,'$'
ENTERF2  DB 'TO START THE GAME PRESS F2', 13 ,10 ,'$'
ENTERESC  DB 'TO END THE PROGRAM PRESS ESC', 13 ,10 ,'$'


.CODE
MAIN PROC FAR

          MOV  AX , @DATA
          MOV  DS , AX
;//////////////////////////////HOME PAGE///////////////////////////

 
  mov ax,0600h
  mov bh,07
  mov cx,0
  mov dx,184fh
  int 10h

mov ah,02
mov bh,00
mov dl,0
mov dh,0
int 10h


MOV DX,OFFSET ENTERNAME
MOV AH,9
INT 21h

mov ah,02
mov bh,00
mov dl,5
mov dh,1
int 10h


mov ah,0AH
mov dx,offset InDATA
int 21h

mov ah,02
mov bh,00
mov dl,0
mov dh,15
int 10h


MOV DX,OFFSET ENTERKEY
MOV AH,9
INT 21h

MOV AH,00
INT 16H

mov ax,0600h
mov bh,07
mov cx,0
mov dx,184fh
int 10h

mov ah,02
mov bh,00
mov dl,20
mov dh,10
int 10h


MOV DX,OFFSET ENTERF1
MOV AH,9
INT 21h

mov ah,02
mov bh,00
mov dl,20
mov dh,11
int 10h

MOV DX,OFFSET ENTERF2
MOV AH,9
INT 21h


mov ah,02
mov bh,00
mov dl,20
mov dh,12
int 10h

MOV DX,OFFSET ENTERESC
MOV AH,9
INT 21h

JJMP:
MOV AH,00H
INT 16h

;;CMP AH,3BH
;;MOVE TO CHATTING
CMP AH,3CH
JE GAME

CMP AH,01H
JNE JJMP
JMP PRESS_ESC



 
 



;///////////////////////////////////////////////////////////////////



 GAME:
  ;//////////////
          mov  AX,4F02h            ;/
          mov  BX,105h             ;/  graph 1024x768  256 colors
          INT  10h                 ;/
  ;//////////////
      MOV  imgFilename[0],'M'
      MOV  imgFilename[1],'O'
          MOV XSTART, 625






BLUELOOPOUTTER:
  
   BLUELOOPINNER:
          CALL PRINT
          ADD YSTART,75
          CMP YSTART,600        
  JNE BLUELOOPINNER
        ADD XSTART,75
        MOV YSTART,0
        CMP XSTART,1000
JNE  BLUELOOPOUTTER

MOV XSTART,0
MOV YSTART,0


  ;;; PRINT GRID==============================


  MYLOOP: 
          MOV  imgFilename[0],'G'
          MOV  imgFilename[1],'1'
          call PrintGrid
          ADD  YSTART,75
          MOV  imgFilename[0],'G'
          MOV  imgFilename[1],'2'
          call PrintGrid
          ADD  YSTART,75
          DEC  COUNT
          JNZ  MYLOOP
  ;;==============================================
   
;;;PRINT POWN==================================
          MOV  imgFilename[0],'W'
          MOV  imgFilename[1],'P'
          MOV  XSTART,0
          MOV  YSTART,75
          MOV  MODE ,0
          MOV  COUNT ,8
  MYLOOP1:
          CALL PRINT
          ADD  XSTART,75
          DEC  COUNT
          JNE  MYLOOP1

          MOV  imgFilename[0],'B'
          MOV  imgFilename[1],'P'
          MOV  XSTART,0
          MOV  YSTART,450
          MOV  MODE ,1
          MOV  COUNT ,8
  MYLOOP2:
          CALL PRINT
          ADD  XSTART,75
          DEC  COUNT
          JNE  MYLOOP2
  ;;============================================


  ;;;PRINT LAST ROW==================================
          MOV  imgFilename[0],'B'
          MOV  imgFilename[1],'R'
          MOV  XSTART,0
          MOV  YSTART,525
          CALL PRINT
          MOV  imgFilename[0],'B'
          MOV  imgFilename[1],'H'
          MOV  XSTART,75
          MOV  YSTART,525
          CALL PRINT
          MOV  imgFilename[0],'B'
          MOV  imgFilename[1],'S'
          MOV  XSTART,150
          MOV  YSTART,525
          CALL PRINT
          MOV  imgFilename[0],'B'
          MOV  imgFilename[1],'Q'
          MOV  XSTART,225
          MOV  YSTART,525
          CALL PRINT
          MOV  imgFilename[0],'B'
          MOV  imgFilename[1],'K'
          MOV  XSTART,300
          MOV  YSTART,525
          CALL PRINT

          MOV  imgFilename[0],'B'
          MOV  imgFilename[1],'S'
          MOV  XSTART,375
          MOV  YSTART,525
          CALL PRINT
          MOV  imgFilename[0],'B'
          MOV  imgFilename[1],'H'
          MOV  XSTART,450
          MOV  YSTART,525
          CALL PRINT

          MOV  imgFilename[0],'B'
          MOV  imgFilename[1],'R'
          MOV  XSTART,525
          MOV  YSTART,525
          CALL PRINT
 ;;============================================

  MOV MODE,0
  ;;;PRINT FIRST ROW==================================
          MOV  imgFilename[0],'W'
          MOV  imgFilename[1],'R'
          MOV  XSTART,0
          MOV  YSTART,0
          CALL PRINT
          MOV  imgFilename[0],'W'
          MOV  imgFilename[1],'H'
          MOV  XSTART,75
          MOV  YSTART,0
          CALL PRINT
          MOV  imgFilename[0],'W'
          MOV  imgFilename[1],'S'
          MOV  XSTART,150
          MOV  YSTART,0
          CALL PRINT
          MOV  imgFilename[0],'W'
          MOV  imgFilename[1],'Q'
          MOV  XSTART,225
          MOV  YSTART,0
          CALL PRINT
          MOV  imgFilename[0],'W'
          MOV  imgFilename[1],'K'
          MOV  XSTART,300
          MOV  YSTART,0
          CALL PRINT

          MOV  imgFilename[0],'W'
          MOV  imgFilename[1],'S'
          MOV  XSTART,375
          MOV  YSTART,0
          CALL PRINT
          MOV  imgFilename[0],'W'
          MOV  imgFilename[1],'H'
          MOV  XSTART,450
          MOV  YSTART,0
          CALL PRINT

          MOV  imgFilename[0],'W'
          MOV  imgFilename[1],'R'
          MOV  XSTART,525
          MOV  YSTART,0
          CALL PRINT
 ;;============================================

;;PRINT Highlight CELL===================================================
          MOV  imgFilename[0],'F'         
          MOV  imgFilename[1],'R'
          MOV  XSTART,0             ;PRINT HIGHLIGHT AT THE FIRST CELL
          MOV  YSTART,0
          MOV MODE,1
          CALL PRINT
;;PLAYER TWO
          MOV  imgFilename[0],'F'         
          MOV  imgFilename[1],'B'
          MOV  XSTARTB,525             ;PRINT HIGHLIGHT AT THE FIRST CELL
          MOV  YSTARTB,525
          MOV MODEB,1
          CALL PRINTB





MOV AH,2
MOV DH,40
MOV DL,75
MOV BH,0
INT 10h


MOV AH,09H
MOV AL,'A'
MOV BL,6FH
MOV BH,0
MOV CX,1

INT 10h



;;==========================================================================
;;  THIS PART OF CODE DO 
;;  WAIT FOR THE KEYBOARD CLICK AND GET IT 
;;=========================================================================
	CheckKeyPressed:
        mov AH,00H
        int 16h
	
        CMP AH, 48H     ;SCANCODE FOR UP ARROW
        jne not_up1
        jmp PRESS_UP1
        not_up1:
	
        CMP AH, 50H     ;SCANCODE FOR DOWN ARROW
        jne not_down1
        jmp PRESS_DOWN1
        not_down1:	
      
        CMP AH, 4BH     ;SCANCODE FOR LEFT ARROW
        jne not_left1
        jmp PRESS_LEFT1
        not_left1:
        CMP AH, 4DH     ;SCANCODE FOR UP ARROW
        jne not_right1
        jmp PRESS_RIGHT1
        not_right1:

        CMP AH,1CH     ;SCANCODE FOR UP ENTER
        jne not_enter
        jmp PRESS_ENTER
        not_enter:
;;==========================================================================
;;  FOR PLAYER TWO 
;;;==================THIS PART WILL DELETED AFTER PHASE 1===================
;;==========================================================================
	
        CMP AH, 11H     ;SCANCODE FOR W
        jne not_up2
        jmp PRESS_UP2
        not_up2:
	
        CMP AH, 1FH     ;SCANCODE FOR S
        jne not_down2
        jmp PRESS_DOWN2
        not_down2:	
      
        CMP AH, 1EH     ;SCANCODE FOR A
        jne not_left2
        jmp PRESS_LEFT2
        not_left2:
        CMP AH, 20H     ;SCANCODE FOR D 
        jne not_right2
        jmp PRESS_RIGHT2
        not_right2:

        CMP AH,10H     ;SCANCODE FOR UP Q
        jne not_q
        jmp PRESS_Q
        not_Q:

        CMP AH, 01H     ;SCANCODE FOR ESC
        jne not_esc
        jmp PRESS_ESC
        not_esc:

        JMP CheckKeyPressed

	
;;==========================================================================
;;  THIS PART OF CODE DO 
;;  1-MOVE HIGHLIGHT OF FIRST PLAYER
;;=========================================================================
        PRESS_UP1:
        MOV BX,YSTART
        SUB BX,75 
        CMP BX,0
        JL CheckKeyPressed
        CALL PrintInState          ;removing the highlight from current cell
        MOV  imgFilename[0],'F' 
        MOV  imgFilename[1],'R'
        MOV MODE,1
        SUB YSTART,75  
	CALL PRINT               ;printing the highlight in the new cell
        JMP CheckKeyPressed

        PRESS_DOWN1:
        MOV BX,YSTART
        ADD BX,75 
        CMP BX,525
        JA JMPGO1
        CALL PrintInState
        MOV  imgFilename[0],'F'
        MOV  imgFilename[1],'R'
        MOV MODE,1
	ADD YSTART,75
        CALL PRINT
        JMPGO1:
        JMP CheckKeyPressed

	PRESS_LEFT1:
        MOV BX,XSTART
        SUB BX,75 
        CMP BX,0
        JL JMPGO1
        CALL PrintInState
        MOV  imgFilename[0],'F'
        MOV  imgFilename[1],'R'
        MOV MODE,1
	SUB XSTART,75
        CALL PRINT
        JMP CheckKeyPressed
	
	PRESS_RIGHT1: 
        MOV BX,XSTART
        ADD BX,75 
        CMP BX,525
        JA JMPGO1
        CALL PrintInState
        MOV  imgFilename[0],'F'
        MOV  imgFilename[1],'R'
        MOV MODE,1
	ADD XSTART,75
        CALL PRINT
        JMP CheckKeyPressed
	
;;==========================================================================
;;  THIS PART OF CODE DO 
;;  1-MOVE HIGHLIGHT OF PLAYER TWO
;;;==================THIS PART WILL DELETED AFTER PHASE 1===================
;;==========================================================================
        PRESS_UP2:
        MOV BX,YSTARTB
        SUB BX,75 
        CMP BX,0
        JL JMPGO2
        CALL PrintInStateB          ;removing the highlight from current cell
        MOV  imgFilename[0],'F' 
        MOV  imgFilename[1],'B'
        MOV MODEB,1
        SUB YSTARTB,75  
	CALL PRINTB               ;printing the highlight in the new cell
        JMP CheckKeyPressed

        PRESS_DOWN2:
        MOV BX,YSTARTB
        ADD BX,75 
        CMP BX,525
        JA JMPGO2
        CALL PrintInStateB
        MOV  imgFilename[0],'F'
        MOV  imgFilename[1],'B'
        MOV MODEB,1
	ADD YSTARTB,75
        CALL PRINTB
        JMPGO2:
        JMP CheckKeyPressed

	PRESS_LEFT2:
        MOV BX,XSTARTB
        SUB BX,75 
        CMP BX,0
        JL JMPGO2
        CALL PrintInStateB
        MOV  imgFilename[0],'F'
        MOV  imgFilename[1],'B'
        MOV MODEB,1
	SUB XSTARTB,75
        CALL PRINTB
        JMP CheckKeyPressed
	
	PRESS_RIGHT2: 
        MOV BX,XSTARTB
        ADD BX,75 
        CMP BX,525
        JA JMPGO2
        CALL PrintInStateB
        MOV  imgFilename[0],'F'
        MOV  imgFilename[1],'B'
        MOV MODEB,1
	ADD XSTARTB,75
        CALL PRINTB
        here:
        JMP CheckKeyPressed

;;==========================================================================
;;  THIS PART OF CODE DO 
;;  1-WHEN FIRST PLAYER PRESSED ENTER ON A CELL
;;  2-THEN CHECK IF THE "SHAPESTORAGE" IS EMPTY OR NOT 
;;     3-IF IT IS EMPTY(START WITH 'Y') WE STORE ITS SHAPE IN "SHAPESTORAGE"
;;     4-AND STORE ITS X,Y IN "PLACESTORAGEX" ,"PLACESTORAGEY"
;;  5-IF IT IS NOT EMPTY GET THE STORED SHAPE AND ITS X,Y
;;     6- DELETE THE OLD SHAPE
;;     7- PRINT THE OLD SHAPE IN CURRENT X,Y   ;
;;=========================================================================

       PRESS_ENTER:
       CMP SHAPESTORAGE[0],'Y'    ;CHECK IF IS EMPTY
       JNE BRIDGE_TO_NOTEMPTY
;;=========================CHECK TIME =======================================  
   PUSH AX 
   PUSH BX 
   PUSH CX 
   PUSH DX
   MOV AH,2ch ;11:39:00
   INT 21h                               ; CH         Hours (BCD)
   CALL GETPLACE                            ; CL         Minutes (BCD)
   MOV BX ,PLACE                            ; DH         Seconds (BCD)
   MOV AL,TIME0[BX]
   ;Check if it is the first move                             
   CMP AL,'X'    
   JE FIRSTMOVE_OR_MORE_THAN_3SEC
   
   MOV AH,CH    ;NEW HOUR IN AH 
   CMP AL,AH     
   JE CHECK_MIN ;IF OLD_HOUR = NEW_HOUR
   DEC AH 
   CMP AL,AH 
   JNE FIRSTMOVE_OR_MORE_THAN_3SEC
   ;CASE 2 ---> CHECK MIN ---> EX: 10:59:59 -> 11:00:01
   MOV AL , TIME0[BX+1]
   MOV AH , CL 
   CMP AL , 59 
   JNE FIRSTMOVE_OR_MORE_THAN_3SEC 
   CMP AH , 00 
   JNE FIRSTMOVE_OR_MORE_THAN_3SEC 
   JMP OUR_LOGIC

   CHECK_MIN:
      MOV BX , PLACE
      MOV AL,TIME0[BX+1]
      MOV AH,CL 
      CMP AL , AH 
      JE OUR_LOGIC
      DEC AH 
      CMP AL , AH 
      JNE FIRSTMOVE_OR_MORE_THAN_3SEC
      JA OUR_LOGIC




BRIDGE_TO_NOTEMPTY:  
JMP NOTEMPTY



OUR_LOGIC:

    MOV AL,TIME0[BX+2]                     ;Seconds
    CMP DH,AL 
    JA DH_IS_GREATER 
    ; If AL IS GREATER
    SUB AL,DH
    CMP Al,WAITING_TIME
    JAE FIRSTMOVE_OR_MORE_THAN_3SEC
    JMP here
    


    DH_IS_GREATER:
    SUB DH,AL
    CMP DH,WAITING_TIME
    JAE FIRSTMOVE_OR_MORE_THAN_3SEC
    JMP here
    
                         





;;=========================================================================
FIRSTMOVE_OR_MORE_THAN_3SEC:
       POP DX 
       POP CX 
       POP BX 
       POP AX
       ;;EMPTY --> GET ITS PLACE WHICH IS WANTED TO MOVE 
       CALL GETPLACE       
       MOV BX ,place 
      ;;THEN  GET THE SHAPE WHICH IS WANTED TO MOVE
      ;; AND STORE  IT IN  "SHAPESTORAGE"      
       MOV AL,STATE0[BX+2]
       CMP AL,'X'          ;;THIS CHECK IF IT IS EMPY CELL AND PLAYER WANT TO MOVE IF WHICH IS FORBIEDDEN                                                  
       JE BRIDGE_TO_here 
       CMP AL,'B'
       JE BRIDGE_TO_here 
       MOV SHAPESTORAGE[0],AL                           
       MOV AL,STATE0[BX+3]
       MOV SHAPESTORAGE[1],AL

      ;;THEN  GET THE X,Y
      ;; AND STORE  IT IN  "PLACESTORAGEX" ,PLACESTORAGEY
       MOV AX,XSTART                 
       MOV PLACESTORAGEX,AX
       MOV AX,YSTART                         
       MOV PLACESTORAGEY,AX                    
       JMP CheckKeyPressed
 
       BRIDGE_TO_here:
       JMP here 
    ;;IF IT IS NOT EMPTY WE DO THE FOLLOWING:
       NOTEMPTY:
       ;; HERE WE PRINT ON THE NEW CELL
   
;;==========================COMPARSIONS==========================================================
   PUSH XSTART
   PUSH YSTART
   MOV AX,PLACESTORAGEX   
   MOV XOLD,AX
   MOV AX,XSTART
   MOV XNEW,AX 
   MOV AX,PLACESTORAGEY
   MOV YOLD,AX 
   MOV AX,YSTART
   MOV YNEW,AX
 ;XOLD ,YOLD ,XNEW ,YNEW
   MOV AL,SHAPESTORAGE[1]
   CMP Al,'S'
   jE Bishop
   CMP AL,'R'
   JE TABEA11
   CMP AL,'Q'
   JE Queen11
   JMP  STATION_FOR_NEXT_COMPARSIONS




; ADD YOUR COMPARSION HERE :





   JMP CODE1
;;===============================================================================================
;==============================================Bishop============================================
  Bishop:
mov ax,XNEW
mov bx,XOLD
cmp ax,bx
jg check1
jmp check2
check1:
mov ax,YNEW
mov bx,YOLD
cmp ax,bx
jg move1
jmp move2
check2:
mov ax,YNEW
mov bx,YOLD
cmp ax,bx
jg move3
jmp move4
move1: ;x>,y>
mov ax,XNEW
sub ax,XOLD
mov bx,YNEW
sub bx,YOLD
cmp ax,bx
jz  checkmove1
jmp Invalid 
move2: ;x>,y<
mov ax,XNEW
sub ax,XOLD
mov bx,YOLD
sub bx,YNEW
cmp ax,bx
jz  checkmove2
jmp Invalid   
TABEA11:
JMP TABEA
move3: ;x<,y>
mov ax,XOLD
sub ax,XNEW
mov bx,YNEW
sub bx,YOLD
cmp ax,bx
jz  STATIONTOcheckmove3
jmp Invalid
Queen11:
JMP Queen
move4: ;x<,y<
mov ax,XOLD
sub ax,XNEW
mov bx,YOLD
sub bx,YNEW
cmp ax,bx
jz  STATIONTOcheckmove4
jmp Invalid
; -----------------------------------------
Invalid:
 CMP IsQueen,1
 jE TABEA12
 JMP HHERE
 ;-------------------------------------------
 ;Loop Till You Reach Destination,Or You Hit A Piece
 checkmove1:
 Add XOLD,75
 Add YOLD,75
 MOV AX,XNEW
 cmp AX,XOLD
 JE GOTOCODE
MOV AX,XOLD
MOV XSTART,AX
MOV AX,YOLD
MOV YSTART,AX
CALL GETPLACE
MOV BX,PLACE
MOV Al,STATE0[BX+2]
CMP AL,'X'
JNE FORINVAILDBISHOP
JMP checkmove1

        JMP FORBISHOP
        STATIONTOcheckmove3:   
        JMP checkmove3
        FORBISHOP:

checkmove2:
 Add XOLD,75
 SUB YOLD,75
 MOV AX,XNEW
 cmp AX,XOLD
  GOTOCODE:
 JE FORVAILDBISHOP
 MOV AX,XOLD
 MOV XSTART,AX
 MOV AX,YOLD
 MOV YSTART,AX
 CALL GETPLACE
 MOV BX,PLACE
 MOV Al,STATE0[BX+2]
 CMP AL,'X'
 JNE STATIONTOHHERE0
 JMP checkmove2 

TABEA12:
JMP TABEA

         JMP FORBISHOP1  
         STATIONTOcheckmove4:   
         JMP checkmove4
         FORBISHOP1:

 checkmove3:
 SUB XOLD,75
 Add YOLD,75
 MOV AX,XNEW
 cmp AX,XOLD
FORVAILDBISHOP:
 JE STATIONTOCODE0
 MOV AX,XOLD
 MOV XSTART,AX
 MOV AX,YOLD
 MOV YSTART,AX
 CALL GETPLACE
 MOV BX,PLACE
 MOV Al,STATE0[BX+2]
 CMP AL,'X'
FORINVAILDBISHOP:
 JNE STATIONTOHHERE0
 JMP checkmove3

 checkmove4:
 SUB XOLD,75
 SUB YOLD,75
 MOV AX,XNEW
 cmp AX,XOLD
 JE STATIONTOCODE0
 MOV AX,XOLD
 MOV XSTART,AX
 MOV AX,YOLD
 MOV YSTART,AX
 CALL GETPLACE
 MOV BX,PLACE
 MOV Al,STATE0[BX+2]
 CMP AL,'X'
 JNE STATIONTOHHERE0
 JMP checkmove4
;=========================================================================================
;=========================================Queen===========================================
Queen:
mov IsQueen,1
JMP Bishop
;=======================================STATION(0)=======================================
STATIONTOHHERE0:
JMP TOHHERE
STATIONTOCODE0:
JMP CODE1
;=========================================================================================

;=========================================================================================
;;==========================TABEA=========================================================
  TABEA:
  MOV AX,YOLD
  CMP YNEW,AX          
  JE MOTION_XDIR
  MOV AX,XOLD
  CMP XNEW,AX
  JE MOTION_YDIR
  JMP HHERE
;==============================================================
    MOTION_XDIR:
    MOV AX,XOLD
    CMP XNEW,AX
    JA MOTION_IN_XPOSITIVE
    JB MOTION_IN_XNEGATIVE
;============================================================== 
MOTION_IN_XPOSITIVE:
ADD XOLD,75
MOV BX,XNEW        ; IN +VE DIR
CMP XOLD,BX
JE TOCODE
MOV AX,XOLD
MOV XSTART,AX
CALL GETPLACE
MOV BX,PLACE
MOV AL,STATE0[BX+2]
CMP AL,'X'
JNE STATIONTOHHERE1
JMP MOTION_IN_XPOSITIVE
;==============================================================
MOTION_IN_XNEGATIVE:
SUB XOLD,75
MOV BX,XNEW           ;IN -VE DIR
CMP XOLD,BX
TOCODE:
JE STATIONTOCODE1
MOV AX,XOLD
MOV XSTART,AX
CALL GETPLACE
MOV BX,PLACE
MOV AL,STATE0[BX+2]
CMP AL,'X'
JNE STATIONTOHHERE1
JMP MOTION_IN_XNEGATIVE
;==============================================================
MOTION_YDIR:
    MOV AX,YOLD
    CMP YNEW,AX
    JA MOTION_IN_YPOSITIVE
    JB MOTION_IN_YNEGATIVE
;==============================================================
MOTION_IN_YPOSITIVE:
ADD YOLD,75
MOV BX,YNEW        ; IN +VE DIR
CMP YOLD,BX
JE STATIONTOCODE1
MOV AX,YOLD
MOV YSTART,AX
CALL GETPLACE
MOV BX,PLACE
MOV AL,STATE0[BX+2]
CMP AL,'X'
JNE STATIONTOHHERE1
JMP MOTION_IN_YPOSITIVE
;==============================================================
MOTION_IN_YNEGATIVE:
SUB YOLD,75
MOV BX,YNEW           ;IN -VE DIR
CMP YOLD,BX
JE STATIONTOCODE1
MOV AX,YOLD
MOV YSTART,AX
CALL GETPLACE
MOV BX,PLACE
MOV AL,STATE0[BX+2]
CMP AL,'X'
JNE STATIONTOHHERE1
JMP MOTION_IN_YNEGATIVE
;======================================STATIONT(1)============================================
STATIONTOHHERE1:
JMP TOHHERE
STATIONTOCODE1:
JMP CODE1
;==========================STATION_FOR_NEXT_COMPARSIONS====================================
STATION_FOR_NEXT_COMPARSIONS:
   CMP AL,'H'
   JE HORSE 
   JMP STATION1_FOR_NEXT_COMPARSIONS
;===========================================================================================
;===========================================================================================
;;==========================HORSE===========================================================
HORSE:
MOV AX,XOLD
MOV BX,YOLD
ADD AX,150 ;right down
ADD BX,75
CMP AX,XNEW
JE  right_down_YES
jne right_UP
right_down_YES:
CMP BX,YNEW
jne right_UP
jmp CODE1
;;;;;;;;;;;;;;;;;;;;;;;
right_UP:
MOV AX,XOLD
MOV BX,YOLD
ADD AX,150
SUB BX,75
CMP AX,XNEW     ;right up
JE right_UP_YES
jne left_down
right_UP_YES:
CMP BX,YNEW
jne left_down
jmp CODE1
;;;;;;;;;;;;;;;;;;;;;;;;;
left_down:
MOV AX,XOLD
MOV BX,YOLD
SUB AX,150
ADD BX,75
CMP AX,XNEW     ;left down
JE left_down_YES
jne left_UP
left_down_YES:
CMP BX,YNEW
jne left_UP
jmp CODE1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
left_UP:
MOV AX,XOLD
MOV BX,YOLD
SUB AX,150
SUB BX,75       ;left up
CMP AX,XNEW
JE left_UP_YES
jne up_rgiht
left_UP_YES:
CMP BX,YNEW
jne up_rgiht
jmp CODE1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
up_rgiht:
MOV AX,XOLD
MOV BX,YOLD
SUB BX,150
ADD AX,75
CMP AX,XNEW     ;up right
JE up_rgiht_YES
jne up_left
up_rgiht_YES:
CMP BX,YNEW
jne up_left
jmp CODE1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
up_left:
MOV AX,XOLD
MOV BX,YOLD
SUB BX,150
SUB AX,75
CMP AX,XNEW     ;up left
JE up_left_YES
jne down_right
up_left_YES:
CMP BX,YNEW
jne down_right
jmp CODE1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
down_right:
MOV AX,XOLD
MOV BX,YOLD
ADD BX,150
ADD AX,75
CMP AX,XNEW
JE down_right_YES
jne down_left
down_right_YES:
CMP BX,YNEW
jne down_left
jmp CODE1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
down_left:
MOV AX,XOLD
MOV BX,YOLD
ADD BX,150
SUB AX,75
CMP AX,XNEW
JE down_left_YES
jne STATIONTOHHERE2
down_left_YES:
CMP BX,YNEW
jne STATIONTOHHERE2
jmp CODE1
;===========================================================================================
;======================================STATIONT(2)============================================
STATIONTOHHERE2:
JMP TOHHERE
STATIONTOCODE2:
JMP CODE1
;===========================================================================================
;==========================STATION1_FOR_NEXT_COMPARSIONS====================================
STATION1_FOR_NEXT_COMPARSIONS:
   CMP AL,'K'
   JE KING 
 JMP STATION2_FOR_NEXT_COMPARSIONS
;===========================================================================================
;;==========================KING============================================================
KING:
mov AX,XOLD
mov BX,YOLD
ADD AX,75       ;moves to the right
CMP AX,XNEW
je XRYES
jne UPRIGHT
XRYES:
CMP BX,YNEW
jne UPRIGHT
Jmp CODE1
;;;;;;;;;;;
UPRIGHT:
mov AX,XOLD
mov BX,YOLD
SUB BX,75
ADD Ax,75
CMP AX,XNEW
je XURYES
jne UP
XURYES:
CMP BX,YNEW
jne UP
jmp CODE1
;;;;;;;;;;;
UP:
mov AX,XOLD
mov BX,YOLD
SUB BX,75
CMP AX,XNEW
je XUYES
jne UPLEFT
XUYES:
CMP BX,YNEW
jne UPLEFT
jmp CODE1
;;;;;;;;;;
UPLEFT:
mov AX,XOLD
mov BX,YOLD
SUB AX,75
SUB BX,75
CMP AX,XNEW
je XULYES
jne LEFT
XULYES:
CMP BX,YNEW
jne LEFT
jmp CODE1
;;;;;;;;;;;
LEFT:
mov AX,XOLD
mov BX,YOLD
SUB AX,75
CMP AX,XNEW
je XLYES
jne DOWNLEFT
XLYES:
CMP BX,YNEW
jne DOWNLEFT
jmp CODE1
;;;;;;;;;;;;
DOWNLEFT:
mov AX,XOLD
mov BX,YOLD
SUB AX,75
ADD BX,75       
CMP AX,XNEW
je XDLYES
jne DOWN
XDLYES:
CMP BX,YNEW
jne DOWN
jmp CODE1
;;;;;;;;;;;;
DOWN:
mov AX,XOLD
mov BX,YOLD
ADD BX,75       
CMP AX,XNEW
je XDYES
jne DOWNRIGHT
XDYES:
CMP BX,YNEW
jne DOWNRIGHT
jmp CODE1
;;;;;;;;;;;;
DOWNRIGHT:
mov AX,XOLD
mov BX,YOLD
ADD AX,75
ADD BX,75       
CMP AX,XNEW
je XDRYES
jne STATIONTOHHERE3
XDRYES:
CMP BX,YNEW
jne STATIONTOHHERE3;invalid move
jmp CODE1
;===========================================================================================
;======================================STATIONT(3)============================================
STATIONTOHHERE3:
JMP TOHHERE
STATIONTOCODE3:
JMP CODE1
;===========================================================================================
;==========================STATION2_FOR_NEXT_COMPARSIONS====================================
STATION2_FOR_NEXT_COMPARSIONS:
   CMP AL,'P'
   je POWN
   JMP CODE1 ;=====****** 
;===========================================================================================
;==========================================POWN=============================================

POWN:
MOV AX,XOLD
MOV BX,YOLD
cmp BX,75
je tow_moves
;;;;;;
one_move:
ADD BX,75
cmp BX,YNEW
jne TOHHERE2
cmp AX,XNEW
jne check3
;
;jne diagonal_mov_positive 
mov XSTART,AX
mov YSTART,BX
call GETPLACE
mov BX,place
MOV AL ,state0[BX+2];move odam
cmp AL,'X'
je CODE2
jne TOHHERE2 
;
check3:
cmp AX,XNEW
jA diagonal_mov_negative
JL diagonal_mov_positive

diagonal_mov_positive:
ADD AX,75
mov XSTART,AX
mov YSTART,BX
call GETPLACE
mov BX,place
MOV AL ,state0[BX+2]
cmp AL,'B'
je CODE2
jne TOHHERE2

diagonal_mov_negative:
SUB AX,75
mov XSTART,AX
mov YSTART,BX
call GETPLACE
mov BX,place
MOV AL ,state0[BX+2]
cmp AL,'B'
je CODE1
jne TOHHERE2
;;;;;;;;;;;;;
CODE2:
jmp CODE1
TOHHERE2:
jmp TOHHERE


tow_moves:
ADD BX,75
cmp BX,YNEW
jne another_col
cmp AX,XNEW
jne check3
je check_X
another_col:
ADD BX,75
cmp BX,YNEW
je check_X
jne TOHHERE
check_X:
cmp AX,XNEW
jne TOHHERE 
mov XSTART,AX
mov YSTART,BX
call GETPLACE
mov BX,place
MOV AL ,state0[BX+2]
cmp AL,'X'
je CODE1
jne TOHHERE
;===========================================================================================
;===========================================================================================


;===========================================================================================
TOHHERE:
 POP AX
 MOV YSTART,AX
 POP AX
 MOV XSTART,AX
JMP JUMPTOHHERE
;===========================================================================================
CODE1:
 POP AX
 MOV YSTART,AX
 POP AX
 MOV XSTART,AX
 ;;=================Update Time Array================================
   PUSH AX 
   PUSH BX 
   PUSH CX 
   PUSH DX
   MOV AH,2ch    ;New Time 
   INT 21h                                  ; CH         Hours (BCD)
   CALL GETPLACE                            ; CL         Minutes (BCD)
   MOV BX ,PLACE                            ; DH         Seconds (BCD)
   ;;=====================bonus 1===================================
   CMP BX , RANDOMPLACE
   JNE NOT_THE_POWER_PLACE
   MOV WAITING_TIME,2
   NOT_THE_POWER_PLACE:
   MOV TIME0[BX],CH
   MOV TIME0[BX+1],CL 
   MOV TIME0[BX+2],DH
   POP DX 
   POP CX 
   POP BX 
   POP AX 
;;==================================================================

       CALL GETPLACE
       MOV BX,place                                       
       PUSH BX
       MOV AL ,state0[BX+2]
       CMP AL,'W'
        JNE HELLO
       JMP JUMPTOHHERE
       HELLO:
       ;;Check if the killed one is king,then the game is over 
       MOV AL , state0[BX+3]
       CMP AL , 'K'
       JNE CON
       JMP PRESS_ESC
       CON:
       MOV AL,state0 [BX]                 
       MOV  imgFilename[0], AL 
       MOV AH, state0[BX+1]          ;printing the background  OF THE NEW CELL  TO DELETE THE ANIMY SHAPE IF EXSITS          
       MOV  imgFilename[1], AH  
       MOV MODE,2
       CALL PRINT
        

        PUSH XSTART
        PUSH YSTART

       CALL GETPLACE
       MOV BX,place  
        MOV AL,state0 [BX+2] 
        CMP AL,'X'
        JE GO_TO_POP  
       MOV  imgFilename[0], AL 
       MOV AH, state0[BX+3]               
       MOV  imgFilename[1], AH 
       MOV MODE,1
       MOV AX,XKILLED
       MOV XSTART,AX
       MOV AX,YKILLED
       MOV YSTART,AX
       CALL PRINT
       
       ADD YKILLED,75
       CMP YKILLED,600
       JNE GO_TO_POP
        MOV YKILLED,0
        ADD XKILLED,75




      GO_TO_POP:
        POP YSTART
        POP XSTART




       POP BX 
       MOV AL,SHAPESTORAGE[0]
       MOV  imgFilename[0], AL            ;;GET OLD SHAPE AND PRINT IT ON THE NEW CELL
       MOV STATE0[BX+2],AL                                        
       MOV  AL,SHAPESTORAGE[1]
       MOV  imgFilename[1], AL
       MOV  STATE0[BX+3],AL 
       MOV MODE ,0
       CALL PRINT
       MOV  imgFilename[0],'F'         
       MOV  imgFilename[1],'R'    ;PRINT HIGHLIGHT AT THE FIRST CELL
          MOV MODE,1
       CALL PRINT                            
                         
      


   
         JMP GOAT
        JUMPTOHHERE:   
        JMP HHERE

        GOAT:

       MOV AX,XSTART 
       PUSH AX                         
       MOV AX ,YSTART
       PUSH AX  

        ;;GET OLD PLACE  
       MOV AX,PLACESTORAGEX  
       MOV XSTART,AX                         
       MOV AX ,PLACESTORAGEY
       MOV YSTART,AX 
       CALL GETPLACE
       MOV BX,place                  ;;WE DELETE THE OLD SHAPE
       MOV AL,state0 [BX]                 
       MOV  imgFilename[0], AL 
       MOV AL, state0[BX+1]          ;printing the background OF THE OLD PLACE SO THE OLD SHAPE ID DISAPPERED
       MOV  imgFilename[1], AL
       MOV STATE0[BX+2],'X'       ;;UPDATE THE STATE ARRAY
       MOV STATE0[BX+3],'X'
       MOV MODE,2
       CALL PRINT

        POP AX
        MOV YSTART,AX
        POP AX
        MOV XSTART,AX



        HHERE:
        MOV SHAPESTORAGE[0],'Y'            ;;RETURN THE SHAPE STORAGE EMPTY AGAIN
        MOV SHAPESTORAGE[1],'Y'     
      JMP CheckKeyPressed
;;==========================================================================
;;=========================================================================

;;==========================================================================
;;;==================THIS PART WILL DELETED AFTER PHASE 1===================
;;;==================THIS PART WILL DELETED AFTER PHASE 1===================
;;;==================THIS PART WILL DELETED AFTER PHASE 1===================
;;  THIS PART OF CODE DO 
;;  1-WHEN FIRST PLAYER PRESSED ENTER ON A CELL
;;  2-THEN CHECK IF THE "SHAPESTORAGEB" IS EMPTY OR NOT 
;;     3-IF IT IS EMPTY(START WITH 'Y') WE STORE ITS SHAPE IN "SHAPESTORAGEB"
;;     4-AND STORE ITS X,Y IN "PLACESTORAGEXB" ,"PLACESTORAGEYB"
;;  5-IF IT IS NOT EMPTY GET THE STORED SHAPE AND ITS X,Y
;;     6- DELETE THE OLD SHAPE
;;     7- PRINT THE OLD SHAPE IN CURRENT X,Y   ;
;;=========================================================================

       PRESS_Q:
       CMP SHAPESTORAGEB[0],'Y'    ;CHECK IF IS EMPTY
       JNE BRIDGE_TO_NOTEMPTYB
;;==========================================================================
;;=========================CHECK TIME=======================================  
   PUSH AX 
   PUSH BX 
   PUSH CX 
   PUSH DX
   MOV AH,2ch ;11:39:00
   INT 21h                               ; CH         Hours (BCD)
   CALL GETPLACEB                            ; CL         Minutes (BCD)
   MOV BX ,PLACEB                            ; DH         Seconds (BCD)
   MOV AL,TIME0[BX]
   ;Check if it is the first MOVEB                             
   CMP AL,'X'    
   JE FIRSTMOVEB_OR_MORE_THAN_3SEC
   
   MOV AH,CH    ;NEW HOUR IN AH 
   CMP AL,AH     
   JE CHECK_MINB ;IF OLD_HOUR = NEW_HOUR
   DEC AH 
   CMP AL,AH 
   JNE FIRSTMOVEB_OR_MORE_THAN_3SEC
   ;CASE 2 ---> CHECK MIN ---> EX: 10:59:59 -> 11:00:01
   MOV AL , TIME0[BX+1]
   MOV AH , CL 
   CMP AL , 59 
   JNE FIRSTMOVEB_OR_MORE_THAN_3SEC 
   CMP AH , 00 
   JNE FIRSTMOVEB_OR_MORE_THAN_3SEC 
   JMP OUR_LOGICB

   CHECK_MINB:
      MOV BX , PLACEB
      MOV AL,TIME0[BX+1]
      MOV AH,CL 
      CMP AL , AH 
      JE OUR_LOGICB
      DEC AH 
      CMP AL , AH 
      JNE FIRSTMOVEB_OR_MORE_THAN_3SEC
      JA OUR_LOGICB




BRIDGE_TO_NOTEMPTYB:  
JMP NOTEMPTY1



OUR_LOGICB:

    MOV AL,TIME0[BX+2]                     ;Seconds
    CMP DH,AL 
    JA DH_IS_GREATERB 
    ; If AL IS GREATERB
    SUB AL,DH
    CMP Al,WAITING_TIMEB
    JAE FIRSTMOVEB_OR_MORE_THAN_3SEC
    JMP hereB1
    


    DH_IS_GREATERB:
    SUB DH,AL
    CMP DH,WAITING_TIMEB
    JAE FIRSTMOVEB_OR_MORE_THAN_3SEC
    JMP hereB1

;;=========================================================================
FIRSTMOVEB_OR_MORE_THAN_3SEC:
       POP DX 
       POP CX 
       POP BX 
       POP AX
       ;;EMPTY --> GET ITS PLACEB WHICH IS WANTED TO MOVEB 
       CALL GETPLACEB        
       MOV BX ,placeB 
      ;;THEN  GET THE SHAPE WHICH IS WANTED TO MOVE
      ;; AND STORE  IT IN  "SHAPESTORAGEB"      
       MOV AL,STATE0[BX+2]
       CMP AL,'X'          ;;THIS CHECK IF IT IS EMPY CELL AND PLAYER WANT TO MOVE IF WHICH IS FORBIEDDEN                                                  
       JE hereB1 
       CMP AL,'W'
       JE hereB1 
       MOV SHAPESTORAGEB[0],AL                           
       MOV AL,STATE0[BX+3]
       MOV SHAPESTORAGEB[1],AL

      ;;THEN  GET THE X,Y
      ;; AND STORE  IT IN  "PLACESTORAGEXB" ,PLACESTORAGEYB
       MOV AX,XSTARTB                 
       MOV PLACESTORAGEXB,AX
       MOV AX,YSTARTB                         
       MOV PLACESTORAGEYB,AX
       hereB1:                    
       JMP CheckKeyPressed
 


    ;;IF IT IS NOT EMPTY WE DO THE FOLLOWING:
       NOTEMPTY1:
   
   ;;==========================COMPARSIONS==========================================================
   PUSH XSTARTB
   PUSH YSTARTB
   MOV AX,PLACESTORAGEXB   
   MOV XOLD,AX
   MOV AX,XSTARTB
   MOV XNEW,AX 
   MOV AX,PLACESTORAGEYB
   MOV YOLD,AX 
   MOV AX,YSTARTB
   MOV YNEW,AX
 ;XOLD ,YOLD ,XNEW ,YNEW
   MOV AL,SHAPESTORAGEB[1]
   CMP Al,'S'
   jE BISHOPB
   CMP AL,'R'
   JE TABEAB11
   CMP AL,'Q'
   JE QUEENB11
   JMP  STATION_FOR_NEXT_COMPARSIONSB




; ADD YOUR COMPARSION HERE :





   JMP CODEB1B
;;===============================================================================================
;==============================================BISHOPB============================================
  BISHOPB:
mov ax,XNEW
mov bx,XOLD
cmp ax,bx
jg CHECKB1
jmp CHECKB2
CHECKB1:
mov ax,YNEW
mov bx,YOLD
cmp ax,bx
jg MOVEB1
jmp MOVEB2
CHECKB2:
mov ax,YNEW
mov bx,YOLD
cmp ax,bx
jg MOVEB3
jmp MOVEB4
MOVEB1: ;x>,y>
mov ax,XNEW
sub ax,XOLD
mov bx,YNEW
sub bx,YOLD
cmp ax,bx
jz  CHECKBMOVEB1
jmp InvalidB 
MOVEB2: ;x>,y<
mov ax,XNEW
sub ax,XOLD
mov bx,YOLD
sub bx,YNEW
cmp ax,bx
jz  CHECKBMOVEB2
jmp InvalidB   
TABEAB11:
JMP TABEAB
MOVEB3: ;x<,y>
mov ax,XOLD
sub ax,XNEW
mov bx,YNEW
sub bx,YOLD
cmp ax,bx
jz  STATIONTOCHECKBMOVEB3
jmp InvalidB
QUEENB11:
JMP QUEENB
MOVEB4: ;x<,y<
mov ax,XOLD
sub ax,XNEW
mov bx,YOLD
sub bx,YNEW
cmp ax,bx
jz  STATIONTOCHECKBMOVEB4
jmp InvalidB
; -----------------------------------------
InvalidB:
 CMP IsQUEENB,1
 jE TABEAB12
 JMP HHEREB
 ;-------------------------------------------
 ;Loop Till You Reach Destination,Or You Hit A Piece
 CHECKBMOVEB1:
 Add XOLD,75
 Add YOLD,75
 MOV AX,XNEW
 cmp AX,XOLD
 JE GOTOCODEBB
MOV AX,XOLD
MOV XSTARTB,AX
MOV AX,YOLD
MOV YSTARTB,AX
CALL GETPLACEB
MOV BX,PLACEB
MOV Al,STATE0[BX+2]
CMP AL,'X'
JNE FORINVAILDBISHOPB
JMP CHECKBMOVEB1

        JMP FORBISHOPB
        STATIONTOCHECKBMOVEB3:   
        JMP CHECKBMOVEB3
        FORBISHOPB:

CHECKBMOVEB2:
 Add XOLD,75
 SUB YOLD,75
 MOV AX,XNEW
 cmp AX,XOLD
  GOTOCODEBB:
 JE FORVAILDBISHOPB
 MOV AX,XOLD
 MOV XSTARTB,AX
 MOV AX,YOLD
 MOV YSTARTB,AX
 CALL GETPLACEB
 MOV BX,PLACEB
 MOV Al,STATE0[BX+2]
 CMP AL,'X'
 JNE STATIONTOHHEREB0
 JMP CHECKBMOVEB2 

TABEAB12:
JMP TABEAB

         JMP FORBISHOPB1  
         STATIONTOCHECKBMOVEB4:   
         JMP CHECKBMOVEB4
         FORBISHOPB1:

 CHECKBMOVEB3:
 SUB XOLD,75
 Add YOLD,75
 MOV AX,XNEW
 cmp AX,XOLD
FORVAILDBISHOPB:
 JE STATIONTOCODEB0
 MOV AX,XOLD
 MOV XSTARTB,AX
 MOV AX,YOLD
 MOV YSTARTB,AX
 CALL GETPLACEB
 MOV BX,PLACEB
 MOV Al,STATE0[BX+2]
 CMP AL,'X'
FORINVAILDBISHOPB:
 JNE STATIONTOHHEREB0
 JMP CHECKBMOVEB3

 CHECKBMOVEB4:
 SUB XOLD,75
 SUB YOLD,75
 MOV AX,XNEW
 cmp AX,XOLD
 JE STATIONTOCODEB0
 MOV AX,XOLD
 MOV XSTARTB,AX
 MOV AX,YOLD
 MOV YSTARTB,AX
 CALL GETPLACEB
 MOV BX,PLACEB
 MOV Al,STATE0[BX+2]
 CMP AL,'X'
 JNE STATIONTOHHEREB0
 JMP CHECKBMOVEB4
;=========================================================================================
;=========================================QUEENB===========================================
QUEENB:
mov IsQUEENB,1
JMP BISHOPB
;=======================================STATION(0)=======================================
STATIONTOHHEREB0:
JMP TOHHEREB
STATIONTOCODEB0:
JMP CODEB1B
;=========================================================================================

;=========================================================================================
;;==========================TABEAB=========================================================
  TABEAB:
  MOV AX,YOLD
  CMP YNEW,AX          
  JE MOTIONB_XDIR
  MOV AX,XOLD
  CMP XNEW,AX
  JE MOTIONB_YDIR
  JMP HHEREB
;==============================================================
    MOTIONB_XDIR:
    MOV AX,XOLD
    CMP XNEW,AX
    JA MOTIONB_IN_XPOSITIVE
    JB MOTIONB_IN_XNEGATIVE
;============================================================== 
MOTIONB_IN_XPOSITIVE:
ADD XOLD,75
MOV BX,XNEW        ; IN +VE DIR
CMP XOLD,BX
JE TOCODEB
MOV AX,XOLD
MOV XSTARTB,AX
CALL GETPLACEB
MOV BX,PLACEB
MOV AL,STATE0[BX+2]
CMP AL,'X'
JNE STATIONTOHHEREB1
JMP MOTIONB_IN_XPOSITIVE
;==============================================================
MOTIONB_IN_XNEGATIVE:
SUB XOLD,75
MOV BX,XNEW           ;IN -VE DIR
CMP XOLD,BX
TOCODEB:
JE STATIONTOCODEB1B
MOV AX,XOLD
MOV XSTARTB,AX
CALL GETPLACEB
MOV BX,PLACEB
MOV AL,STATE0[BX+2]
CMP AL,'X'
JNE STATIONTOHHEREB1
JMP MOTIONB_IN_XNEGATIVE
;==============================================================
MOTIONB_YDIR:
    MOV AX,YOLD
    CMP YNEW,AX
    JA MOTIONB_IN_YPOSITIVE
    JB MOTIONB_IN_YNEGATIVE
;==============================================================
MOTIONB_IN_YPOSITIVE:
ADD YOLD,75
MOV BX,YNEW        ; IN +VE DIR
CMP YOLD,BX
JE STATIONTOCODEB1B
MOV AX,YOLD
MOV YSTARTB,AX
CALL GETPLACEB
MOV BX,PLACEB
MOV AL,STATE0[BX+2]
CMP AL,'X'
JNE STATIONTOHHEREB1
JMP MOTIONB_IN_YPOSITIVE
;==============================================================
MOTIONB_IN_YNEGATIVE:
SUB YOLD,75
MOV BX,YNEW           ;IN -VE DIR
CMP YOLD,BX
JE STATIONTOCODEB1B
MOV AX,YOLD
MOV YSTARTB,AX
CALL GETPLACEB
MOV BX,PLACEB
MOV AL,STATE0[BX+2]
CMP AL,'X'
JNE STATIONTOHHEREB1
JMP MOTIONB_IN_YNEGATIVE
;======================================STATIONT(1)============================================
STATIONTOHHEREB1:
JMP TOHHEREB
STATIONTOCODEB1B:
JMP CODEB1B
;==========================STATION_FOR_NEXT_COMPARSIONSB====================================
STATION_FOR_NEXT_COMPARSIONSB:
   CMP AL,'H'
   JE HORSEB 
   JMP STATION1_FOR_NEXT_COMPARSIONSB
;===========================================================================================
;===========================================================================================
;;==========================HORSEB===========================================================
HORSEB:
MOV AX,XOLD
MOV BX,YOLD
ADD AX,150 ;rightB DOWNB
ADD BX,75
CMP AX,XNEW
JE  rightB_DOWNB_YESB
jne rightB_UPB
rightB_DOWNB_YESB:
CMP BX,YNEW
jne rightB_UPB
jmp CODEB1B
;;;;;;;;;;;;;;;;;;;;;;;
rightB_UPB:
MOV AX,XOLD
MOV BX,YOLD
ADD AX,150
SUB BX,75
CMP AX,XNEW     ;rightB UPB
JE rightB_UPB_YESB
jne leftB_DOWNB
rightB_UPB_YESB:
CMP BX,YNEW
jne leftB_DOWNB
jmp CODEB1B
;;;;;;;;;;;;;;;;;;;;;;;;;
leftB_DOWNB:
MOV AX,XOLD
MOV BX,YOLD
SUB AX,150
ADD BX,75
CMP AX,XNEW     ;leftB DOWNB
JE leftB_DOWNB_YESB
jne leftB_UPB
leftB_DOWNB_YESB:
CMP BX,YNEW
jne leftB_UPB
jmp CODEB1B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
leftB_UPB:
MOV AX,XOLD
MOV BX,YOLD
SUB AX,150
SUB BX,75       ;leftB UPB
CMP AX,XNEW
JE leftB_UPB_YESB
jne UPB_rgihtB
leftB_UPB_YESB:
CMP BX,YNEW
jne UPB_rgihtB
jmp CODEB1B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UPB_rgihtB:
MOV AX,XOLD
MOV BX,YOLD
SUB BX,150
ADD AX,75
CMP AX,XNEW     ;UPB rightB
JE UPB_rgihtB_YESB
jne UPB_leftB
UPB_rgihtB_YESB:
CMP BX,YNEW
jne UPB_leftB
jmp CODEB1B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
UPB_leftB:
MOV AX,XOLD
MOV BX,YOLD
SUB BX,150
SUB AX,75
CMP AX,XNEW     ;UPB leftB
JE UPB_leftB_YESB
jne DOWNB_rightB
UPB_leftB_YESB:
CMP BX,YNEW
jne DOWNB_rightB
jmp CODEB1B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DOWNB_rightB:
MOV AX,XOLD
MOV BX,YOLD
ADD BX,150
ADD AX,75
CMP AX,XNEW
JE DOWNB_rightB_YESB
jne DOWNB_leftB
DOWNB_rightB_YESB:
CMP BX,YNEW
jne DOWNB_leftB
jmp CODEB1B
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DOWNB_leftB:
MOV AX,XOLD
MOV BX,YOLD
ADD BX,150
SUB AX,75
CMP AX,XNEW
JE DOWNB_leftB_YESB
jne STATIONTOHHEREB2
DOWNB_leftB_YESB:
CMP BX,YNEW
jne STATIONTOHHEREB2
jmp CODEB1B
;===========================================================================================
;======================================STATIONT(2)============================================
STATIONTOHHEREB2:
JMP TOHHEREB
STATIONTOCODEB2:
JMP CODEB1B
;===========================================================================================
;==========================STATION1_FOR_NEXT_COMPARSIONSB====================================
STATION1_FOR_NEXT_COMPARSIONSB:
   CMP AL,'K'
   JE KINGB 
 JMP STATION2_FOR_NEXT_COMPARSIONSB
;===========================================================================================
;;==========================KINGB============================================================
KINGB:
mov AX,XOLD
mov BX,YOLD
ADD AX,75       ;MOVEBs to the rightB
CMP AX,XNEW
je XRYESB
jne UPBrightB
XRYESB:
CMP BX,YNEW
jne UPBrightB
Jmp CODEB1B
;;;;;;;;;;;
UPBrightB:
mov AX,XOLD
mov BX,YOLD
SUB BX,75
ADD Ax,75
CMP AX,XNEW
je XURYESB
jne UPB
XURYESB:
CMP BX,YNEW
jne UPB
jmp CODEB1B
;;;;;;;;;;;
UPB:
mov AX,XOLD
mov BX,YOLD
SUB BX,75
CMP AX,XNEW
je XUYESB
jne UPBleftB
XUYESB:
CMP BX,YNEW
jne UPBleftB
jmp CODEB1B
;;;;;;;;;;
UPBleftB:
mov AX,XOLD
mov BX,YOLD
SUB AX,75
SUB BX,75
CMP AX,XNEW
je XULYESB
jne leftB
XULYESB:
CMP BX,YNEW
jne leftB
jmp CODEB1B
;;;;;;;;;;;
leftB:
mov AX,XOLD
mov BX,YOLD
SUB AX,75
CMP AX,XNEW
je XLYESB
jne DOWNBleftB
XLYESB:
CMP BX,YNEW
jne DOWNBleftB
jmp CODEB1B
;;;;;;;;;;;;
DOWNBleftB:
mov AX,XOLD
mov BX,YOLD
SUB AX,75
ADD BX,75       
CMP AX,XNEW
je XDLYESB
jne DOWNB
XDLYESB:
CMP BX,YNEW
jne DOWNB
jmp CODEB1B
;;;;;;;;;;;;
DOWNB:
mov AX,XOLD
mov BX,YOLD
ADD BX,75       
CMP AX,XNEW
je XDYESB
jne DOWNBrightB
XDYESB:
CMP BX,YNEW
jne DOWNBrightB
jmp CODEB1B
;;;;;;;;;;;;
DOWNBrightB:
mov AX,XOLD
mov BX,YOLD
ADD AX,75
ADD BX,75       
CMP AX,XNEW
je XDRYESB
jne STATIONTOHHEREB3
XDRYESB:
CMP BX,YNEW
jne STATIONTOHHEREB3;InvalidB MOVEB
jmp CODEB1B
;===========================================================================================
;======================================STATIONT(3)============================================
STATIONTOHHEREB3:
JMP TOHHEREB
STATIONTOCODEB3:
JMP CODEB1B
;===========================================================================================
;==========================STATION2_FOR_NEXT_COMPARSIONSB====================================
STATION2_FOR_NEXT_COMPARSIONSB:
   CMP AL,'P'
   je POWNB
   JMP CODEB1B ;=====****** 
;===========================================================================================
;==========================================POWNB=============================================

POWNB:
MOV AX,XOLD
MOV BX,YOLD
cmp BX,450
je tow_MOVEBs
;;;;;;
one_MOVEB:
SUB BX,75
cmp BX,YNEW
jne TOHHEREB2
cmp AX,XNEW
jne CHECKB3
;
;jne diagonalB_mov_positive 
mov XSTARTB,AX
mov YSTARTB,BX
call GETPLACEB
mov BX,PLACEB
MOV AL ,state0[BX+2];MOVEB odam
cmp AL,'X'
je CODEB2
jne TOHHEREB2 
;
CHECKB3:
cmp AX,XNEW
jA diagonalB_mov_negative
JL diagonalB_mov_positive

diagonalB_mov_positive:
SUB AX,75
mov XSTARTB,AX
mov YSTARTB,BX
call GETPLACEB
mov BX,PLACEB
MOV AL ,state0[BX+2]
cmp AL,'W'
je CODEB2
jne TOHHEREB2

diagonalB_mov_negative:
ADD AX,75
mov XSTARTB,AX
mov YSTARTB,BX
call GETPLACEB
mov BX,PLACEB
MOV AL ,state0[BX+2]
cmp AL,'W'
je CODEB1B
jne TOHHEREB2
;;;;;;;;;;;;;
CODEB2:
jmp CODEB1B
TOHHEREB2:
jmp TOHHEREB


tow_MOVEBs:
SUB BX,75
cmp BX,YNEW
jne anotherB_col
cmp AX,XNEW
jne CHECKB3
je CHECKB_X
anotherB_col:
SUB BX,75
cmp BX,YNEW
je CHECKB_X
jne TOHHEREB
CHECKB_X:
cmp AX,XNEW
jne TOHHEREB 
mov XSTARTB,AX
mov YSTARTB,BX
call GETPLACEB
mov BX,PLACEB
MOV AL ,state0[BX+2]
cmp AL,'X'
je CODEB1B
jne TOHHEREB
;===========================================================================================
;===========================================================================================


;===========================================================================================
TOHHEREB:
 POP AX
 MOV YSTARTB,AX
 POP AX
 MOV XSTARTB,AX
JMP JUMPTOHHEREB
;===========================================================================================
CODEB1B:
 POP AX
 MOV YSTARTB,AX
 POP AX
 MOV XSTARTB,AX

;;=================Update Time Array OF SECOND PLAYER================================
   PUSH AX 
   PUSH BX 
   PUSH CX 
   PUSH DX
   MOV AH,2ch    ;New Time 
   INT 21h                                  ; CH         Hours (BCD)
   CALL GETPLACEB                            ; CL         Minutes (BCD)
   MOV BX ,PLACEB                            ; DH         Seconds (BCD)
   MOV TIME0[BX],CH
   MOV TIME0[BX+1],CL 
   MOV TIME0[BX+2],DH
   POP DX 
   POP CX 
   POP BX 
   POP AX 
;;==================================================================
;===================;=;=;========================================



       ;; HERE WE PRINT ON THE NEW CELLv
   
       CALL GETPLACEB
       MOV BX,placeB                                       
       PUSH BX
       MOV AL ,state0[BX+2]
       CMP AL,'B'
       JNE HELLOB
       JMP JUMPTOHHEREB
       HELLOB:
       ;;Check if the killed one is king,then the game is over 
       MOV AL , state0[BX+3]
       CMP AL , 'K'
       JNE CONB
       JMP PRESS_ESC
       CONB:
       MOV AL,state0 [BX]                 
       MOV  imgFilename[0], AL 
       MOV AH, state0[BX+1]          ;printing the background  OF THE NEW CELL  TO DELETE THE ANIMY SHAPE IF EXSITS          
       MOV  imgFilename[1], AH  
       MOV MODEB,2
       CALL PRINTB
   
     

        PUSH XSTARTB
        PUSH YSTARTB

       CALL GETPLACEB
       MOV BX,placeB  
        MOV AL,state0 [BX+2] 
        CMP AL,'X'
        JE GO_TO_POPB 
       MOV  imgFilename[0], AL 
       MOV AH, state0[BX+3]               
       MOV  imgFilename[1], AH 
       MOV MODEB,0
       MOV AX,XKILLED
       MOV XSTARTB,AX
       MOV AX,YKILLED
       MOV YSTARTB,AX
       CALL PRINTB
       
       ADD YKILLED,75
       CMP YKILLED,600
       JNE GO_TO_POPB
        MOV YKILLED,0
        ADD XKILLED,75




      GO_TO_POPB:
        POP YSTARTB
        POP XSTARTB






       POP BX 
       MOV AL,SHAPESTORAGEB[0]
       MOV  imgFilename[0], AL            ;;GET OLD SHAPE AND PRINT IT ON THE NEW CELL
       MOV STATE0[BX+2],AL                                        
       MOV  AL,SHAPESTORAGEB[1]
       MOV  imgFilename[1], AL
       MOV  STATE0[BX+3],AL 
       MOV MODEB ,1
       CALL PRINTB
        MOV  imgFilename[0],'F'         
        MOV  imgFilename[1],'B'    ;PRINT HIGHLIGHT AT THE FIRST CELL
        MOV MODE,1
        CALL PRINTB       
       
     
         JMP GOATB
         
        JUMPTOHHEREB:   
        JMP HHEREB

        GOATB:



       MOV AX,XSTARTB 
       PUSH AX                         
       MOV AX ,YSTARTB
       PUSH AX  
      

        ;;GET OLD PLACE  
       MOV AX,PLACESTORAGEXB  
       MOV XSTARTB,AX                         
       MOV AX ,PLACESTORAGEYB
       MOV YSTARTB,AX 
       CALL GETPLACEB
       MOV BX,placeB                  ;;WE DELETE THE OLD SHAPE
       MOV AL,state0 [BX]                 
       MOV  imgFilename[0], AL 
       MOV AL, state0[BX+1]          ;printing the background OF THE OLD PLACE SO THE OLD SHAPE ID DISAPPERED
       MOV  imgFilename[1], AL
       MOV STATE0[BX+2],'X'       ;;UPDATE THE STATE ARRAY
       MOV STATE0[BX+3],'X'
       MOV MODEB,2
       CALL PRINTB
       
        POP AX
        MOV YSTARTB,AX
        POP AX
        MOV XSTARTB,AX


        HHEREB:
        MOV SHAPESTORAGEB[0],'Y'            ;;RETURN THE SHAPE STORAGE EMPTY AGAIN
        MOV SHAPESTORAGEB[1],'Y'     
      JMP CheckKeyPressed
;;==========================================================================
;;=========================================================================



 PRESS_ESC:
  ;END GAME
  ;Change to Text MODE
          MOV  AH,0
          MOV  AL,03h
          INT  10h
  ;return control to operating system
          MOV  AH , 4ch
          INT  21H
MAIN ENDP


PrintInState PROC       ;prints the square in 'place'

                ;525
        MOV AX, XSTART      
        MOV BL,SIZE_XY         ;rowNo = XSTART/SIZE_XY
        DIV BL 
        MOV rowNo,AL        
                          
        MOV AX, YSTART                               
        DIV SIZE_XY          ;columnNo = YSTART/SIZE_XY
        MOV columnNo,AL       
        MOV AH,0
           
        MOV BL,8
        MUL BL               ;AX = columnNo * 8                    

        ADD AL,rowNo        ;AX = (columnNo*8) + rowNo   
        MOV BL,4     
        MUL BL               ;AX = [ (columnNo*8) + rowNo ] *4

        Mov place,AX
       
                              
        MOV BX,place            
        MOV AL,state0 [BX]                 
        MOV  imgFilename[0], AL 
        MOV AH, state0[BX+1]          ;printing the background
        MOV  imgFilename[1], AH  
        MOV MODE,2
        CALL PRINT
       
        MOV BX,place                               
        MOV AL,state0 [BX+2]     
        MOV  imgFilename[0], AL       ;printing the PICE                   
        MOV AH, state0[BX+3]  
        MOV  imgFilename[1], AH 
        CMP AL,'X'
        JE EXIT0 
        CMP AL,'W'
         JNE BLACK
         MOV MODE,0
         JMP GOHERE
         BLACK:
         MOV MODE,1
    
        GOHERE:
        CALL PRINT
        EXIT0:
        ret
PrintInState ENDP



GETPLACE PROC  

             ;525
        MOV AX, XSTART      
        MOV BL,SIZE_XY         ;rowNo = XSTART/SIZE_XY
        DIV BL 
        MOV rowNo,AL        
                          
        MOV AX, YSTART                               
        DIV SIZE_XY          ;columnNo = YSTART/SIZE_XY
        MOV columnNo,AL       
        MOV AH,0
           
        MOV BL,8
        MUL BL               ;AX = columnNo * 8                    

        ADD AL,rowNo        ;AX = (columnNo*8) + rowNo   
        MOV BL,4     
        MUL BL               ;AX = [ (columnNo*8) + rowNo ] *4

        Mov place,AX


        ret
GETPLACE ENDP






;;;==================THIS PART WILL DELETED AFTER PHASE 1====================================



PrintInStateB PROC       ;prints the square in 'place'

                ;525
        MOV AX, XSTARTB     
        MOV BL,SIZE_XY         ;rowNo = XSTART/SIZE_XY
        DIV BL 
        MOV rowNo,AL        
                          
        MOV AX, YSTARTB                               
        DIV SIZE_XY          ;columnNo = YSTART/SIZE_XY
        MOV columnNo,AL       
        MOV AH,0
           
        MOV BL,8
        MUL BL               ;AX = columnNo * 8                    

        ADD AL,rowNo        ;AX = (columnNo*8) + rowNo   
        MOV BL,4     
        MUL BL               ;AX = [ (columnNo*8) + rowNo ] *4

        Mov placeB,AX
       
                              
        MOV BX,placeB            
        MOV AL,state0 [BX]                 
        MOV  imgFilename[0], AL 
        MOV AH, state0[BX+1]          ;printing the background
        MOV  imgFilename[1], AH  
        MOV MODEB,2
        CALL PRINTB
       
        MOV BX,placeB                               
        MOV AL,state0 [BX+2]     
        MOV  imgFilename[0], AL       ;printing the PICE                   
        MOV AH, state0[BX+3]  
        MOV  imgFilename[1], AH 
        CMP AL,'X'
        JE EXIT01 
        CMP AL,'W'
         JNE BLACK1
         MOV MODEB,0
         JMP GOHERE1
         BLACK1:
         MOV MODEB,1
    
        GOHERE1:
        CALL PRINTB
        EXIT01:
        ret
PrintInStateB ENDP



GETPLACEB PROC  

             ;525
        MOV AX, XSTARTB      
        MOV BL,SIZE_XY         ;rowNo = XSTART/SIZE_XY
        DIV BL 
        MOV rowNo,AL        
                          
        MOV AX, YSTARTB                               
        DIV SIZE_XY          ;columnNo = YSTART/SIZE_XY
        MOV columnNo,AL       
        MOV AH,0
           
        MOV BL,8
        MUL BL               ;AX = columnNo * 8                    

        ADD AL,rowNo        ;AX = (columnNo*8) + rowNo   
        MOV BL,4     
        MUL BL               ;AX = [ (columnNo*8) + rowNo ] *4

        Mov placeB,AX


        ret
GETPLACEB ENDP

END MAIN    