#line 1 "D:/ALL_PROJECTS/GAZ_DETECTOR/UZCAR_STM32F0/UZCAR_STM32F031_MC101_BTU/adc_func.c"
#line 1 "d:/all_projects/gaz_detector/uzcar_stm32f0/uzcar_stm32f031_mc101_btu/hider.h"
#line 1 "d:/all_projects/gaz_detector/uzcar_stm32f0/uzcar_stm32f031_mc101_btu/stm32f030x6.h"
#line 1 "c:/program files (x86)/mikroelektronika/mikroc pro for arm/include/built_in.h"
#line 24 "d:/all_projects/gaz_detector/uzcar_stm32f0/uzcar_stm32f031_mc101_btu/hider.h"
extern sfr sbit BOARD_HEATER;
extern sfr sbit FORWARD_HEATER;
extern sfr sbit BACKWARD_HEATER;

extern sfr sbit CAL_BUTTON;

extern sfr sbit BUZER;

extern sfr sbit LED_GREEN;
extern sfr sbit LED_RED;
#line 78 "d:/all_projects/gaz_detector/uzcar_stm32f0/uzcar_stm32f031_mc101_btu/hider.h"
typedef enum state_t{control_calibration = 1,error_calibration,read_data_for_cal,
 calibration,start_sound,preheat,ready_alarm,getV0,process,sensor_alarm,sensor_damage}state_n;
extern state_n state;
extern sfr sbit LED_GREEN;
extern char input_buffer[ 25  ];
extern char request_string[];

extern sfr sbit BOARD_HEATER;
extern sfr sbit FORWARD_HEATER;
extern sfr sbit BACKWARD_HEATER;

extern sfr sbit CAL_BUTTON;

extern sfr sbit BUZER;

extern sfr sbit LED_GREEN;
extern sfr sbit LED_RED;

extern sfr sbit LED_UART_TR;

struct flag {

 unsigned char ovf_flag;
 unsigned char board_sensor_status;
 unsigned char forward_sensor_status;
 unsigned char backward_sensor_status;
 unsigned char cal_button_status;
 unsigned char start_sensor_control;
 unsigned char heater_status;
 unsigned char ready_calibration_prog;
 unsigned char alarm_enable_status;
 unsigned char board_sensor_damage;
 unsigned char forward_sensor_damage;
 unsigned char backward_sensor_damage;
 unsigned char calibrate_status;
 unsigned char recalibrate;
 unsigned char board_cal_status;
 unsigned char forward_cal_status;
 unsigned char backward_cal_status;
 unsigned char enable_status;
 unsigned char request_uart_status;
 unsigned char start_process_status;
 unsigned char response_status;
 unsigned char process_start_status;
 unsigned char first_start;
 unsigned char alarm_sensor_status;
 };
extern struct flag flag_t;



struct parameters {
 unsigned int forward_sensor_v0_cal_data;
 unsigned int backward_sensor_v0_cal_data;
 unsigned int board_sensor_v0_cal_data;
 unsigned int forward_sensor_cal_data;
 unsigned int backward_sensor_cal_data;
 unsigned int board_sensor_cal_data;
 unsigned int forward_sensor_ready;
 unsigned int backward_sensor_ready;
 unsigned int board_sensor_ready;
 unsigned int board_sensor_koef;
 unsigned int forward_sensor_koef;
 unsigned int backward_sensor_koef;
 unsigned int crc_adc;
};
extern struct parameters parameters_t;

extern volatile float BoardSensorValue, ForwardSensorValue, BackwardSensorValue;
extern volatile float BoardSensorPPM, ForwardSensorPPM,BackwardSensorPPM;
extern volatile float BoardSensorR0, ForwardSensorR0, BackwardSensorR0;
extern volatile float BoardSensorVrl,ForwardSensorVrl,BackwardSensorVrl;
extern volatile unsigned char analogStatusAllChanell;
extern volatile unsigned long bs_var;
extern volatile unsigned long fs_var;
extern volatile unsigned long bcs_var;
extern volatile unsigned long bs_fs_var;
extern volatile unsigned long fs_bcs_var;
extern volatile unsigned long bs_bcs_var;
extern volatile unsigned long bs_fs_bcs_var;
extern volatile unsigned char AnalogSensorDamageControl;
extern volatile float VrefIntVoltage;
extern volatile float temperature;
extern unsigned long ADDRESS;
extern unsigned long ADDRESS2;
extern float VsenseArray[ 100 ];

