#include "hider.h"

//==============================================================================
void one_level_comparator_sec(float reference,float value, float gisteresis,
     unsigned int delay_on_sec,unsigned int delay_off_sec,unsigned int ms_in_one_cycle,unsigned char* status,
     unsigned int* count_olc,unsigned int* count_olc1)
{
    if(value>=(reference+gisteresis))
        {
                if(++(*count_olc)>=(unsigned int)(delay_on_sec*(1000/ms_in_one_cycle)))
                {
                        *count_olc = 0;
                        *count_olc1=0;

                        if(value>=(reference+gisteresis))
                        {
                                *status = 1;
                        }
                }
        }

//------------------------------------------------------------------------------

    if(value<=(reference-gisteresis))
        {
                if(++(*count_olc1)>=(unsigned int)(delay_off_sec*(1000/ms_in_one_cycle)))
                {
                        *count_olc = 0;
                        *count_olc1=0;

                        if(value<=(reference-gisteresis))
                        {
                                *status = 0;
                        }
                }
        }
}
//==============================================================================
void one_level_comparator_ms(float reference,float value, float gisteresis,
     unsigned int delay_on_ms,unsigned int delay_off_ms,unsigned int ms_in_one_cycle,unsigned char* status,
     unsigned int* count_olc,unsigned int* count_olc1)
{
    if(value>=(reference+gisteresis))
        {
                if(++(*count_olc)>=(unsigned int)(delay_on_ms/ms_in_one_cycle))
                {
                        *count_olc  = 0;
                        *count_olc1 = 0;

                        if(value>=(reference+gisteresis))
                        {
                                *status = 1;
                        }
                }
        }

//------------------------------------------------------------------------------

    if(value<=(reference-gisteresis))
        {
                if(++(*count_olc1)>=(unsigned int)(delay_off_ms/ms_in_one_cycle))
                {
                        *count_olc  = 0;
                        *count_olc1 = 0;

                        if(value<=(reference-gisteresis))
                        {
                                *status = 0;
                        }
                }
        }
}
//==============================================================================
void two_level_comparator(float high_reference,float low_reference,float value,
     float gisteresis, unsigned int delay_on_sec_tlc,unsigned int delay_off_sec_tlc,
     unsigned int ms_in_one_cycle_tlc,unsigned char* status_tlc,unsigned int* count_tlc,
     unsigned int* count_tlc1)
{
   if( (value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
     {

       if(++(*count_tlc)>=(unsigned int)(delay_off_sec_tlc*(1000/ms_in_one_cycle_tlc)))
           {
             *count_tlc  = 0;
             *count_tlc1 = 0;
              if((value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
                {
                   *status_tlc = 0;
                }

          }

    }
//------------------------------------------------------------------------------
   if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
     {

        if(++(*count_tlc1)>=(unsigned int)(delay_on_sec_tlc*(1000/ms_in_one_cycle_tlc)))
           {
             *count_tlc = 0;
             *count_tlc1=0;
              if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
                {
                   *status_tlc = 1;
                }

          }
    }
}
//==============================================================================
void two_level_comparator_ms(float high_reference,float low_reference,float value,
     float gisteresis, unsigned int delay_on_ms_tlc,unsigned int delay_off_ms_tlc,
     unsigned int ms_in_one_cycle_tlc,unsigned char* status_tlc,unsigned int* count_tlc,
     unsigned int* count_tlc1)
{
   if((value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
     {

       if(++(*count_tlc)>=(delay_on_ms_tlc/ms_in_one_cycle_tlc))
           {
             *count_tlc  = 0;
             *count_tlc1 = 0;
              if((value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
                {
                   *status_tlc = 0;
                }

          }

    }
//------------------------------------------------------------------------------
   if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
     {

        if(++(*count_tlc1)>=(delay_off_ms_tlc/ms_in_one_cycle_tlc))
           {
             *count_tlc = 0;
             *count_tlc1=0;
              if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
                {
                   *status_tlc = 1;
                }

          }
    }
}


//==============================================================================
void ControlDigit_sec(unsigned char in_value, unsigned int delay_set,
        unsigned int delay_reset, unsigned int ms_in_one_cycle, unsigned char *status,
        unsigned int *count_ci, unsigned int* count_ci1)
{
        if (in_value == SET)
        {

                if ((++(*count_ci)) >= (unsigned int)(delay_set*(1000 / ms_in_one_cycle)))
                {
                        *count_ci = 0;
                        *count_ci1 = 0;
                        if (in_value == SET)
                        {
                                *status = 1;
                        }
                }

        }
        //------------------------------------------------------------------------------
        if (in_value == RESET)
        {

                if ((++(*count_ci1)) >= (unsigned int)(delay_reset*(1000 / ms_in_one_cycle)))
                {
                        *count_ci = 0;
                        *count_ci1 = 0;
                        if (in_value == RESET)
                        {
                                *status = 0;
                        }
                }

        }
}
//==============================================================================
//min delay 10 ms
void ControlDigit_ms(unsigned char in_value, unsigned int delay_set,
     unsigned int delay_reset, unsigned int ms_in_one_cycle, unsigned char *status,
     unsigned int *count_ci, unsigned int* count_ci1)
{
        if (in_value == SET)
        {

                if ((++(*count_ci)) >= (unsigned int)(delay_set / ms_in_one_cycle))
                {
                        *count_ci = 0;
                        *count_ci1 = 0;
                        if (in_value == SET)
                        {
                                *status = 1;
                        }
                }

        }
        //------------------------------------------------------------------------------
        if (in_value == RESET)
        {

                if ((++(*count_ci1)) >= (unsigned int)(delay_reset / ms_in_one_cycle))
                {
                        *count_ci = 0;
                        *count_ci1 = 0;
                        if (in_value == RESET)
                        {
                                *status = 0;
                        }
                }

        }
}
//==============================================================================