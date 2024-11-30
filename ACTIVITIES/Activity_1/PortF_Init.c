// PortF_Init.c
// initilization steps for port F
// PF2 and PF1 as outputs 
//

#include <stdint.h>
#include "tm4c123gh6pm.h"

void PortF_Init(void){
  SYSCTL_RCGCGPIO_R |= 0x20;          // 1) Port F clock
  while((SYSCTL_PRGPIO_R&0x0020) == 0){};// ready?
  GPIO_PORTF_LOCK_R = 0x4C4F434B;   // 2) unlock GPIO Port F
  GPIO_PORTF_CR_R = 0x1F; 
  GPIO_PORTF_AMSEL_R &= ~0x1F;     // 3) disable analog
  GPIO_PORTF_PCTL_R =0;// 4) configure as GPIO
  GPIO_PORTF_DIR_R |= 0x06;        // 5) PF2 PF1 outputs
	GPIO_PORTF_DIR_R &= ~0x11;        // 5) PF4 PF0 inputs
  GPIO_PORTF_AFSEL_R &= ~0x1F;     // 6) normal function
	GPIO_PORTF_PUR_R = 0x11;          // enable pull-up on PF0 and PF4
  GPIO_PORTF_DEN_R |= 0x1F;        // 7) digital I/O on PF2-1


}  