void Init_flags();
void Init_pin();
void Init_ADC_chanell();
void ReadAnalogInput();
unsigned long Read_ADC_chanell(unsigned char chanell,unsigned int samples);
void ControlAnalogFlags();
void one_level_comparator_sec(float reference,float value, float gisteresis,
 unsigned int delay_on_sec,unsigned int delay_off_sec,unsigned int ms_in_one_cycle,unsigned char* status,
 unsigned int* count_olc,unsigned int* count_olc1);
void two_level_comparator(float high_reference,float low_reference,float value,
 float gisteresis, unsigned int delay_on_sec_tlc,unsigned int delay_off_sec_tlc,
 unsigned int ms_in_one_cycle_tlc,unsigned char* status_tlc,unsigned int* count_tlc,
 unsigned int* count_tlc1);
void two_level_comparator_ms(float high_reference,float low_reference,float value,
 float gisteresis, unsigned int delay_on_ms_tlc,unsigned int delay_off_ms_tlc,
 unsigned int ms_in_one_cycle_tlc,unsigned char* status_tlc,unsigned int* count_tlc,
 unsigned int* count_tlc1);
void ControlDigitalFlags();
void ControlOut();
void ControlDigit_sec(unsigned char in_value, unsigned int delay_set,
 unsigned int delay_reset, unsigned int ms_in_one_cycle, unsigned char* status,
 unsigned int* count_ci, unsigned int* count_ci1);
void globalProcess();
void WDT_Init();
void clear_WDT();
void setPreloadValue(unsigned long value);
char save_data_to_eeprom(unsigned char len_array);
char read_data_from_eeprom(unsigned char len_array);
void StartTimer3_10ms();
void Init_flash_cal();
void setState(state_n newState);
state_n getState();
void ReadDataInEEPROM();
void controlCalibration();
void ErrorCalibration();
void Blink_buz_func(unsigned int blink_mode,char count_loop1,
 char out,char count_digit,char new_state,char enable_new_state,unsigned char after_count);
void Blink_leds_func(unsigned int blink_mode_led,unsigned char count_loop1,
 unsigned char out,unsigned char count_digit_led,unsigned char new_state,unsigned char enable_new_state,
 unsigned char after_count,unsigned char enable_buzzer);
void StartSound(unsigned char state);
void Preheat_f();
void Calibration_f();
void ReadyAlarm_f();
void Process_f();
void SensorAlarm();
void setAdcControlStatus(unsigned char status);
void setHeaterStatus(unsigned char state);
void heaterMode(unsigned char mode);
unsigned char getAdcStatus();
unsigned char getAdcControlStatus();
unsigned char getHeaterStatus();
void resetLB();
void setLB();
void resetAllHeater();
void setAllHeater();
void CalibrateADC();
void EnableADC(void);
void SetClockForADC(void);
void ControlDigit_ms(unsigned char in_value, unsigned int delay_set,
 unsigned int delay_reset, unsigned int ms_in_one_cycle, unsigned char* status,
 unsigned int* count_ci, unsigned int* count_ci1);
void one_level_comparator_ms(float reference,float value, float gisteresis,
 unsigned int delay_on_ms,unsigned int delay_off_ms,unsigned int ms_in_one_cycle,unsigned char* status,
 unsigned int* count_olc,unsigned int* count_olc1);
