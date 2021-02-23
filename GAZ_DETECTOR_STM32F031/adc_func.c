#include "hider.h"

//==============================================================================
void Init_ADC_chanell()
{
  ADC1_Init();
  ADC_Set_Input_Channel(_ADC_CHANNEL_1|_ADC_CHANNEL_3|_ADC_CHANNEL_4);//|_ADC_CHANNEL_3|_ADC_CHANNEL_4);
  /* (1) Enable the ADC */
  /* (2) Wait until ADC ready */
  ADC_CR |= ADC_CR_ADEN; /* (1) */
  //while ((ADC_ISR & ADC_ISR_ADRDY) == 0 ) /* (2) */
 // {
    /* For robust implementation, add here time-out management */
 // }
}
//==============================================================================
struct flag flag_t;
//==============================================================================================================
volatile float BoardSensorValue = 0    absolute 0x20000000,
               ForwardSensorValue = 0  absolute 0x20000004,
               BackwardSensorValue = 0 absolute 0x20000008;
volatile float BoardSensorPPM = 0      absolute 0x2000000C,
               ForwardSensorPPM = 0    absolute 0x20000010,
               BackwardSensorPPM = 0   absolute 0x20000014;
volatile float BoardSensorR0 = 0       absolute 0x20000018,
               ForwardSensorR0 = 0     absolute 0x2000001C,
               BackwardSensorR0 = 0    absolute 0x20000020;
volatile float BoardSensorVrl = 0      absolute 0x20000024,
               ForwardSensorVrl = 0    absolute 0x20000028,
               BackwardSensorVrl = 0   absolute 0x2000002C;
volatile float VrefIntVoltage = 0      absolute 0x20000030;
volatile float temperature = 0         absolute 0x20000034; 
volatile unsigned char AnalogSensorDamageControl = 0 absolute 0x2000003C;
//==============================================================================================================
void ReadAnalogInput()
{
 static unsigned char rai_count = 0, read_count = 0;
 static unsigned long tmpBoardSensorValue = 0,tmpForwardSensorValue = 0,tmpBackwardSensorValue = 0;
  if((rai_count++)>=2)
  {
    rai_count=0;
    switch(read_count++)
     {
        case 0:  tmpBoardSensorValue = BoardSensorValue;
                 BoardSensorValue    = (float)Read_ADC_chanell(BOARD_SENSOR,ADC_AVG);    
                 if(flag_t.process_start_status)
                  {
                   if(BoardSensorValue > BoardSensorR0)
                    {
                       if(((BoardSensorValue - BoardSensorR0) >= 1)&&((BoardSensorValue - BoardSensorR0) <= 4))
                        {
                           BoardSensorValue = BoardSensorR0;
                        }
                    }
                  }
                 BoardSensorVrl = ((float)BoardSensorValue *  (float)(VrefIntVoltage/ADC_RANGE*1000));     
                                                                                     break;
        case 1:  BoardSensorPPM  = calculatePPM((float)BoardSensorValue,(float)parameters_t.board_sensor_v0_cal_data,(float)parameters_t.board_sensor_cal_data);
                                                                                     break;
        case 2:  tmpForwardSensorValue = ForwardSensorValue;
                 ForwardSensorValue  = (float)Read_ADC_chanell(FORWARD_SENSOR,ADC_AVG);
                 if(flag_t.process_start_status)
                  {
                   if(ForwardSensorValue > ForwardSensorR0)
                    {
                     if(((ForwardSensorValue - ForwardSensorR0) >= 1)&&((ForwardSensorValue - ForwardSensorR0) <= 4))
                      {
                        ForwardSensorValue = ForwardSensorR0;
                      }
                     }
                  }
                 ForwardSensorVrl  =  ((float)ForwardSensorValue *  (float)(VrefIntVoltage/ADC_RANGE*1000));   
                                                                                     break;
        case 3:  ForwardSensorPPM    = calculatePPM((float)ForwardSensorValue, (float)parameters_t.forward_sensor_v0_cal_data,(float)parameters_t.forward_sensor_cal_data);
                                                                                     break;
        case 4:  tmpBackwardSensorValue = BackwardSensorValue;
                 BackwardSensorValue = Read_ADC_chanell(BACKWARD_SENSOR,ADC_AVG);
                 if(flag_t.process_start_status)
                  {
                   if(BackwardSensorValue > BackwardSensorR0)
                    {
                     if(((BackwardSensorValue - BackwardSensorR0) >= 1)&&((BackwardSensorValue - BackwardSensorR0) <= 4))
                      {
                        BackwardSensorValue = BackwardSensorR0;
                      }
                    }
                  }
                 BackwardSensorVrl =  ((float)BackwardSensorValue *  (float)(VrefIntVoltage/ADC_RANGE*1000));
                                                                                     break;
        case 5:  BackwardSensorPPM   = calculatePPM((float)BackwardSensorValue, (float)parameters_t.backward_sensor_v0_cal_data,(float)parameters_t.backward_sensor_cal_data);
                                                                                     break;
        case 6:  ReadVrefIntValue();                                                 break;
        case 7:  ComputeTemperature();       read_count = 0;                         break;
     }

  }
}
//==============================================================================

