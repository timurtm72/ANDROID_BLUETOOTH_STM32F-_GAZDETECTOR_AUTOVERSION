_ControlDigitalFlags:
;func.c,6 :: 		void ControlDigitalFlags()
PUSH	(R14)
;func.c,13 :: 		&start_button_status_count1, &start_button_status_count2);
MOVW	R4, #lo_addr(ControlDigitalFlags_start_button_status_count2_L0+0)
MOVT	R4, #hi_addr(ControlDigitalFlags_start_button_status_count2_L0+0)
MOVW	R3, #lo_addr(ControlDigitalFlags_start_button_status_count1_L0+0)
MOVT	R3, #hi_addr(ControlDigitalFlags_start_button_status_count1_L0+0)
;func.c,12 :: 		MS_IN_CYCLE, &flag_t.cal_button_status,
MOVW	R2, #lo_addr(_flag_t+4)
MOVT	R2, #hi_addr(_flag_t+4)
;func.c,11 :: 		ControlDigit_ms(CAL_BUTTON, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,
MOVW	R0, #lo_addr(CAL_BUTTON+0)
MOVT	R0, #hi_addr(CAL_BUTTON+0)
_LX	[R0, ByteOffset(CAL_BUTTON+0)]
MOVS	R0, #1
LSLS	R0, R0, BitPos(CAL_BUTTON+0)
ANDS	R0, R1
LSRS	R0, R0, BitPos(CAL_BUTTON+0)
;func.c,13 :: 		&start_button_status_count1, &start_button_status_count2);
PUSH	(R4)
PUSH	(R3)
;func.c,12 :: 		MS_IN_CYCLE, &flag_t.cal_button_status,
PUSH	(R2)
MOVS	R3, #10
;func.c,11 :: 		ControlDigit_ms(CAL_BUTTON, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,
MOVW	R2, #1000
MOVT	R2, #0
MOVW	R1, #1000
MOVT	R1, #0
;func.c,13 :: 		&start_button_status_count1, &start_button_status_count2);
;func.c,12 :: 		MS_IN_CYCLE, &flag_t.cal_button_status,
;func.c,13 :: 		&start_button_status_count1, &start_button_status_count2);
BL	_ControlDigit_ms+0
ADD	SP, SP, #12
;func.c,16 :: 		if(flag_t.cal_button_status==RESET&&flag_t.ready_calibration_prog==RESET)
MOVW	R0, #lo_addr(_flag_t+4)
MOVT	R0, #hi_addr(_flag_t+4)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L__ControlDigitalFlags59
MOVW	R0, #lo_addr(_flag_t+7)
MOVT	R0, #hi_addr(_flag_t+7)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L__ControlDigitalFlags58
L__ControlDigitalFlags57:
;func.c,18 :: 		flag_t.calibrate_status = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+12)
MOVT	R0, #hi_addr(_flag_t+12)
STRB	R1, [R0, #0]
;func.c,19 :: 		setState(getV0);
MOVS	R0, #8
BL	_setState+0
;func.c,16 :: 		if(flag_t.cal_button_status==RESET&&flag_t.ready_calibration_prog==RESET)
L__ControlDigitalFlags59:
L__ControlDigitalFlags58:
;func.c,21 :: 		}
L_end_ControlDigitalFlags:
POP	(R15)
; end of _ControlDigitalFlags
_globalProcess:
;func.c,23 :: 		void globalProcess()
PUSH	(R14)
;func.c,25 :: 		ControlInputData();
BL	_ControlInputData+0
;func.c,26 :: 		WriteDataToAndroid();
BL	_WriteDataToAndroid+0
;func.c,27 :: 		if(flag_t.ovf_flag==SET)
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_globalProcess3
;func.c,29 :: 		flag_t.ovf_flag = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STRB	R1, [R0, #0]
;func.c,31 :: 		clear_WDT();
BL	_clear_WDT+0
;func.c,32 :: 		ReadAnalogInput();
BL	_ReadAnalogInput+0
;func.c,33 :: 		ControlAnalogFlags();
BL	_ControlAnalogFlags+0
;func.c,34 :: 		ControlDigitalFlags();
BL	_ControlDigitalFlags+0
;func.c,35 :: 		ControlSensorDamage();
BL	_ControlSensorDamage+0
;func.c,37 :: 		ControlCalibrate(3600);
MOVW	R0, #3600
MOVT	R0, #0
BL	_ControlCalibrate+0
;func.c,38 :: 		ControlRecalFlags();
BL	_ControlRecalFlags+0
;func.c,42 :: 		switch(state)
IT	AL
BLAL	L_globalProcess4
;func.c,44 :: 		case control_calibration :    controlCalibration();                  break;
L_globalProcess6:
BL	_controlCalibration+0
IT	AL
BLAL	L_globalProcess5
;func.c,45 :: 		case error_calibration   :    ErrorCalibration();                    break;
L_globalProcess7:
BL	_ErrorCalibration+0
IT	AL
BLAL	L_globalProcess5
;func.c,46 :: 		case start_sound         :    StartSound(TRUE);                      break;
L_globalProcess8:
MOVS	R0, #1
BL	_StartSound+0
IT	AL
BLAL	L_globalProcess5
;func.c,47 :: 		case preheat             :    Preheat_f();                           break;
L_globalProcess9:
BL	_Preheat_f+0
IT	AL
BLAL	L_globalProcess5
;func.c,48 :: 		case calibration         :    Calibration_f();                       break;
L_globalProcess10:
BL	_Calibration_f+0
IT	AL
BLAL	L_globalProcess5
;func.c,49 :: 		case getV0               :    Calibrate();                           break;
L_globalProcess11:
BL	_Calibrate+0
IT	AL
BLAL	L_globalProcess5
;func.c,50 :: 		case ready_alarm         :    ReadyAlarm_f();                        break;
L_globalProcess12:
BL	_ReadyAlarm_f+0
IT	AL
BLAL	L_globalProcess5
;func.c,51 :: 		case process             :    Process_f();                           break;
L_globalProcess13:
BL	_Process_f+0
IT	AL
BLAL	L_globalProcess5
;func.c,52 :: 		case sensor_alarm        :    SensorAlarm();                         break;
L_globalProcess14:
BL	_SensorAlarm+0
IT	AL
BLAL	L_globalProcess5
;func.c,53 :: 		case sensor_damage       :    SensorDamage();                        break;
L_globalProcess15:
BL	_SensorDamage+0
IT	AL
BLAL	L_globalProcess5
;func.c,54 :: 		}
L_globalProcess4:
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BLEQ	L_globalProcess6
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BLEQ	L_globalProcess7
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BLEQ	L_globalProcess8
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	EQ
BLEQ	L_globalProcess9
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BLEQ	L_globalProcess10
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #8
IT	EQ
BLEQ	L_globalProcess11
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	EQ
BLEQ	L_globalProcess12
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #9
IT	EQ
BLEQ	L_globalProcess13
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	EQ
BLEQ	L_globalProcess14
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #11
IT	EQ
BLEQ	L_globalProcess15
L_globalProcess5:
;func.c,56 :: 		}
L_globalProcess3:
;func.c,57 :: 		}
L_end_globalProcess:
POP	(R15)
; end of _globalProcess
_Process_f:
;func.c,59 :: 		void Process_f()
PUSH	(R14)
;func.c,61 :: 		setAdcControlStatus(SET);
MOVS	R0, #1
BL	_setAdcControlStatus+0
;func.c,63 :: 		LED_GREEN = ON;
MOVW	R2, #lo_addr(LED_GREEN+0)
MOVT	R2, #hi_addr(LED_GREEN+0)
_LX	[R2, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_GREEN+0)]
;func.c,64 :: 		LED_RED   = OFF;
MOVW	R2, #lo_addr(LED_RED+0)
MOVT	R2, #hi_addr(LED_RED+0)
_LX	[R2, ByteOffset(LED_RED+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
BICS	R0, R1
_SX	[R2, ByteOffset(LED_RED+0)]
;func.c,65 :: 		RestartCalibration(1200);
MOVW	R0, #1200
MOVT	R0, #0
BL	_RestartCalibration+0
;func.c,66 :: 		flag_t.process_start_status = SET;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+21)
MOVT	R0, #hi_addr(_flag_t+21)
STRB	R1, [R0, #0]
;func.c,67 :: 		}
L_end_Process_f:
POP	(R15)
; end of _Process_f
_setState:
;func.c,69 :: 		void setState(state_n newState)
; newState start address is: 0 (R0)
; newState end address is: 0 (R0)
; newState start address is: 0 (R0)
;func.c,71 :: 		state =  newState;
MOVW	R1, #lo_addr(_state+0)
MOVT	R1, #hi_addr(_state+0)
STRB	R0, [R1, #0]
; newState end address is: 0 (R0)
;func.c,72 :: 		}
L_end_setState:
BX	LR
; end of _setState
_getState:
;func.c,74 :: 		state_n getState()
PUSH	(R14)
;func.c,76 :: 		return state;
MOVW	R0, #lo_addr(_state+0)
MOVT	R0, #hi_addr(_state+0)
LDRB	R0, [R0, #0]
;func.c,77 :: 		}
L_end_getState:
POP	(R15)
; end of _getState
_StartSound:
;func.c,79 :: 		void StartSound(unsigned char state)
; state start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #4
; state end address is: 0 (R0)
; state start address is: 0 (R0)
;func.c,81 :: 		flag_t.start_process_status = SET;
MOVS	R2, #1
MOVW	R1, #lo_addr(_flag_t+19)
MOVT	R1, #hi_addr(_flag_t+19)
STRB	R2, [R1, #0]
;func.c,83 :: 		ControlReadOutProtection();
STR	R0, [SP, #0]
BL	_ControlReadOutProtection+0
LDR	R0, [SP, #0]
UXTB	R0, R0
;func.c,85 :: 		if(state)
CMP	R0, #0
IT	EQ
BLEQ	L_StartSound16
; state end address is: 0 (R0)
;func.c,87 :: 		Blink_buz_func(0b00010101,9,1,5,preheat,TRUE,0);
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #6
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #5
MOVS	R2, #1
MOVS	R1, #9
MOVS	R0, #21
BL	_Blink_buz_func+0
ADD	SP, SP, #12
;func.c,88 :: 		}
IT	AL
BLAL	L_StartSound17
L_StartSound16:
;func.c,91 :: 		resetLB();
BL	_resetLB+0
;func.c,92 :: 		setState(preheat);
MOVS	R0, #6
BL	_setState+0
;func.c,93 :: 		}
L_StartSound17:
;func.c,94 :: 		}
L_end_StartSound:
ADD	SP, SP, #4
POP	(R15)
; end of _StartSound
_ErrorCalibration:
;func.c,96 :: 		void ErrorCalibration()
PUSH	(R14)
;func.c,99 :: 		setAdcControlStatus(RESET);
MOVS	R0, #0
BL	_setAdcControlStatus+0
;func.c,101 :: 		if((count_error_cal++)>=50)
MOVW	R2, #lo_addr(ErrorCalibration_count_error_cal_L0+0)
MOVT	R2, #hi_addr(ErrorCalibration_count_error_cal_L0+0)
LDRB	R1, [R2, #0]
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, #1
STRB	R0, [R2, #0]
CMP	R1, #50
IT	CC
BLCC	L_ErrorCalibration18
;func.c,103 :: 		count_error_cal = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ErrorCalibration_count_error_cal_L0+0)
MOVT	R0, #hi_addr(ErrorCalibration_count_error_cal_L0+0)
STRB	R1, [R0, #0]
;func.c,104 :: 		state_error^=1;
MOVW	R2, #lo_addr(ErrorCalibration_state_error_L0+0)
MOVT	R2, #hi_addr(ErrorCalibration_state_error_L0+0)
LDRB	R1, [R2, #0]
MOVS	R0, #1
EORS	R0, R1
STRB	R0, [R2, #0]
;func.c,105 :: 		}
L_ErrorCalibration18:
;func.c,106 :: 		if(state_error)
MOVW	R0, #lo_addr(ErrorCalibration_state_error_L0+0)
MOVT	R0, #hi_addr(ErrorCalibration_state_error_L0+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_ErrorCalibration19
;func.c,108 :: 		LED_GREEN = OFF;
MOVW	R2, #lo_addr(LED_GREEN+0)
MOVT	R2, #hi_addr(LED_GREEN+0)
_LX	[R2, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
BICS	R0, R1
_SX	[R2, ByteOffset(LED_GREEN+0)]
;func.c,109 :: 		LED_RED   = ON;
MOVW	R2, #lo_addr(LED_RED+0)
MOVT	R2, #hi_addr(LED_RED+0)
_LX	[R2, ByteOffset(LED_RED+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_RED+0)]
;func.c,110 :: 		}
IT	AL
BLAL	L_ErrorCalibration20
L_ErrorCalibration19:
;func.c,113 :: 		LED_GREEN = OFF;
MOVW	R2, #lo_addr(LED_GREEN+0)
MOVT	R2, #hi_addr(LED_GREEN+0)
_LX	[R2, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
BICS	R0, R1
_SX	[R2, ByteOffset(LED_GREEN+0)]
;func.c,114 :: 		LED_RED   = OFF;
MOVW	R2, #lo_addr(LED_RED+0)
MOVT	R2, #hi_addr(LED_RED+0)
_LX	[R2, ByteOffset(LED_RED+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
BICS	R0, R1
_SX	[R2, ByteOffset(LED_RED+0)]
;func.c,115 :: 		}
L_ErrorCalibration20:
;func.c,116 :: 		}
L_end_ErrorCalibration:
POP	(R15)
; end of _ErrorCalibration
_controlCalibration:
;func.c,118 :: 		void controlCalibration()
PUSH	(R14)
;func.c,123 :: 		setAdcControlStatus(RESET);
MOVS	R0, #0
BL	_setAdcControlStatus+0
;func.c,125 :: 		ReadAnalogInput();
BL	_ReadAnalogInput+0
;func.c,126 :: 		LED_RED      =  ON;
MOVW	R2, #lo_addr(LED_RED+0)
MOVT	R2, #hi_addr(LED_RED+0)
_LX	[R2, ByteOffset(LED_RED+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_RED+0)]
;func.c,128 :: 		switch(start_buz++)
MOVW	R1, #lo_addr(controlCalibration_start_buz_L0+0)
MOVT	R1, #hi_addr(controlCalibration_start_buz_L0+0)
LDRH	R3, [R1, #0]
MOV	R0, R1
LDRH	R0, [R0, #0]
ADDS	R0, #1
STRH	R0, [R1, #0]
IT	AL
BLAL	L_controlCalibration21
;func.c,130 :: 		case 1:   BUZER = ON;          break;
L_controlCalibration23:
MOVW	R2, #lo_addr(BUZER+0)
MOVT	R2, #hi_addr(BUZER+0)
_LX	[R2, ByteOffset(BUZER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(BUZER+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(BUZER+0)]
IT	AL
BLAL	L_controlCalibration22
;func.c,131 :: 		case 51:  BUZER = OFF;         break;
L_controlCalibration24:
MOVW	R2, #lo_addr(BUZER+0)
MOVT	R2, #hi_addr(BUZER+0)
_LX	[R2, ByteOffset(BUZER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(BUZER+0)
BICS	R0, R1
_SX	[R2, ByteOffset(BUZER+0)]
IT	AL
BLAL	L_controlCalibration22
;func.c,132 :: 		}
L_controlCalibration21:
CMP	R3, #1
IT	EQ
BLEQ	L_controlCalibration23
CMP	R3, #51
IT	EQ
BLEQ	L_controlCalibration24
L_controlCalibration22:
;func.c,134 :: 		if((start_control_count++)>=500&&start_control_cal==RESET)
MOVW	R2, #lo_addr(controlCalibration_start_control_count_L0+0)
MOVT	R2, #hi_addr(controlCalibration_start_control_count_L0+0)
LDRH	R1, [R2, #0]
MOV	R0, R2
LDRH	R0, [R0, #0]
ADDS	R0, #1
STRH	R0, [R2, #0]
MOVS	R0, #255
ADDS	R0, #245
CMP	R1, R0
IT	CC
BLCC	L__controlCalibration62
MOVW	R0, #lo_addr(controlCalibration_start_control_cal_L0+0)
MOVT	R0, #hi_addr(controlCalibration_start_control_cal_L0+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L__controlCalibration61
L__controlCalibration60:
;func.c,136 :: 		start_control_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(controlCalibration_start_control_count_L0+0)
MOVT	R0, #hi_addr(controlCalibration_start_control_count_L0+0)
STRH	R1, [R0, #0]
;func.c,137 :: 		start_buz = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(controlCalibration_start_buz_L0+0)
MOVT	R0, #hi_addr(controlCalibration_start_buz_L0+0)
STRH	R1, [R0, #0]
;func.c,138 :: 		start_control_cal = SET;
MOVS	R1, #1
MOVW	R0, #lo_addr(controlCalibration_start_control_cal_L0+0)
MOVT	R0, #hi_addr(controlCalibration_start_control_cal_L0+0)
STRB	R1, [R0, #0]
;func.c,134 :: 		if((start_control_count++)>=500&&start_control_cal==RESET)
L__controlCalibration62:
L__controlCalibration61:
;func.c,140 :: 		if(start_control_cal==SET)
MOVW	R0, #lo_addr(controlCalibration_start_control_cal_L0+0)
MOVT	R0, #hi_addr(controlCalibration_start_control_cal_L0+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L_controlCalibration28
;func.c,142 :: 		if(read_data_from_eeprom(EEPROM_DATA_SIZE)==SET)
MOVS	R0, #13
BL	_read_data_from_eeprom+0
CMP	R0, #1
IT	NE
BLNE	L_controlCalibration29
;func.c,144 :: 		resetLB();
BL	_resetLB+0
;func.c,145 :: 		start_control_cal = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(controlCalibration_start_control_cal_L0+0)
MOVT	R0, #hi_addr(controlCalibration_start_control_cal_L0+0)
STRB	R1, [R0, #0]
;func.c,146 :: 		flag_t.calibrate_status = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+12)
MOVT	R0, #hi_addr(_flag_t+12)
STRB	R1, [R0, #0]
;func.c,147 :: 		setState(error_calibration);
MOVS	R0, #2
BL	_setState+0
;func.c,148 :: 		}
IT	AL
BLAL	L_controlCalibration30
L_controlCalibration29:
;func.c,151 :: 		start_control_cal = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(controlCalibration_start_control_cal_L0+0)
MOVT	R0, #hi_addr(controlCalibration_start_control_cal_L0+0)
STRB	R1, [R0, #0]
;func.c,152 :: 		resetLB();
BL	_resetLB+0
;func.c,156 :: 		flag_t.calibrate_status = SET;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+12)
MOVT	R0, #hi_addr(_flag_t+12)
STRB	R1, [R0, #0]
;func.c,157 :: 		setState(start_sound);
MOVS	R0, #5
BL	_setState+0
;func.c,158 :: 		}
L_controlCalibration30:
;func.c,159 :: 		}
L_controlCalibration28:
;func.c,160 :: 		}
L_end_controlCalibration:
POP	(R15)
; end of _controlCalibration
_Preheat_f:
;func.c,162 :: 		void Preheat_f()
PUSH	(R14)
;func.c,167 :: 		setAdcControlStatus(RESET);
MOVS	R0, #0
BL	_setAdcControlStatus+0
;func.c,169 :: 		if((cycle_preheat_count++)<=FASE_PREHEAT)
MOVW	R2, #lo_addr(Preheat_f_cycle_preheat_count_L0+0)
MOVT	R2, #hi_addr(Preheat_f_cycle_preheat_count_L0+0)
LDR	R1, [R2, #0]
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, #1
STR	R0, [R2, #0]
MOVW	R0, #18000
MOVT	R0, #0
CMP	R1, R0
IT	HI
BLHI	L_Preheat_f31
;func.c,174 :: 		switch(preheat_count_loop++)
MOVW	R1, #lo_addr(Preheat_f_preheat_count_loop_L0+0)
MOVT	R1, #hi_addr(Preheat_f_preheat_count_loop_L0+0)
LDRB	R3, [R1, #0]
MOV	R0, R1
LDRB	R0, [R0, #0]
ADDS	R0, #1
STRB	R0, [R1, #0]
IT	AL
BLAL	L_Preheat_f32
;func.c,176 :: 		case   1:    LED_RED   = ON;
L_Preheat_f34:
MOVW	R2, #lo_addr(LED_RED+0)
MOVT	R2, #hi_addr(LED_RED+0)
_LX	[R2, ByteOffset(LED_RED+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_RED+0)]
;func.c,177 :: 		LED_GREEN = OFF;
MOVW	R2, #lo_addr(LED_GREEN+0)
MOVT	R2, #hi_addr(LED_GREEN+0)
_LX	[R2, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
BICS	R0, R1
_SX	[R2, ByteOffset(LED_GREEN+0)]
;func.c,178 :: 		break;
IT	AL
BLAL	L_Preheat_f33
;func.c,179 :: 		case   11:   LED_RED   = OFF;
L_Preheat_f35:
MOVW	R2, #lo_addr(LED_RED+0)
MOVT	R2, #hi_addr(LED_RED+0)
_LX	[R2, ByteOffset(LED_RED+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
BICS	R0, R1
_SX	[R2, ByteOffset(LED_RED+0)]
;func.c,180 :: 		LED_GREEN = ON;
MOVW	R2, #lo_addr(LED_GREEN+0)
MOVT	R2, #hi_addr(LED_GREEN+0)
_LX	[R2, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_GREEN+0)]
;func.c,181 :: 		break;
IT	AL
BLAL	L_Preheat_f33
;func.c,182 :: 		case   49:   LED_GREEN = ON;
L_Preheat_f36:
MOVW	R2, #lo_addr(LED_GREEN+0)
MOVT	R2, #hi_addr(LED_GREEN+0)
_LX	[R2, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_GREEN+0)]
;func.c,183 :: 		preheat_count_loop = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Preheat_f_preheat_count_loop_L0+0)
MOVT	R0, #hi_addr(Preheat_f_preheat_count_loop_L0+0)
STRB	R1, [R0, #0]
;func.c,184 :: 		break;
IT	AL
BLAL	L_Preheat_f33
;func.c,185 :: 		}
L_Preheat_f32:
CMP	R3, #1
IT	EQ
BLEQ	L_Preheat_f34
CMP	R3, #11
IT	EQ
BLEQ	L_Preheat_f35
CMP	R3, #49
IT	EQ
BLEQ	L_Preheat_f36
L_Preheat_f33:
;func.c,186 :: 		}
IT	AL
BLAL	L_Preheat_f37
L_Preheat_f31:
;func.c,191 :: 		preheat_count_loop = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Preheat_f_preheat_count_loop_L0+0)
MOVT	R0, #hi_addr(Preheat_f_preheat_count_loop_L0+0)
STRB	R1, [R0, #0]
;func.c,192 :: 		cycle_preheat_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Preheat_f_cycle_preheat_count_L0+0)
MOVT	R0, #hi_addr(Preheat_f_cycle_preheat_count_L0+0)
STR	R1, [R0, #0]
;func.c,193 :: 		resetLB();
BL	_resetLB+0
;func.c,194 :: 		setState(getV0);
MOVS	R0, #8
BL	_setState+0
;func.c,195 :: 		}
L_Preheat_f37:
;func.c,196 :: 		}
L_end_Preheat_f:
POP	(R15)
; end of _Preheat_f
_Calibration_f:
;func.c,198 :: 		void Calibration_f()
PUSH	(R14)
;func.c,202 :: 		setAdcControlStatus(RESET);
MOVS	R0, #0
BL	_setAdcControlStatus+0
;func.c,204 :: 		if((count_cal++)>=count_ready)
MOVW	R2, #lo_addr(Calibration_f_count_cal_L0+0)
MOVT	R2, #hi_addr(Calibration_f_count_cal_L0+0)
LDRB	R1, [R2, #0]
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, #1
STRB	R0, [R2, #0]
MOVW	R0, #lo_addr(Calibration_f_count_ready_L0+0)
MOVT	R0, #hi_addr(Calibration_f_count_ready_L0+0)
LDRB	R0, [R0, #0]
CMP	R1, R0
IT	CC
BLCC	L_Calibration_f38
;func.c,206 :: 		count_cal = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Calibration_f_count_cal_L0+0)
MOVT	R0, #hi_addr(Calibration_f_count_cal_L0+0)
STRB	R1, [R0, #0]
;func.c,207 :: 		state_cal^=1;
MOVW	R2, #lo_addr(Calibration_f_state_cal_L0+0)
MOVT	R2, #hi_addr(Calibration_f_state_cal_L0+0)
LDRB	R1, [R2, #0]
MOVS	R0, #1
EORS	R0, R1
STRB	R0, [R2, #0]
;func.c,208 :: 		}
L_Calibration_f38:
;func.c,209 :: 		ReadAnalogInput();
BL	_ReadAnalogInput+0
;func.c,210 :: 		if((count_ready_cal++)>=300&&flag_t.ready_calibration_prog==RESET)
MOVW	R2, #lo_addr(Calibration_f_count_ready_cal_L0+0)
MOVT	R2, #hi_addr(Calibration_f_count_ready_cal_L0+0)
LDR	R1, [R2, #0]
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, #1
STR	R0, [R2, #0]
MOVS	R0, #255
ADDS	R0, #45
CMP	R1, R0
IT	CC
BLCC	L__Calibration_f66
MOVW	R0, #lo_addr(_flag_t+7)
MOVT	R0, #hi_addr(_flag_t+7)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L__Calibration_f65
L__Calibration_f64:
;func.c,212 :: 		flag_t.ready_calibration_prog = SET;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+7)
MOVT	R0, #hi_addr(_flag_t+7)
STRB	R1, [R0, #0]
;func.c,213 :: 		count_ready = 25;
MOVS	R1, #25
MOVW	R0, #lo_addr(Calibration_f_count_ready_L0+0)
MOVT	R0, #hi_addr(Calibration_f_count_ready_L0+0)
STRB	R1, [R0, #0]
;func.c,210 :: 		if((count_ready_cal++)>=300&&flag_t.ready_calibration_prog==RESET)
L__Calibration_f66:
L__Calibration_f65:
;func.c,215 :: 		if( state_cal)
MOVW	R0, #lo_addr(Calibration_f_state_cal_L0+0)
MOVT	R0, #hi_addr(Calibration_f_state_cal_L0+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_Calibration_f42
;func.c,217 :: 		LED_GREEN = ON;
MOVW	R2, #lo_addr(LED_GREEN+0)
MOVT	R2, #hi_addr(LED_GREEN+0)
_LX	[R2, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_GREEN+0)]
;func.c,218 :: 		LED_RED   = ON;
MOVW	R2, #lo_addr(LED_RED+0)
MOVT	R2, #hi_addr(LED_RED+0)
_LX	[R2, ByteOffset(LED_RED+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_RED+0)]
;func.c,219 :: 		}
IT	AL
BLAL	L_Calibration_f43
L_Calibration_f42:
;func.c,222 :: 		LED_GREEN = OFF;
MOVW	R2, #lo_addr(LED_GREEN+0)
MOVT	R2, #hi_addr(LED_GREEN+0)
_LX	[R2, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
BICS	R0, R1
_SX	[R2, ByteOffset(LED_GREEN+0)]
;func.c,223 :: 		LED_RED   = OFF;
MOVW	R2, #lo_addr(LED_RED+0)
MOVT	R2, #hi_addr(LED_RED+0)
_LX	[R2, ByteOffset(LED_RED+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
BICS	R0, R1
_SX	[R2, ByteOffset(LED_RED+0)]
;func.c,224 :: 		}
L_Calibration_f43:
;func.c,225 :: 		if(flag_t.cal_button_status==RESET&&flag_t.ready_calibration_prog==SET)
MOVW	R0, #lo_addr(_flag_t+4)
MOVT	R0, #hi_addr(_flag_t+4)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L__Calibration_f68
MOVW	R0, #lo_addr(_flag_t+7)
MOVT	R0, #hi_addr(_flag_t+7)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BLNE	L__Calibration_f67
L__Calibration_f63:
;func.c,227 :: 		parameters_t.board_sensor_cal_data    = (unsigned int)BoardSensorValue;
MOVW	R0, #lo_addr(_BoardSensorValue+0)
MOVT	R0, #hi_addr(_BoardSensorValue+0)
LDR	R0, [R0, #0]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_parameters_t+10)
MOVT	R1, #hi_addr(_parameters_t+10)
STRH	R0, [R1, #0]
;func.c,228 :: 		parameters_t.forward_sensor_cal_data  = (unsigned int)ForwardSensorValue;
MOVW	R0, #lo_addr(_ForwardSensorValue+0)
MOVT	R0, #hi_addr(_ForwardSensorValue+0)
LDR	R0, [R0, #0]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_parameters_t+6)
MOVT	R1, #hi_addr(_parameters_t+6)
STRH	R0, [R1, #0]
;func.c,229 :: 		parameters_t.backward_sensor_cal_data = (unsigned int)BackwardSensorValue;
MOVW	R0, #lo_addr(_BackwardSensorValue+0)
MOVT	R0, #hi_addr(_BackwardSensorValue+0)
LDR	R0, [R0, #0]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
MOVW	R1, #lo_addr(_parameters_t+8)
MOVT	R1, #hi_addr(_parameters_t+8)
STRH	R0, [R1, #0]
;func.c,230 :: 		save_data_to_eeprom(EEPROM_DATA_SIZE);
MOVS	R0, #13
BL	_save_data_to_eeprom+0
;func.c,231 :: 		if(read_data_from_eeprom(EEPROM_DATA_SIZE)==SET)
MOVS	R0, #13
BL	_read_data_from_eeprom+0
CMP	R0, #1
IT	NE
BLNE	L_Calibration_f47
;func.c,233 :: 		resetLB();
BL	_resetLB+0
;func.c,234 :: 		flag_t.ready_calibration_prog=RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+7)
MOVT	R0, #hi_addr(_flag_t+7)
STRB	R1, [R0, #0]
;func.c,235 :: 		count_ready_cal= 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Calibration_f_count_ready_cal_L0+0)
MOVT	R0, #hi_addr(Calibration_f_count_ready_cal_L0+0)
STR	R1, [R0, #0]
;func.c,236 :: 		count_ready = 50;
MOVS	R1, #50
MOVW	R0, #lo_addr(Calibration_f_count_ready_L0+0)
MOVT	R0, #hi_addr(Calibration_f_count_ready_L0+0)
STRB	R1, [R0, #0]
;func.c,237 :: 		setState(calibration);
MOVS	R0, #4
BL	_setState+0
;func.c,238 :: 		}
IT	AL
BLAL	L_Calibration_f48
L_Calibration_f47:
;func.c,241 :: 		resetLB();
BL	_resetLB+0
;func.c,242 :: 		flag_t.ready_calibration_prog=RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+7)
MOVT	R0, #hi_addr(_flag_t+7)
STRB	R1, [R0, #0]
;func.c,243 :: 		count_ready_cal = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Calibration_f_count_ready_cal_L0+0)
MOVT	R0, #hi_addr(Calibration_f_count_ready_cal_L0+0)
STR	R1, [R0, #0]
;func.c,244 :: 		count_ready = 50;
MOVS	R1, #50
MOVW	R0, #lo_addr(Calibration_f_count_ready_L0+0)
MOVT	R0, #hi_addr(Calibration_f_count_ready_L0+0)
STRB	R1, [R0, #0]
;func.c,245 :: 		SystemReset();
BL	_SystemReset+0
;func.c,246 :: 		}
L_Calibration_f48:
;func.c,225 :: 		if(flag_t.cal_button_status==RESET&&flag_t.ready_calibration_prog==SET)
L__Calibration_f68:
L__Calibration_f67:
;func.c,248 :: 		}
L_end_Calibration_f:
POP	(R15)
; end of _Calibration_f
_Recalibrate:
;func.c,250 :: 		void Recalibrate()
PUSH	(R14)
;func.c,252 :: 		setState(getV0);
MOVS	R0, #8
BL	_setState+0
;func.c,253 :: 		}
L_end_Recalibrate:
POP	(R15)
; end of _Recalibrate
_setHeaterStatus:
;func.c,255 :: 		void setHeaterStatus(unsigned char state)
; state start address is: 0 (R0)
PUSH	(R14)
; state end address is: 0 (R0)
; state start address is: 0 (R0)
;func.c,257 :: 		if(state)
CMP	R0, #0
IT	EQ
BLEQ	L_setHeaterStatus49
; state end address is: 0 (R0)
;func.c,259 :: 		flag_t.heater_status = SET;
MOVS	R2, #1
MOVW	R1, #lo_addr(_flag_t+6)
MOVT	R1, #hi_addr(_flag_t+6)
STRB	R2, [R1, #0]
;func.c,260 :: 		}
IT	AL
BLAL	L_setHeaterStatus50
L_setHeaterStatus49:
;func.c,263 :: 		flag_t.heater_status = RESET;
MOVS	R2, #0
MOVW	R1, #lo_addr(_flag_t+6)
MOVT	R1, #hi_addr(_flag_t+6)
STRB	R2, [R1, #0]
;func.c,264 :: 		}
L_setHeaterStatus50:
;func.c,266 :: 		}
L_end_setHeaterStatus:
POP	(R15)
; end of _setHeaterStatus
_getHeaterStatus:
;func.c,268 :: 		unsigned char getHeaterStatus()
PUSH	(R14)
;func.c,270 :: 		return flag_t.heater_status;
MOVW	R0, #lo_addr(_flag_t+6)
MOVT	R0, #hi_addr(_flag_t+6)
LDRB	R0, [R0, #0]
;func.c,271 :: 		}
L_end_getHeaterStatus:
POP	(R15)
; end of _getHeaterStatus
_ReadyAlarm_f:
;func.c,273 :: 		void ReadyAlarm_f()
PUSH	(R14)
SUB	SP, SP, #4
;func.c,276 :: 		setAdcControlStatus(RESET);
MOVS	R0, #0
BL	_setAdcControlStatus+0
;func.c,278 :: 		switch(ra_count++)
MOVW	R1, #lo_addr(ReadyAlarm_f_ra_count_L0+0)
MOVT	R1, #hi_addr(ReadyAlarm_f_ra_count_L0+0)
LDRH	R0, [R1, #0]
STR	R0, [SP, #0]
MOV	R0, R1
LDRH	R0, [R0, #0]
ADDS	R0, #1
STRH	R0, [R1, #0]
IT	AL
BLAL	L_ReadyAlarm_f51
;func.c,280 :: 		case     11:    BUZER = ON;      break;
L_ReadyAlarm_f53:
MOVW	R2, #lo_addr(BUZER+0)
MOVT	R2, #hi_addr(BUZER+0)
_LX	[R2, ByteOffset(BUZER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(BUZER+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(BUZER+0)]
IT	AL
BLAL	L_ReadyAlarm_f52
;func.c,281 :: 		case    200:    BUZER = OFF;     break;
L_ReadyAlarm_f54:
MOVW	R2, #lo_addr(BUZER+0)
MOVT	R2, #hi_addr(BUZER+0)
_LX	[R2, ByteOffset(BUZER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(BUZER+0)
BICS	R0, R1
_SX	[R2, ByteOffset(BUZER+0)]
IT	AL
BLAL	L_ReadyAlarm_f52
;func.c,282 :: 		case    260:    BUZER = ON;      break;
L_ReadyAlarm_f55:
MOVW	R2, #lo_addr(BUZER+0)
MOVT	R2, #hi_addr(BUZER+0)
_LX	[R2, ByteOffset(BUZER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(BUZER+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(BUZER+0)]
IT	AL
BLAL	L_ReadyAlarm_f52
;func.c,283 :: 		case    340:    BUZER = OFF;
L_ReadyAlarm_f56:
MOVW	R2, #lo_addr(BUZER+0)
MOVT	R2, #hi_addr(BUZER+0)
_LX	[R2, ByteOffset(BUZER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(BUZER+0)
BICS	R0, R1
_SX	[R2, ByteOffset(BUZER+0)]
;func.c,284 :: 		ra_count= 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ReadyAlarm_f_ra_count_L0+0)
MOVT	R0, #hi_addr(ReadyAlarm_f_ra_count_L0+0)
STRH	R1, [R0, #0]
;func.c,285 :: 		resetLB();
BL	_resetLB+0
;func.c,286 :: 		setState(process);
MOVS	R0, #9
BL	_setState+0
;func.c,287 :: 		break;
IT	AL
BLAL	L_ReadyAlarm_f52
;func.c,288 :: 		}
L_ReadyAlarm_f51:
LDR	R1, [SP, #0]
UXTH	R1, R1
CMP	R1, #11
IT	EQ
BLEQ	L_ReadyAlarm_f53
CMP	R1, #200
IT	EQ
BLEQ	L_ReadyAlarm_f54
MOVS	R0, #255
ADDS	R0, #5
CMP	R1, R0
IT	EQ
BLEQ	L_ReadyAlarm_f55
MOVS	R0, #255
ADDS	R0, #85
CMP	R1, R0
IT	EQ
BLEQ	L_ReadyAlarm_f56
L_ReadyAlarm_f52:
;func.c,289 :: 		}
L_end_ReadyAlarm_f:
ADD	SP, SP, #4
POP	(R15)
; end of _ReadyAlarm_f