void Sequence(unsigned char* seq_data,unsigned char count_digit_led,unsigned char buz_en);
void WriteVarToArray(unsigned char* data_ar_local, unsigned long var,unsigned char num_of_char);
unsigned int Read_ADC_sample(unsigned char chanell);
void bs_alarm_signal();
void fs_alarm_signal();
void bcs_alarm_signal();
void bs_fs_alarm_signal();
void fs_bcs_alarm_signal();
void bs_bcs_alarm_signal();
void bs_fs_bcs_alarm_signal();
void bs_damage_signal();
void fs_damage_signal();
void bcs_damage_signal();
void bs_fs_damage_signal();
void fs_bcs_damage_signal();
void bs_bcs_damage_signal();
void bs_fs_bcs_damage_signal();
double calculatePPM(double adcValue,double R0,double cal_data);
float getR0(float Rl,float adcValue,float koef, float volt, float adcRange);
void Calibrate();
void GetAllPPM();
double map(double x, double in_min, double in_max, double out_min, double out_max);
void SensorDamage();
void ControlSensorDamage();
unsigned char getDamageSensorStatus();
void InitVar();
void Recalibrate();
void ReadVrefIntValue();
void ControlV0(unsigned int* v0_data,unsigned int* tmp,unsigned int offset,unsigned char* flag);
void ControlVs(unsigned int* v0_data,unsigned int* tmp,unsigned int* vs_data,unsigned char* flag);
void ComputeTemperature();
void ReadTempAndVoltage();
void ControlCalibrate(long delay_sec);
void CalculateVsense(float* sense_adc_value,unsigned int time,float* out_value);
unsigned int read_from_eeprom_one(unsigned long adr);
char save_data_to_eeprom_one(unsigned long adr,unsigned char sample,unsigned char* status);
void ChekTrue();
void RestartCalibration(unsigned long delay_rcal);
void ControlRecalFlags();
unsigned char getRcalAdcStatus();
float NegativeLimiter(float value);

char FLASH_ReadOutProtection(unsigned char new_state);
char FLASH_WaitForLastOperation();
void ControlReadOutProtection();

void InitUartModuleBTU();
void Clear_buffer(char* buf,unsigned int len);
void ControlInputData();
void WriteDataToAndroid();
unsigned char ControlData();
#line 4 "D:/ALL_PROJECTS/GAZ_DETECTOR/UZCAR_STM32F0/UZCAR_STM32F031_MC101_BTU/adc_func.c"
void Init_ADC_chanell()
{
 ADC1_Init();
 ADC_Set_Input_Channel(_ADC_CHANNEL_1|_ADC_CHANNEL_3|_ADC_CHANNEL_4);


 ADC_CR |=  (( unsigned long )0x00000001) ;




}

struct flag flag_t;

volatile float BoardSensorValue = 0 absolute 0x20000000,
 ForwardSensorValue = 0 absolute 0x20000004,
 BackwardSensorValue = 0 absolute 0x20000008;
volatile float BoardSensorPPM = 0 absolute 0x2000000C,
 ForwardSensorPPM = 0 absolute 0x20000010,
 BackwardSensorPPM = 0 absolute 0x20000014;
volatile float BoardSensorR0 = 0 absolute 0x20000018,
 ForwardSensorR0 = 0 absolute 0x2000001C,
 BackwardSensorR0 = 0 absolute 0x20000020;
volatile float BoardSensorVrl = 0 absolute 0x20000024,
 ForwardSensorVrl = 0 absolute 0x20000028,
 BackwardSensorVrl = 0 absolute 0x2000002C;
volatile float VrefIntVoltage = 0 absolute 0x20000030;
volatile float temperature = 0 absolute 0x20000034;
volatile unsigned char AnalogSensorDamageControl = 0 absolute 0x2000003C;

