// Documentation Section 
// main.c

// Runs on TM4C123 LaunchPad
// Input From: 
// Output to:
//
// 
// Author: Enter your name here
// Date: 
// Last modified: 

// 1. Pre-processor Directives Section
// Constant declarations to access port registers using 
// symbolic names instead of addresses
// include directives
#include <stdint.h>
#include "tm4c123gh6pm.h"
#include "PortF_Init.h"
#include "delay.h"

// 2. Declarations Section
//   Global Variables
//   Insert Function Prototypes here



// 3. Subroutines Section
// MAIN: Mandatory for a C Program to be executable
unsigned long sw;


int main(void){
// Declare variables here
// Initialize the ports here
	
PortF_Init();																			// initialize port F, PF0 & PF4 inputs, PF1, PF2 outputs 

		while(1){
// Insert your code here
    sw=	GPIO_PORTF_DATA_R	& 0x11;									// read the switch input from the board SW0 and SW4
	
		if ( sw == 0x01){															// if SW1 or 0x01 is pressed
			GPIO_PORTF_DATA_R ^= 0x02;                  // Red ON Blue Off
			Delay(436344);			// delay								// wait for some time 
		
		}
		else if (sw==0x00){														// if SW0 or 0x10 is pressed //changed to 0x11 meaaning both buttons are pressed 
			GPIO_PORTF_DATA_R ^= 0x04;                  // Red ON Blue Off
			Delay(436344);			// delay
		}
		
		else 
			GPIO_PORTF_DATA_R = 0x00;										// otherwise do this 
  }
}


// Insert subroutines here 
// Inputs: 
// Outputs:
// Notes of functionality 

