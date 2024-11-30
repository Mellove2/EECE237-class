; main.s
; Runs on any Cortex M processor
; Activity_05
; MEMORY OPERATIONS
;
; Author: Mel Manuel
; Date Created: 11/6/2024
; Date Modified: 11/6/2024
; Insert a brief description of your program solution here 
; Lab number and lab partner if applicable 
; list all inputs and outputs here.

; we align 32 bit variables to 32-bits
; we align op codes to 16 bits

;------ DO NOT MODIFY OR REMOVE THIS SECTION ---------------      
	   THUMB
       AREA    DATA, ALIGN=4
;       GET tm4c123gh6pm.s
	   ALIGN 
;-----------------------------------------------------------
ONESEC             DCD 5333333      ; approximately 1s delay at ~16 MHz clock
QUARTERSEC         DCD 1333333      ; approximately 0.25s delay at ~16 MHz clock
FIFTHSEC           DCD 1066666      ; approximately 0.2s delay at ~16 MHz clock
	
; memory addresses for Port F control registers. 

GPIO_PORTF_DATA_R       EQU   0x400253FC
GPIO_PORTF_DIR_R        EQU   0x40025400
GPIO_PORTF_DEN_R        EQU   0x4002551C

; System control register use either one to turn on the clock for any port

SYSCTL_SCGC2_R          EQU   0x400FE118
	
SYSCTL_RCGCGPIO_R       EQU   0x400FE608
	
;; Delcare global variables here if needed
   

;;------------ DO NOT MODIFY OR REMOVE THIS SECTION------------
       AREA    |.text|, CODE, READONLY, ALIGN=2
 ;      GET tm4c123gh6pm.s
	   EXPORT  Start
;;------------------------------------------------------------


Start	proc		; DO NOT MODIFY THIS LINE. THIS MARKS THE START OF YOUR ASSEMBLY PROGRAM.

; board initialization here 
; insert all pins initilization code here before entering the main endless loop.
	
	;turn on port : port F	
	LDR R0, =SYSCTL_RCGCGPIO_R
	LDR R1, [R0]
	ORR R1, #0x20 
	STR R1, [R0]
	
	;wait
	NOP
	NOP
	NOP
	
	;enable pins : PF1, PF2, and PF3
	LDR R2, =GPIO_PORTF_DEN_R
	LDR R8, [R2]
	ORR R8, #0x0E
	STR R8, [R2]
	
	;Configure directon (input/output) : make PF1,PF2,PF3 output
	LDR R6, =GPIO_PORTF_DIR_R
	LDR R7, [R6]
	ORR R7, #0x0E
	STR R7, [R6]
	
	
	
		
	
;;INSTEAD OF R4 FOR THE LED STUFF I USED R9!!!!!!!!!!!!!!!!!

loop   
	; main program loop
	; insert your code here

	;SHIFT OPERATIONS
	LDR R6, =GPIO_PORTF_DATA_R
	LDR R9, [R6]
	MOV R9, #0x03 ;can't use R4 since its in delay function ;;gives red
	LSL R9, #2 ;gives sky blue  
	STR R9,[R6] 
	
	BL delay ;delay
		
	;pink
	LSR	R9, #1 ;gives pink 
	STR R9, [R6] 
	
	BL delay 
	
	LSL R9, #2 ;gives green
	STR R9, [R6]
	
	BL delay 
	
	LSR R9, #3 ;give red
	STR R9, [R6] 
	
	BL delay
	
	LSR R9, #1 ;gives black
	STR R9, [R6]
	
	;to make off look off more
	BL delay
	BL delay
	BL delay
	BL delay
	BL delay
	
	
	
	B   loop		; do not modify or delete this line. 


;-------------DO NOT MODIFY ANY LINES BELOW THIS SECTION------------
;------------delay------------
; Delay function for testing, which delays about 3*count cycles.
; Input: R0  count
; Output: none

delay
    LDR	 R3, = ONESEC
	LDR	 R4, [R3]
d	SUBS R4, R4, #1                 ; R0 = R0 - 1 (count = count - 1)
    BNE  d                           ; if count (R0) != 0, skip to 'd'
    BX   LR                          ; return

       ALIGN      
       ENDP 
       END 

