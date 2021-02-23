#include "hider.h"
//==============================================================================
//Timer3 Prescaler :7; Preload = 59999; Actual Interrupt Time = 10 ms
void StartTimer3_10ms(){
  RCC_APB1ENRbits.TIM3EN = ON;
  TIM3_CR1bits.CEN = OFF;
  TIM3_PSC = 7;
  TIM3_ARR = 59999;
  NVIC_IntEnable(IVT_INT_TIM3);
  TIM3_DIERbits.UIE = ON;
  TIM3_CR1bits.CEN = ON;
}
//==============================================================================
//#define DEBUG
void Timer3_10ms_int() iv IVT_INT_TIM3 ics ICS_AUTO
{
 static unsigned char tim_count = 0;
 static unsigned int msec = 0,sec = 0,min = 0,hour = 0;
  TIM3_SRbits.UIF = 0;
  flag_t.ovf_flag = SET;
 /*msec++;
  if(msec>=100)
   {
      msec = 0;
      sec++;
      if(sec>=60)
       {
         sec = 0;
         min++;
         if(min>=60)
          {
           min = 0;
           hour++;
           if(hour>=1)
            {
              if(ControlCalibrate(&BoardSensorPPM,&ForwardSensorPPM,&BackwardSensorPPM,ALARM_LEVEL/2.0))
               {
                  msec = 0;
                  sec  = 0;
                  min  = 0;
                  hour = 0;
                  flag_t.calibrate_status = SET;
                  flag_t.recalibrate = SET;
                  resetLB();
                  Recalibrate();
               }
                else
                 {
                   msec = 0;
                   sec  = 0;
                   min  = 0;
                   hour = 0;
                 }
            }
          }
       }
   }*/

//------------------------------------------------------------------------------
   /*if(getAdcStatus()&&getHeaterStatus())
      {
       heaterMode(ON);
      }
        else
         {
           heaterMode(getHeaterStatus());
         }*/
//------------------------------------------------------------------------------
}
//==============================================================================
void WDT_Init()
{
   RCC_CSRbits.LSION = 1;
   while(!RCC_CSRbits.LSIRDY);
   IWDG_KR = 0x5555;      //write with protect
   IWDG_PRbits.PR = 0x00;  //prescaler
   IWDG_KR = 0xCCCC;      //start watchdog
   IWDG_KR = 0xAAAA;      //reset watchdog
                          //PCKL/4096/prescaler,LSI clock speed 37kHz
                          //000: divider /4
                          //001: divider /8
                          //010: divider /16
                          //011: divider /32
                          //100: divider /64
                          //101: divider /128
                          //110: divider /256
                          //111: divider /256

}
//==============================================================================
void clear_WDT()
{
   IWDG_KR = 0xAAAA;      //reset watchdog
}
//==============================================================================
/*void setPreloadValue(unsigned long value)
{
  while(IWDG_SRbits.PVU);
  IWDG_KR = 0x5555;
  IWDG_PR = value;

}*/