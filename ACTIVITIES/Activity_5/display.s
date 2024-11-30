; main.s
; Runs on any Cortex M processor
; Activity_05
; MEMORY OPERATIONS
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
       GET tm4c123gh6pm.s
	   ALIGN 
;-----------------------------------------------------------
ONESEC             DCD 5333333      ; approximately 1s delay at ~16 MHz clock
QUARTERSEC         DCD 1333333      ; approximately 0.25s delay at ~16 MHz clock
FIFTHSEC           DCD 1066666      ; approximately 0.2s delay at ~16 MHz clock
;; Delcare global variables here if needed
   


;;------------ DO NOT MODIFY OR REMOVE THIS SECTION------------
       AREA    |.text|, CODE, READONLY, ALIGN=2
 ;      GET tm4c123gh6pm.s
	   EXPORT  Start
;;------------------------------------------------------------


Start	proc		; DO NOT MODIFY THIS LINE. THIS MARKS THE START OF YOUR ASSEMBLY PROGRAM.

; board initialization here if needed
; insert all pins initilization code here before entering the main endless loop.

loop   
	; main program loop
	; insert your code here

	LDR R0, =0x400253FC ;address is in R0
	LDR R1, [R0] ;load contents of that address into R1 //data flows right to left
	ORR R1, #0x2 ; turns red
	STR R1, [R0] ;store value in R1 at address location pointed to by R0
	
	BL delay ;delay since you can't change it so

    AND R1, #0x0 ; turn off 
	STR R1, [R0]
	
	BL delay
	
	
	ORR R1, #0x6 ;turn blue ORR 0x04 //pink ORR 0x06  
	STR R1, [R0]	
	
	BL delay 
	
	AND R1, #0x0
	STR R1, [R0]
	
	BL delay
	
	
	ORR R1, #0x8 ;turn green   
	STR R1, [R0]
	
	BL delay 
	
	AND R1, #0x0
	STR R1, [R0]
	
	BL delay
	
	B   loop		; do not modify or delete this line. 


;-------------DO NOT MODIFY ANY LINES BELOW THIS SECTION------------
;------------delay------------
; Delay function for testing, which delays about 3*count cycles.
; Input: R0  count
; Output: none

delay
    LDR	 R3, = QUARTERSEC
	LDR	 R4, [R3]
d	SUBS R4, R4, #1                ; R0 = R0 - 1 (count = count - 1)
    BNE  d                           ; if count (R0) != 0, skip to 'd'
    BX   LR                          ; return

       ALIGN      
       ENDP 
       END 

