#line 1 "D:/ALL_PROJECTS/GAZ_DETECTOR/UZCAR_STM32F0/UZCAR_STM32F031_MC101_BTU/func.c"
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
#line 3 "D:/ALL_PROJECTS/GAZ_DETECTOR/UZCAR_STM32F0/UZCAR_STM32F031_MC101_BTU/func.c"
state_n state;
struct parameters parameters_t;

void ControlDigitalFlags()
{
static unsigned int start_button_status_count1 = 0, start_button_status_count2 = 0,
 start_count = 0;

 ControlDigit_ms(CAL_BUTTON,  1000 , 1000 ,
  10 , &flag_t.cal_button_status,
 &start_button_status_count1, &start_button_status_count2);


 if(flag_t.cal_button_status== 0 &&flag_t.ready_calibration_prog== 0 )
 {
 flag_t.calibrate_status =  0 ;
 setState(getV0);
 }
}

void globalProcess()
{
 ControlInputData();
 WriteDataToAndroid();
 if(flag_t.ovf_flag== 1 )
 {
 flag_t.ovf_flag =  0 ;

 clear_WDT();
 ReadAnalogInput();
 ControlAnalogFlags();
 ControlDigitalFlags();
 ControlSensorDamage();

 ControlCalibrate(3600);
 ControlRecalFlags();



 switch(state)
 {
 case control_calibration : controlCalibration(); break;
 case error_calibration : ErrorCalibration(); break;
 case start_sound : StartSound( 1 ); break;
 case preheat : Preheat_f(); break;
 case calibration : Calibration_f(); break;
 case getV0 : Calibrate(); break;
 case ready_alarm : ReadyAlarm_f(); break;
 case process : Process_f(); break;
 case sensor_alarm : SensorAlarm(); break;
 case sensor_damage : SensorDamage(); break;
 }

 }
}

void Process_f()
{
 setAdcControlStatus( 1 );

 LED_GREEN =  1 ;
 LED_RED =  0 ;
 RestartCalibration(1200);
 flag_t.process_start_status =  1 ;
}

void setState(state_n newState)
{
 state = newState;
}

state_n getState()
{
 return state;
}

void StartSound(unsigned char state)
{
 flag_t.start_process_status =  1 ;

 ControlReadOutProtection();

 if(state)
 {
 Blink_buz_func(0b00010101,9,1,5,preheat, 1 ,0);
 }
 else
 {
 resetLB();
 setState(preheat);
 }
}

void ErrorCalibration()
{
 static unsigned char count_error_cal = 0, state_error = 0;
 setAdcControlStatus( 0 );

 if((count_error_cal++)>=50)
 {
 count_error_cal = 0;
 state_error^=1;
 }
 if(state_error)
 {
 LED_GREEN =  0 ;
 LED_RED =  1 ;
 }
 else
 {
 LED_GREEN =  0 ;
 LED_RED =  0 ;
 }
}

void controlCalibration()
{
 static unsigned char start_control_cal = 0;
 static unsigned int start_control_count = 0;
 static unsigned int start_buz = 0;
 setAdcControlStatus( 0 );

 ReadAnalogInput();
 LED_RED =  1 ;

 switch(start_buz++)
 {
 case 1: BUZER =  1 ; break;
 case 51: BUZER =  0 ; break;
 }

 if((start_control_count++)>=500&&start_control_cal== 0 )
 {
 start_control_count = 0;
 start_buz = 0;
 start_control_cal =  1 ;
 }
 if(start_control_cal== 1 )
 {
 if(read_data_from_eeprom( 13 )== 1 )
 {
 resetLB();
 start_control_cal =  0 ;
 flag_t.calibrate_status =  0 ;
 setState(error_calibration);
 }
 else
 {
 start_control_cal =  0 ;
 resetLB();



 flag_t.calibrate_status =  1 ;
 setState(start_sound);
 }
 }
}

void Preheat_f()
{
static unsigned char preheat_count_loop = 0;
static unsigned long cycle_preheat_count = 0;

 setAdcControlStatus( 0 );

 if((cycle_preheat_count++)<= 180* 100 )
 {



 switch(preheat_count_loop++)
 {
 case 1: LED_RED =  1 ;
 LED_GREEN =  0 ;
 break;
 case 11: LED_RED =  0 ;
 LED_GREEN =  1 ;
 break;
 case 49: LED_GREEN =  1 ;
 preheat_count_loop = 0;
 break;
 }
 }


 else
 {
 preheat_count_loop = 0;
 cycle_preheat_count = 0;
 resetLB();
 setState(getV0);
 }
}

void Calibration_f()
{
 static unsigned char count_cal = 0, state_cal = 0,count_ready = 50;
 static unsigned long count_ready_cal = 0;
 setAdcControlStatus( 0 );

 if((count_cal++)>=count_ready)
 {
 count_cal = 0;
 state_cal^=1;
 }
 ReadAnalogInput();
 if((count_ready_cal++)>=300&&flag_t.ready_calibration_prog== 0 )
 {
 flag_t.ready_calibration_prog =  1 ;
 count_ready = 25;
 }
 if( state_cal)
 {
 LED_GREEN =  1 ;
 LED_RED =  1 ;
 }
 else
 {
 LED_GREEN =  0 ;
 LED_RED =  0 ;
 }
 if(flag_t.cal_button_status== 0 &&flag_t.ready_calibration_prog== 1 )
 {
 parameters_t.board_sensor_cal_data = (unsigned int)BoardSensorValue;
 parameters_t.forward_sensor_cal_data = (unsigned int)ForwardSensorValue;
 parameters_t.backward_sensor_cal_data = (unsigned int)BackwardSensorValue;
 save_data_to_eeprom( 13 );
 if(read_data_from_eeprom( 13 )== 1 )
 {
 resetLB();
 flag_t.ready_calibration_prog= 0 ;
 count_ready_cal= 0;
 count_ready = 50;
 setState(calibration);
 }
 else
 {
 resetLB();
 flag_t.ready_calibration_prog= 0 ;
 count_ready_cal = 0;
 count_ready = 50;
 SystemReset();
 }
 }
}

void Recalibrate()
{
 setState(getV0);
}

void setHeaterStatus(unsigned char state)
{
 if(state)
 {
 flag_t.heater_status =  1 ;
 }
 else
 {
 flag_t.heater_status =  0 ;
 }

}

unsigned char getHeaterStatus()
{
 return flag_t.heater_status;
}

void ReadyAlarm_f()
{
 static unsigned int ra_count = 0;
 setAdcControlStatus( 0 );

 switch(ra_count++)
 {
 case 11: BUZER =  1 ; break;
 case 200: BUZER =  0 ; break;
 case 260: BUZER =  1 ; break;
 case 340: BUZER =  0 ;
 ra_count= 0;
 resetLB();
 setState(process);
 break;
 }
}
