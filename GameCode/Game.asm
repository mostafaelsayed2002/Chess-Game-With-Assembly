EXTRN Print:FAR
EXTRN PrintGrid:FAR
PUBLIC imgFilename,MODE,XSTART,YSTART


.model small
.STACK 512
.DATA

SHAPESTORAGE    DB  'Y','Y' 
PLACESTORAGEX    DW 0  
PLACESTORAGEY    DW 0 



  XSTART      DW 0
  YSTART      DW 0
  MODE        DB 2
  COUNT       DB 4

SIZE_XY         DB 75
rowNo           DB 0
columnNo        DB 0
place           DW 0





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

  ;;;PRINT Highlight CELL===================================================
          MOV  imgFilename[0],'F'         
          MOV  imgFilename[1],'R'
          MOV  XSTART,0             ;PRINT HIGHLIGHT AT THE FIRST CELL
          MOV  YSTART,0
          MOV MODE,1
          CALL PRINT
;;==========================================================================
;;  THIS PART OF CODE DO 
;;  WAIT FOR THE KEYBOARD CLICK AND GET IT 
;;=========================================================================
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

        CMP AH,1CH     ;SCANCODE FOR UP ENTER
        jne not_enter
        jmp PRESS_ENTER
        not_enter:

        CMP AH, 01H     ;SCANCODE FOR ESC
        jne not_esc
        jmp PRESS_ESC
        not_esc:
        JMP CheckKeyPressed
	
;;==========================================================================
;;  THIS PART OF CODE DO 
;;  1-MOVE HIGHLIGHT OF FIRST PLAYER
;;=========================================================================
        PRESS_UP:
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

        PRESS_DOWN:
        MOV BX,YSTART
        ADD BX,75 
        CMP BX,525
        JA CheckKeyPressed
        CALL PrintInState
        MOV  imgFilename[0],'F'
        MOV  imgFilename[1],'R'
        MOV MODE,1
	ADD YSTART,75
        CALL PRINT
        JMPGO:
        JMP CheckKeyPressed

	PRESS_LEFT:
        MOV BX,XSTART
        SUB BX,75 
        CMP BX,0
        JL JMPGO
        CALL PrintInState
        MOV  imgFilename[0],'F'
        MOV  imgFilename[1],'R'
        MOV MODE,1
	SUB XSTART,75
        CALL PRINT
        JMP CheckKeyPressed
	
	PRESS_RIGHT: 
        MOV BX,XSTART
        ADD BX,75 
        CMP BX,525
        JA JMPGO
        CALL PrintInState
        MOV  imgFilename[0],'F'
        MOV  imgFilename[1],'R'
        MOV MODE,1
	ADD XSTART,75
        CALL PRINT
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
;;     7- PRINT THE OLD SHAPE IN CURRENT X,Y
;;=========================================================================

       PRESS_ENTER:
       CMP SHAPESTORAGE[0],'Y'    ;CHECK IF IS EMPTY
       JNE NOTEMPTY

       ;;EMPTY --> GET ITS PLACE WHICH IS WANTED TO MOVE 
       CALL GETPLACE       
       MOV BX ,place 
      ;;THEN  GET THE SHAPE WHICH IS WANTED TO MOVE
      ;; AND STORE  IT IN  "SHAPESTORAGE"      
       MOV AL,STATE0[BX+2]
       CMP AL,'X'          ;;THIS CHECK IF IT IS EMPY CELL AND PLAYER WANT TO MOVE IF WHICH IS FORBIEDDEN                                                  
       JE here 
       CMP AL,'B'
       JE here 
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
 


    ;;IF IT IS NOT EMPTY WE DO THE FOLLOWING:
       NOTEMPTY:
       MOV DX,XSTART    
       MOV CX,YSTART                        
       PUSH DX                 
       PUSH CX                        ;;GET OLD PLACE
       
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
       
       ;; HERE WE PRINT ON THE NEW CELL
       POP CX 
       POP DX
       MOV XSTART,DX
       MOV YSTART,CX
       CALL GETPLACE
       MOV BX,place                                       
       PUSH BX
       MOV AL ,state0[BX+2]
       CMP AL,'W'
       JE HHERE
       MOV AL,state0 [BX]                 
       MOV  imgFilename[0], AL 
       MOV AH, state0[BX+1]          ;printing the background  OF THE NEW CELL  TO DELETE THE ANIMY SHAPE IF EXSITS          
       MOV  imgFilename[1], AH  
       MOV MODE,2
       CALL PRINT
   
     
       POP BX 
       MOV AL,SHAPESTORAGE[0]
       MOV  imgFilename[0], AL            ;;GET OLD SHAPE AND PRINT IT ON THE NEW CELL
       MOV STATE0[BX+2],AL                                        
       MOV  AL,SHAPESTORAGE[1]
       MOV  imgFilename[1], AL
       MOV  STATE0[BX+3],AL 
       MOV MODE ,0
       CALL PRINT
        
        HHERE:
        MOV SHAPESTORAGE[0],'Y'            ;;RETURN THE SHAPE STORAGE EMPTY AGAIN
        MOV SHAPESTORAGE[1],'Y'
       
     
      JMP CheckKeyPressed
;;==========================================================================
;;=========================================================================





       


 PRESS_ESC:
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









END MAIN    






