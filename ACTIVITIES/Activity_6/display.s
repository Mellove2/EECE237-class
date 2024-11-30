; Runs on any Cortex M processor
; Activity_06
; MEMORY OPERATIONS


; Author: Mel Manuel //helped by Anna 

; Date Created: 10/23/2024
; Date Modified: 10/23/2024

; This program initializes two arrays, 'Colors' and 'Pattern', and controls the LEDs on the Tiva Launchpad
; by outputting specific color patterns using memory operations.

; Inputs: None
; Outputs: LEDs on Tiva Launchpad



; we align 32-bit variables to 32 bits
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


;declare colors and pattern
Colors  DCW 0,0,0,0,0,0,0,0 ; block of 8 variables, each 16-bit
Pattern DCB 0,0,0,0,0,0 ; block of 6 variables, each 8-bit

;;------------ DO NOT MODIFY OR REMOVE THIS SECTION------------

       AREA    |.text|, CODE, READONLY, ALIGN=2
       EXPORT  Start

;;------------------------------------------------------------

Start  PROC  ; DO NOT MODIFY THIS LINE. THIS MARKS THE START OF YOUR ASSEMBLY PROGRAM.



; Initialize 'Colors' array with the 8 color values



    ;LDR R0, =Colors        ; Load base address of Colors into R0



    ;MOV R1, #0x00          ; Black create
    ;STRH R1, [R0], #2        ; store in R0, 16-bits, and increment by 2-bits.

    ;MOV R1, #0x02          ; Red
    ;STRH R1, [R0], #2

    ;MOV R1, #0x04          ; Blue
    ;STRH R1, [R0], #2

    ;MOV R1, #0x06          ; Magenta
    ;STRH R1, [R0], #2

    ;MOV R1, #0x08          ; Green
    ;STRH R1, [R0], #2

    ;MOV R1, #0x0A          ; Yellow
    ;STRH R1, [R0], #2

    ;MOV R1, #0x0C          ; Cyan
    ;STRH R1, [R0], #2

    ;MOV R1, #0x0E          ; White
    ;STRH R1, [R0]



    LDR R4, =Colors        ; points to Colors
    LDR R5, =Pattern       ; points to Pattern

;pattern stuff
    LDRH R6, [R4, #4]      ; blue
    STRB R6, [R5], #1      

    LDRH R6, [R4]          ; black
    STRB R6, [R5], #1

    LDRH R6, [R4, #10]     ; yellow
    STRB R6, [R5], #1

    LDRH R6, [R4]          ; black
    STRB R6, [R5], #1

    LDRH R6, [R4, #14]     ;white
    STRB R6, [R5], #1

    LDRH R6, [R4]          ;black
    STRB R6, [R5], #1



loop
    
    LDR R0, =Colors 
	LDR R1, R0
	
	STRH R1, [R0]
color_loop CMP R1, #0x00
	BEQ stop
	SUB R1, #2
	STRH R1, [R0], #2
	B color_loop
stop   

	LDR R4, =Colors
	LDR R5, =Pattern
	
	MOV R7, #0 
	MOV R8, #0
	
pattern_maker
	LDRH R6, [R4, R7]
	STRB R6, [R5, R8]
	ADD R7, R7, #1 ;increment counter
	
	;check the colors
	CMP R6, #0x04 
	BEQ blue

	CMP R6, #0x0A
	BEQ yellow
	
	CMP R6, #0x0E
	BEQ white

    CMP R6, #0x00
	BEQ black
	
	
	BGE next
;store the colors	
blue
	MOV R6, #0x04
    STRB R6, [R5, R8] ;move blue into pattern
    ADD R8, R8, #1 ;increment counter 
	B next
	
yellow
	MOV R6, #0x0A
    STRB R6, [R5, R8 ;move blue into pattern
    ADD R8, R8, #1 ;increment counter
	B next
	
white
	MOV R6, #0x0E
    STRB R6, [R5, R8] ;move blue into pattern
    ADD R8, R8, #1 ;increment counter
	B next
	
black 
	MOV R6, #0x00
    STRB R6, [R5, R8] ;move blue into pattern
    ADD R8, R8, #1 ;increment counter
	B next
	
next
	ADD R7, R7, #2
	CMP R7, $6
	BGE Pattern_Loop
	
; Output the pattern sequence from 'Pattern' array

    LDR R1, =0x400253FC    ; used to control I/Os
    LDR R5, =Pattern       ; points to Pattern
    MOV R2, #6             ; Counter for 6 times

   
Pattern_Loop

    LDRB R3, [R5], #1      ; Load byte from Pattern into R3, increment R5
    STR R3, [R1]           ; Output to LEDs
	
    BL delay               ; Delay
	
    SUBS R2, R2, #1        ; Decrement counter
    BNE Pattern_Loop       ; Loop if R2 != 0



    B loop                 ; Repeat the loop



;-------------DO NOT MODIFY ANY LINES BELOW THIS SECTION------------

;------------delay------------

; Delay function for testing, which delays about 3*count cycles.
; Input: R0  count
; Output: none



delay

    LDR     R3, = ONESEC
    LDR     R4, [R3]
d    SUBS R4, R4, #1                 ; R4 = R4 - 1
    BNE  d                           ; if R4 != 0, loop
    BX   LR                          ; return



   ALIGN      

   ENDP

   END