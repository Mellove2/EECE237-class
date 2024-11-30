
;------------PortF_Init------------
; Initialize GPIO Port F for negative logic switches on PF0 and
; PF4 as the Launchpad is wired.  Weak internal pull-up
; resistors are enabled, and the NMI functionality on PF0 is
; disabled.  Make the RGB LED's pins outputs.
; Input: none
; Output: none
; Modifies: R0, R1, R2

       AREA    |.text|, CODE, READONLY, ALIGN=2
       GET tm4c123gh6pm.s
	   EXPORT  PortF_Init
		   
PortF_Init	proc
    LDR R1, =SYSCTL_RCGCGPIO_R      ; 1) activate clock for Port F
    LDR R0, [R1]                 
    ORR R0, R0, #0x20               ; set bit 5 to turn on clock
    STR R0, [R1]                  
    NOP
    NOP                             ; allow time for clock to finish
    LDR R1, =GPIO_PORTF_LOCK_R      ; 2) unlock the lock register
    LDR R0, =0x4C4F434B             ; unlock GPIO Port F Commit Register
    STR R0, [R1]                    
    LDR R1, =GPIO_PORTF_CR_R        ; enable commit for Port F
    MOV R0, #0xFF                   ; 1 means allow access
    STR R0, [R1]                                                        
    LDR R1, =GPIO_PORTF_DIR_R       ; 5) set direction register
    MOV R0,#0x0E                    ; PF0 and PF7-4 input, PF3-1 output
    STR R0, [R1]                                       
    LDR R1, =GPIO_PORTF_PUR_R       ; pull-up resistors for PF4,PF0
    MOV R0, #0x11                   ; enable weak pull-up on PF0 and PF4
    STR R0, [R1]              
    LDR R1, =GPIO_PORTF_DEN_R       ; 7) enable Port F digital port
    MOV R0, #0xFF                   ; 1 means enable digital I/O
    STR R0, [R1]                   
    BX  LR      
	
	
       ALIGN      
       ENDP 
       END 

