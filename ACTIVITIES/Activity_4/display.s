; main.s
; Runs on any Cortex M processor
; Activity_03 
; see a program run in C and assembly
;
; Author: Mel Manuel
; Date Created: 10/9/2024
; Date Modified: 10/9/2024
; Insert a brief description of your program solution here 
; --> recreate the c progarm in main.c into assembly code
; Lab number and lab partner if applicable 
; --> lab 4
; list all inputs and outputs here.
;;;;;
; we align 32 bit variables to 32-bits
; we align op codes to 16 bits

;------ DO NOT MODIFY OR REMOVE THIS SECTION ---------------      
	   THUMB
       AREA    DATA, ALIGN=4
	   ALIGN 
;-----------------------------------------------------------

;; Delcare global variables here if needed
   


;;------------ DO NOT MODIFY OR REMOVE THIS SECTION------------
       AREA    |.text|, CODE, READONLY, ALIGN=2
       GET tm4c123gh6pm.s
	   EXPORT  Start
;;------------------------------------------------------------

Start	proc		; DO NOT MODIFY THIS LINE. THIS MARKS THE START OF YOUR ASSEMBLY PROGRAM.

; board initialization here if needed
; insert all pins initilization code here before entering the main endless loop.


loop   
	; main program loop
	; insert your code here
	MOV R1, #100 ;R1 = TinF
	MOV R2, #24  ;R2 = TinC 
	
	;number holders
	MOV R0, #5 
    MOV R10, #9	
	;R3 = TC, R4 = TF, R5 = TK, R6 = TFdiff, R7 = TCdiff   
    ;TC = ((TinF - 32)*5)/9)
    SUB R3, R1, #32
	MUL R3, R3, R0
    UDIV R3, R10
	
	;TF = ((TC*9)/5)+32
	MUL R4, R3, R10
	UDIV R4, R0
	ADD R4, #32
	
	;TFdiff = TinF - TF
	SUB R6, R1, R4
	
	;TF = ((TinC * 9)/5)+32)
	MUL R4, R2, R10
	UDIV R4, R0
	ADD R4, #32
	
	;TC = ((TF - 32)*5)/9)
	SUB R3, R4, #32
	MUL R3, R0
	UDIV R3, R10
	
	;TCDiff = Tinc - TC
	SUB R7, R2, R3

	;TK = TC + 273
	ADD R5, R3, #255
	ADD R5, #18
    	


	B   loop		; do not modify or delete this line. 

		

       ALIGN      
       ENDP 
       END 

