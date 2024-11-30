
#include <stdint.h>



// Defined in display.s

void Start(void);
// define global variables here



int main(void) {
	uint32_t x=0x255; 
	uint32_t y=0x250;
	uint32_t z=0x20;
	uint32_t n=0x300;
	uint32_t Result=0;
	uint32_t sum;
	uint32_t remainder;
	
	Result = ((x+y) - (z+n)) - 300;  
	sum=x+y+z+n;
	remainder= y%z;			// calculates the remainder after performing an integer division of y/z. 
	
	Start();				//do not modify or delete this line.
	
	return 0;
}
