EXTRN Print:FAR
EXTRN PrintGrid:FAR
PUBLIC imgFilename,MODE,XSTART,YSTART


.model small
.STACK 512
.DATA

  XSTART      DW 0
  YSTART      DW 0
  MODE        DB 2
  COUNT       DB 4
                ; 'G','L','W','R',       'G','D','W','H',       'G','L','W','S',       'G','D','W','Q',       'G','L','W','K',       'G','D','W','S',       'G','L','W','H',       'G','D','W','R',

                ; 'G','D','W','P',       'G','L','W','P',       'G','D','W','P',       'G','L','W','P',       'G','D','W','P',       'G','L','W','P',       'G','D','W','P',       'G','L','W','P',

                ; 'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',

                ; 'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',

                ; 'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',

                ; 'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',       'G','D','X','X',       'G','L','X','X',

                ; 'G','L','B','P',       'G','D','B','P',       'G','L','B','P',       'G','D','B','P',       'G','L','B','P',       'G','D','B','P',       'G','L','B','P',       'G','D','B','P',

                ; 'G','D','B','R',       'G','L','B','H',       'G','D','B','S',       'G','L','B','Q',       'G','D','B','K',       'G','L','B','S',       'G','D','B','H',       'G','L','B','R',
                 
STATE0       DW         'G','L','W','R','G','D','W','H','G','L','W','S','G','D','W','Q','G','L','W','K','G','D','W','S','G','L','W','H','G','D','W','R'
STATE1       DW         'G','D','W','P','G','L','W','P','G','D','W','P','G','L','W','P','G','D','W','P','G','L','W','P','G','D','W','P','G','L','W','P'
STATE2       DW         'G','L','X','X','G','D','X','X','G','L','X','X','G','D','X','X','G','L','X','X','G','D','X','X','G','L','X','X','G','D','X','X'
STATE3       DW         'G','D','X','X','G','L','X','X','G','D','X','X','G','L','X','X','G','D','X','X','G','L','X','X','G','D','X','X','G','L','X','X'
STATE4       DW         'G','L','X','X','G','D','X','X','G','L','X','X','G','D','X','X','G','L','X','X','G','D','X','X','G','L','X','X','G','D','X','X'
STATE5       DW         'G','D','X','X','G','L','X','X','G','D','X','X','G','L','X','X','G','D','X','X','G','L','X','X','G','D','X','X','G','L','X','X'
STATE6       DW         'G','L','B','P','G','D','B','P','G','L','B','P','G','D','B','P','G','L','B','P','G','D','B','P','G','L','B','P','G','D','B','P'
STATE7       DW         'G','D','B','R','G','L','B','H','G','D','B','S','G','L','B','Q','G','D','B','K','G','L','B','S','G','D','B','H','G','L','B','R'
                 
SIZE_XY         DW 75
rowNo           DW 0
columnNo        DW 0
place           DW 0


  imgFilename DB 'G1', 0

.CODE
MAIN PROC FAR

          MOV  AX , @DATA
          MOV  DS , AX


  ;//////////////
          mov  AX,4F02h            ;/
          mov  BX,105h             ;/  graph 800*600  256 colors
          INT  10h                 ;/
  ;//////////////
  

  ;;; PRINT GRID==============================


  MYLOOP: 
          MOV  imgFilename[0],'G'
          MOV  imgFilename[1],'L'
          call PrintGrid
          ADD  YSTART,75
          MOV  imgFilename[0],'G'
          MOV  imgFilename[1],'D'
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

  ;;;PRINT Highlight ROW==================================
          MOV  imgFilename[0],'F'
          MOV  imgFilename[1],'R'
          MOV  XSTART,0
          MOV  YSTART,0
          MOV MODE,1
          CALL PRINT


	CheckKeyPressed:
        mov AH,00H
        int 16h
	CMP AH, 48H     ;SCANCODE FOR UP ARROW
        jne not_up
        jmp PRESS_UP
        not_up:
	CMP AH, 50H     ;SCANCODE FOR DOWN ARROW
        jne not_down
        jmp PRESS_DOWN
        not_down:	
        CMP AH, 4BH     ;SCANCODE FOR LEFT ARROW
        jne not_left
        jmp PRESS_LEFT
        not_left:
        CMP AH, 4DH     ;SCANCODE FOR UP ARROW
        jne not_right
        jmp PRESS_RIGHT
        not_right:	
        JMP CheckKeyPressed
	
	PRESS_UP:
        ;CALL GetPlace   ;set the 'place' value
        ;CALL PrintInState       ;removing the highlight from current cell
        MOV  imgFilename[0],'F' 
        MOV  imgFilename[1],'R'
        MOV MODE,1
	SUB YSTART,75           ;printing the highlight in the new cell
        CALL PRINT
        JMP CheckKeyPressed

        PRESS_DOWN:
        ;CALL GetPlace
        ;CALL PrintInState
        MOV  imgFilename[0],'F'
        MOV  imgFilename[1],'R'
        MOV MODE,1
	ADD YSTART,75
        CALL PRINT
        JMP CheckKeyPressed

	PRESS_LEFT:
        ;CALL GetPlace
        ;CALL PrintInState
        MOV  imgFilename[0],'F'
        MOV  imgFilename[1],'R'
        MOV MODE,1
	SUB XSTART,75
        CALL PRINT
        JMP CheckKeyPressed
	
	PRESS_RIGHT:
        ;CALL GetPlace
        ;CALL PrintInState
        MOV  imgFilename[0],'F'
        MOV  imgFilename[1],'R'
        MOV MODE,1
	ADD xSTART,75
        CALL PRINT
        JMP CheckKeyPressed

        ENDKEYPRESSED:



  ; Press any key to exit
          MOV  AH , 0
          INT  16h
  ;Change to Text MODE
          MOV  AH,0
          MOV  AL,03h
          INT  10h
  ;return control to operating system
          MOV  AH , 4ch
          INT  21H



MAIN ENDP

;GetPlace PROC
;        MOV AX, XSTART     
;        DIV SIZE_XY         
;        MOV rowNo,AX         ;rowNo = XSTART/SIZE_XY
;
;        MOV AX, YSTART     
;        DIV SIZE_XY         
;        MOV columnNo,AX      ;columnNo = YSTART/SIZE_XY
;               
;        MOV BX,8
;        MUL BX               ;AX = columnNo * 8                    
;        ADD AX,rowNo         ;AX = (columnNo*8) + rowNo
;        
;        MOV BX,4     
;        MUL BX               ;AX = [ (columnNo*8) + rowNo ] *4
;
;        Mov place,AX

;GetPlace ENDP

;PrintInState PROC       ;prints the square in 'place'
;
;        MOV BX,offset state0    ;gets a pointer to first element in state0
;        ADD BX,place            ;adds the place to the pointer to get the values in place
;        MOV AX, [BX]            ;moves the first 2 bytes into ax
;
;        MOV  imgFilename[0], AL
;        MOV  imgFilename[1], AH
;        MOV MODE,2
;        CALL PRINT              ;printing the background
;
;        MOV BX,offset state0    
;        ADD BX,place
;        ADD BX,2                ;gets the second 2 bytes after the state0+place 
;        MOV AX, [BX]
;
;        MOV  imgFilename[0], AL
;        MOV  imgFilename[1], AH
;        MOV MODE,0
;        CALL PRINT              ;printing the piece
;
;PrintInState ENDP

END MAIN    