void ControlSensorDamage()
{
  static unsigned int  board_sensor_damage_count    = 0,board_sensor_damage_count1    = 0;
  static unsigned int  forward_sensor_damage_count  = 0,forward_sensor_damage_count1  = 0;
  static unsigned int  backward_sensor_damage_count = 0,backward_sensor_damage_count1 = 0;
//------------------------------------------------------------------------------
    two_level_comparator_ms(ALARM_DAMAGE_LEVEL_HI,ALARM_DAMAGE_LEVEL_LO,BoardSensorVrl,
                            ANALOG_GISTERESIS_F, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
                            MS_IN_CYCLE,&flag_t.board_sensor_damage,&board_sensor_damage_count,
                            &board_sensor_damage_count1);

    two_level_comparator_ms(ALARM_DAMAGE_LEVEL_HI,ALARM_DAMAGE_LEVEL_LO,ForwardSensorVrl,
                            ANALOG_GISTERESIS_F, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
                            MS_IN_CYCLE,&flag_t.forward_sensor_damage,&forward_sensor_damage_count,
                            &forward_sensor_damage_count1);

    two_level_comparator_ms(ALARM_DAMAGE_LEVEL_HI,ALARM_DAMAGE_LEVEL_LO,BackwardSensorVrl,
                            ANALOG_GISTERESIS_F, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
                            MS_IN_CYCLE,&flag_t.backward_sensor_damage,&backward_sensor_damage_count,
                            &backward_sensor_damage_count1);
//------------------------------------------------------------------------------
     if(getDamageSensorStatus())
      {
        setState(sensor_damage);
      }
//------------------------------------------------------------------------------
        if(flag_t.board_sensor_damage)
         {
           bit_clr(AnalogSensorDamageControl,0);
         }
         else
           {
             bit_set(AnalogSensorDamageControl,0);
           }
//------------------------------------------------------------------------------
        if(flag_t.forward_sensor_damage)
         {
            bit_clr(AnalogSensorDamageControl,1);
         }
         else
           {
             bit_set(AnalogSensorDamageControl,1);
           }
//------------------------------------------------------------------------------
        if(flag_t.backward_sensor_damage)
         {
           bit_clr(AnalogSensorDamageControl,2);
         }
         else
           {
             bit_set(AnalogSensorDamageControl,2);
           }
//------------------------------------------------------------------------------
}
//==============================================================================
unsigned char getDamageSensorStatus()
{
   return (unsigned char)((!flag_t.board_sensor_damage)||(!flag_t.forward_sensor_damage)||(!flag_t.backward_sensor_damage));
}
//==============================================================================
#define VREF_INT_CAL_ADDR ((uint16_t*) ((uint32_t) 0x1FFFF7BA))
//------------------------------------------------------------------------------
void ReadVrefIntValue()
{
 float VrefIntValue = 0;
   ADC_CCR |= ADC_CCR_VREFEN;
   VrefIntValue = Read_ADC_chanell(VREF_INT_CHANELL,32);
   VrefIntVoltage = (3.3*(*VREF_INT_CAL_ADDR))/(float)VrefIntValue*0.25;
}
//==============================================================================
/* Temperature sensor calibration value address */
#define TEMP110_CAL_ADDR ((uint16_t*) ((uint32_t) 0x1FFFF7C2))
#define TEMP30_CAL_ADDR ((uint16_t*) ((uint32_t) 0x1FFFF7B8))
#define VDD_CALIB ((uint16_t) (330))
#define VDD_APPLI ((uint16_t) (300))

