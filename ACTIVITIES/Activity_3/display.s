; main.s
; Runs on any Cortex M processor
; Activity_03 
; see a program run in C and assembly
;
; Author: Place your name here
; Date Created: 
; Date Modified:
; Insert a brief description of your program solution here 
; Lab number and lab partner if applicable 
; list all inputs and outputs here.

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
	;R6 = sum, R7 = result, R0 = remainder 
	MOV R1, #0x255 ;x 
	MOV R2, #0x250 ;y = 592
	MOV R3, #0x20  ;z = 32
	MOV R4, #0x300 ;n
	MOV R5, #0  ;result


;Result = ((x+y) - (z+n)) - 300 ; WORKS
;R8 and R9 are used as holders
	ADD R8, R1, R2 ;add x+y R8 = R1 +R2   
	ADD R9, R3, R4 ;add z+n
	SUB R7, R8, R9 ;subtract lines 49 and 50 and put in result
	SUB R7, #300 ; R7 = R7-300

;Sum = x + y + z + n ;WORKS
	ADD R6, R8, R9 ;since we already have these numbers added 
	
;remainder =y%z = Y-(Y/Z)*Z

	SDIV R8, R2 , R3 ;divid y and z
	MUL R8, R3 ;multiple R10 by z
	SUB R0, R2, R10 ;take y and subtract R10 from it  




	B   loop		; do not modify or delete this line. 

		

       ALIGN      
       ENDP 
       END 

