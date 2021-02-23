#include "hider.h"
//==========================ANALOG SENSOR INPUT=================================
//#define BOARD_SENSOR                    1
//#define FORWARD_SENSOR                  3
//#define BACKWARD_SENSOR                 4
//==========================HEATER SENSOR OUT===================================
sbit  BOARD_HEATER     at               GPIOB_ODR.B4;
sbit  FORWARD_HEATER   at               GPIOB_ODR.B5;
sbit  BACKWARD_HEATER  at               GPIOB_ODR.B6;
//==========================BUTTON INPUT========================================
sbit  CAL_BUTTON       at               GPIOA_IDR.B8;
//==========================BUZER OUT===========================================
sbit  BUZER            at               GPIOB_ODR.B1;
//==========================LED OUT=============================================
sbit  LED_GREEN        at               GPIOB_ODR.B3;
sbit  LED_RED          at               GPIOB_ODR.B0;
//==========================LED UART TRANSMISSION===============================
sbit  LED_UART_TR      at               GPIOA_ODR.B11;
void Init_pin()
{
//==========================HEATER SENSOR OUT===================================
  GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_4|_GPIO_PINMASK_5|_GPIO_PINMASK_6,_GPIO_CFG_DIGITAL_OUTPUT);
//==========================BUTTON INPUT========================================
  GPIO_Config(&GPIOA_BASE,_GPIO_PINMASK_8,_GPIO_CFG_MODE_INPUT | _GPIO_CFG_PULL_UP);
  //GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_8,_GPIO_CFG_DIGITAL_INPUT);
//==========================BUZER OUT===========================================
  GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_1,_GPIO_CFG_DIGITAL_OUTPUT);
//==========================LED OUT=============================================
  GPIO_Config(&GPIOB_BASE,_GPIO_PINMASK_0|_GPIO_PINMASK_3,_GPIO_CFG_DIGITAL_OUTPUT);
//==========================LED UART TRANSMISSION===============================
  GPIO_Config(&GPIOA_BASE,_GPIO_PINMASK_11,_GPIO_CFG_DIGITAL_OUTPUT);
}
//==============================================================================
void Init_flags()
{
  flag_t.ovf_flag                                       = 0;
  flag_t.board_sensor_status                            = 0;
  flag_t.forward_sensor_status                          = 0;
  flag_t.backward_sensor_status                         = 0;
  flag_t.cal_button_status                              = 1;
  flag_t.start_sensor_control                           = 0;
  flag_t.heater_status                                  = 0;
  flag_t.ready_calibration_prog                         = 0;
  flag_t.alarm_enable_status                            = 0;
  flag_t.board_sensor_damage                            = 1;
  flag_t.forward_sensor_damage                          = 1;
  flag_t.backward_sensor_damage                         = 1;
  flag_t.calibrate_status                               = 0;
  flag_t.ovf_flag                                       = 0;
  flag_t.board_cal_status                               = 0;
  flag_t.forward_cal_status                             = 0;
  flag_t.backward_cal_status                            = 0;
  flag_t.enable_status                                  = 0;
  flag_t.request_uart_status                            = 0;
  flag_t.start_process_status                           = 0;
  flag_t.response_status                                = 0;
  flag_t.process_start_status                           = 0;
  flag_t.first_start                                    = 1;
  flag_t.alarm_sensor_status                            = 0;
}
//==============================================================================
void Init_flash_cal()
{
  parameters_t.forward_sensor_ready  = (unsigned int)READY_DATA;
  parameters_t.backward_sensor_ready = (unsigned int)READY_DATA;
  parameters_t.board_sensor_ready    = (unsigned int)READY_DATA;
  parameters_t.crc_adc = parameters_t.forward_sensor_cal_data
                         +parameters_t.backward_sensor_cal_data
                         +parameters_t.board_sensor_cal_data
                         +parameters_t.forward_sensor_v0_cal_data
                         +parameters_t.backward_sensor_v0_cal_data
                         +parameters_t.board_sensor_v0_cal_data;
}
//==============================================================================
void InitVar()
{
   parameters_t.forward_sensor_v0_cal_data            = 0;
   parameters_t.backward_sensor_v0_cal_data           = 0;
   parameters_t.board_sensor_v0_cal_data              = 0;
   parameters_t.forward_sensor_cal_data               = 0;
   parameters_t.backward_sensor_cal_data              = 0;
   parameters_t.board_sensor_cal_data                 = 0;
   //parameters_t.board_sensor_koef                     = 0;
   //parameters_t.forward_sensor_koef                   = 0;
   //parameters_t.backward_sensor_koef                  = 0;
}
//==============================================================================