void ReadAnalogInput()
{
 static unsigned char rai_count = 0, read_count = 0;
 static unsigned long tmpBoardSensorValue = 0,tmpForwardSensorValue = 0,tmpBackwardSensorValue = 0;
 if((rai_count++)>=2)
 {
 rai_count=0;
 switch(read_count++)
 {
 case 0: tmpBoardSensorValue = BoardSensorValue;
 BoardSensorValue = (float)Read_ADC_chanell( 1 , 512 );
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
 BoardSensorVrl = ((float)BoardSensorValue * (float)(VrefIntVoltage/ 1023 *1000));
 break;
 case 1: BoardSensorPPM = calculatePPM((float)BoardSensorValue,(float)parameters_t.board_sensor_v0_cal_data,(float)parameters_t.board_sensor_cal_data);
 break;
 case 2: tmpForwardSensorValue = ForwardSensorValue;
 ForwardSensorValue = (float)Read_ADC_chanell( 3 , 512 );
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
 ForwardSensorVrl = ((float)ForwardSensorValue * (float)(VrefIntVoltage/ 1023 *1000));
 break;
 case 3: ForwardSensorPPM = calculatePPM((float)ForwardSensorValue, (float)parameters_t.forward_sensor_v0_cal_data,(float)parameters_t.forward_sensor_cal_data);
 break;
 case 4: tmpBackwardSensorValue = BackwardSensorValue;
 BackwardSensorValue = Read_ADC_chanell( 4 , 512 );
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
 BackwardSensorVrl = ((float)BackwardSensorValue * (float)(VrefIntVoltage/ 1023 *1000));
 break;
 case 5: BackwardSensorPPM = calculatePPM((float)BackwardSensorValue, (float)parameters_t.backward_sensor_v0_cal_data,(float)parameters_t.backward_sensor_cal_data);
 break;
 case 6: ReadVrefIntValue(); break;
 case 7: ComputeTemperature(); read_count = 0; break;
 }

 }
}


void ControlSensorDamage()
{
 static unsigned int board_sensor_damage_count = 0,board_sensor_damage_count1 = 0;
 static unsigned int forward_sensor_damage_count = 0,forward_sensor_damage_count1 = 0;
 static unsigned int backward_sensor_damage_count = 0,backward_sensor_damage_count1 = 0;

 two_level_comparator_ms( 2300.0 , 1000.0 ,BoardSensorVrl,
  100.0 ,  1000 , 1000 ,
  10 ,&flag_t.board_sensor_damage,&board_sensor_damage_count,
 &board_sensor_damage_count1);

 two_level_comparator_ms( 2300.0 , 1000.0 ,ForwardSensorVrl,
  100.0 ,  1000 , 1000 ,
  10 ,&flag_t.forward_sensor_damage,&forward_sensor_damage_count,
 &forward_sensor_damage_count1);

 two_level_comparator_ms( 2300.0 , 1000.0 ,BackwardSensorVrl,
  100.0 ,  1000 , 1000 ,
  10 ,&flag_t.backward_sensor_damage,&backward_sensor_damage_count,
 &backward_sensor_damage_count1);

 if(getDamageSensorStatus())
 {
 setState(sensor_damage);
 }

 if(flag_t.board_sensor_damage)
 {
  AnalogSensorDamageControl &= (~(1 << 0)) ;
 }
 else
 {
  AnalogSensorDamageControl |= (1 << 0) ;
 }

 if(flag_t.forward_sensor_damage)
 {
  AnalogSensorDamageControl &= (~(1 << 1)) ;
 }
 else
 {
  AnalogSensorDamageControl |= (1 << 1) ;
 }

 if(flag_t.backward_sensor_damage)
 {
  AnalogSensorDamageControl &= (~(1 << 2)) ;
 }
 else
 {
  AnalogSensorDamageControl |= (1 << 2) ;
 }

}

unsigned char getDamageSensorStatus()
{
 return (unsigned char)((!flag_t.board_sensor_damage)||(!flag_t.forward_sensor_damage)||(!flag_t.backward_sensor_damage));
}



void ReadVrefIntValue()
{
 float VrefIntValue = 0;
 ADC_CCR |=  (( unsigned long )0x00400000) ;
 VrefIntValue = Read_ADC_chanell( 17 ,32);
 VrefIntVoltage = (3.3*(* (( unsigned int *) (( unsigned long ) 0x1FFFF7BA)) ))/(float)VrefIntValue*0.25;
}







void ComputeTemperature()
{
 float measure = 0;
 ADC_CCR |=  (( unsigned long )0x00800000) ;
 measure = Read_ADC_chanell( 16 ,64);
 temperature = ((measure *  (( unsigned int ) (300))  /  (( unsigned int ) (330)) ) - ( long ) * (( unsigned int *) (( unsigned long ) 0x1FFFF7B8))  ) ;
 temperature = temperature * ( long )(110 - 30);
 temperature = temperature / ( long )(* (( unsigned int *) (( unsigned long ) 0x1FFFF7C2))  - * (( unsigned int *) (( unsigned long ) 0x1FFFF7B8)) );
 temperature = temperature + 30;
}

