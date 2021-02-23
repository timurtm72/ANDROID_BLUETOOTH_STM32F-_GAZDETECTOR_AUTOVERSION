#include "hider.h"
#define MEMORY_PROTECTIOON
state_n state;
struct parameters  parameters_t;
//==============================================================================
void ControlDigitalFlags()
{
static unsigned int start_button_status_count1 = 0, start_button_status_count2 = 0,
                     start_count = 0;

 ControlDigit_ms(CAL_BUTTON, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,
            MS_IN_CYCLE, &flag_t.cal_button_status,
            &start_button_status_count1, &start_button_status_count2);
            

 if(flag_t.cal_button_status==RESET&&flag_t.ready_calibration_prog==RESET)
  {
     flag_t.calibrate_status = RESET;
     setState(getV0);
  }
}
//==============================================================================
void globalProcess()
{
 ControlInputData();
 WriteDataToAndroid();
 if(flag_t.ovf_flag==SET)
  {
   flag_t.ovf_flag = RESET;
   //---------------------------------------------------------------------------
   clear_WDT();
   ReadAnalogInput();
   ControlAnalogFlags();
   ControlDigitalFlags();
   ControlSensorDamage();
   //ReadTempAndVoltage();
   ControlCalibrate(3600);
   ControlRecalFlags();


  //---------------------------------------------------------------------------
       switch(state)
        {
           case control_calibration :    controlCalibration();                  break;
           case error_calibration   :    ErrorCalibration();                    break;
           case start_sound         :    StartSound(TRUE);                      break;
           case preheat             :    Preheat_f();                           break;
           case calibration         :    Calibration_f();                       break;
           case getV0               :    Calibrate();                           break;
           case ready_alarm         :    ReadyAlarm_f();                        break;
           case process             :    Process_f();                           break;
           case sensor_alarm        :    SensorAlarm();                         break;
           case sensor_damage       :    SensorDamage();                        break;
        }

  }
}
//==============================================================================
void Process_f()
{
  setAdcControlStatus(SET);
  //setHeaterStatus(ON);
  LED_GREEN = ON;
  LED_RED   = OFF;
  RestartCalibration(1200);
  flag_t.process_start_status = SET;
}
//==============================================================================
void setState(state_n newState)
{
  state =  newState;
}
//==============================================================================
state_n getState()
{
  return state;
}
//==============================================================================
void StartSound(unsigned char state)
{
  flag_t.start_process_status = SET;
  #ifdef MEMORY_PROTECTIOON
    ControlReadOutProtection();
  #endif
  if(state)
    {
      Blink_buz_func(0b00010101,9,1,5,preheat,TRUE,0);
    }
     else
      {
        resetLB();
        setState(preheat);
      }
}
//==============================================================================
void ErrorCalibration()
{
  static unsigned char count_error_cal = 0, state_error = 0;
  setAdcControlStatus(RESET);
  //setHeaterStatus(OFF);
  if((count_error_cal++)>=50)
   {
     count_error_cal = 0;
     state_error^=1;
   }
          if(state_error)
          {
                  LED_GREEN = OFF;
                  LED_RED   = ON;
          }
          else
          {
                  LED_GREEN = OFF;
                  LED_RED   = OFF;
          }
}
//==============================================================================
void controlCalibration()
{
  static unsigned char  start_control_cal = 0;
  static unsigned int start_control_count = 0;
  static unsigned int  start_buz = 0;
  setAdcControlStatus(RESET);
  //setHeaterStatus(OFF);
  ReadAnalogInput();
  LED_RED      =  ON;
  //LED_GREEN    =  ON;
  switch(start_buz++)
   {
      case 1:   BUZER = ON;          break;
      case 51:  BUZER = OFF;         break;
   }
   
  if((start_control_count++)>=500&&start_control_cal==RESET)
   {
     start_control_count = 0;
     start_buz = 0;
     start_control_cal = SET;
   }
  if(start_control_cal==SET)
   {
    if(read_data_from_eeprom(EEPROM_DATA_SIZE)==SET)
     {
        resetLB();
        start_control_cal = RESET;
        flag_t.calibrate_status = RESET;
        setState(error_calibration);
     }
     else
      {
         start_control_cal = RESET;
         resetLB();
         //BoardSensorR0    = (float)parameters_t.board_sensor_v0_cal_data;
         //ForwardSensorR0  = (float)parameters_t.forward_sensor_v0_cal_data;
         //BackwardSensorR0 = (float)parameters_t.backward_sensor_v0_cal_data;
         flag_t.calibrate_status = SET;
         setState(start_sound);
      }
    }
}
//==============================================================================
void Preheat_f()
{
static unsigned char preheat_count_loop = 0;
static unsigned long cycle_preheat_count = 0;

 setAdcControlStatus(RESET);
 //setHeaterStatus(ON);
 if((cycle_preheat_count++)<=FASE_PREHEAT)
  {

//------------------------------------------------------------------------------

    switch(preheat_count_loop++)
     {
       case   1:    LED_RED   = ON;
                    LED_GREEN = OFF;
                    break;
       case   11:   LED_RED   = OFF;
                    LED_GREEN = ON;
                    break;
       case   49:   LED_GREEN = ON;
                    preheat_count_loop = 0;
                    break;
     }
   }
//------------------------------------------------------------------------------

   else
    {
      preheat_count_loop = 0;
      cycle_preheat_count = 0;
      resetLB();
      setState(getV0);
    }
}
//==============================================================================
void Calibration_f()
{
 static unsigned char count_cal = 0, state_cal = 0,count_ready = 50;
 static unsigned long  count_ready_cal = 0;
  setAdcControlStatus(RESET);
  //setHeaterStatus(ON);
 if((count_cal++)>=count_ready)
   {
     count_cal = 0;
     state_cal^=1;
   }
     ReadAnalogInput();
     if((count_ready_cal++)>=300&&flag_t.ready_calibration_prog==RESET)
      {
         flag_t.ready_calibration_prog = SET;
         count_ready = 25;
      }
          if( state_cal)
          {
            LED_GREEN = ON;
            LED_RED   = ON;
          }
          else
          {
            LED_GREEN = OFF;
            LED_RED   = OFF;
          }
  if(flag_t.cal_button_status==RESET&&flag_t.ready_calibration_prog==SET)
   {
     parameters_t.board_sensor_cal_data    = (unsigned int)BoardSensorValue;
     parameters_t.forward_sensor_cal_data  = (unsigned int)ForwardSensorValue;
     parameters_t.backward_sensor_cal_data = (unsigned int)BackwardSensorValue;
     save_data_to_eeprom(EEPROM_DATA_SIZE);
     if(read_data_from_eeprom(EEPROM_DATA_SIZE)==SET)
      {
         resetLB();
         flag_t.ready_calibration_prog=RESET;
         count_ready_cal= 0;
         count_ready = 50;
         setState(calibration);
      }
       else
        {
          resetLB();
          flag_t.ready_calibration_prog=RESET;
          count_ready_cal = 0;
          count_ready = 50;
          SystemReset();
        }
   }
}
//==============================================================================
void Recalibrate()
{
   setState(getV0);
}
//==============================================================================
void setHeaterStatus(unsigned char state)
{
  if(state)
   {
      flag_t.heater_status = SET;
   }
   else
    {
       flag_t.heater_status = RESET;
    }

}
//==============================================================================
unsigned char getHeaterStatus()
{
   return flag_t.heater_status;
}
//==============================================================================
void ReadyAlarm_f()
{
  static unsigned int ra_count = 0;
  setAdcControlStatus(RESET);
  //setHeaterStatus(OFF);
  switch(ra_count++)
   {
     case     11:    BUZER = ON;      break;
     case    200:    BUZER = OFF;     break;
     case    260:    BUZER = ON;      break;
     case    340:    BUZER = OFF;
                     ra_count= 0;
                     resetLB();
                     setState(process);
                     break;
   }
}
//==============================================================================