void ComputeTemperature()
{
 float measure = 0;
  ADC_CCR |= ADC_CCR_TSEN;
  measure = Read_ADC_chanell(TEMP_SENS_CHANELL,64);
  temperature = ((measure * VDD_APPLI / VDD_CALIB) - (int32_t) *TEMP30_CAL_ADDR ) ;
  temperature = temperature * (int32_t)(110 - 30);
  temperature = temperature / (int32_t)(*TEMP110_CAL_ADDR - *TEMP30_CAL_ADDR);
  temperature = temperature + 30;
}
//==============================================================================
void ReadTempAndVoltage()
{
  static unsigned char count_t_v = 0;
   switch(count_t_v++)
    {
       case   1:    ReadVrefIntValue();   break;
       case   6:    ComputeTemperature();
       case   11:          count_t_v = 0; break;
    }
}
//==============================================================================
void ControlV0(unsigned int* v0_data,unsigned int* tmp,unsigned int offset,unsigned char* flag)
{
   if(*flag)
    {
     if((*v0_data)>(*tmp))
      {
         if(((*v0_data)-(*tmp))>offset)
          {
            *v0_data = *tmp;
          }
      }
     if((*v0_data)<(*tmp))
      {
         if(((*tmp)-(*v0_data))>offset)
          {
            *v0_data = *tmp;
          }
      }
    }
}
//==============================================================================
void ControlVs(unsigned int* v0_data,unsigned int* tmp,unsigned int* vs_data,unsigned char* flag)
{
  if(*flag)
   {
     if((*v0_data)>(*tmp))
       {
          *vs_data = (*vs_data) + ((*v0_data) - (*tmp));
       }
     if((*v0_data)<(*tmp))
       {
          *vs_data = (*vs_data) - ((*tmp) - (*v0_data));
       }
   }
}
//==============================================================================
/*unsigned char ControlCalibrate(double* board_ppm,double* forward_ppm,double* backward_ppm,double alarm_gist)
{
   if((*board_ppm<(ALARM_LEVEL - alarm_gist))&&(*backward_ppm<(ALARM_LEVEL - alarm_gist))&&
         (*forward_ppm<(ALARM_LEVEL - alarm_gist)))
    {
       return 1;
    }
     else
      {
         return 0;
      }
}*/
//==============================================================================
unsigned char ControlData()
{
  return ((parameters_t.forward_sensor_ready==READY_DATA)&&
         (parameters_t.backward_sensor_ready==READY_DATA)&&
         (parameters_t.board_sensor_ready==READY_DATA));
}
//==============================================================================
void Calibrate()
{
 static unsigned int cal_count,control_rf_count = 0;
 unsigned int board_sens_temp = 0,forward_sens_temp = 0,backward_sens_temp = 0;
  setAdcControlStatus(RESET);
  if(ControlData()&&flag_t.first_start)
   {
     ControlRecalFlags();
   }
  if(getRcalAdcStatus()&&ControlData()&&flag_t.first_start)
   {
     flag_t.alarm_sensor_status = SET;
   }
  if(flag_t.alarm_sensor_status&&ControlData()&&flag_t.first_start)
   {
     if((control_rf_count++)>=RF_DELAY)
      {
         LED_GREEN^=1;
         LED_RED^=1;
         control_rf_count = 0;
      }
   }
    else
     {
        LED_GREEN = ON;
        LED_RED   = ON;
     }

  if((cal_count++)>V0_CAL_TIME)
   {
      cal_count = 0;
      BoardSensorR0    = BoardSensorValue;
      ForwardSensorR0  = ForwardSensorValue;
      BackwardSensorR0 = BackwardSensorValue;
      
      board_sens_temp    = parameters_t.board_sensor_v0_cal_data;
      forward_sens_temp  = parameters_t.forward_sensor_v0_cal_data;
      backward_sens_temp = parameters_t.backward_sensor_v0_cal_data;
      
      if(!flag_t.alarm_sensor_status)
       {
          parameters_t.forward_sensor_v0_cal_data  = (unsigned int)ForwardSensorValue;
          parameters_t.board_sensor_v0_cal_data    = (unsigned int)BoardSensorValue;
          parameters_t.backward_sensor_v0_cal_data = (unsigned int)BackwardSensorValue;
       }
      parameters_t.board_sensor_koef    = 1;
      parameters_t.forward_sensor_koef  = 100;//(unsigned int)(((double)BoardSensorValue/(double)ForwardSensorValue)*100.0);
      parameters_t.backward_sensor_koef = 100;//(unsigned int)(((double)BoardSensorValue/(double)BackwardSensorValue)*100.0);
//==============================================================================
      if(!flag_t.alarm_sensor_status)
       {
          ControlVs(&parameters_t.board_sensor_v0_cal_data,&board_sens_temp,
                    &parameters_t.board_sensor_cal_data,&flag_t.calibrate_status);
//------------------------------------------------------------------------------
          ControlVs(&parameters_t.forward_sensor_v0_cal_data,&forward_sens_temp,
                    &parameters_t.forward_sensor_cal_data,&flag_t.calibrate_status);
//------------------------------------------------------------------------------
          ControlVs(&parameters_t.backward_sensor_v0_cal_data,&backward_sens_temp,
                    &parameters_t.backward_sensor_cal_data,&flag_t.calibrate_status);
//------------------------------------------------------------------------------
       }

     flag_t.alarm_sensor_status = RESET;
     flag_t.first_start = RESET;
//------------------------------------------------------------------------------
     resetLB();
     if(flag_t.calibrate_status)
       {
         if(flag_t.recalibrate)
          {
             flag_t.recalibrate = RESET;
             setState(process);
          }
           else
            {
               setState(ready_alarm);
            }
       }
        else
         {
            setState(calibration);
         }
    }
}
//==============================================================================
void ControlCalibrate(long delay_sec)
{
  static long wait_count =0;
  static unsigned char start_delay_status = 0;
//------------------------------------------------------------------------------
   if(getAdcStatus())
    {
      start_delay_status = SET;
      wait_count = 0;
    }
    if(start_delay_status)
     {
       if((wait_count++)>= (delay_sec*100))
        {
         if(getRcalAdcStatus())
          {
            wait_count = 0;
          }
           else
            {
               wait_count = 0;
               start_delay_status = 0;
               flag_t.calibrate_status = SET;
               flag_t.recalibrate = SET;
               resetLB();
               Recalibrate();
            }
        }
     }
}
//==============================================================================
unsigned char getRcalAdcStatus()
{
   return  (flag_t.board_cal_status||flag_t.forward_cal_status||flag_t.backward_cal_status);
}
//==============================================================================
void ControlRecalFlags()
{
  static unsigned int board_cal_count    = 0,board_cal_count1    = 0;
  static unsigned int forward_cal_count  = 0,forward_cal_count1  = 0;
  static unsigned int backward_cal_count = 0,backward_cal_count1 = 0;
  
    if(ControlData())
     {
       one_level_comparator_ms(ALARM_LEVEL/4.0,BoardSensorPPM,ANALOG_GISTERESIS,
                      ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.board_cal_status,
                         &board_cal_count,&board_cal_count1);

       one_level_comparator_ms(ALARM_LEVEL/4.0,ForwardSensorPPM,ANALOG_GISTERESIS,
                      ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.forward_cal_status,
                         &forward_cal_count,&forward_cal_count1);

       one_level_comparator_ms(ALARM_LEVEL/4.0,BackwardSensorPPM,ANALOG_GISTERESIS,
                      ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.backward_cal_status,
                         &backward_cal_count,&backward_cal_count1);
     }
}
//==============================================================================
void RestartCalibration(unsigned long delay_rcal)
{
  static unsigned long wait_rcal_count = 0;
  static unsigned char rcal_status = 0;
  if(!getRcalAdcStatus())
   {
      if(!rcal_status)
       {
           if((wait_rcal_count++)>= (delay_rcal*100))
            {
              wait_rcal_count = 0;
              rcal_status = SET;
              flag_t.calibrate_status = SET;
              flag_t.recalibrate = SET;
              resetLB();
              Recalibrate();
            }
        }
    }
     else
      {
        wait_rcal_count = 0;
        rcal_status = SET; 
      }
}
//==============================================================================
#define MAX_MAX             20
float VsenseMax[MAX_MAX];
float VsenseArray[MAX_AVG];
//==============================================================================
void CalculateVsense(float* sense_adc_value,unsigned int time,float* out_value)
{
  static unsigned int   vs_count = 0,sec_vs_count = 0;
  unsigned char i = 0;
  static unsigned char calc_max =0;
  static float ret_avg_value = 0, min = 0,max = 0,calc_max_value = 0;
  if((sec_vs_count++)>=time)
   {
      sec_vs_count = 0;
      if(vs_count<MAX_AVG)
       {
         VsenseArray[vs_count] = 0;
         VsenseArray[vs_count++] = *sense_adc_value;
       }
        else
         {
              vs_count = 0;
              max = VsenseArray[0];
              for (i = 0; i < MAX_AVG; i++)
              {
                  if (VsenseArray[i] > max) {
                      max = VsenseArray[i];
                  }
              }
              min = VsenseArray[0];
              for (i = 0; i < MAX_AVG; i++)
              {
                  if (VsenseArray[i] < min) {
                      min = VsenseArray[i];
                  }
              }
             if(calc_max < MAX_MAX)
              {
                VsenseMax[calc_max] = 0;
                VsenseMax[calc_max++] = max - min;
              }
               else
                {
                   calc_max = 0;
                   calc_max_value = VsenseMax[0];
                    for (i = 0; i < MAX_MAX; i++)
                    {
                        if (VsenseMax[i] > calc_max_value) {
                            calc_max_value = VsenseMax[i];
                        }

                    }
                   *out_value = calc_max_value;
                }
         }
   }

}
//==============================================================================
unsigned int Read_ADC_sample(unsigned char chanell)
{
  /* (1) Select HSI14 by writing 00 in CKMODE (reset value) */
  /* (2) Select CHSEL0, CHSEL9, CHSEL10 andCHSEL17 for VRefInt */
  /* (3) Select a sampling mode of 111 i.e. 239.5 ADC clock cycles to be greater
         than 17.1us */
  /* (4) Wake-up the VREFINT (only for VBAT, Temp sensor and VRefInt) */
  //ADC1->CFGR2 &= ~ADC_CFGR2_CKMODE; /* (1) */
  switch(chanell)
   {
      case 0:           ADC_CHSELR = ADC_CHSELR_CHSEL0;                    break;
      case 1:           ADC_CHSELR = ADC_CHSELR_CHSEL1;                    break;
      case 2:           ADC_CHSELR = ADC_CHSELR_CHSEL2;                    break;
      case 3:           ADC_CHSELR = ADC_CHSELR_CHSEL3;                    break;
      case 4:           ADC_CHSELR = ADC_CHSELR_CHSEL4;                    break;
      case 16:          ADC_CHSELR = ADC_CHSELR_CHSEL16;                   break;
      case 17:          ADC_CHSELR = ADC_CHSELR_CHSEL17;                   break;
   }
   /* (2) */
   ADC_SMPR = ADC_SMPR_SMP_0 |ADC_SMPR_SMP_1 | ADC_SMPR_SMP_2; /* (3) */
      /*000: 1.5 ADC clock cycles
      001: 7.5 ADC clock cycles
      010: 13.5 ADC clock cycles
      011: 28.5 ADC clock cycles
      100: 41.5 ADC clock cycles
      101: 55.5 ADC clock cycles
      110: 71.5 ADC clock cycles
      111: 239.5 ADC clock cycles*/
  //ADC->CCR |= ADC_CCR_VREFEN; /* (4) */

    /* Performs the AD conversion */
    ADC_CR |= ADC_CR_ADSTART; /* Start the ADC conversion */
    while ((ADC_ISR & ADC_ISR_EOC) == 0 ) /* Wait end of conversion */
      {
        /* For robust implementation, add here time-out management */
      }
 return (unsigned int)ADC_DR; /* Store the ADC conversion result */

}
//==============================================================================
unsigned long Read_ADC_chanell(unsigned char chanell,unsigned int samples)
{
  unsigned long  temp = 0;
  unsigned int i = 0;
        for(i=0;i<samples;i++)
        {
           temp+= (unsigned long)(Read_ADC_sample(chanell)>>2);
           //Delay_us(5);
        }
  return (unsigned long)(temp/samples);
}
//==============================================================================
volatile unsigned char analogStatusAllChanell = 0;
void ControlAnalogFlags()
{
  static unsigned int  board_sensor_count    = 0,board_sensor_count1    = 0;
  static unsigned int  forward_sensor_count  = 0,forward_sensor_count1  = 0;
  static unsigned int  backward_sensor_count = 0,backward_sensor_count1 = 0;
//------------------------------------------------------------------------------
 if(getAdcControlStatus())
   {
    one_level_comparator_ms(ALARM_LEVEL,BoardSensorPPM,ANALOG_GISTERESIS,
                      ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.board_sensor_status,
                         &board_sensor_count,&board_sensor_count1);

    one_level_comparator_ms(ALARM_LEVEL,ForwardSensorPPM,ANALOG_GISTERESIS,
                      ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.forward_sensor_status,
                         &forward_sensor_count,&forward_sensor_count1);

    one_level_comparator_ms(ALARM_LEVEL,BackwardSensorPPM,ANALOG_GISTERESIS,
                      ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.backward_sensor_status,
                         &backward_sensor_count,&backward_sensor_count1);
//------------------------------------------------------------------------------
     if(getAdcStatus())
      {
        setState(sensor_alarm);
      }
//------------------------------------------------------------------------------
        if(flag_t.board_sensor_status)
         {
           bit_set(analogStatusAllChanell,0);
         }
         else
               {
                 bit_clr(analogStatusAllChanell,0);
               }
//------------------------------------------------------------------------------
        if(flag_t.forward_sensor_status)
         {
                 bit_set(analogStatusAllChanell,1);
         }
         else
         {
                 bit_clr(analogStatusAllChanell,1);
         }
//------------------------------------------------------------------------------
        if(flag_t.backward_sensor_status)
         {
           bit_set(analogStatusAllChanell,2);
         }
         else
         {
           bit_clr(analogStatusAllChanell,2);
         }
//------------------------------------------------------------------------------
   }
    else
     {
        flag_t.board_sensor_status    = RESET;
        flag_t.forward_sensor_status  = RESET;
        flag_t.backward_sensor_status = RESET;
     }
}
//==============================================================================
unsigned char getAdcStatus()
{
  return (unsigned char)(flag_t.board_sensor_status||flag_t.forward_sensor_status||flag_t.backward_sensor_status);
}
//==============================================================================
void setAdcControlStatus(unsigned char status)
{
   if(status)
    {
       flag_t.start_sensor_control = SET;
    }
     else
      {
         flag_t.start_sensor_control = RESET;
      }
}
//==============================================================================
unsigned char getAdcControlStatus()
{
  return  (unsigned char)flag_t.start_sensor_control;
}
//==============================================================================
void CalibrateADC(void)
{
  /* (1) Ensure that ADEN = 0 */
  /* (2) Clear ADEN */
  /* (3) Launch the calibration by setting ADCAL */
  /* (4) Wait until ADCAL=0 */
  if ((ADC_CR & ADC_CR_ADEN) != 0) /* (1) */
  {
    ADC_CR &= (uint32_t)(~ADC_CR_ADEN);  /* (2) */
  }
  ADC_CR |= ADC_CR_ADCAL; /* (3) */
  while ((ADC_CR & ADC_CR_ADCAL) != 0) /* (4) */
  {
    /* For robust implementation, add here time-out management */
  }
}
//==============================================================================
/* Define used below to easily configure the ADC clock */
#define ADC_PRESCALER_DIV2               ADC_CFGR2_CKMODE_0
#define ADC_PRESCALER_DIV4               ADC_CFGR2_CKMODE_1
#define ADC_CLOCK                        HSI14
/* Preprocessor variable to select the ADC clock
   If HSI14 is not selected as ADC clock, HSI14 must be commented
   HSI14 select the ADC dedicated asynchronous 14MHz RC oscillator
   RCC_CFGR_PPRE_DIVx prescale the AHB clock by x to get the peripheral clock (PCLK)
   It is user responsibility to ensure the ADC clock is 14MHz max
   The ADC interface will divide the PCLK by 2 or by 4 depending on ADC_PRESCALER */
