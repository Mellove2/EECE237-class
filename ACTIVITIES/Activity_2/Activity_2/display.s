; main.s
; Runs on any Cortex M processor
; Template porject to be used as a starting point for all activities

;
; Author: Place your name here
; Date Created: 
; Date Modified:
; Insert a brief description of your program solution here 
; Lab number and lab partner if applicable 
; list all inputs and outputs here.

; we align 32 bit variables to 32-bits
; we align op codes to 16 bits
       
	   THUMB
       AREA    DATA, ALIGN=4 

;; Delcare global variables here if needed
;; Three variables are declared in memory 
;; Do not modify this code, you will only modify the memory window contents. 

	   ALIGN

x	   DCD	255 
y	   DCD	250
z	   DCD	0

;;------------ DO NOT MODIFY OR REMOVE THIS SECTION------------
       AREA    |.text|, CODE, READONLY, ALIGN=2
       GET tm4c123gh6pm.s
	   EXPORT  Start
;;------------------------------------------------------------


Start	proc

; initialization here
; insert all initilization code here before entering the main endless loop.


loop   
	; main program loop
	ldr		R0, =x				; the following two lines load the first varialbe x into R1
	ldr 	R1, [R0]			; R1=x
	ldr		R2, =y				; these two lines load variable y into R3
	ldr 	R3, [R2]			; R3 = y
	ADDS	R4, R1, R3			; Add the contents of R1 and R3, store results in R4
	ldr 	R5, =z	
	str		R4, [R5]			; Strore the results back in memory at z
	
    B   	loop

		

       ALIGN      
       ENDP 
       END 