void ReadTempAndVoltage()
{
 static unsigned char count_t_v = 0;
 switch(count_t_v++)
 {
 case 1: ReadVrefIntValue(); break;
 case 6: ComputeTemperature();
 case 11: count_t_v = 0; break;
 }
}

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
#line 247 "D:/ALL_PROJECTS/GAZ_DETECTOR/UZCAR_STM32F0/UZCAR_STM32F031_MC101_BTU/adc_func.c"
unsigned char ControlData()
{
 return ((parameters_t.forward_sensor_ready== 0xAAAA )&&
 (parameters_t.backward_sensor_ready== 0xAAAA )&&
 (parameters_t.board_sensor_ready== 0xAAAA ));
}

void Calibrate()
{
 static unsigned int cal_count,control_rf_count = 0;
 unsigned int board_sens_temp = 0,forward_sens_temp = 0,backward_sens_temp = 0;
 setAdcControlStatus( 0 );
 if(ControlData()&&flag_t.first_start)
 {
 ControlRecalFlags();
 }
 if(getRcalAdcStatus()&&ControlData()&&flag_t.first_start)
 {
 flag_t.alarm_sensor_status =  1 ;
 }
 if(flag_t.alarm_sensor_status&&ControlData()&&flag_t.first_start)
 {
 if((control_rf_count++)>= 25 )
 {
 LED_GREEN^=1;
 LED_RED^=1;
 control_rf_count = 0;
 }
 }
 else
 {
 LED_GREEN =  1 ;
 LED_RED =  1 ;
 }

 if((cal_count++)> 10* 100 )
 {
 cal_count = 0;
 BoardSensorR0 = BoardSensorValue;
 ForwardSensorR0 = ForwardSensorValue;
 BackwardSensorR0 = BackwardSensorValue;

 board_sens_temp = parameters_t.board_sensor_v0_cal_data;
 forward_sens_temp = parameters_t.forward_sensor_v0_cal_data;
 backward_sens_temp = parameters_t.backward_sensor_v0_cal_data;

 if(!flag_t.alarm_sensor_status)
 {
 parameters_t.forward_sensor_v0_cal_data = (unsigned int)ForwardSensorValue;
 parameters_t.board_sensor_v0_cal_data = (unsigned int)BoardSensorValue;
 parameters_t.backward_sensor_v0_cal_data = (unsigned int)BackwardSensorValue;
 }
 parameters_t.board_sensor_koef = 1;
 parameters_t.forward_sensor_koef = 100;
 parameters_t.backward_sensor_koef = 100;

 if(!flag_t.alarm_sensor_status)
 {
 ControlVs(&parameters_t.board_sensor_v0_cal_data,&board_sens_temp,
 &parameters_t.board_sensor_cal_data,&flag_t.calibrate_status);

 ControlVs(&parameters_t.forward_sensor_v0_cal_data,&forward_sens_temp,
 &parameters_t.forward_sensor_cal_data,&flag_t.calibrate_status);

 ControlVs(&parameters_t.backward_sensor_v0_cal_data,&backward_sens_temp,
 &parameters_t.backward_sensor_cal_data,&flag_t.calibrate_status);

 }

 flag_t.alarm_sensor_status =  0 ;
 flag_t.first_start =  0 ;

 resetLB();
 if(flag_t.calibrate_status)
 {
 if(flag_t.recalibrate)
 {
 flag_t.recalibrate =  0 ;
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

void ControlCalibrate(long delay_sec)
{
 static long wait_count =0;
 static unsigned char start_delay_status = 0;

 if(getAdcStatus())
 {
 start_delay_status =  1 ;
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
 flag_t.calibrate_status =  1 ;
 flag_t.recalibrate =  1 ;
 resetLB();
 Recalibrate();
 }
 }
 }
}

unsigned char getRcalAdcStatus()
{
 return (flag_t.board_cal_status||flag_t.forward_cal_status||flag_t.backward_cal_status);
}

void ControlRecalFlags()
{
 static unsigned int board_cal_count = 0,board_cal_count1 = 0;
 static unsigned int forward_cal_count = 0,forward_cal_count1 = 0;
 static unsigned int backward_cal_count = 0,backward_cal_count1 = 0;

 if(ControlData())
 {
 one_level_comparator_ms( 8000 /4.0,BoardSensorPPM, 200 ,
  1000 , 1000 , 10 ,&flag_t.board_cal_status,
 &board_cal_count,&board_cal_count1);

 one_level_comparator_ms( 8000 /4.0,ForwardSensorPPM, 200 ,
  1000 , 1000 , 10 ,&flag_t.forward_cal_status,
 &forward_cal_count,&forward_cal_count1);

 one_level_comparator_ms( 8000 /4.0,BackwardSensorPPM, 200 ,
  1000 , 1000 , 10 ,&flag_t.backward_cal_status,
 &backward_cal_count,&backward_cal_count1);
 }
}

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
 rcal_status =  1 ;
 flag_t.calibrate_status =  1 ;
 flag_t.recalibrate =  1 ;
 resetLB();
 Recalibrate();
 }
 }
 }
 else
 {
 wait_rcal_count = 0;
 rcal_status =  1 ;
 }
}


