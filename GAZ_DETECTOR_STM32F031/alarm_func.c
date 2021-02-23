#include "hider.h"

//==============================================================================
unsigned char data_ar[32];
//board sensor       1
//forward sensor     2
//backward sensor    3
volatile unsigned long bs_var        = 0b10000000000000000000000000000000;
volatile unsigned long fs_var        = 0b10100000000000000000000000000000;
volatile unsigned long bcs_var       = 0b10101000000000000000000000000000;
volatile unsigned long bs_fs_var     = 0b10000101000000000000000000000000;
volatile unsigned long fs_bcs_var    = 0b10100001010100000000000000000000;
volatile unsigned long bs_bcs_var    = 0b10000101010000000000000000000000;
volatile unsigned long bs_fs_bcs_var = 0b10000101000010101000000000000000;
//------------------------------------------------------------------------------
void SensorAlarm()
{
    setAdcControlStatus(SET);
    setHeaterStatus(ON);
    if(getAdcStatus())
     {
       LED_GREEN = ON;
       switch(analogStatusAllChanell)
         {
           case 0b00000001:           bs_alarm_signal();              break;
           case 0b00000010:           fs_alarm_signal();              break;
           case 0b00000100:           bcs_alarm_signal();             break;
           case 0b00000011:           bs_fs_alarm_signal();           break;
           case 0b00000111:           bs_fs_bcs_alarm_signal();       break;
           case 0b00000110:           fs_bcs_alarm_signal();          break;
           case 0b00000101:           bs_bcs_alarm_signal();          break;
           case 0b00000000:           resetLB();
                                      setState(process);              break;
         }

      }
       else
        {
          resetLB();
          setState(process);
        }
}
//==============================================================================
void SensorDamage()
{
     if(getDamageSensorStatus())
     {
       switch(AnalogSensorDamageControl)
         {
           case 0b00000001:           bs_damage_signal();              break;
           case 0b00000010:           fs_damage_signal();              break;
           case 0b00000100:           bcs_damage_signal();             break;
           case 0b00000011:           bs_fs_damage_signal();           break;
           case 0b00000111:           bs_fs_bcs_damage_signal();       break;
           case 0b00000110:           fs_bcs_damage_signal();          break;
           case 0b00000101:           bs_bcs_damage_signal();          break;
           case 0b00000000:           resetLB();
                                      setState(control_calibration);               break;
         }

      }
       else
        {
          resetLB();
          setState(control_calibration);
        }
}
//==============================================================================
void bs_alarm_signal()
{
        WriteVarToArray(data_ar, bs_var,32);
        Sequence(data_ar,14,TRUE);
}
//==============================================================================
void fs_alarm_signal()
{
        WriteVarToArray(data_ar, fs_var,32);
        Sequence(data_ar,16,TRUE);
}
//==============================================================================
void bcs_alarm_signal()
{
        WriteVarToArray(data_ar, bcs_var,32);
        Sequence(data_ar,18,TRUE);
}
//==============================================================================
void bs_fs_alarm_signal()
{
        WriteVarToArray(data_ar, bs_fs_var,32);
        Sequence(data_ar,21,TRUE);
}
//==============================================================================
void bs_bcs_alarm_signal()
{
        WriteVarToArray(data_ar, bs_bcs_var,32);
        Sequence(data_ar,23,TRUE);
}
//==============================================================================
void fs_bcs_alarm_signal()
{
        WriteVarToArray(data_ar, fs_bcs_var,32);
        Sequence(data_ar,25,TRUE);
}

//==============================================================================
void bs_fs_bcs_alarm_signal()
{
        WriteVarToArray(data_ar, bs_fs_bcs_var,32);
        Sequence(data_ar,30,TRUE);
}
//==============================================================================
////////////////////////////////////////////////////////////////////////////////
void bs_damage_signal()
{
        WriteVarToArray(data_ar, bs_var,32);
        Sequence(data_ar,14,FALSE);
}
//==============================================================================
void fs_damage_signal()
{
        WriteVarToArray(data_ar, fs_var,32);
        Sequence(data_ar,16,FALSE);
}
//==============================================================================
void bcs_damage_signal()
{
        WriteVarToArray(data_ar, bcs_var,32);
        Sequence(data_ar,18,FALSE);
}
//==============================================================================
void bs_fs_damage_signal()
{
        WriteVarToArray(data_ar, bs_fs_var,32);
        Sequence(data_ar,21,FALSE);
}
//==============================================================================
void bs_bcs_damage_signal()
{
        WriteVarToArray(data_ar, bs_bcs_var,32);
        Sequence(data_ar,23,FALSE);
}
//==============================================================================
void fs_bcs_damage_signal()
{
        WriteVarToArray(data_ar, fs_bcs_var,32);
        Sequence(data_ar,25,FALSE);
}

//==============================================================================
void bs_fs_bcs_damage_signal()
{
        WriteVarToArray(data_ar, bs_fs_bcs_var,32);
        Sequence(data_ar,30,FALSE);
}
//==============================================================================
void WriteVarToArray(unsigned char* data_ar_local, unsigned long var,unsigned char num_of_char)
{
 unsigned char i;
  for(i = 0;i < num_of_char;i++)
   {
      data_ar_local[i] = 0;
      data_ar_local[i] = ((var&0x80000000)>>31);
      var = var<<1;
   }
}
//==============================================================================
void Sequence(unsigned char* seq_data,unsigned char count_digit_led,unsigned char buz_en)
{
   static unsigned char blink_loop_led = 0, loop_count = 0;
        if((loop_count++)>9)
         {
                loop_count = 0;
                 if( seq_data[blink_loop_led]==SET)
                 {
                         LED_RED        = ON;
                         if(buz_en)
                          {
                            BUZER          = ON;
                          }
                           else
                            {
                              BUZER          = OFF;
                            }

                 }
                 else
                 {
                         LED_RED        = OFF;
                         BUZER          = OFF;
                 }

                 if((blink_loop_led++)>=count_digit_led)
                 {
                         blink_loop_led = 0;
                 }
         }
}
//==============================================================================
void resetLB()
{
   LED_RED        = OFF;
   LED_GREEN      = OFF;
   BUZER          = OFF;
}
//==============================================================================
void setLB()
{
   LED_RED        = ON;
   LED_GREEN      = ON;
   BUZER          = ON;
}
//==============================================================================
void resetAllHeater()
{
  BOARD_HEATER     = OFF;
  FORWARD_HEATER   = OFF;
  BACKWARD_HEATER  = OFF;
}
//==============================================================================
void setAllHeater()
{
  BOARD_HEATER     = ON;
  FORWARD_HEATER   = ON;
  BACKWARD_HEATER  = ON;
}
//==============================================================================