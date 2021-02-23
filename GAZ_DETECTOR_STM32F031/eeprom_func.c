#include "hider.h"

unsigned long ADDRESS   = 0x08007400;//0x08007000;//sector 7 page 31   0x08080000;
unsigned long ADDRESS2  = 0x08007800;
unsigned long _data[30];

//==============================================================================
char save_data_to_eeprom_one(unsigned long adr,unsigned unsigned char sample,unsigned char* status)
{
  unsigned int tmp_data = 0;
  DisableInterrupts();
  tmp_data = (unsigned int)read_from_eeprom_one(adr);
  //tmp_data&=0x0000FFFF;
  if((tmp_data>=sample)&&(tmp_data!=0xFFFF))
    {
       EnableInterrupts();
       *status = SET;
       return 0;
    }
      if(tmp_data==0xFFFF)
       {
         FLASH_Unlock();
         FLASH_ErasePage(adr);
         FLASH_Write_HalfWord(adr,0);
         FLASH_Write_HalfWord(adr+2, 0);
         *status = RESET;
       }
        else
         {
           FLASH_Unlock();
           FLASH_ErasePage(adr);
           ++tmp_data;
           FLASH_Write_HalfWord(adr,tmp_data);
           *status = RESET;
         }
}
//==============================================================================
void ChekTrue()
{
 save_data_to_eeprom_one(ADDRESS2,DEMO_START_COUNT,&flag_t.enable_status);
   if(!flag_t.enable_status)
    {
      setState(control_calibration);
    }
     else
      {
        setState(error_calibration);
      }
}
//==============================================================================
unsigned int read_from_eeprom_one(unsigned long adr)
{
  unsigned int tmp_data = 0;
  unsigned long* ptr;
  ptr = (unsigned long*)adr;
  DisableInterrupts();
  tmp_data = (unsigned int)(*ptr);
  EnableInterrupts();
  return  (unsigned int)tmp_data;
}
//==============================================================================
char save_data_to_eeprom(unsigned char len_array)
{
  unsigned char position=0;
  unsigned int* array_struct;
//------------------------------------------------------------------------------
  array_struct = (unsigned long*)&parameters_t;
  DisableInterrupts();
  FLASH_Unlock();
  FLASH_ErasePage(ADDRESS);
  Init_flash_cal();
  for(position=0;position<len_array;position++)
   {
      FLASH_Write_HalfWord(ADDRESS+(position*4-2), 0);
      FLASH_Write_HalfWord(ADDRESS+position*4, (*array_struct));
      array_struct++;
   }
  FLASH_Write_HalfWord(ADDRESS+(position*4-2), 0);
  FLASH_Lock();
  EnableInterrupts();
  return 1;
}
//==============================================================================

