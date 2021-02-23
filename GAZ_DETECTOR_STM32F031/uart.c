#include "hider.h"

char input_buffer[INPUT_BUFFER_SIZE ]= {0};
unsigned char out_buffer[OUT_BUFFER_SIZE];
char request_string[] = {"request"};
//==============================================================================
void InitUartModuleBTU()
{
  UART1_Init_Advanced(BAUD_RATE, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
  USART1_CR1 = USART_CR1_RXNEIE | USART_CR1_RE | USART_CR1_UE|USART_CR1_TE;
  NVIC_IntEnable(IVT_INT_USART1);
}
//==============================================================================
volatile static unsigned char in = 0;
void UART_INT() iv IVT_INT_USART1 ics ICS_AUTO 
{
  unsigned char in_data;
  if((USART1_ISR & USART_ISR_RXNE) == USART_ISR_RXNE)
   {
     in_data = USART1_RDR;
     if(in<INPUT_BUFFER_SIZE)
      {
        input_buffer[in++] = in_data;
      }
       else
        {
          in = 0;
          Clear_buffer(input_buffer,INPUT_BUFFER_SIZE );
          flag_t.request_uart_status = SET;
        }
   }
}
//==============================================================================
void ControlInputData()
{
 static unsigned char gn = 0;
 if(flag_t.start_process_status)
  {
 if(strstr(input_buffer,request_string))
    {
      flag_t.response_status = SET;
      Clear_buffer(input_buffer,INPUT_BUFFER_SIZE );
      in = 0;
    }
   if(strstr(input_buffer,"CONNECT"))
    {
      Clear_buffer(input_buffer,INPUT_BUFFER_SIZE );
      in = 0;
    }
  }
}
//==============================================================================
float NegativeLimiter(float value)
{
   if(value<=0)
    {
      return 0;
    }
    else
     {
       return value;
     }
}
//==============================================================================
void WriteDataToAndroid()
{
  static unsigned char out_count = 0;
  unsigned int tmp = 0;
  if(flag_t.response_status)
   {
     LED_UART_TR = ON;
     for(out_count=0;out_count<OUT_BUFFER_SIZE;out_count++)
      {
        out_buffer[out_count] = 0;
      }
     out_buffer[0] = 0;
     out_buffer[1] = 0;
     tmp = (unsigned int)(NegativeLimiter(BoardSensorPPM));
     out_buffer[2] = (unsigned char)(tmp>>8);
     out_buffer[3] = (unsigned char)(tmp);
     
     tmp = (unsigned int)(NegativeLimiter(ForwardSensorPPM));
     out_buffer[4] = (unsigned char)(tmp>>8);
     out_buffer[5] = (unsigned char)(tmp);
     
     tmp = (unsigned int)(NegativeLimiter(BackwardSensorPPM));
     out_buffer[6] = (unsigned char)(tmp>>8);
     out_buffer[7] = (unsigned char)(tmp);
     
     out_buffer[8] = (unsigned char)(((unsigned int)BoardSensorR0)>>8);
     out_buffer[9] = (unsigned char)((unsigned int)BoardSensorR0);
     
     out_buffer[10] = (unsigned char)(((unsigned int)ForwardSensorR0)>>8);
     out_buffer[11] = (unsigned char)((unsigned int)ForwardSensorR0);
     
     out_buffer[12] = (unsigned char)(((unsigned int)BackwardSensorR0)>>8);
     out_buffer[13] = (unsigned char)((unsigned int)BackwardSensorR0);
     
     out_buffer[14] = (unsigned char)flag_t.board_sensor_status;
     out_buffer[15] = (unsigned char)flag_t.forward_sensor_status;
     out_buffer[16] = (unsigned char)flag_t.backward_sensor_status;
     
     out_buffer[17] = (unsigned char)(!flag_t.board_sensor_damage);
     out_buffer[18] = (unsigned char)(!flag_t.forward_sensor_damage);
     out_buffer[19] = (unsigned char)(!flag_t.backward_sensor_damage);
     
     out_buffer[20] = (unsigned char)13;
     out_buffer[21] = (unsigned char)10;

     for(out_count=0;out_count<OUT_BUFFER_SIZE;out_count++)
      {
        UART1_Write(out_buffer[out_count]);
      }
     flag_t.response_status = RESET;
     LED_UART_TR = OFF;
   }
}
//==============================================================================
void Clear_buffer(char* buf,unsigned int len)
{
  unsigned char count_buf;
   for(count_buf = 0;count_buf<len;count_buf++)
    {
      buf[count_buf] = 0;
    }
}
//==============================================================================