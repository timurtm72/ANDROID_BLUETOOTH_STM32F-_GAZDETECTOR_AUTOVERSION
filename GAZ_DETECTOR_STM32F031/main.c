#include"hider.h"
//==============================================================================
void main()
{

 Init_flags();
 InitVar();
 Init_pin();
 Init_ADC_chanell();
 StartTimer3_10ms();
 InitUartModuleBTU();
 EnableInterrupts();
 WDT_Init();
 ChekTrue();
 while(TRUE)
  {
     globalProcess();
  }
}
//==============================================================================