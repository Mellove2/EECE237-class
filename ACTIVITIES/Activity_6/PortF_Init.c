//Port F initialization with minimum configuration 

#include <stdint.h>
#include "TM4c123gh6pm_V.h"
# include "PortF_Init.h"

void PortF_Init(void){
  SYSCTL_RCGCGPIO_R |= 0x20;          // 1) Port F clock
  while((SYSCTL_PRGPIO_R&0x0020) == 0){};// ready?

  GPIO_PORTF_DIR_R |= 0x0E;        // 5) PF3 PF2 PF1 outputs
  GPIO_PORTF_DEN_R |= 0x0E;        // 7) digital I/O on PF3-1
}  
