_Init_ADC_chanell:
;adc_func.c,4 :: 		void Init_ADC_chanell()
PUSH	(R14)
;adc_func.c,6 :: 		ADC1_Init();
BL	_ADC1_Init+0
;adc_func.c,7 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_1|_ADC_CHANNEL_3|_ADC_CHANNEL_4);//|_ADC_CHANNEL_3|_ADC_CHANNEL_4);
MOVS	R0, #26
BL	_ADC_Set_Input_Channel+0
;adc_func.c,10 :: 		ADC_CR |= ADC_CR_ADEN; /* (1) */
MOVW	R0, 1073816584
MOVT	R0, 16385
LDR	R1, [R0, #0]
MOVS	R0, #1
ORRS	R1, R0
MOVW	R0, 1073816584
MOVT	R0, 16385
STR	R1, [R0, #0]
;adc_func.c,15 :: 		}
L_end_Init_ADC_chanell:
POP	(R15)
; end of _Init_ADC_chanell
_ReadAnalogInput:
;adc_func.c,35 :: 		void ReadAnalogInput()
PUSH	(R14)
SUB	SP, SP, #12
;adc_func.c,39 :: 		if((rai_count++)>=2)
MOVW	R2, #lo_addr(ReadAnalogInput_rai_count_L0+0)
MOVT	R2, #hi_addr(ReadAnalogInput_rai_count_L0+0)
LDRB	R1, [R2, #0]
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, #1
STRB	R0, [R2, #0]
CMP	R1, #2
IT	CC
BLCC	L_ReadAnalogInput0
;adc_func.c,41 :: 		rai_count=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ReadAnalogInput_rai_count_L0+0)
MOVT	R0, #hi_addr(ReadAnalogInput_rai_count_L0+0)
STRB	R1, [R0, #0]
;adc_func.c,42 :: 		switch(read_count++)
MOVW	R1, #lo_addr(ReadAnalogInput_read_count_L0+0)
MOVT	R1, #hi_addr(ReadAnalogInput_read_count_L0+0)
LDRB	R0, [R1, #0]
STR	R0, [SP, #8]
MOV	R0, R1
LDRB	R0, [R0, #0]
ADDS	R0, #1
STRB	R0, [R1, #0]
IT	AL
BLAL	L_ReadAnalogInput1
;adc_func.c,44 :: 		case 0:  tmpBoardSensorValue = BoardSensorValue;
L_ReadAnalogInput3:
;adc_func.c,45 :: 		BoardSensorValue    = (float)Read_ADC_chanell(BOARD_SENSOR,ADC_AVG);
MOVW	R1, #512
MOVT	R1, #0
MOVS	R0, #1
BL	_Read_ADC_chanell+0
BL	__UnsignedIntegralToFloat+0
MOVW	R1, 536870912
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,46 :: 		if(flag_t.process_start_status)
MOVW	R0, #lo_addr(_flag_t+21)
MOVT	R0, #hi_addr(_flag_t+21)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_ReadAnalogInput4
;adc_func.c,48 :: 		if(BoardSensorValue > BoardSensorR0)
MOVW	R0, 536870936
MOVT	R0, 8192
LDR	R2, [R0, #0]
MOVW	R0, 536870912
MOVT	R0, 8192
LDR	R0, [R0, #0]
BL	__Compare_FP+0
BLE	L__ReadAnalogInput154
MOVS	R0, #1
B	L__ReadAnalogInput155
L__ReadAnalogInput154:
MOVS	R0, #0
L__ReadAnalogInput155:
CMP	R0, #0
IT	EQ
BLEQ	L_ReadAnalogInput5
;adc_func.c,50 :: 		if(((BoardSensorValue - BoardSensorR0) >= 1)&&((BoardSensorValue - BoardSensorR0) <= 4))
MOVW	R0, 536870936
MOVT	R0, 8192
LDR	R2, [R0, #0]
MOVW	R0, 536870912
MOVT	R0, 8192
LDR	R0, [R0, #0]
BL	__Sub_FP+0
MOVW	R2, #0
MOVT	R2, #16256
BL	__Compare_FP+0
BLT	L__ReadAnalogInput156
MOVS	R0, #1
B	L__ReadAnalogInput157
L__ReadAnalogInput156:
MOVS	R0, #0
L__ReadAnalogInput157:
CMP	R0, #0
IT	EQ
BLEQ	L__ReadAnalogInput136
MOVW	R0, 536870936
MOVT	R0, 8192
LDR	R2, [R0, #0]
MOVW	R0, 536870912
MOVT	R0, 8192
LDR	R0, [R0, #0]
BL	__Sub_FP+0
MOVW	R2, #0
MOVT	R2, #16512
BL	__Compare_FP+0
BGT	L__ReadAnalogInput158
MOVS	R0, #1
B	L__ReadAnalogInput159
L__ReadAnalogInput158:
MOVS	R0, #0
L__ReadAnalogInput159:
CMP	R0, #0
IT	EQ
BLEQ	L__ReadAnalogInput135
L__ReadAnalogInput134:
;adc_func.c,52 :: 		BoardSensorValue = BoardSensorR0;
MOVW	R0, 536870936
MOVT	R0, 8192
LDR	R1, [R0, #0]
MOVW	R0, 536870912
MOVT	R0, 8192
STR	R1, [R0, #0]
;adc_func.c,50 :: 		if(((BoardSensorValue - BoardSensorR0) >= 1)&&((BoardSensorValue - BoardSensorR0) <= 4))
L__ReadAnalogInput136:
L__ReadAnalogInput135:
;adc_func.c,54 :: 		}
L_ReadAnalogInput5:
;adc_func.c,55 :: 		}
L_ReadAnalogInput4:
;adc_func.c,56 :: 		BoardSensorVrl = ((float)BoardSensorValue *  (float)(VrefIntVoltage/ADC_RANGE*1000));
MOVW	R0, 536870912
MOVT	R0, 8192
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
MOVW	R0, 536870960
MOVT	R0, 8192
LDR	R0, [R0, #0]
MOVW	R2, #49152
MOVT	R2, #17535
BL	__Div_FP+0
MOVW	R2, #0
MOVT	R2, #17530
BL	__Mul_FP+0
LDR	R2, [SP, #4]
BL	__Mul_FP+0
MOVW	R1, 536870948
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,57 :: 		break;
IT	AL
BLAL	L_ReadAnalogInput2
;adc_func.c,58 :: 		case 1:  BoardSensorPPM  = calculatePPM((float)BoardSensorValue,(float)parameters_t.board_sensor_v0_cal_data,(float)parameters_t.board_sensor_cal_data);
L_ReadAnalogInput9:
MOVW	R0, #lo_addr(_parameters_t+10)
MOVT	R0, #hi_addr(_parameters_t+10)
LDRH	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
STR	R0, [SP, #4]
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
LDRH	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
MOVW	R1, 536870912
MOVT	R1, 8192
LDR	R2, [R1, #0]
LDR	R1, [SP, #4]
STR	R0, [SP, #0]
MOV	R0, R2
MOV	R2, R1
LDR	R1, [SP, #0]
BL	_calculatePPM+0
MOVW	R1, 536870924
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,59 :: 		break;
IT	AL
BLAL	L_ReadAnalogInput2
;adc_func.c,60 :: 		case 2:  tmpForwardSensorValue = ForwardSensorValue;
L_ReadAnalogInput10:
;adc_func.c,61 :: 		ForwardSensorValue  = (float)Read_ADC_chanell(FORWARD_SENSOR,ADC_AVG);
MOVW	R1, #512
MOVT	R1, #0
MOVS	R0, #3
BL	_Read_ADC_chanell+0
BL	__UnsignedIntegralToFloat+0
MOVW	R1, 536870916
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,62 :: 		if(flag_t.process_start_status)
MOVW	R0, #lo_addr(_flag_t+21)
MOVT	R0, #hi_addr(_flag_t+21)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_ReadAnalogInput11
;adc_func.c,64 :: 		if(ForwardSensorValue > ForwardSensorR0)
MOVW	R0, 536870940
MOVT	R0, 8192
LDR	R2, [R0, #0]
MOVW	R0, 536870916
MOVT	R0, 8192
LDR	R0, [R0, #0]
BL	__Compare_FP+0
BLE	L__ReadAnalogInput160
MOVS	R0, #1
B	L__ReadAnalogInput161
L__ReadAnalogInput160:
MOVS	R0, #0
L__ReadAnalogInput161:
CMP	R0, #0
IT	EQ
BLEQ	L_ReadAnalogInput12
;adc_func.c,66 :: 		if(((ForwardSensorValue - ForwardSensorR0) >= 1)&&((ForwardSensorValue - ForwardSensorR0) <= 4))
MOVW	R0, 536870940
MOVT	R0, 8192
LDR	R2, [R0, #0]
MOVW	R0, 536870916
MOVT	R0, 8192
LDR	R0, [R0, #0]
BL	__Sub_FP+0
MOVW	R2, #0
MOVT	R2, #16256
BL	__Compare_FP+0
BLT	L__ReadAnalogInput162
MOVS	R0, #1
B	L__ReadAnalogInput163
L__ReadAnalogInput162:
MOVS	R0, #0
L__ReadAnalogInput163:
CMP	R0, #0
IT	EQ
BLEQ	L__ReadAnalogInput138
MOVW	R0, 536870940
MOVT	R0, 8192
LDR	R2, [R0, #0]
MOVW	R0, 536870916
MOVT	R0, 8192
LDR	R0, [R0, #0]
BL	__Sub_FP+0
MOVW	R2, #0
MOVT	R2, #16512
BL	__Compare_FP+0
BGT	L__ReadAnalogInput164
MOVS	R0, #1
B	L__ReadAnalogInput165
L__ReadAnalogInput164:
MOVS	R0, #0
L__ReadAnalogInput165:
CMP	R0, #0
IT	EQ
BLEQ	L__ReadAnalogInput137
L__ReadAnalogInput133:
;adc_func.c,68 :: 		ForwardSensorValue = ForwardSensorR0;
MOVW	R0, 536870940
MOVT	R0, 8192
LDR	R1, [R0, #0]
MOVW	R0, 536870916
MOVT	R0, 8192
STR	R1, [R0, #0]
;adc_func.c,66 :: 		if(((ForwardSensorValue - ForwardSensorR0) >= 1)&&((ForwardSensorValue - ForwardSensorR0) <= 4))
L__ReadAnalogInput138:
L__ReadAnalogInput137:
;adc_func.c,70 :: 		}
L_ReadAnalogInput12:
;adc_func.c,71 :: 		}
L_ReadAnalogInput11:
;adc_func.c,72 :: 		ForwardSensorVrl  =  ((float)ForwardSensorValue *  (float)(VrefIntVoltage/ADC_RANGE*1000));
MOVW	R0, 536870916
MOVT	R0, 8192
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
MOVW	R0, 536870960
MOVT	R0, 8192
LDR	R0, [R0, #0]
MOVW	R2, #49152
MOVT	R2, #17535
BL	__Div_FP+0
MOVW	R2, #0
MOVT	R2, #17530
BL	__Mul_FP+0
LDR	R2, [SP, #4]
BL	__Mul_FP+0
MOVW	R1, 536870952
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,73 :: 		break;
IT	AL
BLAL	L_ReadAnalogInput2
;adc_func.c,74 :: 		case 3:  ForwardSensorPPM    = calculatePPM((float)ForwardSensorValue, (float)parameters_t.forward_sensor_v0_cal_data,(float)parameters_t.forward_sensor_cal_data);
L_ReadAnalogInput16:
MOVW	R0, #lo_addr(_parameters_t+6)
MOVT	R0, #hi_addr(_parameters_t+6)
LDRH	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
STR	R0, [SP, #4]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
LDRH	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
MOVW	R1, 536870916
MOVT	R1, 8192
LDR	R2, [R1, #0]
LDR	R1, [SP, #4]
STR	R0, [SP, #0]
MOV	R0, R2
MOV	R2, R1
LDR	R1, [SP, #0]
BL	_calculatePPM+0
MOVW	R1, 536870928
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,75 :: 		break;
IT	AL
BLAL	L_ReadAnalogInput2
;adc_func.c,76 :: 		case 4:  tmpBackwardSensorValue = BackwardSensorValue;
L_ReadAnalogInput17:
;adc_func.c,77 :: 		BackwardSensorValue = Read_ADC_chanell(BACKWARD_SENSOR,ADC_AVG);
MOVW	R1, #512
MOVT	R1, #0
MOVS	R0, #4
BL	_Read_ADC_chanell+0
BL	__UnsignedIntegralToFloat+0
MOVW	R1, 536870920
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,78 :: 		if(flag_t.process_start_status)
MOVW	R0, #lo_addr(_flag_t+21)
MOVT	R0, #hi_addr(_flag_t+21)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_ReadAnalogInput18
;adc_func.c,80 :: 		if(BackwardSensorValue > BackwardSensorR0)
MOVW	R0, 536870944
MOVT	R0, 8192
LDR	R2, [R0, #0]
MOVW	R0, 536870920
MOVT	R0, 8192
LDR	R0, [R0, #0]
BL	__Compare_FP+0
BLE	L__ReadAnalogInput166
MOVS	R0, #1
B	L__ReadAnalogInput167
L__ReadAnalogInput166:
MOVS	R0, #0
L__ReadAnalogInput167:
CMP	R0, #0
IT	EQ
BLEQ	L_ReadAnalogInput19
;adc_func.c,82 :: 		if(((BackwardSensorValue - BackwardSensorR0) >= 1)&&((BackwardSensorValue - BackwardSensorR0) <= 4))
MOVW	R0, 536870944
MOVT	R0, 8192
LDR	R2, [R0, #0]
MOVW	R0, 536870920
MOVT	R0, 8192
LDR	R0, [R0, #0]
BL	__Sub_FP+0
MOVW	R2, #0
MOVT	R2, #16256
BL	__Compare_FP+0
BLT	L__ReadAnalogInput168
MOVS	R0, #1
B	L__ReadAnalogInput169
L__ReadAnalogInput168:
MOVS	R0, #0
L__ReadAnalogInput169:
CMP	R0, #0
IT	EQ
BLEQ	L__ReadAnalogInput140
MOVW	R0, 536870944
MOVT	R0, 8192
LDR	R2, [R0, #0]
MOVW	R0, 536870920
MOVT	R0, 8192
LDR	R0, [R0, #0]
BL	__Sub_FP+0
MOVW	R2, #0
MOVT	R2, #16512
BL	__Compare_FP+0
BGT	L__ReadAnalogInput170
MOVS	R0, #1
B	L__ReadAnalogInput171
L__ReadAnalogInput170:
MOVS	R0, #0
L__ReadAnalogInput171:
CMP	R0, #0
IT	EQ
BLEQ	L__ReadAnalogInput139
L__ReadAnalogInput132:
;adc_func.c,84 :: 		BackwardSensorValue = BackwardSensorR0;
MOVW	R0, 536870944
MOVT	R0, 8192
LDR	R1, [R0, #0]
MOVW	R0, 536870920
MOVT	R0, 8192
STR	R1, [R0, #0]
;adc_func.c,82 :: 		if(((BackwardSensorValue - BackwardSensorR0) >= 1)&&((BackwardSensorValue - BackwardSensorR0) <= 4))
L__ReadAnalogInput140:
L__ReadAnalogInput139:
;adc_func.c,86 :: 		}
L_ReadAnalogInput19:
;adc_func.c,87 :: 		}
L_ReadAnalogInput18:
;adc_func.c,88 :: 		BackwardSensorVrl =  ((float)BackwardSensorValue *  (float)(VrefIntVoltage/ADC_RANGE*1000));
MOVW	R0, 536870920
MOVT	R0, 8192
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
MOVW	R0, 536870960
MOVT	R0, 8192
LDR	R0, [R0, #0]
MOVW	R2, #49152
MOVT	R2, #17535
BL	__Div_FP+0
MOVW	R2, #0
MOVT	R2, #17530
BL	__Mul_FP+0
LDR	R2, [SP, #4]
BL	__Mul_FP+0
MOVW	R1, 536870956
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,89 :: 		break;
IT	AL
BLAL	L_ReadAnalogInput2
;adc_func.c,90 :: 		case 5:  BackwardSensorPPM   = calculatePPM((float)BackwardSensorValue, (float)parameters_t.backward_sensor_v0_cal_data,(float)parameters_t.backward_sensor_cal_data);
L_ReadAnalogInput23:
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
LDRH	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
STR	R0, [SP, #4]
MOVW	R0, #lo_addr(_parameters_t+2)
MOVT	R0, #hi_addr(_parameters_t+2)
LDRH	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
MOVW	R1, 536870920
MOVT	R1, 8192
LDR	R2, [R1, #0]
LDR	R1, [SP, #4]
STR	R0, [SP, #0]
MOV	R0, R2
MOV	R2, R1
LDR	R1, [SP, #0]
BL	_calculatePPM+0
MOVW	R1, 536870932
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,91 :: 		break;
IT	AL
BLAL	L_ReadAnalogInput2
;adc_func.c,92 :: 		case 6:  ReadVrefIntValue();                                                 break;
L_ReadAnalogInput24:
BL	_ReadVrefIntValue+0
IT	AL
BLAL	L_ReadAnalogInput2
;adc_func.c,93 :: 		case 7:  ComputeTemperature();       read_count = 0;                         break;
L_ReadAnalogInput25:
BL	_ComputeTemperature+0
MOVS	R1, #0
MOVW	R0, #lo_addr(ReadAnalogInput_read_count_L0+0)
MOVT	R0, #hi_addr(ReadAnalogInput_read_count_L0+0)
STRB	R1, [R0, #0]
IT	AL
BLAL	L_ReadAnalogInput2
;adc_func.c,94 :: 		}
L_ReadAnalogInput1:
LDR	R0, [SP, #8]
UXTB	R0, R0
CMP	R0, #0
IT	EQ
BLEQ	L_ReadAnalogInput3
CMP	R0, #1
IT	EQ
BLEQ	L_ReadAnalogInput9
CMP	R0, #2
IT	EQ
BLEQ	L_ReadAnalogInput10
CMP	R0, #3
IT	EQ
BLEQ	L_ReadAnalogInput16
CMP	R0, #4
IT	EQ
BLEQ	L_ReadAnalogInput17
CMP	R0, #5
IT	EQ
BLEQ	L_ReadAnalogInput23
CMP	R0, #6
IT	EQ
BLEQ	L_ReadAnalogInput24
CMP	R0, #7
IT	EQ
BLEQ	L_ReadAnalogInput25
L_ReadAnalogInput2:
;adc_func.c,96 :: 		}
L_ReadAnalogInput0:
;adc_func.c,97 :: 		}
L_end_ReadAnalogInput:
ADD	SP, SP, #12
POP	(R15)
; end of _ReadAnalogInput
_ControlSensorDamage:
;adc_func.c,100 :: 		void ControlSensorDamage()
PUSH	(R14)
;adc_func.c,109 :: 		&board_sensor_damage_count1);
MOVW	R6, #lo_addr(ControlSensorDamage_board_sensor_damage_count1_L0+0)
MOVT	R6, #hi_addr(ControlSensorDamage_board_sensor_damage_count1_L0+0)
;adc_func.c,108 :: 		MS_IN_CYCLE,&flag_t.board_sensor_damage,&board_sensor_damage_count,
MOVW	R5, #lo_addr(ControlSensorDamage_board_sensor_damage_count_L0+0)
MOVT	R5, #hi_addr(ControlSensorDamage_board_sensor_damage_count_L0+0)
MOVW	R4, #lo_addr(_flag_t+9)
MOVT	R4, #hi_addr(_flag_t+9)
MOVS	R3, #10
;adc_func.c,107 :: 		ANALOG_GISTERESIS_F, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
MOVW	R2, #1000
MOVT	R2, #0
MOVW	R1, #1000
MOVT	R1, #0
;adc_func.c,106 :: 		two_level_comparator_ms(ALARM_DAMAGE_LEVEL_HI,ALARM_DAMAGE_LEVEL_LO,BoardSensorVrl,
MOVW	R0, 536870948
MOVT	R0, 8192
LDR	R0, [R0, #0]
;adc_func.c,109 :: 		&board_sensor_damage_count1);
PUSH	(R6)
;adc_func.c,108 :: 		MS_IN_CYCLE,&flag_t.board_sensor_damage,&board_sensor_damage_count,
PUSH	(R5)
PUSH	(R4)
PUSH	(R3)
;adc_func.c,107 :: 		ANALOG_GISTERESIS_F, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
PUSH	(R2)
PUSH	(R1)
MOVW	R3, #0
MOVT	R3, #17096
;adc_func.c,106 :: 		two_level_comparator_ms(ALARM_DAMAGE_LEVEL_HI,ALARM_DAMAGE_LEVEL_LO,BoardSensorVrl,
MOV	R2, R0
MOVW	R1, #0
MOVT	R1, #17530
MOVW	R0, #49152
MOVT	R0, #17679
;adc_func.c,109 :: 		&board_sensor_damage_count1);
;adc_func.c,108 :: 		MS_IN_CYCLE,&flag_t.board_sensor_damage,&board_sensor_damage_count,
;adc_func.c,107 :: 		ANALOG_GISTERESIS_F, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
;adc_func.c,109 :: 		&board_sensor_damage_count1);
BL	_two_level_comparator_ms+0
ADD	SP, SP, #24
;adc_func.c,114 :: 		&forward_sensor_damage_count1);
MOVW	R6, #lo_addr(ControlSensorDamage_forward_sensor_damage_count1_L0+0)
MOVT	R6, #hi_addr(ControlSensorDamage_forward_sensor_damage_count1_L0+0)
;adc_func.c,113 :: 		MS_IN_CYCLE,&flag_t.forward_sensor_damage,&forward_sensor_damage_count,
MOVW	R5, #lo_addr(ControlSensorDamage_forward_sensor_damage_count_L0+0)
MOVT	R5, #hi_addr(ControlSensorDamage_forward_sensor_damage_count_L0+0)
MOVW	R4, #lo_addr(_flag_t+10)
MOVT	R4, #hi_addr(_flag_t+10)
MOVS	R3, #10
;adc_func.c,112 :: 		ANALOG_GISTERESIS_F, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
MOVW	R2, #1000
MOVT	R2, #0
MOVW	R1, #1000
MOVT	R1, #0
;adc_func.c,111 :: 		two_level_comparator_ms(ALARM_DAMAGE_LEVEL_HI,ALARM_DAMAGE_LEVEL_LO,ForwardSensorVrl,
MOVW	R0, 536870952
MOVT	R0, 8192
LDR	R0, [R0, #0]
;adc_func.c,114 :: 		&forward_sensor_damage_count1);
PUSH	(R6)
;adc_func.c,113 :: 		MS_IN_CYCLE,&flag_t.forward_sensor_damage,&forward_sensor_damage_count,
PUSH	(R5)
PUSH	(R4)
PUSH	(R3)
;adc_func.c,112 :: 		ANALOG_GISTERESIS_F, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
PUSH	(R2)
PUSH	(R1)
MOVW	R3, #0
MOVT	R3, #17096
;adc_func.c,111 :: 		two_level_comparator_ms(ALARM_DAMAGE_LEVEL_HI,ALARM_DAMAGE_LEVEL_LO,ForwardSensorVrl,
MOV	R2, R0
MOVW	R1, #0
MOVT	R1, #17530
MOVW	R0, #49152
MOVT	R0, #17679
;adc_func.c,114 :: 		&forward_sensor_damage_count1);
;adc_func.c,113 :: 		MS_IN_CYCLE,&flag_t.forward_sensor_damage,&forward_sensor_damage_count,
;adc_func.c,112 :: 		ANALOG_GISTERESIS_F, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
;adc_func.c,114 :: 		&forward_sensor_damage_count1);
BL	_two_level_comparator_ms+0
ADD	SP, SP, #24
;adc_func.c,119 :: 		&backward_sensor_damage_count1);
MOVW	R6, #lo_addr(ControlSensorDamage_backward_sensor_damage_count1_L0+0)
MOVT	R6, #hi_addr(ControlSensorDamage_backward_sensor_damage_count1_L0+0)
;adc_func.c,118 :: 		MS_IN_CYCLE,&flag_t.backward_sensor_damage,&backward_sensor_damage_count,
MOVW	R5, #lo_addr(ControlSensorDamage_backward_sensor_damage_count_L0+0)
MOVT	R5, #hi_addr(ControlSensorDamage_backward_sensor_damage_count_L0+0)
MOVW	R4, #lo_addr(_flag_t+11)
MOVT	R4, #hi_addr(_flag_t+11)
MOVS	R3, #10
;adc_func.c,117 :: 		ANALOG_GISTERESIS_F, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
MOVW	R2, #1000
MOVT	R2, #0
MOVW	R1, #1000
MOVT	R1, #0
;adc_func.c,116 :: 		two_level_comparator_ms(ALARM_DAMAGE_LEVEL_HI,ALARM_DAMAGE_LEVEL_LO,BackwardSensorVrl,
MOVW	R0, 536870956
MOVT	R0, 8192
LDR	R0, [R0, #0]
;adc_func.c,119 :: 		&backward_sensor_damage_count1);
PUSH	(R6)
;adc_func.c,118 :: 		MS_IN_CYCLE,&flag_t.backward_sensor_damage,&backward_sensor_damage_count,
PUSH	(R5)
PUSH	(R4)
PUSH	(R3)
;adc_func.c,117 :: 		ANALOG_GISTERESIS_F, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
PUSH	(R2)
PUSH	(R1)
MOVW	R3, #0
MOVT	R3, #17096
;adc_func.c,116 :: 		two_level_comparator_ms(ALARM_DAMAGE_LEVEL_HI,ALARM_DAMAGE_LEVEL_LO,BackwardSensorVrl,
MOV	R2, R0
MOVW	R1, #0
MOVT	R1, #17530
MOVW	R0, #49152
MOVT	R0, #17679
;adc_func.c,119 :: 		&backward_sensor_damage_count1);
;adc_func.c,118 :: 		MS_IN_CYCLE,&flag_t.backward_sensor_damage,&backward_sensor_damage_count,
;adc_func.c,117 :: 		ANALOG_GISTERESIS_F, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
;adc_func.c,119 :: 		&backward_sensor_damage_count1);
BL	_two_level_comparator_ms+0
ADD	SP, SP, #24
;adc_func.c,121 :: 		if(getDamageSensorStatus())
BL	_getDamageSensorStatus+0
CMP	R0, #0
IT	EQ
BLEQ	L_ControlSensorDamage26
;adc_func.c,123 :: 		setState(sensor_damage);
MOVS	R0, #11
BL	_setState+0
;adc_func.c,124 :: 		}
L_ControlSensorDamage26:
;adc_func.c,126 :: 		if(flag_t.board_sensor_damage)
MOVW	R0, #lo_addr(_flag_t+9)
MOVT	R0, #hi_addr(_flag_t+9)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_ControlSensorDamage27
;adc_func.c,128 :: 		bit_clr(AnalogSensorDamageControl,0);
MOVW	R0, 536870972
MOVT	R0, 8192
LDRB	R1, [R0, #0]
MOVS	R0, #1
MVN	R0, R0
SXTH	R0, R0
ANDS	R1, R0
MOVW	R0, 536870972
MOVT	R0, 8192
STRB	R1, [R0, #0]
;adc_func.c,129 :: 		}
IT	AL
BLAL	L_ControlSensorDamage28
L_ControlSensorDamage27:
;adc_func.c,132 :: 		bit_set(AnalogSensorDamageControl,0);
MOVW	R0, 536870972
MOVT	R0, 8192
LDRB	R1, [R0, #0]
MOVS	R0, #1
ORRS	R1, R0
MOVW	R0, 536870972
MOVT	R0, 8192
STRB	R1, [R0, #0]
;adc_func.c,133 :: 		}
L_ControlSensorDamage28:
;adc_func.c,135 :: 		if(flag_t.forward_sensor_damage)
MOVW	R0, #lo_addr(_flag_t+10)
MOVT	R0, #hi_addr(_flag_t+10)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_ControlSensorDamage29
;adc_func.c,137 :: 		bit_clr(AnalogSensorDamageControl,1);
MOVW	R0, 536870972
MOVT	R0, 8192
LDRB	R1, [R0, #0]
MOVS	R0, #2
MVN	R0, R0
SXTH	R0, R0
ANDS	R1, R0
MOVW	R0, 536870972
MOVT	R0, 8192
STRB	R1, [R0, #0]
;adc_func.c,138 :: 		}
IT	AL
BLAL	L_ControlSensorDamage30
L_ControlSensorDamage29:
;adc_func.c,141 :: 		bit_set(AnalogSensorDamageControl,1);
MOVW	R0, 536870972
MOVT	R0, 8192
LDRB	R1, [R0, #0]
MOVS	R0, #2
ORRS	R1, R0
MOVW	R0, 536870972
MOVT	R0, 8192
STRB	R1, [R0, #0]
;adc_func.c,142 :: 		}
L_ControlSensorDamage30:
;adc_func.c,144 :: 		if(flag_t.backward_sensor_damage)
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_ControlSensorDamage31
;adc_func.c,146 :: 		bit_clr(AnalogSensorDamageControl,2);
MOVW	R0, 536870972
MOVT	R0, 8192
LDRB	R1, [R0, #0]
MOVS	R0, #4
MVN	R0, R0
SXTH	R0, R0
ANDS	R1, R0
MOVW	R0, 536870972
MOVT	R0, 8192
STRB	R1, [R0, #0]
;adc_func.c,147 :: 		}
IT	AL
BLAL	L_ControlSensorDamage32
L_ControlSensorDamage31:
;adc_func.c,150 :: 		bit_set(AnalogSensorDamageControl,2);
MOVW	R0, 536870972
MOVT	R0, 8192
LDRB	R1, [R0, #0]
MOVS	R0, #4
ORRS	R1, R0
MOVW	R0, 536870972
MOVT	R0, 8192
STRB	R1, [R0, #0]
;adc_func.c,151 :: 		}
L_ControlSensorDamage32:
;adc_func.c,153 :: 		}
L_end_ControlSensorDamage:
POP	(R15)
; end of _ControlSensorDamage
_getDamageSensorStatus:
;adc_func.c,155 :: 		unsigned char getDamageSensorStatus()
PUSH	(R14)
;adc_func.c,157 :: 		return (unsigned char)((!flag_t.board_sensor_damage)||(!flag_t.forward_sensor_damage)||(!flag_t.backward_sensor_damage));
MOVW	R0, #lo_addr(_flag_t+9)
MOVT	R0, #hi_addr(_flag_t+9)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_getDamageSensorStatus34
MOVW	R0, #lo_addr(_flag_t+10)
MOVT	R0, #hi_addr(_flag_t+10)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_getDamageSensorStatus34
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_getDamageSensorStatus34
MOVS	R0, #0
IT	AL
BLAL	L_getDamageSensorStatus33
L_getDamageSensorStatus34:
MOVS	R0, #1
L_getDamageSensorStatus33:
;adc_func.c,158 :: 		}
L_end_getDamageSensorStatus:
POP	(R15)
; end of _getDamageSensorStatus
_ReadVrefIntValue:
;adc_func.c,162 :: 		void ReadVrefIntValue()
PUSH	(R14)
;adc_func.c,164 :: 		float VrefIntValue = 0;
;adc_func.c,165 :: 		ADC_CCR |= ADC_CCR_VREFEN;
MOVW	R0, 1073817352
MOVT	R0, 16385
LDR	R1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #64
ORRS	R1, R0
MOVW	R0, 1073817352
MOVT	R0, 16385
STR	R1, [R0, #0]
;adc_func.c,166 :: 		VrefIntValue = Read_ADC_chanell(VREF_INT_CHANELL,32);
MOVS	R1, #32
MOVS	R0, #17
BL	_Read_ADC_chanell+0
BL	__UnsignedIntegralToFloat+0
; VrefIntValue start address is: 28 (R7)
MOV	R7, R0
;adc_func.c,167 :: 		VrefIntVoltage = (3.3*(*VREF_INT_CAL_ADDR))/(float)VrefIntValue*0.25;
MOVW	R0, 536868794
MOVT	R0, 8191
LDRH	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
MOVW	R2, #13107
MOVT	R2, #16467
BL	__Mul_FP+0
MOV	R2, R7
BL	__Div_FP+0
; VrefIntValue end address is: 28 (R7)
MOVW	R2, #0
MOVT	R2, #16000
BL	__Mul_FP+0
MOVW	R1, 536870960
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,168 :: 		}
L_end_ReadVrefIntValue:
POP	(R15)
; end of _ReadVrefIntValue
_ComputeTemperature:
;adc_func.c,176 :: 		void ComputeTemperature()
PUSH	(R14)
SUB	SP, SP, #12
;adc_func.c,178 :: 		float measure = 0;
;adc_func.c,179 :: 		ADC_CCR |= ADC_CCR_TSEN;
MOVW	R0, 1073817352
MOVT	R0, 16385
LDR	R1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #128
ORRS	R1, R0
MOVW	R0, 1073817352
MOVT	R0, 16385
STR	R1, [R0, #0]
;adc_func.c,180 :: 		measure = Read_ADC_chanell(TEMP_SENS_CHANELL,64);
MOVS	R1, #64
MOVS	R0, #16
BL	_Read_ADC_chanell+0
BL	__UnsignedIntegralToFloat+0
;adc_func.c,181 :: 		temperature = ((measure * VDD_APPLI / VDD_CALIB) - (int32_t) *TEMP30_CAL_ADDR ) ;
MOVW	R2, #0
MOVT	R2, #17302
BL	__Mul_FP+0
MOVW	R2, #0
MOVT	R2, #17317
BL	__Div_FP+0
STR	R0, [SP, #8]
MOVW	R0, 536868792
MOVT	R0, 8191
LDRH	R0, [R0, #0]
BL	__SignedIntegralToFloat+0
STR	R0, [SP, #4]
LDR	R0, [SP, #8]
STR	R1, [SP, #0]
LDR	R1, [SP, #4]
MOV	R2, R1
BL	__Sub_FP+0
LDR	R1, [SP, #0]
MOVW	R1, 536870964
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,182 :: 		temperature = temperature * (int32_t)(110 - 30);
MOVW	R0, 536870964
MOVT	R0, 8192
LDR	R2, [R0, #0]
MOVW	R0, #0
MOVT	R0, #17056
BL	__Mul_FP+0
MOVW	R1, 536870964
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,183 :: 		temperature = temperature / (int32_t)(*TEMP110_CAL_ADDR - *TEMP30_CAL_ADDR);
MOVW	R0, 536868792
MOVT	R0, 8191
LDRH	R1, [R0, #0]
MOVW	R0, 536868802
MOVT	R0, 8191
LDRH	R0, [R0, #0]
SUBS	R0, R0, R1
UXTH	R0, R0
BL	__SignedIntegralToFloat+0
STR	R0, [SP, #4]
MOVW	R0, 536870964
MOVT	R0, 8192
LDR	R0, [R0, #0]
STR	R1, [SP, #0]
LDR	R1, [SP, #4]
MOV	R2, R1
BL	__Div_FP+0
LDR	R1, [SP, #0]
MOVW	R1, 536870964
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,184 :: 		temperature = temperature + 30;
MOVW	R0, 536870964
MOVT	R0, 8192
LDR	R2, [R0, #0]
MOVW	R0, #0
MOVT	R0, #16880
BL	__Add_FP+0
MOVW	R1, 536870964
MOVT	R1, 8192
STR	R0, [R1, #0]
;adc_func.c,185 :: 		}
L_end_ComputeTemperature:
ADD	SP, SP, #12
POP	(R15)
; end of _ComputeTemperature
_ReadTempAndVoltage:
;adc_func.c,187 :: 		void ReadTempAndVoltage()
PUSH	(R14)
SUB	SP, SP, #4
;adc_func.c,190 :: 		switch(count_t_v++)
MOVW	R1, #lo_addr(ReadTempAndVoltage_count_t_v_L0+0)
MOVT	R1, #hi_addr(ReadTempAndVoltage_count_t_v_L0+0)
LDRB	R0, [R1, #0]
STR	R0, [SP, #0]
MOV	R0, R1
LDRB	R0, [R0, #0]
ADDS	R0, #1
STRB	R0, [R1, #0]
IT	AL
BLAL	L_ReadTempAndVoltage35
;adc_func.c,192 :: 		case   1:    ReadVrefIntValue();   break;
L_ReadTempAndVoltage37:
BL	_ReadVrefIntValue+0
IT	AL
BLAL	L_ReadTempAndVoltage36
;adc_func.c,193 :: 		case   6:    ComputeTemperature();
L_ReadTempAndVoltage38:
BL	_ComputeTemperature+0
;adc_func.c,194 :: 		case   11:          count_t_v = 0; break;
L_ReadTempAndVoltage39:
MOVS	R1, #0
MOVW	R0, #lo_addr(ReadTempAndVoltage_count_t_v_L0+0)
MOVT	R0, #hi_addr(ReadTempAndVoltage_count_t_v_L0+0)
STRB	R1, [R0, #0]
IT	AL
BLAL	L_ReadTempAndVoltage36
;adc_func.c,195 :: 		}
L_ReadTempAndVoltage35:
LDR	R0, [SP, #0]
UXTB	R0, R0
CMP	R0, #1
IT	EQ
BLEQ	L_ReadTempAndVoltage37
CMP	R0, #6
IT	EQ
BLEQ	L_ReadTempAndVoltage38
CMP	R0, #11
IT	EQ
BLEQ	L_ReadTempAndVoltage39
L_ReadTempAndVoltage36:
;adc_func.c,196 :: 		}
L_end_ReadTempAndVoltage:
ADD	SP, SP, #4
POP	(R15)
; end of _ReadTempAndVoltage
_ControlV0:
;adc_func.c,198 :: 		void ControlV0(unsigned int* v0_data,unsigned int* tmp,unsigned int offset,unsigned char* flag)
; flag start address is: 12 (R3)
; offset start address is: 8 (R2)
; tmp start address is: 4 (R1)
; v0_data start address is: 0 (R0)
PUSH	(R14)
; flag end address is: 12 (R3)
; offset end address is: 8 (R2)
; tmp end address is: 4 (R1)
; v0_data end address is: 0 (R0)
; v0_data start address is: 0 (R0)
; tmp start address is: 4 (R1)
; offset start address is: 8 (R2)
; flag start address is: 12 (R3)
;adc_func.c,200 :: 		if(*flag)
LDRB	R4, [R3, #0]
; flag end address is: 12 (R3)
CMP	R4, #0
IT	EQ
BLEQ	L_ControlV040
;adc_func.c,202 :: 		if((*v0_data)>(*tmp))
LDRH	R5, [R0, #0]
LDRH	R4, [R1, #0]
CMP	R5, R4
IT	LS
BLLS	L_ControlV041
;adc_func.c,204 :: 		if(((*v0_data)-(*tmp))>offset)
LDRH	R5, [R0, #0]
LDRH	R4, [R1, #0]
SUBS	R4, R5, R4
UXTH	R4, R4
CMP	R4, R2
IT	LS
BLLS	L_ControlV042
;adc_func.c,206 :: 		*v0_data = *tmp;
LDRH	R4, [R1, #0]
STRH	R4, [R0, #0]
;adc_func.c,207 :: 		}
L_ControlV042:
;adc_func.c,208 :: 		}
L_ControlV041:
;adc_func.c,209 :: 		if((*v0_data)<(*tmp))
LDRH	R5, [R0, #0]
LDRH	R4, [R1, #0]
CMP	R5, R4
IT	CS
BLCS	L_ControlV043
;adc_func.c,211 :: 		if(((*tmp)-(*v0_data))>offset)
LDRH	R5, [R1, #0]
LDRH	R4, [R0, #0]
SUBS	R4, R5, R4
UXTH	R4, R4
CMP	R4, R2
IT	LS
BLLS	L_ControlV044
; offset end address is: 8 (R2)
;adc_func.c,213 :: 		*v0_data = *tmp;
LDRH	R4, [R1, #0]
; tmp end address is: 4 (R1)
STRH	R4, [R0, #0]
; v0_data end address is: 0 (R0)
;adc_func.c,214 :: 		}
L_ControlV044:
;adc_func.c,215 :: 		}
L_ControlV043:
;adc_func.c,216 :: 		}
L_ControlV040:
;adc_func.c,217 :: 		}
L_end_ControlV0:
POP	(R15)
; end of _ControlV0
_ControlVs:
;adc_func.c,219 :: 		void ControlVs(unsigned int* v0_data,unsigned int* tmp,unsigned int* vs_data,unsigned char* flag)
; flag start address is: 12 (R3)
; vs_data start address is: 8 (R2)
; tmp start address is: 4 (R1)
; v0_data start address is: 0 (R0)
PUSH	(R14)
; flag end address is: 12 (R3)
; vs_data end address is: 8 (R2)
; tmp end address is: 4 (R1)
; v0_data end address is: 0 (R0)
; v0_data start address is: 0 (R0)
; tmp start address is: 4 (R1)
; vs_data start address is: 8 (R2)
; flag start address is: 12 (R3)
;adc_func.c,221 :: 		if(*flag)
LDRB	R4, [R3, #0]
; flag end address is: 12 (R3)
CMP	R4, #0
IT	EQ
BLEQ	L_ControlVs45
;adc_func.c,223 :: 		if((*v0_data)>(*tmp))
LDRH	R5, [R0, #0]
LDRH	R4, [R1, #0]
CMP	R5, R4
IT	LS
BLLS	L_ControlVs46
;adc_func.c,225 :: 		*vs_data = (*vs_data) + ((*v0_data) - (*tmp));
LDRH	R6, [R2, #0]
LDRH	R5, [R0, #0]
LDRH	R4, [R1, #0]
SUBS	R4, R5, R4
UXTH	R4, R4
ADDS	R4, R6, R4
STRH	R4, [R2, #0]
;adc_func.c,226 :: 		}
L_ControlVs46:
;adc_func.c,227 :: 		if((*v0_data)<(*tmp))
LDRH	R5, [R0, #0]
LDRH	R4, [R1, #0]
CMP	R5, R4
IT	CS
BLCS	L_ControlVs47
;adc_func.c,229 :: 		*vs_data = (*vs_data) - ((*tmp) - (*v0_data));
LDRH	R6, [R2, #0]
LDRH	R5, [R1, #0]
; tmp end address is: 4 (R1)
LDRH	R4, [R0, #0]
; v0_data end address is: 0 (R0)
SUBS	R4, R5, R4
UXTH	R4, R4
SUBS	R4, R6, R4
STRH	R4, [R2, #0]
; vs_data end address is: 8 (R2)
;adc_func.c,230 :: 		}
L_ControlVs47:
;adc_func.c,231 :: 		}
L_ControlVs45:
;adc_func.c,232 :: 		}
L_end_ControlVs:
POP	(R15)
; end of _ControlVs
_ControlData:
;adc_func.c,247 :: 		unsigned char ControlData()
PUSH	(R14)
;adc_func.c,250 :: 		(parameters_t.backward_sensor_ready==READY_DATA)&&
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
LDRH	R1, [R0, #0]
MOVW	R0, #43690
MOVT	R0, #0
CMP	R1, R0
IT	NE
BLNE	L_ControlData49
MOVW	R0, #lo_addr(_parameters_t+14)
MOVT	R0, #hi_addr(_parameters_t+14)
LDRH	R1, [R0, #0]
MOVW	R0, #43690
MOVT	R0, #0
CMP	R1, R0
IT	NE
BLNE	L_ControlData49
;adc_func.c,251 :: 		(parameters_t.board_sensor_ready==READY_DATA));
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
LDRH	R1, [R0, #0]
MOVW	R0, #43690
MOVT	R0, #0
CMP	R1, R0
IT	NE
BLNE	L_ControlData49
MOVS	R0, #1
IT	AL
BLAL	L_ControlData48
L_ControlData49:
MOVS	R0, #0
L_ControlData48:
;adc_func.c,252 :: 		}
L_end_ControlData:
POP	(R15)
; end of _ControlData
_Calibrate:
;adc_func.c,254 :: 		void Calibrate()
PUSH	(R14)
SUB	SP, SP, #12
;adc_func.c,257 :: 		unsigned int board_sens_temp = 0,forward_sens_temp = 0,backward_sens_temp = 0;
MOV	R6, SP
MOVS	R5, #10
ADDS	R5, R5, R6
MOVW	R7, #lo_addr(?ICSCalibrate_board_sens_temp_L0+0)
MOVT	R7, #hi_addr(?ICSCalibrate_board_sens_temp_L0+0)
BL	___CC2DW+0
;adc_func.c,258 :: 		setAdcControlStatus(RESET);
MOVS	R0, #0
BL	_setAdcControlStatus+0
;adc_func.c,259 :: 		if(ControlData()&&flag_t.first_start)
BL	_ControlData+0
CMP	R0, #0
IT	EQ
BLEQ	L__Calibrate145
MOVW	R0, #lo_addr(_flag_t+22)
MOVT	R0, #hi_addr(_flag_t+22)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L__Calibrate144
L__Calibrate143:
;adc_func.c,261 :: 		ControlRecalFlags();
BL	_ControlRecalFlags+0
;adc_func.c,259 :: 		if(ControlData()&&flag_t.first_start)
L__Calibrate145:
L__Calibrate144:
;adc_func.c,263 :: 		if(getRcalAdcStatus()&&ControlData()&&flag_t.first_start)
BL	_getRcalAdcStatus+0
CMP	R0, #0
IT	EQ
BLEQ	L__Calibrate148
BL	_ControlData+0
CMP	R0, #0
IT	EQ
BLEQ	L__Calibrate147
MOVW	R0, #lo_addr(_flag_t+22)
MOVT	R0, #hi_addr(_flag_t+22)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L__Calibrate146
L__Calibrate142:
;adc_func.c,265 :: 		flag_t.alarm_sensor_status = SET;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+23)
MOVT	R0, #hi_addr(_flag_t+23)
STRB	R1, [R0, #0]
;adc_func.c,263 :: 		if(getRcalAdcStatus()&&ControlData()&&flag_t.first_start)
L__Calibrate148:
L__Calibrate147:
L__Calibrate146:
;adc_func.c,267 :: 		if(flag_t.alarm_sensor_status&&ControlData()&&flag_t.first_start)
MOVW	R0, #lo_addr(_flag_t+23)
MOVT	R0, #hi_addr(_flag_t+23)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L__Calibrate151
BL	_ControlData+0
CMP	R0, #0
IT	EQ
BLEQ	L__Calibrate150
MOVW	R0, #lo_addr(_flag_t+22)
MOVT	R0, #hi_addr(_flag_t+22)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L__Calibrate149
L__Calibrate141:
;adc_func.c,269 :: 		if((control_rf_count++)>=RF_DELAY)
MOVW	R2, #lo_addr(Calibrate_control_rf_count_L0+0)
MOVT	R2, #hi_addr(Calibrate_control_rf_count_L0+0)
LDRH	R1, [R2, #0]
MOV	R0, R2
LDRH	R0, [R0, #0]
ADDS	R0, #1
STRH	R0, [R2, #0]
CMP	R1, #25
IT	CC
BLCC	L_Calibrate59
;adc_func.c,271 :: 		LED_GREEN^=1;
MOVW	R3, #lo_addr(LED_GREEN+0)
MOVT	R3, #hi_addr(LED_GREEN+0)
_LX	[R3, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
ANDS	R1, R0
LSRS	R1, R1, BitPos(LED_GREEN+0)
MOVS	R0, #1
EORS	R0, R1
UXTB	R2, R0
_LX	[R3, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
ANDS	R1, R2
BEQ	L__Calibrate182
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
ORRS	R0, R1
B	L__Calibrate181
L__Calibrate182:
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
BICS	R0, R1
L__Calibrate181:
_SX	[R3, ByteOffset(LED_GREEN+0)]
;adc_func.c,272 :: 		LED_RED^=1;
MOVW	R3, #lo_addr(LED_RED+0)
MOVT	R3, #hi_addr(LED_RED+0)
_LX	[R3, ByteOffset(LED_RED+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
ANDS	R1, R0
LSRS	R1, R1, BitPos(LED_RED+0)
MOVS	R0, #1
EORS	R0, R1
UXTB	R2, R0
_LX	[R3, ByteOffset(LED_RED+0)]
MOVS	R1, #1
ANDS	R1, R2
BEQ	L__Calibrate184
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
ORRS	R0, R1
B	L__Calibrate183
L__Calibrate184:
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
BICS	R0, R1
L__Calibrate183:
_SX	[R3, ByteOffset(LED_RED+0)]
;adc_func.c,273 :: 		control_rf_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Calibrate_control_rf_count_L0+0)
MOVT	R0, #hi_addr(Calibrate_control_rf_count_L0+0)
STRH	R1, [R0, #0]
;adc_func.c,274 :: 		}
L_Calibrate59:
;adc_func.c,275 :: 		}
IT	AL
BLAL	L_Calibrate60
;adc_func.c,267 :: 		if(flag_t.alarm_sensor_status&&ControlData()&&flag_t.first_start)
L__Calibrate151:
L__Calibrate150:
L__Calibrate149:
;adc_func.c,278 :: 		LED_GREEN = ON;
MOVW	R2, #lo_addr(LED_GREEN+0)
MOVT	R2, #hi_addr(LED_GREEN+0)
_LX	[R2, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_GREEN+0)]
;adc_func.c,279 :: 		LED_RED   = ON;
MOVW	R2, #lo_addr(LED_RED+0)
MOVT	R2, #hi_addr(LED_RED+0)
_LX	[R2, ByteOffset(LED_RED+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_RED+0)]
;adc_func.c,280 :: 		}
L_Calibrate60:
;adc_func.c,282 :: 		if((cal_count++)>V0_CAL_TIME)
MOVW	R2, #lo_addr(Calibrate_cal_count_L0+0)
MOVT	R2, #hi_addr(Calibrate_cal_count_L0+0)
LDRH	R1, [R2, #0]
MOV	R0, R2
LDRH	R0, [R0, #0]
ADDS	R0, #1
STRH	R0, [R2, #0]
MOVW	R0, #1000
MOVT	R0, #0
CMP	R1, R0
IT	LS
BLLS	L_Calibrate61
;adc_func.c,284 :: 		cal_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Calibrate_cal_count_L0+0)
MOVT	R0, #hi_addr(Calibrate_cal_count_L0+0)
STRH	R1, [R0, #0]
;adc_func.c,285 :: 		BoardSensorR0    = BoardSensorValue;
MOVW	R0, 536870912
MOVT	R0, 8192
LDR	R1, [R0, #0]
MOVW	R0, 536870936
MOVT	R0, 8192
STR	R1, [R0, #0]
;adc_func.c,286 :: 		ForwardSensorR0  = ForwardSensorValue;
MOVW	R0, 536870916
MOVT	R0, 8192
LDR	R1, [R0, #0]
MOVW	R0, 536870940
MOVT	R0, 8192
STR	R1, [R0, #0]
;adc_func.c,287 :: 		BackwardSensorR0 = BackwardSensorValue;
MOVW	R0, 536870920
MOVT	R0, 8192
LDR	R1, [R0, #0]
MOVW	R0, 536870944
MOVT	R0, 8192
STR	R1, [R0, #0]
;adc_func.c,289 :: 		board_sens_temp    = parameters_t.board_sensor_v0_cal_data;
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
LDRH	R0, [R0, #0]
STR	R0, [SP, #0]
;adc_func.c,290 :: 		forward_sens_temp  = parameters_t.forward_sensor_v0_cal_data;
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
LDRH	R0, [R0, #0]
STR	R0, [SP, #4]
;adc_func.c,291 :: 		backward_sens_temp = parameters_t.backward_sensor_v0_cal_data;
MOVW	R0, #lo_addr(_parameters_t+2)
MOVT	R0, #hi_addr(_parameters_t+2)
LDRH	R0, [R0, #0]
STR	R0, [SP, #8]
;adc_func.c,293 :: 		if(!flag_t.alarm_sensor_status)
MOVW	R0, #lo_addr(_flag_t+23)
MOVT	R0, #hi_addr(_flag_t+23)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_Calibrate62
;adc_func.c,295 :: 		parameters_t.forward_sensor_v0_cal_data  = (unsigned int)ForwardSensorValue;
MOVW	R0, 536870916
MOVT	R0, 8192
LDR	R0, [R0, #0]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_parameters_t+0)
MOVT	R1, #hi_addr(_parameters_t+0)
STRH	R0, [R1, #0]
;adc_func.c,296 :: 		parameters_t.board_sensor_v0_cal_data    = (unsigned int)BoardSensorValue;
MOVW	R0, 536870912
MOVT	R0, 8192
LDR	R0, [R0, #0]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_parameters_t+4)
MOVT	R1, #hi_addr(_parameters_t+4)
STRH	R0, [R1, #0]
;adc_func.c,297 :: 		parameters_t.backward_sensor_v0_cal_data = (unsigned int)BackwardSensorValue;
MOVW	R0, 536870920
MOVT	R0, 8192
LDR	R0, [R0, #0]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_parameters_t+2)
MOVT	R1, #hi_addr(_parameters_t+2)
STRH	R0, [R1, #0]
;adc_func.c,298 :: 		}
L_Calibrate62:
;adc_func.c,299 :: 		parameters_t.board_sensor_koef    = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_parameters_t+18)
MOVT	R0, #hi_addr(_parameters_t+18)
STRH	R1, [R0, #0]
;adc_func.c,300 :: 		parameters_t.forward_sensor_koef  = 100;//(unsigned int)(((double)BoardSensorValue/(double)ForwardSensorValue)*100.0);
MOVS	R1, #100
MOVW	R0, #lo_addr(_parameters_t+20)
MOVT	R0, #hi_addr(_parameters_t+20)
STRH	R1, [R0, #0]
;adc_func.c,301 :: 		parameters_t.backward_sensor_koef = 100;//(unsigned int)(((double)BoardSensorValue/(double)BackwardSensorValue)*100.0);
MOVS	R1, #100
MOVW	R0, #lo_addr(_parameters_t+22)
MOVT	R0, #hi_addr(_parameters_t+22)
STRH	R1, [R0, #0]
;adc_func.c,303 :: 		if(!flag_t.alarm_sensor_status)
MOVW	R0, #lo_addr(_flag_t+23)
MOVT	R0, #hi_addr(_flag_t+23)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_Calibrate63
;adc_func.c,305 :: 		ControlVs(&parameters_t.board_sensor_v0_cal_data,&board_sens_temp,
MOV	R0, SP
;adc_func.c,306 :: 		&parameters_t.board_sensor_cal_data,&flag_t.calibrate_status);
MOVW	R3, #lo_addr(_flag_t+12)
MOVT	R3, #hi_addr(_flag_t+12)
MOVW	R2, #lo_addr(_parameters_t+10)
MOVT	R2, #hi_addr(_parameters_t+10)
;adc_func.c,305 :: 		ControlVs(&parameters_t.board_sensor_v0_cal_data,&board_sens_temp,
MOV	R1, R0
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
;adc_func.c,306 :: 		&parameters_t.board_sensor_cal_data,&flag_t.calibrate_status);
BL	_ControlVs+0
;adc_func.c,308 :: 		ControlVs(&parameters_t.forward_sensor_v0_cal_data,&forward_sens_temp,
MOVS	R0, #4
ADD	R0, SP, R0
;adc_func.c,309 :: 		&parameters_t.forward_sensor_cal_data,&flag_t.calibrate_status);
MOVW	R3, #lo_addr(_flag_t+12)
MOVT	R3, #hi_addr(_flag_t+12)
MOVW	R2, #lo_addr(_parameters_t+6)
MOVT	R2, #hi_addr(_parameters_t+6)
;adc_func.c,308 :: 		ControlVs(&parameters_t.forward_sensor_v0_cal_data,&forward_sens_temp,
MOV	R1, R0
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
;adc_func.c,309 :: 		&parameters_t.forward_sensor_cal_data,&flag_t.calibrate_status);
BL	_ControlVs+0
;adc_func.c,311 :: 		ControlVs(&parameters_t.backward_sensor_v0_cal_data,&backward_sens_temp,
MOVS	R0, #8
ADD	R0, SP, R0
;adc_func.c,312 :: 		&parameters_t.backward_sensor_cal_data,&flag_t.calibrate_status);
MOVW	R3, #lo_addr(_flag_t+12)
MOVT	R3, #hi_addr(_flag_t+12)
MOVW	R2, #lo_addr(_parameters_t+8)
MOVT	R2, #hi_addr(_parameters_t+8)
;adc_func.c,311 :: 		ControlVs(&parameters_t.backward_sensor_v0_cal_data,&backward_sens_temp,
MOV	R1, R0
MOVW	R0, #lo_addr(_parameters_t+2)
MOVT	R0, #hi_addr(_parameters_t+2)
;adc_func.c,312 :: 		&parameters_t.backward_sensor_cal_data,&flag_t.calibrate_status);
BL	_ControlVs+0
;adc_func.c,314 :: 		}
L_Calibrate63:
;adc_func.c,316 :: 		flag_t.alarm_sensor_status = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+23)
MOVT	R0, #hi_addr(_flag_t+23)
STRB	R1, [R0, #0]
;adc_func.c,317 :: 		flag_t.first_start = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+22)
MOVT	R0, #hi_addr(_flag_t+22)
STRB	R1, [R0, #0]
;adc_func.c,319 :: 		resetLB();
BL	_resetLB+0
;adc_func.c,320 :: 		if(flag_t.calibrate_status)
MOVW	R0, #lo_addr(_flag_t+12)
MOVT	R0, #hi_addr(_flag_t+12)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_Calibrate64
;adc_func.c,322 :: 		if(flag_t.recalibrate)
MOVW	R0, #lo_addr(_flag_t+13)
MOVT	R0, #hi_addr(_flag_t+13)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_Calibrate65
;adc_func.c,324 :: 		flag_t.recalibrate = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+13)
MOVT	R0, #hi_addr(_flag_t+13)
STRB	R1, [R0, #0]
;adc_func.c,325 :: 		setState(process);
MOVS	R0, #9
BL	_setState+0
;adc_func.c,326 :: 		}
IT	AL
BLAL	L_Calibrate66
L_Calibrate65:
;adc_func.c,329 :: 		setState(ready_alarm);
MOVS	R0, #7
BL	_setState+0
;adc_func.c,330 :: 		}
L_Calibrate66:
;adc_func.c,331 :: 		}
IT	AL
BLAL	L_Calibrate67
L_Calibrate64:
;adc_func.c,334 :: 		setState(calibration);
MOVS	R0, #4
BL	_setState+0
;adc_func.c,335 :: 		}
L_Calibrate67:
;adc_func.c,336 :: 		}
L_Calibrate61:
;adc_func.c,337 :: 		}
L_end_Calibrate:
ADD	SP, SP, #12
POP	(R15)
; end of _Calibrate
_ControlCalibrate:
;adc_func.c,339 :: 		void ControlCalibrate(long delay_sec)
; delay_sec start address is: 0 (R0)
PUSH	(R14)
MOV	R4, R0
; delay_sec end address is: 0 (R0)
; delay_sec start address is: 16 (R4)
;adc_func.c,344 :: 		if(getAdcStatus())
BL	_getAdcStatus+0
CMP	R0, #0
IT	EQ
BLEQ	L_ControlCalibrate68
;adc_func.c,346 :: 		start_delay_status = SET;
MOVS	R2, #1
MOVW	R1, #lo_addr(ControlCalibrate_start_delay_status_L0+0)
MOVT	R1, #hi_addr(ControlCalibrate_start_delay_status_L0+0)
STRB	R2, [R1, #0]
;adc_func.c,347 :: 		wait_count = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(ControlCalibrate_wait_count_L0+0)
MOVT	R1, #hi_addr(ControlCalibrate_wait_count_L0+0)
STR	R2, [R1, #0]
;adc_func.c,348 :: 		}
L_ControlCalibrate68:
;adc_func.c,349 :: 		if(start_delay_status)
MOVW	R1, #lo_addr(ControlCalibrate_start_delay_status_L0+0)
MOVT	R1, #hi_addr(ControlCalibrate_start_delay_status_L0+0)
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BLEQ	L_ControlCalibrate69
;adc_func.c,351 :: 		if((wait_count++)>= (delay_sec*100))
MOVW	R2, #lo_addr(ControlCalibrate_wait_count_L0+0)
MOVT	R2, #hi_addr(ControlCalibrate_wait_count_L0+0)
LDR	R3, [R2, #0]
MOV	R1, R2
LDR	R1, [R1, #0]
ADDS	R1, #1
STR	R1, [R2, #0]
MOVS	R2, #100
MOV	R1, R2
MULS	R1, R4, R1
; delay_sec end address is: 16 (R4)
CMP	R3, R1
IT	LT
BLLT	L_ControlCalibrate70
;adc_func.c,353 :: 		if(getRcalAdcStatus())
BL	_getRcalAdcStatus+0
CMP	R0, #0
IT	EQ
BLEQ	L_ControlCalibrate71
;adc_func.c,355 :: 		wait_count = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(ControlCalibrate_wait_count_L0+0)
MOVT	R1, #hi_addr(ControlCalibrate_wait_count_L0+0)
STR	R2, [R1, #0]
;adc_func.c,356 :: 		}
IT	AL
BLAL	L_ControlCalibrate72
L_ControlCalibrate71:
;adc_func.c,359 :: 		wait_count = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(ControlCalibrate_wait_count_L0+0)
MOVT	R1, #hi_addr(ControlCalibrate_wait_count_L0+0)
STR	R2, [R1, #0]
;adc_func.c,360 :: 		start_delay_status = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(ControlCalibrate_start_delay_status_L0+0)
MOVT	R1, #hi_addr(ControlCalibrate_start_delay_status_L0+0)
STRB	R2, [R1, #0]
;adc_func.c,361 :: 		flag_t.calibrate_status = SET;
MOVS	R2, #1
MOVW	R1, #lo_addr(_flag_t+12)
MOVT	R1, #hi_addr(_flag_t+12)
STRB	R2, [R1, #0]
;adc_func.c,362 :: 		flag_t.recalibrate = SET;
MOVS	R2, #1
MOVW	R1, #lo_addr(_flag_t+13)
MOVT	R1, #hi_addr(_flag_t+13)
STRB	R2, [R1, #0]
;adc_func.c,363 :: 		resetLB();
BL	_resetLB+0
;adc_func.c,364 :: 		Recalibrate();
BL	_Recalibrate+0
;adc_func.c,365 :: 		}
L_ControlCalibrate72:
;adc_func.c,366 :: 		}
L_ControlCalibrate70:
;adc_func.c,367 :: 		}
L_ControlCalibrate69:
;adc_func.c,368 :: 		}
L_end_ControlCalibrate:
POP	(R15)
; end of _ControlCalibrate
_getRcalAdcStatus:
;adc_func.c,370 :: 		unsigned char getRcalAdcStatus()
PUSH	(R14)
;adc_func.c,372 :: 		return  (flag_t.board_cal_status||flag_t.forward_cal_status||flag_t.backward_cal_status);
MOVW	R0, #lo_addr(_flag_t+14)
MOVT	R0, #hi_addr(_flag_t+14)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_getRcalAdcStatus74
MOVW	R0, #lo_addr(_flag_t+15)
MOVT	R0, #hi_addr(_flag_t+15)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_getRcalAdcStatus74
MOVW	R0, #lo_addr(_flag_t+16)
MOVT	R0, #hi_addr(_flag_t+16)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_getRcalAdcStatus74
MOVS	R0, #0
IT	AL
BLAL	L_getRcalAdcStatus73
L_getRcalAdcStatus74:
MOVS	R0, #1
L_getRcalAdcStatus73:
;adc_func.c,373 :: 		}
L_end_getRcalAdcStatus:
POP	(R15)
; end of _getRcalAdcStatus
_ControlRecalFlags:
;adc_func.c,375 :: 		void ControlRecalFlags()
PUSH	(R14)
;adc_func.c,381 :: 		if(ControlData())
BL	_ControlData+0
CMP	R0, #0
IT	EQ
BLEQ	L_ControlRecalFlags75
;adc_func.c,385 :: 		&board_cal_count,&board_cal_count1);
MOVW	R5, #lo_addr(ControlRecalFlags_board_cal_count1_L0+0)
MOVT	R5, #hi_addr(ControlRecalFlags_board_cal_count1_L0+0)
MOVW	R4, #lo_addr(ControlRecalFlags_board_cal_count_L0+0)
MOVT	R4, #hi_addr(ControlRecalFlags_board_cal_count_L0+0)
;adc_func.c,384 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.board_cal_status,
MOVW	R3, #lo_addr(_flag_t+14)
MOVT	R3, #hi_addr(_flag_t+14)
MOVS	R2, #10
MOVW	R1, #1000
MOVT	R1, #0
;adc_func.c,383 :: 		one_level_comparator_ms(ALARM_LEVEL/4.0,BoardSensorPPM,ANALOG_GISTERESIS,
MOVW	R0, 536870924
MOVT	R0, 8192
LDR	R0, [R0, #0]
;adc_func.c,385 :: 		&board_cal_count,&board_cal_count1);
PUSH	(R5)
PUSH	(R4)
;adc_func.c,384 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.board_cal_status,
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
MOVW	R3, #1000
MOVT	R3, #0
;adc_func.c,383 :: 		one_level_comparator_ms(ALARM_LEVEL/4.0,BoardSensorPPM,ANALOG_GISTERESIS,
MOVW	R2, #0
MOVT	R2, #17224
MOV	R1, R0
MOVW	R0, #0
MOVT	R0, #17658
;adc_func.c,385 :: 		&board_cal_count,&board_cal_count1);
;adc_func.c,384 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.board_cal_status,
;adc_func.c,385 :: 		&board_cal_count,&board_cal_count1);
BL	_one_level_comparator_ms+0
ADD	SP, SP, #20
;adc_func.c,389 :: 		&forward_cal_count,&forward_cal_count1);
MOVW	R5, #lo_addr(ControlRecalFlags_forward_cal_count1_L0+0)
MOVT	R5, #hi_addr(ControlRecalFlags_forward_cal_count1_L0+0)
MOVW	R4, #lo_addr(ControlRecalFlags_forward_cal_count_L0+0)
MOVT	R4, #hi_addr(ControlRecalFlags_forward_cal_count_L0+0)
;adc_func.c,388 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.forward_cal_status,
MOVW	R3, #lo_addr(_flag_t+15)
MOVT	R3, #hi_addr(_flag_t+15)
MOVS	R2, #10
MOVW	R1, #1000
MOVT	R1, #0
;adc_func.c,387 :: 		one_level_comparator_ms(ALARM_LEVEL/4.0,ForwardSensorPPM,ANALOG_GISTERESIS,
MOVW	R0, 536870928
MOVT	R0, 8192
LDR	R0, [R0, #0]
;adc_func.c,389 :: 		&forward_cal_count,&forward_cal_count1);
PUSH	(R5)
PUSH	(R4)
;adc_func.c,388 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.forward_cal_status,
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
MOVW	R3, #1000
MOVT	R3, #0
;adc_func.c,387 :: 		one_level_comparator_ms(ALARM_LEVEL/4.0,ForwardSensorPPM,ANALOG_GISTERESIS,
MOVW	R2, #0
MOVT	R2, #17224
MOV	R1, R0
MOVW	R0, #0
MOVT	R0, #17658
;adc_func.c,389 :: 		&forward_cal_count,&forward_cal_count1);
;adc_func.c,388 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.forward_cal_status,
;adc_func.c,389 :: 		&forward_cal_count,&forward_cal_count1);
BL	_one_level_comparator_ms+0
ADD	SP, SP, #20
;adc_func.c,393 :: 		&backward_cal_count,&backward_cal_count1);
MOVW	R5, #lo_addr(ControlRecalFlags_backward_cal_count1_L0+0)
MOVT	R5, #hi_addr(ControlRecalFlags_backward_cal_count1_L0+0)
MOVW	R4, #lo_addr(ControlRecalFlags_backward_cal_count_L0+0)
MOVT	R4, #hi_addr(ControlRecalFlags_backward_cal_count_L0+0)
;adc_func.c,392 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.backward_cal_status,
MOVW	R3, #lo_addr(_flag_t+16)
MOVT	R3, #hi_addr(_flag_t+16)
MOVS	R2, #10
MOVW	R1, #1000
MOVT	R1, #0
;adc_func.c,391 :: 		one_level_comparator_ms(ALARM_LEVEL/4.0,BackwardSensorPPM,ANALOG_GISTERESIS,
MOVW	R0, 536870932
MOVT	R0, 8192
LDR	R0, [R0, #0]
;adc_func.c,393 :: 		&backward_cal_count,&backward_cal_count1);
PUSH	(R5)
PUSH	(R4)
;adc_func.c,392 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.backward_cal_status,
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
MOVW	R3, #1000
MOVT	R3, #0
;adc_func.c,391 :: 		one_level_comparator_ms(ALARM_LEVEL/4.0,BackwardSensorPPM,ANALOG_GISTERESIS,
MOVW	R2, #0
MOVT	R2, #17224
MOV	R1, R0
MOVW	R0, #0
MOVT	R0, #17658
;adc_func.c,393 :: 		&backward_cal_count,&backward_cal_count1);
;adc_func.c,392 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.backward_cal_status,
;adc_func.c,393 :: 		&backward_cal_count,&backward_cal_count1);
BL	_one_level_comparator_ms+0
ADD	SP, SP, #20
;adc_func.c,394 :: 		}
L_ControlRecalFlags75:
;adc_func.c,395 :: 		}
L_end_ControlRecalFlags:
POP	(R15)
; end of _ControlRecalFlags
_RestartCalibration:
;adc_func.c,397 :: 		void RestartCalibration(unsigned long delay_rcal)
; delay_rcal start address is: 0 (R0)
PUSH	(R14)
MOV	R4, R0
; delay_rcal end address is: 0 (R0)
; delay_rcal start address is: 16 (R4)
;adc_func.c,401 :: 		if(!getRcalAdcStatus())
BL	_getRcalAdcStatus+0
CMP	R0, #0
IT	NE
BLNE	L_RestartCalibration76
;adc_func.c,403 :: 		if(!rcal_status)
MOVW	R1, #lo_addr(RestartCalibration_rcal_status_L0+0)
MOVT	R1, #hi_addr(RestartCalibration_rcal_status_L0+0)
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	NE
BLNE	L_RestartCalibration77
;adc_func.c,405 :: 		if((wait_rcal_count++)>= (delay_rcal*100))
MOVW	R2, #lo_addr(RestartCalibration_wait_rcal_count_L0+0)
MOVT	R2, #hi_addr(RestartCalibration_wait_rcal_count_L0+0)
LDR	R3, [R2, #0]
MOV	R1, R2
LDR	R1, [R1, #0]
ADDS	R1, #1
STR	R1, [R2, #0]
MOVS	R2, #100
MOV	R1, R2
MULS	R1, R4, R1
; delay_rcal end address is: 16 (R4)
CMP	R3, R1
IT	CC
BLCC	L_RestartCalibration78
;adc_func.c,407 :: 		wait_rcal_count = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(RestartCalibration_wait_rcal_count_L0+0)
MOVT	R1, #hi_addr(RestartCalibration_wait_rcal_count_L0+0)
STR	R2, [R1, #0]
;adc_func.c,408 :: 		rcal_status = SET;
MOVS	R2, #1
MOVW	R1, #lo_addr(RestartCalibration_rcal_status_L0+0)
MOVT	R1, #hi_addr(RestartCalibration_rcal_status_L0+0)
STRB	R2, [R1, #0]
;adc_func.c,409 :: 		flag_t.calibrate_status = SET;
MOVS	R2, #1
MOVW	R1, #lo_addr(_flag_t+12)
MOVT	R1, #hi_addr(_flag_t+12)
STRB	R2, [R1, #0]
;adc_func.c,410 :: 		flag_t.recalibrate = SET;
MOVS	R2, #1
MOVW	R1, #lo_addr(_flag_t+13)
MOVT	R1, #hi_addr(_flag_t+13)
STRB	R2, [R1, #0]
;adc_func.c,411 :: 		resetLB();
BL	_resetLB+0
;adc_func.c,412 :: 		Recalibrate();
BL	_Recalibrate+0
;adc_func.c,413 :: 		}
L_RestartCalibration78:
;adc_func.c,414 :: 		}
L_RestartCalibration77:
;adc_func.c,415 :: 		}
IT	AL
BLAL	L_RestartCalibration79
L_RestartCalibration76:
;adc_func.c,418 :: 		wait_rcal_count = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(RestartCalibration_wait_rcal_count_L0+0)
MOVT	R1, #hi_addr(RestartCalibration_wait_rcal_count_L0+0)
STR	R2, [R1, #0]
;adc_func.c,419 :: 		rcal_status = SET;
MOVS	R2, #1
MOVW	R1, #lo_addr(RestartCalibration_rcal_status_L0+0)
MOVT	R1, #hi_addr(RestartCalibration_rcal_status_L0+0)
STRB	R2, [R1, #0]
;adc_func.c,420 :: 		}
L_RestartCalibration79:
;adc_func.c,421 :: 		}
L_end_RestartCalibration:
POP	(R15)
; end of _RestartCalibration
_CalculateVsense:
;adc_func.c,427 :: 		void CalculateVsense(float* sense_adc_value,unsigned int time,float* out_value)
; out_value start address is: 8 (R2)
; time start address is: 4 (R1)
; sense_adc_value start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #8
; out_value end address is: 8 (R2)
; time end address is: 4 (R1)
; sense_adc_value end address is: 0 (R0)
; sense_adc_value start address is: 0 (R0)
; time start address is: 4 (R1)
; out_value start address is: 8 (R2)
;adc_func.c,430 :: 		unsigned char i = 0;
;adc_func.c,433 :: 		if((sec_vs_count++)>=time)
MOVW	R5, #lo_addr(CalculateVsense_sec_vs_count_L0+0)
MOVT	R5, #hi_addr(CalculateVsense_sec_vs_count_L0+0)
LDRH	R4, [R5, #0]
MOV	R3, R5
LDRH	R3, [R3, #0]
ADDS	R3, #1
STRH	R3, [R5, #0]
CMP	R4, R1
IT	CC
BLCC	L_CalculateVsense80
; time end address is: 4 (R1)
;adc_func.c,435 :: 		sec_vs_count = 0;
MOVS	R4, #0
MOVW	R3, #lo_addr(CalculateVsense_sec_vs_count_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_sec_vs_count_L0+0)
STRH	R4, [R3, #0]
;adc_func.c,436 :: 		if(vs_count<MAX_AVG)
MOVW	R3, #lo_addr(CalculateVsense_vs_count_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_vs_count_L0+0)
LDRH	R3, [R3, #0]
CMP	R3, #100
IT	CS
BLCS	L_CalculateVsense81
; out_value end address is: 8 (R2)
;adc_func.c,438 :: 		VsenseArray[vs_count] = 0;
MOVW	R5, #lo_addr(CalculateVsense_vs_count_L0+0)
MOVT	R5, #hi_addr(CalculateVsense_vs_count_L0+0)
LDRH	R3, [R5, #0]
LSLS	R4, R3, #2
MOVW	R3, #lo_addr(_VsenseArray+0)
MOVT	R3, #hi_addr(_VsenseArray+0)
ADDS	R4, R3, R4
MOVS	R3, #0
STR	R3, [R4, #0]
;adc_func.c,439 :: 		VsenseArray[vs_count++] = *sense_adc_value;
MOV	R3, R5
LDRH	R3, [R3, #0]
LSLS	R4, R3, #2
MOVW	R3, #lo_addr(_VsenseArray+0)
MOVT	R3, #hi_addr(_VsenseArray+0)
ADDS	R4, R3, R4
LDR	R3, [R0, #0]
; sense_adc_value end address is: 0 (R0)
STR	R3, [R4, #0]
MOV	R3, R5
LDRH	R3, [R3, #0]
ADDS	R3, #1
STRH	R3, [R5, #0]
;adc_func.c,440 :: 		}
IT	AL
BLAL	L_CalculateVsense82
L_CalculateVsense81:
;adc_func.c,443 :: 		vs_count = 0;
; out_value start address is: 8 (R2)
MOVS	R4, #0
MOVW	R3, #lo_addr(CalculateVsense_vs_count_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_vs_count_L0+0)
STRH	R4, [R3, #0]
;adc_func.c,444 :: 		max = VsenseArray[0];
MOVW	R3, #lo_addr(_VsenseArray+0)
MOVT	R3, #hi_addr(_VsenseArray+0)
LDR	R4, [R3, #0]
MOVW	R3, #lo_addr(CalculateVsense_max_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_max_L0+0)
STR	R4, [R3, #0]
;adc_func.c,445 :: 		for (i = 0; i < MAX_AVG; i++)
; i start address is: 24 (R6)
MOVS	R6, #0
; out_value end address is: 8 (R2)
; i end address is: 24 (R6)
MOV	R5, R2
L_CalculateVsense83:
; i start address is: 24 (R6)
; out_value start address is: 20 (R5)
CMP	R6, #100
IT	CS
BLCS	L_CalculateVsense84
;adc_func.c,447 :: 		if (VsenseArray[i] > max) {
LSLS	R4, R6, #2
MOVW	R3, #lo_addr(_VsenseArray+0)
MOVT	R3, #hi_addr(_VsenseArray+0)
ADDS	R3, R3, R4
LDR	R2, [R3, #0]
MOVW	R3, #lo_addr(CalculateVsense_max_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_max_L0+0)
LDR	R0, [R3, #0]
BL	__Compare_FP+0
BGE	L__CalculateVsense190
MOVS	R0, #1
B	L__CalculateVsense191
L__CalculateVsense190:
MOVS	R0, #0
L__CalculateVsense191:
CMP	R0, #0
IT	EQ
BLEQ	L_CalculateVsense86
;adc_func.c,448 :: 		max = VsenseArray[i];
LSLS	R4, R6, #2
MOVW	R3, #lo_addr(_VsenseArray+0)
MOVT	R3, #hi_addr(_VsenseArray+0)
ADDS	R3, R3, R4
LDR	R4, [R3, #0]
MOVW	R3, #lo_addr(CalculateVsense_max_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_max_L0+0)
STR	R4, [R3, #0]
;adc_func.c,449 :: 		}
L_CalculateVsense86:
;adc_func.c,445 :: 		for (i = 0; i < MAX_AVG; i++)
ADDS	R6, #1
UXTB	R6, R6
;adc_func.c,450 :: 		}
; i end address is: 24 (R6)
IT	AL
BLAL	L_CalculateVsense83
L_CalculateVsense84:
;adc_func.c,451 :: 		min = VsenseArray[0];
MOVW	R3, #lo_addr(_VsenseArray+0)
MOVT	R3, #hi_addr(_VsenseArray+0)
LDR	R4, [R3, #0]
MOVW	R3, #lo_addr(CalculateVsense_min_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_min_L0+0)
STR	R4, [R3, #0]
;adc_func.c,452 :: 		for (i = 0; i < MAX_AVG; i++)
; i start address is: 24 (R6)
MOVS	R6, #0
; out_value end address is: 20 (R5)
; i end address is: 24 (R6)
L_CalculateVsense87:
; i start address is: 24 (R6)
; out_value start address is: 20 (R5)
CMP	R6, #100
IT	CS
BLCS	L_CalculateVsense88
;adc_func.c,454 :: 		if (VsenseArray[i] < min) {
LSLS	R4, R6, #2
MOVW	R3, #lo_addr(_VsenseArray+0)
MOVT	R3, #hi_addr(_VsenseArray+0)
ADDS	R3, R3, R4
LDR	R2, [R3, #0]
MOVW	R3, #lo_addr(CalculateVsense_min_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_min_L0+0)
LDR	R0, [R3, #0]
BL	__Compare_FP+0
BLE	L__CalculateVsense192
MOVS	R0, #1
B	L__CalculateVsense193
L__CalculateVsense192:
MOVS	R0, #0
L__CalculateVsense193:
CMP	R0, #0
IT	EQ
BLEQ	L_CalculateVsense90
;adc_func.c,455 :: 		min = VsenseArray[i];
LSLS	R4, R6, #2
MOVW	R3, #lo_addr(_VsenseArray+0)
MOVT	R3, #hi_addr(_VsenseArray+0)
ADDS	R3, R3, R4
LDR	R4, [R3, #0]
MOVW	R3, #lo_addr(CalculateVsense_min_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_min_L0+0)
STR	R4, [R3, #0]
;adc_func.c,456 :: 		}
L_CalculateVsense90:
;adc_func.c,452 :: 		for (i = 0; i < MAX_AVG; i++)
ADDS	R6, #1
UXTB	R6, R6
;adc_func.c,457 :: 		}
; i end address is: 24 (R6)
IT	AL
BLAL	L_CalculateVsense87
L_CalculateVsense88:
;adc_func.c,458 :: 		if(calc_max < MAX_MAX)
MOVW	R3, #lo_addr(CalculateVsense_calc_max_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_calc_max_L0+0)
LDRB	R3, [R3, #0]
CMP	R3, #20
IT	CS
BLCS	L_CalculateVsense91
; out_value end address is: 20 (R5)
;adc_func.c,460 :: 		VsenseMax[calc_max] = 0;
MOVW	R5, #lo_addr(CalculateVsense_calc_max_L0+0)
MOVT	R5, #hi_addr(CalculateVsense_calc_max_L0+0)
STR	R5, [SP, #4]
LDRB	R3, [R5, #0]
LSLS	R4, R3, #2
MOVW	R3, #lo_addr(_VsenseMax+0)
MOVT	R3, #hi_addr(_VsenseMax+0)
ADDS	R4, R3, R4
MOVS	R3, #0
STR	R3, [R4, #0]
;adc_func.c,461 :: 		VsenseMax[calc_max++] = max - min;
MOV	R3, R5
LDRB	R3, [R3, #0]
LSLS	R4, R3, #2
MOVW	R3, #lo_addr(_VsenseMax+0)
MOVT	R3, #hi_addr(_VsenseMax+0)
ADDS	R3, R3, R4
STR	R3, [SP, #0]
MOVW	R3, #lo_addr(CalculateVsense_min_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_min_L0+0)
LDR	R2, [R3, #0]
MOVW	R3, #lo_addr(CalculateVsense_max_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_max_L0+0)
LDR	R0, [R3, #0]
BL	__Sub_FP+0
LDR	R3, [SP, #0]
STR	R0, [R3, #0]
LDR	R4, [SP, #4]
MOV	R3, R4
LDRB	R3, [R3, #0]
ADDS	R3, #1
STRB	R3, [R4, #0]
;adc_func.c,462 :: 		}
IT	AL
BLAL	L_CalculateVsense92
L_CalculateVsense91:
;adc_func.c,465 :: 		calc_max = 0;
; out_value start address is: 20 (R5)
MOVS	R4, #0
MOVW	R3, #lo_addr(CalculateVsense_calc_max_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_calc_max_L0+0)
STRB	R4, [R3, #0]
;adc_func.c,466 :: 		calc_max_value = VsenseMax[0];
MOVW	R3, #lo_addr(_VsenseMax+0)
MOVT	R3, #hi_addr(_VsenseMax+0)
LDR	R4, [R3, #0]
MOVW	R3, #lo_addr(CalculateVsense_calc_max_value_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_calc_max_value_L0+0)
STR	R4, [R3, #0]
;adc_func.c,467 :: 		for (i = 0; i < MAX_MAX; i++)
; i start address is: 24 (R6)
MOVS	R6, #0
; out_value end address is: 20 (R5)
; i end address is: 24 (R6)
L_CalculateVsense93:
; i start address is: 24 (R6)
; out_value start address is: 20 (R5)
CMP	R6, #20
IT	CS
BLCS	L_CalculateVsense94
;adc_func.c,469 :: 		if (VsenseMax[i] > calc_max_value) {
LSLS	R4, R6, #2
MOVW	R3, #lo_addr(_VsenseMax+0)
MOVT	R3, #hi_addr(_VsenseMax+0)
ADDS	R3, R3, R4
LDR	R2, [R3, #0]
MOVW	R3, #lo_addr(CalculateVsense_calc_max_value_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_calc_max_value_L0+0)
LDR	R0, [R3, #0]
BL	__Compare_FP+0
BGE	L__CalculateVsense194
MOVS	R0, #1
B	L__CalculateVsense195
L__CalculateVsense194:
MOVS	R0, #0
L__CalculateVsense195:
CMP	R0, #0
IT	EQ
BLEQ	L_CalculateVsense96
;adc_func.c,470 :: 		calc_max_value = VsenseMax[i];
LSLS	R4, R6, #2
MOVW	R3, #lo_addr(_VsenseMax+0)
MOVT	R3, #hi_addr(_VsenseMax+0)
ADDS	R3, R3, R4
LDR	R4, [R3, #0]
MOVW	R3, #lo_addr(CalculateVsense_calc_max_value_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_calc_max_value_L0+0)
STR	R4, [R3, #0]
;adc_func.c,471 :: 		}
L_CalculateVsense96:
;adc_func.c,467 :: 		for (i = 0; i < MAX_MAX; i++)
ADDS	R6, #1
UXTB	R6, R6
;adc_func.c,473 :: 		}
; i end address is: 24 (R6)
IT	AL
BLAL	L_CalculateVsense93
L_CalculateVsense94:
;adc_func.c,474 :: 		*out_value = calc_max_value;
MOVW	R3, #lo_addr(CalculateVsense_calc_max_value_L0+0)
MOVT	R3, #hi_addr(CalculateVsense_calc_max_value_L0+0)
LDR	R3, [R3, #0]
STR	R3, [R5, #0]
; out_value end address is: 20 (R5)
;adc_func.c,475 :: 		}
L_CalculateVsense92:
;adc_func.c,476 :: 		}
L_CalculateVsense82:
;adc_func.c,477 :: 		}
L_CalculateVsense80:
;adc_func.c,479 :: 		}
L_end_CalculateVsense:
ADD	SP, SP, #8
POP	(R15)
; end of _CalculateVsense
_Read_ADC_sample:
;adc_func.c,481 :: 		unsigned int Read_ADC_sample(unsigned char chanell)
; chanell start address is: 0 (R0)
PUSH	(R14)
; chanell end address is: 0 (R0)
; chanell start address is: 0 (R0)
;adc_func.c,489 :: 		switch(chanell)
IT	AL
BLAL	L_Read_ADC_sample97
; chanell end address is: 0 (R0)
;adc_func.c,491 :: 		case 0:           ADC_CHSELR = ADC_CHSELR_CHSEL0;                    break;
L_Read_ADC_sample99:
MOVS	R2, #1
MOVW	R1, 1073816616
MOVT	R1, 16385
STR	R2, [R1, #0]
IT	AL
BLAL	L_Read_ADC_sample98
;adc_func.c,492 :: 		case 1:           ADC_CHSELR = ADC_CHSELR_CHSEL1;                    break;
L_Read_ADC_sample100:
MOVS	R2, #2
MOVW	R1, 1073816616
MOVT	R1, 16385
STR	R2, [R1, #0]
IT	AL
BLAL	L_Read_ADC_sample98
;adc_func.c,493 :: 		case 2:           ADC_CHSELR = ADC_CHSELR_CHSEL2;                    break;
L_Read_ADC_sample101:
MOVS	R2, #4
MOVW	R1, 1073816616
MOVT	R1, 16385
STR	R2, [R1, #0]
IT	AL
BLAL	L_Read_ADC_sample98
;adc_func.c,494 :: 		case 3:           ADC_CHSELR = ADC_CHSELR_CHSEL3;                    break;
L_Read_ADC_sample102:
MOVS	R2, #8
MOVW	R1, 1073816616
MOVT	R1, 16385
STR	R2, [R1, #0]
IT	AL
BLAL	L_Read_ADC_sample98
;adc_func.c,495 :: 		case 4:           ADC_CHSELR = ADC_CHSELR_CHSEL4;                    break;
L_Read_ADC_sample103:
MOVS	R2, #16
MOVW	R1, 1073816616
MOVT	R1, 16385
STR	R2, [R1, #0]
IT	AL
BLAL	L_Read_ADC_sample98
;adc_func.c,496 :: 		case 16:          ADC_CHSELR = ADC_CHSELR_CHSEL16;                   break;
L_Read_ADC_sample104:
MOVW	R2, #0
MOVT	R2, #1
MOVW	R1, 1073816616
MOVT	R1, 16385
STR	R2, [R1, #0]
IT	AL
BLAL	L_Read_ADC_sample98
;adc_func.c,497 :: 		case 17:          ADC_CHSELR = ADC_CHSELR_CHSEL17;                   break;
L_Read_ADC_sample105:
MOVW	R2, #0
MOVT	R2, #2
MOVW	R1, 1073816616
MOVT	R1, 16385
STR	R2, [R1, #0]
IT	AL
BLAL	L_Read_ADC_sample98
;adc_func.c,498 :: 		}
L_Read_ADC_sample97:
; chanell start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BLEQ	L_Read_ADC_sample99
CMP	R0, #1
IT	EQ
BLEQ	L_Read_ADC_sample100
CMP	R0, #2
IT	EQ
BLEQ	L_Read_ADC_sample101
CMP	R0, #3
IT	EQ
BLEQ	L_Read_ADC_sample102
CMP	R0, #4
IT	EQ
BLEQ	L_Read_ADC_sample103
CMP	R0, #16
IT	EQ
BLEQ	L_Read_ADC_sample104
CMP	R0, #17
IT	EQ
BLEQ	L_Read_ADC_sample105
; chanell end address is: 0 (R0)
L_Read_ADC_sample98:
;adc_func.c,500 :: 		ADC_SMPR = ADC_SMPR_SMP_0 |ADC_SMPR_SMP_1 | ADC_SMPR_SMP_2; /* (3) */
MOVS	R2, #7
MOVW	R1, 1073816596
MOVT	R1, 16385
STR	R2, [R1, #0]
;adc_func.c,512 :: 		ADC_CR |= ADC_CR_ADSTART; /* Start the ADC conversion */
MOVW	R1, 1073816584
MOVT	R1, 16385
LDR	R2, [R1, #0]
MOVS	R1, #4
ORRS	R2, R1
MOVW	R1, 1073816584
MOVT	R1, 16385
STR	R2, [R1, #0]
;adc_func.c,513 :: 		while ((ADC_ISR & ADC_ISR_EOC) == 0 ) /* Wait end of conversion */
L_Read_ADC_sample106:
MOVW	R1, 1073816576
MOVT	R1, 16385
LDR	R2, [R1, #0]
MOVS	R1, #4
ANDS	R1, R2
CMP	R1, #0
IT	NE
BLNE	L_Read_ADC_sample107
;adc_func.c,516 :: 		}
IT	AL
BLAL	L_Read_ADC_sample106
L_Read_ADC_sample107:
;adc_func.c,517 :: 		return (unsigned int)ADC_DR; /* Store the ADC conversion result */
MOVW	R1, 1073816640
MOVT	R1, 16385
LDR	R1, [R1, #0]
UXTH	R0, R1
;adc_func.c,519 :: 		}
L_end_Read_ADC_sample:
POP	(R15)
; end of _Read_ADC_sample
_Read_ADC_chanell:
;adc_func.c,521 :: 		unsigned long Read_ADC_chanell(unsigned char chanell,unsigned int samples)
; samples start address is: 4 (R1)
; chanell start address is: 0 (R0)
PUSH	(R14)
; samples end address is: 4 (R1)
; chanell end address is: 0 (R0)
; chanell start address is: 0 (R0)
; samples start address is: 4 (R1)
;adc_func.c,523 :: 		unsigned long  temp = 0;
; temp start address is: 24 (R6)
MOVS	R6, #0
;adc_func.c,524 :: 		unsigned int i = 0;
;adc_func.c,525 :: 		for(i=0;i<samples;i++)
; i start address is: 20 (R5)
MOVS	R5, #0
; chanell end address is: 0 (R0)
; samples end address is: 4 (R1)
; temp end address is: 24 (R6)
; i end address is: 20 (R5)
UXTB	R4, R0
UXTH	R3, R1
L_Read_ADC_chanell108:
; i start address is: 20 (R5)
; chanell start address is: 16 (R4)
; temp start address is: 24 (R6)
; samples start address is: 12 (R3)
; chanell start address is: 16 (R4)
; chanell end address is: 16 (R4)
CMP	R5, R3
IT	CS
BLCS	L_Read_ADC_chanell109
; chanell end address is: 16 (R4)
;adc_func.c,527 :: 		temp+= (unsigned long)(Read_ADC_sample(chanell)>>2);
; chanell start address is: 16 (R4)
UXTB	R0, R4
BL	_Read_ADC_sample+0
LSRS	R2, R0, #2
UXTH	R2, R2
ADDS	R6, R6, R2
;adc_func.c,525 :: 		for(i=0;i<samples;i++)
ADDS	R5, #1
UXTH	R5, R5
;adc_func.c,529 :: 		}
; chanell end address is: 16 (R4)
; i end address is: 20 (R5)
IT	AL
BLAL	L_Read_ADC_chanell108
L_Read_ADC_chanell109:
;adc_func.c,530 :: 		return (unsigned long)(temp/samples);
UXTH	R2, R3
MOV	R0, R6
BL	__Div_32x32_U+0
; samples end address is: 12 (R3)
; temp end address is: 24 (R6)
;adc_func.c,531 :: 		}
L_end_Read_ADC_chanell:
POP	(R15)
; end of _Read_ADC_chanell
_ControlAnalogFlags:
;adc_func.c,534 :: 		void ControlAnalogFlags()
PUSH	(R14)
;adc_func.c,540 :: 		if(getAdcControlStatus())
BL	_getAdcControlStatus+0
CMP	R0, #0
IT	EQ
BLEQ	L_ControlAnalogFlags111
;adc_func.c,544 :: 		&board_sensor_count,&board_sensor_count1);
MOVW	R5, #lo_addr(ControlAnalogFlags_board_sensor_count1_L0+0)
MOVT	R5, #hi_addr(ControlAnalogFlags_board_sensor_count1_L0+0)
MOVW	R4, #lo_addr(ControlAnalogFlags_board_sensor_count_L0+0)
MOVT	R4, #hi_addr(ControlAnalogFlags_board_sensor_count_L0+0)
;adc_func.c,543 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.board_sensor_status,
MOVW	R3, #lo_addr(_flag_t+1)
MOVT	R3, #hi_addr(_flag_t+1)
MOVS	R2, #10
MOVW	R1, #1000
MOVT	R1, #0
;adc_func.c,542 :: 		one_level_comparator_ms(ALARM_LEVEL,BoardSensorPPM,ANALOG_GISTERESIS,
MOVW	R0, 536870924
MOVT	R0, 8192
LDR	R0, [R0, #0]
;adc_func.c,544 :: 		&board_sensor_count,&board_sensor_count1);
PUSH	(R5)
PUSH	(R4)
;adc_func.c,543 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.board_sensor_status,
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
MOVW	R3, #1000
MOVT	R3, #0
;adc_func.c,542 :: 		one_level_comparator_ms(ALARM_LEVEL,BoardSensorPPM,ANALOG_GISTERESIS,
MOVW	R2, #0
MOVT	R2, #17224
MOV	R1, R0
MOVW	R0, #0
MOVT	R0, #17914
;adc_func.c,544 :: 		&board_sensor_count,&board_sensor_count1);
;adc_func.c,543 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.board_sensor_status,
;adc_func.c,544 :: 		&board_sensor_count,&board_sensor_count1);
BL	_one_level_comparator_ms+0
ADD	SP, SP, #20
;adc_func.c,548 :: 		&forward_sensor_count,&forward_sensor_count1);
MOVW	R5, #lo_addr(ControlAnalogFlags_forward_sensor_count1_L0+0)
MOVT	R5, #hi_addr(ControlAnalogFlags_forward_sensor_count1_L0+0)
MOVW	R4, #lo_addr(ControlAnalogFlags_forward_sensor_count_L0+0)
MOVT	R4, #hi_addr(ControlAnalogFlags_forward_sensor_count_L0+0)
;adc_func.c,547 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.forward_sensor_status,
MOVW	R3, #lo_addr(_flag_t+2)
MOVT	R3, #hi_addr(_flag_t+2)
MOVS	R2, #10
MOVW	R1, #1000
MOVT	R1, #0
;adc_func.c,546 :: 		one_level_comparator_ms(ALARM_LEVEL,ForwardSensorPPM,ANALOG_GISTERESIS,
MOVW	R0, 536870928
MOVT	R0, 8192
LDR	R0, [R0, #0]
;adc_func.c,548 :: 		&forward_sensor_count,&forward_sensor_count1);
PUSH	(R5)
PUSH	(R4)
;adc_func.c,547 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.forward_sensor_status,
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
MOVW	R3, #1000
MOVT	R3, #0
;adc_func.c,546 :: 		one_level_comparator_ms(ALARM_LEVEL,ForwardSensorPPM,ANALOG_GISTERESIS,
MOVW	R2, #0
MOVT	R2, #17224
MOV	R1, R0
MOVW	R0, #0
MOVT	R0, #17914
;adc_func.c,548 :: 		&forward_sensor_count,&forward_sensor_count1);
;adc_func.c,547 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.forward_sensor_status,
;adc_func.c,548 :: 		&forward_sensor_count,&forward_sensor_count1);
BL	_one_level_comparator_ms+0
ADD	SP, SP, #20
;adc_func.c,552 :: 		&backward_sensor_count,&backward_sensor_count1);
MOVW	R5, #lo_addr(ControlAnalogFlags_backward_sensor_count1_L0+0)
MOVT	R5, #hi_addr(ControlAnalogFlags_backward_sensor_count1_L0+0)
MOVW	R4, #lo_addr(ControlAnalogFlags_backward_sensor_count_L0+0)
MOVT	R4, #hi_addr(ControlAnalogFlags_backward_sensor_count_L0+0)
;adc_func.c,551 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.backward_sensor_status,
MOVW	R3, #lo_addr(_flag_t+3)
MOVT	R3, #hi_addr(_flag_t+3)
MOVS	R2, #10
MOVW	R1, #1000
MOVT	R1, #0
;adc_func.c,550 :: 		one_level_comparator_ms(ALARM_LEVEL,BackwardSensorPPM,ANALOG_GISTERESIS,
MOVW	R0, 536870932
MOVT	R0, 8192
LDR	R0, [R0, #0]
;adc_func.c,552 :: 		&backward_sensor_count,&backward_sensor_count1);
PUSH	(R5)
PUSH	(R4)
;adc_func.c,551 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.backward_sensor_status,
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
MOVW	R3, #1000
MOVT	R3, #0
;adc_func.c,550 :: 		one_level_comparator_ms(ALARM_LEVEL,BackwardSensorPPM,ANALOG_GISTERESIS,
MOVW	R2, #0
MOVT	R2, #17224
MOV	R1, R0
MOVW	R0, #0
MOVT	R0, #17914
;adc_func.c,552 :: 		&backward_sensor_count,&backward_sensor_count1);
;adc_func.c,551 :: 		ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.backward_sensor_status,
;adc_func.c,552 :: 		&backward_sensor_count,&backward_sensor_count1);
BL	_one_level_comparator_ms+0
ADD	SP, SP, #20
;adc_func.c,554 :: 		if(getAdcStatus())
BL	_getAdcStatus+0
CMP	R0, #0
IT	EQ
BLEQ	L_ControlAnalogFlags112
;adc_func.c,556 :: 		setState(sensor_alarm);
MOVS	R0, #10
BL	_setState+0
;adc_func.c,557 :: 		}
L_ControlAnalogFlags112:
;adc_func.c,559 :: 		if(flag_t.board_sensor_status)
MOVW	R0, #lo_addr(_flag_t+1)
MOVT	R0, #hi_addr(_flag_t+1)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_ControlAnalogFlags113
;adc_func.c,561 :: 		bit_set(analogStatusAllChanell,0);
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R1, [R0, #0]
MOVS	R0, #1
ORRS	R1, R0
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
STRB	R1, [R0, #0]
;adc_func.c,562 :: 		}
IT	AL
BLAL	L_ControlAnalogFlags114
L_ControlAnalogFlags113:
;adc_func.c,565 :: 		bit_clr(analogStatusAllChanell,0);
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R1, [R0, #0]
MOVS	R0, #1
MVN	R0, R0
SXTH	R0, R0
ANDS	R1, R0
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
STRB	R1, [R0, #0]
;adc_func.c,566 :: 		}
L_ControlAnalogFlags114:
;adc_func.c,568 :: 		if(flag_t.forward_sensor_status)
MOVW	R0, #lo_addr(_flag_t+2)
MOVT	R0, #hi_addr(_flag_t+2)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_ControlAnalogFlags115
;adc_func.c,570 :: 		bit_set(analogStatusAllChanell,1);
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R1, [R0, #0]
MOVS	R0, #2
ORRS	R1, R0
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
STRB	R1, [R0, #0]
;adc_func.c,571 :: 		}
IT	AL
BLAL	L_ControlAnalogFlags116
L_ControlAnalogFlags115:
;adc_func.c,574 :: 		bit_clr(analogStatusAllChanell,1);
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R1, [R0, #0]
MOVS	R0, #2
MVN	R0, R0
SXTH	R0, R0
ANDS	R1, R0
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
STRB	R1, [R0, #0]
;adc_func.c,575 :: 		}
L_ControlAnalogFlags116:
;adc_func.c,577 :: 		if(flag_t.backward_sensor_status)
MOVW	R0, #lo_addr(_flag_t+3)
MOVT	R0, #hi_addr(_flag_t+3)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_ControlAnalogFlags117
;adc_func.c,579 :: 		bit_set(analogStatusAllChanell,2);
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R1, [R0, #0]
MOVS	R0, #4
ORRS	R1, R0
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
STRB	R1, [R0, #0]
;adc_func.c,580 :: 		}
IT	AL
BLAL	L_ControlAnalogFlags118
L_ControlAnalogFlags117:
;adc_func.c,583 :: 		bit_clr(analogStatusAllChanell,2);
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R1, [R0, #0]
MOVS	R0, #4
MVN	R0, R0
SXTH	R0, R0
ANDS	R1, R0
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
STRB	R1, [R0, #0]
;adc_func.c,584 :: 		}
L_ControlAnalogFlags118:
;adc_func.c,586 :: 		}
IT	AL
BLAL	L_ControlAnalogFlags119
L_ControlAnalogFlags111:
;adc_func.c,589 :: 		flag_t.board_sensor_status    = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+1)
MOVT	R0, #hi_addr(_flag_t+1)
STRB	R1, [R0, #0]
;adc_func.c,590 :: 		flag_t.forward_sensor_status  = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+2)
MOVT	R0, #hi_addr(_flag_t+2)
STRB	R1, [R0, #0]
;adc_func.c,591 :: 		flag_t.backward_sensor_status = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+3)
MOVT	R0, #hi_addr(_flag_t+3)
STRB	R1, [R0, #0]
;adc_func.c,592 :: 		}
L_ControlAnalogFlags119:
;adc_func.c,593 :: 		}
L_end_ControlAnalogFlags:
POP	(R15)
; end of _ControlAnalogFlags
_getAdcStatus:
;adc_func.c,595 :: 		unsigned char getAdcStatus()
PUSH	(R14)
;adc_func.c,597 :: 		return (unsigned char)(flag_t.board_sensor_status||flag_t.forward_sensor_status||flag_t.backward_sensor_status);
MOVW	R0, #lo_addr(_flag_t+1)
MOVT	R0, #hi_addr(_flag_t+1)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_getAdcStatus121
MOVW	R0, #lo_addr(_flag_t+2)
MOVT	R0, #hi_addr(_flag_t+2)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_getAdcStatus121
MOVW	R0, #lo_addr(_flag_t+3)
MOVT	R0, #hi_addr(_flag_t+3)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_getAdcStatus121
MOVS	R0, #0
IT	AL
BLAL	L_getAdcStatus120
L_getAdcStatus121:
MOVS	R0, #1
L_getAdcStatus120:
;adc_func.c,598 :: 		}
L_end_getAdcStatus:
POP	(R15)
; end of _getAdcStatus
_setAdcControlStatus:
;adc_func.c,600 :: 		void setAdcControlStatus(unsigned char status)
; status start address is: 0 (R0)
PUSH	(R14)
; status end address is: 0 (R0)
; status start address is: 0 (R0)
;adc_func.c,602 :: 		if(status)
CMP	R0, #0
IT	EQ
BLEQ	L_setAdcControlStatus122
; status end address is: 0 (R0)
;adc_func.c,604 :: 		flag_t.start_sensor_control = SET;
MOVS	R2, #1
MOVW	R1, #lo_addr(_flag_t+5)
MOVT	R1, #hi_addr(_flag_t+5)
STRB	R2, [R1, #0]
;adc_func.c,605 :: 		}
IT	AL
BLAL	L_setAdcControlStatus123
L_setAdcControlStatus122:
;adc_func.c,608 :: 		flag_t.start_sensor_control = RESET;
MOVS	R2, #0
MOVW	R1, #lo_addr(_flag_t+5)
MOVT	R1, #hi_addr(_flag_t+5)
STRB	R2, [R1, #0]
;adc_func.c,609 :: 		}
L_setAdcControlStatus123:
;adc_func.c,610 :: 		}
L_end_setAdcControlStatus:
POP	(R15)
; end of _setAdcControlStatus
_getAdcControlStatus:
;adc_func.c,612 :: 		unsigned char getAdcControlStatus()
PUSH	(R14)
;adc_func.c,614 :: 		return  (unsigned char)flag_t.start_sensor_control;
MOVW	R0, #lo_addr(_flag_t+5)
MOVT	R0, #hi_addr(_flag_t+5)
LDRB	R0, [R0, #0]
;adc_func.c,615 :: 		}
L_end_getAdcControlStatus:
POP	(R15)
; end of _getAdcControlStatus
_CalibrateADC:
;adc_func.c,617 :: 		void CalibrateADC(void)
PUSH	(R14)
;adc_func.c,623 :: 		if ((ADC_CR & ADC_CR_ADEN) != 0) /* (1) */
MOVW	R0, 1073816584
MOVT	R0, 16385
LDR	R1, [R0, #0]
MOVS	R0, #1
ANDS	R0, R1
CMP	R0, #0
IT	EQ
BLEQ	L_CalibrateADC124
;adc_func.c,625 :: 		ADC_CR &= (uint32_t)(~ADC_CR_ADEN);  /* (2) */
MOVW	R0, 1073816584
MOVT	R0, 16385
LDR	R1, [R0, #0]
MOVW	R0, #65534
MOVT	R0, #65535
ANDS	R1, R0
MOVW	R0, 1073816584
MOVT	R0, 16385
STR	R1, [R0, #0]
;adc_func.c,626 :: 		}
L_CalibrateADC124:
;adc_func.c,627 :: 		ADC_CR |= ADC_CR_ADCAL; /* (3) */
MOVW	R0, 1073816584
MOVT	R0, 16385
LDR	R1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #32768
ORRS	R1, R0
MOVW	R0, 1073816584
MOVT	R0, 16385
STR	R1, [R0, #0]
;adc_func.c,628 :: 		while ((ADC_CR & ADC_CR_ADCAL) != 0) /* (4) */
L_CalibrateADC125:
MOVW	R0, 1073816584
MOVT	R0, 16385
LDR	R1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #32768
ANDS	R0, R1
CMP	R0, #0
IT	EQ
BLEQ	L_CalibrateADC126
;adc_func.c,631 :: 		}
IT	AL
BLAL	L_CalibrateADC125
L_CalibrateADC126:
;adc_func.c,632 :: 		}
L_end_CalibrateADC:
POP	(R15)
; end of _CalibrateADC
_SetClockForADC:
;adc_func.c,658 :: 		void SetClockForADC(void)
PUSH	(R14)
;adc_func.c,663 :: 		RCC_APB2ENR |= RCC_APB2ENR_ADC1EN; /* (1) */
MOVW	R0, 1073877016
MOVT	R0, 16386
LDR	R1, [R0, #0]
MOVW	R0, #512
MOVT	R0, #0
ORRS	R1, R0
MOVW	R0, 1073877016
MOVT	R0, 16386
STR	R1, [R0, #0]
;adc_func.c,665 :: 		RCC_CR2 |= RCC_CR2_HSI14ON; /* (2) */
MOVW	R0, 1073877044
MOVT	R0, 16386
LDR	R1, [R0, #0]
MOVS	R0, #1
ORRS	R1, R0
MOVW	R0, 1073877044
MOVT	R0, 16386
STR	R1, [R0, #0]
;adc_func.c,666 :: 		while ((RCC_CR2 & RCC_CR2_HSI14RDY) == 0) /* (3) */
L_SetClockForADC127:
MOVW	R0, 1073877044
MOVT	R0, 16386
LDR	R1, [R0, #0]
MOVS	R0, #2
ANDS	R0, R1
CMP	R0, #0
IT	NE
BLNE	L_SetClockForADC128
;adc_func.c,669 :: 		}
IT	AL
BLAL	L_SetClockForADC127
L_SetClockForADC128:
;adc_func.c,673 :: 		}
L_end_SetClockForADC:
POP	(R15)
; end of _SetClockForADC
_EnableADC:
;adc_func.c,676 :: 		void EnableADC(void)
PUSH	(R14)
;adc_func.c,680 :: 		do
L_EnableADC129:
;adc_func.c,683 :: 		ADC_CR |= ADC_CR_ADEN; /* (1) */
MOVW	R0, 1073816584
MOVT	R0, 16385
LDR	R1, [R0, #0]
MOVS	R0, #1
ORRS	R1, R0
MOVW	R0, 1073816584
MOVT	R0, 16385
STR	R1, [R0, #0]
;adc_func.c,684 :: 		}while ((ADC_ISR & ADC_ISR_ADRDY) == 0) /* (2) */;
MOVW	R0, 1073816576
MOVT	R0, 16385
LDR	R1, [R0, #0]
MOVS	R0, #1
ANDS	R0, R1
CMP	R0, #0
IT	EQ
BLEQ	L_EnableADC129
;adc_func.c,685 :: 		}
L_end_EnableADC:
POP	(R15)
; end of _EnableADC