char read_data_from_eeprom(unsigned char len_array)
{
  unsigned char position = 0;
  unsigned int temp = 0,crc=0;
  unsigned long* ptr;
  unsigned int* array_struct;
//------------------------------------------------------------------------------
  array_struct = (unsigned long*)&parameters_t;
  ptr = (unsigned long*)ADDRESS;
  DisableInterrupts();
  for(position=0; position<len_array; position++)
    {
      (*array_struct) = (unsigned int)(*ptr);
      ptr++;
      array_struct++;
    }
    temp =  parameters_t.forward_sensor_cal_data
           +parameters_t.backward_sensor_cal_data
           +parameters_t.board_sensor_cal_data
           +parameters_t.forward_sensor_v0_cal_data
           +parameters_t.backward_sensor_v0_cal_data
           +parameters_t.board_sensor_v0_cal_data;
           //+parameters_t.board_sensor_koef
           //+parameters_t.forward_sensor_koef
           //+parameters_t.backward_sensor_koef;

  EnableInterrupts();
     if(ControlData())
        {
          if(temp==parameters_t.crc_adc)
           {
              return 0;
           }
        }
        else
         {
           return 1;
         }
     if(temp!=parameters_t.crc_adc)
       {
         return 1;
       }
}
//==============================================================================
char FLASH_ReadOutProtection(unsigned char new_state)
 {
   static char status = 0;
   //FLASH_Status status = FLASH_COMPLETE;
   /* Check the parameters */
   //assert_param(IS_FUNCTIONAL_STATE(NewState));
   DisableInterrupts();
   status = FLASH_WaitForLastOperation();
   if(status == SET)
   {
     /* Authorizes the small information block programming */
     FLASH_OPTKEYR = FLASH_FKEY1 ;
     FLASH_OPTKEYR = FLASH_FKEY2 ;
     //FLASH_Unlock();
     FLASH_CR |= FLASH_CR_OPTER;
     FLASH_CR |= FLASH_CR_STRT;
     /* Wait for last operation to be completed */
     status = FLASH_WaitForLastOperation();
     if(status == SET)
     {
       /* if the erase operation is completed, disable the OPTER Bit */
       FLASH_CR &= FLASH_CR_OPTER;
       /* Enable the Option Bytes Programming operation */
       FLASH_CR |= FLASH_CR_OPTPG;
       if(new_state == SET)
       {
          LEVEL1_PROT_bit = SET;
          LEVEL2_PROT_bit = RESET;
       }
       else
       {
          LEVEL1_PROT_bit = RESET;
          LEVEL2_PROT_bit = RESET;
       }
       /* Wait for last operation to be completed */
       status = FLASH_WaitForLastOperation();

       //if(status != FLASH_TIMEOUT)
      // {
         /* if the program operation is completed, disable the OPTPG Bit */
         FLASH_CR &= ~(FLASH_CR_OPTPG);
       //}
     }
     else
     {
       //if(status != FLASH_TIMEOUT)
       //{
         /* Disable the OPTER Bit */
         FLASH_CR &= ~(FLASH_CR_OPTER);
         FLASH_Lock();
         EnableInterrupts();

         return -1;
      // }
     }
   }
   /* Return the protection operation Status */
   FLASH_Lock();
   EnableInterrupts();
   return status;
 }
//==============================================================================

//==============================================================================
/**
* @brief Wait for a FLASH operation to complete.
* @param Timeout maximum flash operation timeout
* @retval HAL Status
*/
char FLASH_WaitForLastOperation()
{
  /* Wait for the FLASH operation to complete by polling on BUSY flag to be reset.
  Even if the FLASH operation fails, the BUSY flag will be reset and an error
  flag will be set */

   while ((FLASH_SR & FLASH_SR_BSY) != 0) /* (3) */
    {
      /* For robust implementation, add here time-out management */
    }

  /* Check FLASH End of Operation flag */
  if((FLASH_SR & FLASH_SR_EOP) == RESET)
  {
     FLASH_SR |= FLASH_SR_EOP;
  }
  if((FLASH_SR & FLASH_SR_WRPERR) || (FLASH_SR & FLASH_SR_PGERR))
  {
     return -1;

  }
  return 1;
}
//==============================================================================
char FLASH_GetReadOutProtectionStatus()
 {
   if ((LEVEL1_PROT_bit == RESET)&&(LEVEL2_PROT_bit == RESET))
   {
     return RESET;
   }
   else
   {
     return SET;
   }
 }
//==============================================================================
void ControlReadOutProtection()
{
    if (FLASH_GetReadOutProtectionStatus() == RESET)
    {
      FLASH_Unlock();
      FLASH_ReadOutProtection(SET);
      FLASH_Lock();
    }
}
//==============================================================================
#define MAX_DATA       16
int inData[MAX_DATA]= {0};

int checkMaxValue(int* ar_data, int len)
{
  int max = 0;
  unsigned char i = 0;
  for(i = 0;i < len;i++)
   {
     if(ar_data[i] > max)
      {
        max = ar_data[i];
      }
   }
  return max;
}