float VsenseMax[ 20 ];
float VsenseArray[ 100 ];

void CalculateVsense(float* sense_adc_value,unsigned int time,float* out_value)
{
 static unsigned int vs_count = 0,sec_vs_count = 0;
 unsigned char i = 0;
 static unsigned char calc_max =0;
 static float ret_avg_value = 0, min = 0,max = 0,calc_max_value = 0;
 if((sec_vs_count++)>=time)
 {
 sec_vs_count = 0;
 if(vs_count< 100 )
 {
 VsenseArray[vs_count] = 0;
 VsenseArray[vs_count++] = *sense_adc_value;
 }
 else
 {
 vs_count = 0;
 max = VsenseArray[0];
 for (i = 0; i <  100 ; i++)
 {
 if (VsenseArray[i] > max) {
 max = VsenseArray[i];
 }
 }
 min = VsenseArray[0];
 for (i = 0; i <  100 ; i++)
 {
 if (VsenseArray[i] < min) {
 min = VsenseArray[i];
 }
 }
 if(calc_max <  20 )
 {
 VsenseMax[calc_max] = 0;
 VsenseMax[calc_max++] = max - min;
 }
 else
 {
 calc_max = 0;
 calc_max_value = VsenseMax[0];
 for (i = 0; i <  20 ; i++)
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

unsigned int Read_ADC_sample(unsigned char chanell)
{
#line 489 "D:/ALL_PROJECTS/GAZ_DETECTOR/UZCAR_STM32F0/UZCAR_STM32F031_MC101_BTU/adc_func.c"
 switch(chanell)
 {
 case 0: ADC_CHSELR =  (( unsigned long )0x00000001) ; break;
 case 1: ADC_CHSELR =  (( unsigned long )0x00000002) ; break;
 case 2: ADC_CHSELR =  (( unsigned long )0x00000004) ; break;
 case 3: ADC_CHSELR =  (( unsigned long )0x00000008) ; break;
 case 4: ADC_CHSELR =  (( unsigned long )0x00000010) ; break;
 case 16: ADC_CHSELR =  (( unsigned long )0x00010000) ; break;
 case 17: ADC_CHSELR =  (( unsigned long )0x00020000) ; break;
 }

 ADC_SMPR =  (( unsigned long )0x00000001)  | (( unsigned long )0x00000002)  |  (( unsigned long )0x00000004) ;
#line 512 "D:/ALL_PROJECTS/GAZ_DETECTOR/UZCAR_STM32F0/UZCAR_STM32F031_MC101_BTU/adc_func.c"
 ADC_CR |=  (( unsigned long )0x00000004) ;
 while ((ADC_ISR &  (( unsigned long )0x00000004) ) == 0 )
 {

 }
 return (unsigned int)ADC_DR;

}

unsigned long Read_ADC_chanell(unsigned char chanell,unsigned int samples)
{
 unsigned long temp = 0;
 unsigned int i = 0;
 for(i=0;i<samples;i++)
 {
 temp+= (unsigned long)(Read_ADC_sample(chanell)>>2);

 }
 return (unsigned long)(temp/samples);
}

volatile unsigned char analogStatusAllChanell = 0;
void ControlAnalogFlags()
{
 static unsigned int board_sensor_count = 0,board_sensor_count1 = 0;
 static unsigned int forward_sensor_count = 0,forward_sensor_count1 = 0;
 static unsigned int backward_sensor_count = 0,backward_sensor_count1 = 0;

 if(getAdcControlStatus())
 {
 one_level_comparator_ms( 8000 ,BoardSensorPPM, 200 ,
  1000 , 1000 , 10 ,&flag_t.board_sensor_status,
 &board_sensor_count,&board_sensor_count1);

 one_level_comparator_ms( 8000 ,ForwardSensorPPM, 200 ,
  1000 , 1000 , 10 ,&flag_t.forward_sensor_status,
 &forward_sensor_count,&forward_sensor_count1);

 one_level_comparator_ms( 8000 ,BackwardSensorPPM, 200 ,
  1000 , 1000 , 10 ,&flag_t.backward_sensor_status,
 &backward_sensor_count,&backward_sensor_count1);

 if(getAdcStatus())
 {
 setState(sensor_alarm);
 }

 if(flag_t.board_sensor_status)
 {
  analogStatusAllChanell |= (1 << 0) ;
 }
 else
 {
  analogStatusAllChanell &= (~(1 << 0)) ;
 }

 if(flag_t.forward_sensor_status)
 {
  analogStatusAllChanell |= (1 << 1) ;
 }
 else
 {
  analogStatusAllChanell &= (~(1 << 1)) ;
 }

 if(flag_t.backward_sensor_status)
 {
  analogStatusAllChanell |= (1 << 2) ;
 }
 else
 {
  analogStatusAllChanell &= (~(1 << 2)) ;
 }

 }
 else
 {
 flag_t.board_sensor_status =  0 ;
 flag_t.forward_sensor_status =  0 ;
 flag_t.backward_sensor_status =  0 ;
 }
}

unsigned char getAdcStatus()
{
 return (unsigned char)(flag_t.board_sensor_status||flag_t.forward_sensor_status||flag_t.backward_sensor_status);
}

void setAdcControlStatus(unsigned char status)
{
 if(status)
 {
 flag_t.start_sensor_control =  1 ;
 }
 else
 {
 flag_t.start_sensor_control =  0 ;
 }
}

unsigned char getAdcControlStatus()
{
 return (unsigned char)flag_t.start_sensor_control;
}

void CalibrateADC(void)
{




 if ((ADC_CR &  (( unsigned long )0x00000001) ) != 0)
 {
 ADC_CR &= ( unsigned long )(~ (( unsigned long )0x00000001) );
 }
 ADC_CR |=  (( unsigned long )0x80000000) ;
 while ((ADC_CR &  (( unsigned long )0x80000000) ) != 0)
 {

 }
}
#line 658 "D:/ALL_PROJECTS/GAZ_DETECTOR/UZCAR_STM32F0/UZCAR_STM32F031_MC101_BTU/adc_func.c"
void SetClockForADC(void)
{



 RCC_APB2ENR |=  (( unsigned long )0x00000200) ;

 RCC_CR2 |=  (( unsigned long )0x00000001) ;
 while ((RCC_CR2 &  (( unsigned long )0x00000002) ) == 0)
 {

 }
#line 673 "D:/ALL_PROJECTS/GAZ_DETECTOR/UZCAR_STM32F0/UZCAR_STM32F031_MC101_BTU/adc_func.c"
}


void EnableADC(void)
{


 do
 {

 ADC_CR |=  (( unsigned long )0x00000001) ;
 }while ((ADC_ISR &  (( unsigned long )0x00000001) ) == 0) ;
}
