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
GPIO_PORTF_PUR_R        EQU   0x40025510 	; PULL UP RESISTOR MEMORY LOCATION 

; System control register use either one to turn on the clock for any port

SYSCTL_RCGC2_R          EQU   0x400FE118
	
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

	
    LDR R0, =SYSCTL_RCGCGPIO_R
	LDR R1, [R0]
	ORR R1, #0x20 
	STR R1, [R0]
	
	;wait
	NOP
	NOP
	NOP
	
	;enable pins : PF1, PF2, and PF4
	LDR R2, =GPIO_PORTF_DEN_R
	LDR R5, [R2]
	ORR R5, #0x16
	STR R5, [R2]
	
	;Configure directon (input/output) : make PF1,PF2 output and make PF4 an input
	LDR R6, =GPIO_PORTF_DIR_R
	LDR R7, [R6]
	ORR R7, #0x06
	BIC R7, #0x10
	STR R7, [R6]
	
	;enbale the pull-up resistor on the board
	LDR R8, =GPIO_PORTF_PUR_R 
	LDR R9, [R8]
	ORR R9, #0x10
	STR R9, [R8]	
loop   
	; main program loop
	; insert your code here
	
	;read from PF4
	LDR R10, =GPIO_PORTF_DATA_R  ;read from port F
	LDR R11, [R10]
	AND R11, #0x10 ;read from PF4
    CMP R11, #0x00 ;compare whats in PF4 to 0000 0000
	BEQ	RED ;turn red if PF4 == 0 -- neg. logic so pin is pressed
    ORR R11, #0x04 ;if PF4 == 0/released then turn blue
	STR R11, [R10]  
	B Stop
			
	
RED
	BIC R11, #0x06
	STR R11, [R10]
	
	EOR R11, #0x02 ;turn on red
	STR R11, [R10]
    BL delay
	
	
	LDR R10, =GPIO_PORTF_DATA_R  ;read from port F
	LDR R11, [R10]
	AND R11, #0x10 ;read from PF4
    CMP R11, #0x00 ;compare whats in PF4 to 0000 0000
	BEQ	BLACK ;turn red if PF4 == 0 -- neg. logic so pin is pressed
	B Stop

BLACK 
	BIC R11, #0x06
	STR R11, [R10]
	BL delay
	B RED

Stop 
	BL delay
	BIC R11, #0x06 ;turn off
	STR R11, [R10]
	B   loop		; do not modify or delete this line. 

 
;-------------DO NOT MODIFY ANY LINES BELOW THIS SECTION------------
;------------delay------------
; Delay function for testing, which delays about 3*count cycles.
; Input: R0  count
; Output: none

delay
	PUSH {R3, R4}
	LDR	 R3, = ONESEC
	LDR	 R4, [R3]
d	SUBS R4, R4, #1                 ; R0 = R0 - 1 (count = count - 1)
    BNE  d                           ; if count (R0) != 0, skip to 'd'
	POP	 {R3, R4}
    BX   LR                          ; return

       ALIGN      
       ENDP 
       END 

