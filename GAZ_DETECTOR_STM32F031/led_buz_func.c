#include "hider.h"


void Blink_buz_func(unsigned int blink_mode,char count_loop1,
char out,char count_digit,char new_state,char enable_new_state,unsigned char after_count)
{
        static unsigned int s_blink_mode;
        static unsigned char  after_count_s = 0;
        static unsigned char blink_loop = 0,count_loop = 0;
        static char end_buzzer = 0;
        s_blink_mode = blink_mode;
        //------------------------------------------------------------------------------
        if(((count_loop++)>=count_loop1)&&end_buzzer==RESET)
        {
                count_loop = 0;

                if(s_blink_mode & 1<<(blink_loop&0x07))
                {
                        BUZER = ON;
                }
                else
                {
                        BUZER = OFF;
                }

                if((blink_loop++)>=count_digit)
                {
                        blink_loop = 0;
                        end_buzzer=SET;

                }
        }

        //------------------------------------------------------------------------------
        if((end_buzzer==SET)&&((after_count_s++)>=after_count))
        {
                BUZER = OFF;
                end_buzzer=RESET;
                after_count_s = 0;
                count_loop = 0;
                if(enable_new_state)
                {
                        setState(new_state);
                }
        }
}
//==============================================================================
void Blink_leds_func(unsigned int blink_mode_led,unsigned char count_loop1,
unsigned char out,unsigned char count_digit_led,unsigned char new_state,unsigned char enable_new_state,
unsigned char after_count,unsigned char enable_buzzer)
{
    static unsigned char led_red_status = 0, end_led = 0;
    static unsigned char count_loop_led = 0,blink_loop_led = 0;
    static unsigned int s_blink_mode_led;
    static unsigned char  after_count_s_led = 0;
    static unsigned char count_start_red_led = 0;
    static unsigned int buzzer_period_count = 0;
    static char buzzer_state = 0;

    s_blink_mode_led = blink_mode_led;

        if(led_red_status==RESET)
        {
                LED_GREEN = ON;//LED_RED = ON;

                if((count_start_red_led++)>=10)
                {
                        count_start_red_led = 0;
                        led_red_status = SET;
                        LED_GREEN = ON;//LED_RED = OFF;
                }

        }
        if(((count_loop_led++)>=count_loop1)&&end_led==RESET)
        {
                count_loop_led = 0;

                if(s_blink_mode_led & 1<<(blink_loop_led&0x07))
                {
                        LED_RED = ON;//LED_GREEN = ON;
                        if(enable_buzzer == SET)
                         {
                           BUZER = ON;
                         }
                }
                else
                {
                        LED_RED = OFF;//LED_GREEN = OFF;
                        BUZER = OFF;
                }

                if((blink_loop_led++)>=count_digit_led)
                {
                        blink_loop_led = 0;
                        end_led=SET;

                }
        }
        //------------------------------------------------------------------------------
        if((end_led==SET)&&((after_count_s_led++)>=after_count))
        {
                LED_RED = OFF;//LED_GREEN = OFF;
                end_led=RESET;
                after_count_s_led = 0;
                count_loop_led = 0;
                led_red_status=RESET;
                blink_loop_led = 0;
                if(enable_new_state)
                {
                   resetLB();
                   setState(new_state);
                }
        }

}
//==============================================================================
void heaterMode(unsigned char mode)
{
  static unsigned long phase_normal_count = 0;

        if(!mode)
        {
             switch(phase_normal_count++)
             {
                     case 1:                          BOARD_HEATER     = ON;    break;

                     case HEATER_CYCLE*10:            BOARD_HEATER     = OFF;
                                                      BACKWARD_HEATER  = ON;    break;

                     case HEATER_CYCLE*20:            BACKWARD_HEATER  = OFF;
                                                      FORWARD_HEATER   = ON;    break;

                     case HEATER_CYCLE*30:           FORWARD_HEATER   = OFF;
                                                     BOARD_HEATER     = OFF;
                                                       phase_normal_count = 0;  break;
           }
        }
//------------------------------------------------------------------------------
        if(mode)
        {
           phase_normal_count = 0;
           setAllHeater();
        }
 }
//==============================================================================