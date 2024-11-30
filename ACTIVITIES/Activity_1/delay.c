// delay.c 
// Use the following delay function to create delay periods 
// Assume it takes 0.1 sec to count from 145448 down to zero
// Inputs: The count number needed
// Outputs: None
// Notes: ...

void Delay(unsigned long TimeVal){

	
  while(TimeVal){
		TimeVal--;
  }
}
