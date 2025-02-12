#include "stm32f030x6.h"
#include "built_in.h"
//==============================================================================
#define         SET                     1
#define         RESET                   0
#define         FALSE                   0
#define         TRUE                    1
#define         ON                      1
#define         OFF                     0
#define         MS_IN_CYCLE             10
#define bit_set(reg, bit_val)           reg |= (1 << bit_val)
#define bit_clr(reg, bit_val)           reg &= (~(1 << bit_val))
#define get_bits(reg, msk)              (reg & msk)
#define get_input(reg, bit_val)         (reg & (1 << bit_val))
#define bitRead(value, bit)             (((value) >> (bit)) & 0x01)
#define bitSet(value, bit)              ((value) |= (1UL << (bit)))
#define bitClear(value, bit)            ((value) &= ~(1UL << (bit)))
#define bitWrite(value, bit, bitvalue)  (bitvalue ? bitSet(value, bit) : bitClear(value, bit))
//==========================ANALOG SENSOR INPUT=================================
#define BOARD_SENSOR                    1
#define FORWARD_SENSOR                  3
#define BACKWARD_SENSOR                 4
//==========================HEATER SENSOR OUT===================================
extern sfr sbit  BOARD_HEATER;
extern sfr sbit  FORWARD_HEATER;
extern sfr sbit  BACKWARD_HEATER;
//==========================BUTTON INPUT========================================
extern sfr sbit  CAL_BUTTON;
//==========================BUZER OUT===========================================
extern sfr sbit  BUZER;
//==========================LED OUT=============================================
extern sfr sbit  LED_GREEN;
extern sfr sbit  LED_RED;
//==============================================================================
#define BUZER_PERIOD                    1000
#define READY_DATA                      0xAAAA
//==============================================================================
#define HEATER_CYCLE                    10
#define WARM_FASE                       60*MS_IN_SEC
#define COOLING_PFASE                   90*MS_IN_SEC
#define MS_IN_SEC                       100
#define FASE_PREHEAT                    180*MS_IN_SEC
#define DIGITAL_DELAY_ON                1000
#define DIGITAL_DELAY_OFF               1000
#define ANALOG_GISTERESIS               200
#define ANALOG_GISTERESIS_F             100.0
#define ANALOG_DELAY_ON                 1000
#define ANALOG_DELAY_OFF                1000
#define uint8_t                         unsigned char
#define uint16_t                        unsigned int
#define uint32_t                        unsigned long
#define int8_t                          char
#define int16_t                         int
#define int32_t                         long
//==============================================================================
#define VOLT                            2.95
#define ADC_RANGE                       1023//4095
#define ALARM_LEVEL                     8000
#define MAX_GAS_LEVEL                   10000
#define ADC_KOEF                        (VOLT/ADC_RANGE*1000)
#define V0_CAL_TIME                     10*MS_IN_SEC
#define ALARM_DAMAGE_LEVEL_LO           1000.0
#define ALARM_DAMAGE_LEVEL_HI           2300.0
#define VOLT_HALF                       1.65
#define POPR_KOEF                       1.15
#define EEPROM_DATA_SIZE                13
#define OFFSET_CAL_DATA                 700
#define VREF_INT_CHANELL                17
#define TEMP_SENS_CHANELL               16
#define MAX_AVG                         100
#define BAUD_RATE                       9600
#define INPUT_BUFFER_SIZE               25
#define OUT_BUFFER_SIZE                 22
#define DEMO_START_COUNT                200
#define RF_DELAY                        25
#define ADC_AVG                         512
//==============================================================================
typedef enum state_t{control_calibration = 1,error_calibration,read_data_for_cal,
                    calibration,start_sound,preheat,ready_alarm,getV0,process,sensor_alarm,sensor_damage}state_n;
extern state_n state;
extern sfr sbit  LED_GREEN;
extern char input_buffer[INPUT_BUFFER_SIZE ];
extern char request_string[];
//==========================HEATER SENSOR OUT===================================
extern sfr sbit  BOARD_HEATER;
extern sfr sbit  FORWARD_HEATER;
extern sfr sbit  BACKWARD_HEATER;
//==========================BUTTON INPUT========================================
extern sfr sbit  CAL_BUTTON;
//==========================BUZER OUT===========================================
extern sfr sbit  BUZER;
//==========================LED OUT=============================================
extern sfr sbit  LED_GREEN;
extern sfr sbit  LED_RED;
//==========================LED UART TRANSMISSION===============================
extern sfr sbit  LED_UART_TR;
//===============================STRUCT=========================================
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
//==============================================================================

//==============================================================================
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
extern struct parameters  parameters_t;
//==============================================================================
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
extern float VsenseArray[MAX_AVG];
//==============================FUNCTIONS=======================================
void  Init_flags();
void  Init_pin();
void  Init_ADC_chanell();
void  ReadAnalogInput();
unsigned long Read_ADC_chanell(unsigned char chanell,unsigned int samples);
void  ControlAnalogFlags();
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
float getR0(float Rl,float  adcValue,float koef, float volt, float adcRange);
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
//===============================FLASH==========================================
char FLASH_ReadOutProtection(unsigned char new_state);
char FLASH_WaitForLastOperation();
void ControlReadOutProtection();
//===============================UART BTU FUNCTIONS=============================
void InitUartModuleBTU();
void Clear_buffer(char* buf,unsigned int len);
void ControlInputData();
void WriteDataToAndroid();
unsigned char ControlData();