#define HSI14 0
#define ADC_CLOCK HSI14
//#define ADC_CLOCK RCC_CFGR_PPRE_DIV2
//#define ADC_CLOCK RCC_CFGR_PPRE_DIV4
//#define ADC_CLOCK RCC_CFGR_PPRE_DIV8
//#define ADC_CLOCK RCC_CFGR_PPRE_DIV16

#ifdef  HSI14
#define ADC_PRESCALER 0
#else
#define ADC_PRESCALER ADC_PRESCALER_DIV2
#endif

//==============================================================================
void SetClockForADC(void)
{
  /* (1) Enable the peripheral clock of the ADC */
  /* (2) Start HSI14 RC oscillator */
  /* (3) Wait HSI14 is ready */
  RCC_APB2ENR |= RCC_APB2ENR_ADC1EN; /* (1) */
#ifdef HSI14
  RCC_CR2 |= RCC_CR2_HSI14ON; /* (2) */
  while ((RCC_CR2 & RCC_CR2_HSI14RDY) == 0) /* (3) */
  {
    /* For robust implementation, add here time-out management */
  }
#else /* Use synchronous clock */
  RCC_CR = (RCC_CR & (~RCC_CFGR_PPRE)) | ADC_CLOCK;
#endif
}

//==============================================================================
void EnableADC(void)
{
  /* (1) Enable the ADC */
  /* (2) Wait until ADC ready */
  do
  {
    /* For robust implementation, add here time-out management */
          ADC_CR |= ADC_CR_ADEN; /* (1) */
  }while ((ADC_ISR & ADC_ISR_ADRDY) == 0) /* (2) */;
}
//==============================================================================