_SensorAlarm:
;alarm_func.c,16 :: 		void SensorAlarm()
PUSH	(R14)
;alarm_func.c,18 :: 		setAdcControlStatus(SET);
MOVS	R0, #1
BL	_setAdcControlStatus+0
;alarm_func.c,19 :: 		setHeaterStatus(ON);
MOVS	R0, #1
BL	_setHeaterStatus+0
;alarm_func.c,20 :: 		if(getAdcStatus())
BL	_getAdcStatus+0
CMP	R0, #0
IT	EQ
BLEQ	L_SensorAlarm0
;alarm_func.c,22 :: 		LED_GREEN = ON;
MOVW	R2, #lo_addr(LED_GREEN+0)
MOVT	R2, #hi_addr(LED_GREEN+0)
_LX	[R2, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_GREEN+0)]
;alarm_func.c,23 :: 		switch(analogStatusAllChanell)
IT	AL
BLAL	L_SensorAlarm1
;alarm_func.c,25 :: 		case 0b00000001:           bs_alarm_signal();              break;
L_SensorAlarm3:
BL	_bs_alarm_signal+0
IT	AL
BLAL	L_SensorAlarm2
;alarm_func.c,26 :: 		case 0b00000010:           fs_alarm_signal();              break;
L_SensorAlarm4:
BL	_fs_alarm_signal+0
IT	AL
BLAL	L_SensorAlarm2
;alarm_func.c,27 :: 		case 0b00000100:           bcs_alarm_signal();             break;
L_SensorAlarm5:
BL	_bcs_alarm_signal+0
IT	AL
BLAL	L_SensorAlarm2
;alarm_func.c,28 :: 		case 0b00000011:           bs_fs_alarm_signal();           break;
L_SensorAlarm6:
BL	_bs_fs_alarm_signal+0
IT	AL
BLAL	L_SensorAlarm2
;alarm_func.c,29 :: 		case 0b00000111:           bs_fs_bcs_alarm_signal();       break;
L_SensorAlarm7:
BL	_bs_fs_bcs_alarm_signal+0
IT	AL
BLAL	L_SensorAlarm2
;alarm_func.c,30 :: 		case 0b00000110:           fs_bcs_alarm_signal();          break;
L_SensorAlarm8:
BL	_fs_bcs_alarm_signal+0
IT	AL
BLAL	L_SensorAlarm2
;alarm_func.c,31 :: 		case 0b00000101:           bs_bcs_alarm_signal();          break;
L_SensorAlarm9:
BL	_bs_bcs_alarm_signal+0
IT	AL
BLAL	L_SensorAlarm2
;alarm_func.c,32 :: 		case 0b00000000:           resetLB();
L_SensorAlarm10:
BL	_resetLB+0
;alarm_func.c,33 :: 		setState(process);              break;
MOVS	R0, #9
BL	_setState+0
IT	AL
BLAL	L_SensorAlarm2
;alarm_func.c,34 :: 		}
L_SensorAlarm1:
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BLEQ	L_SensorAlarm3
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BLEQ	L_SensorAlarm4
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BLEQ	L_SensorAlarm5
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BLEQ	L_SensorAlarm6
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	EQ
BLEQ	L_SensorAlarm7
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	EQ
BLEQ	L_SensorAlarm8
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BLEQ	L_SensorAlarm9
MOVW	R0, #lo_addr(_analogStatusAllChanell+0)
MOVT	R0, #hi_addr(_analogStatusAllChanell+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_SensorAlarm10
L_SensorAlarm2:
;alarm_func.c,36 :: 		}
IT	AL
BLAL	L_SensorAlarm11
L_SensorAlarm0:
;alarm_func.c,39 :: 		resetLB();
BL	_resetLB+0
;alarm_func.c,40 :: 		setState(process);
MOVS	R0, #9
BL	_setState+0
;alarm_func.c,41 :: 		}
L_SensorAlarm11:
;alarm_func.c,42 :: 		}
L_end_SensorAlarm:
POP	(R15)
; end of _SensorAlarm
_SensorDamage:
;alarm_func.c,44 :: 		void SensorDamage()
PUSH	(R14)
;alarm_func.c,46 :: 		if(getDamageSensorStatus())
BL	_getDamageSensorStatus+0
CMP	R0, #0
IT	EQ
BLEQ	L_SensorDamage12
;alarm_func.c,48 :: 		switch(AnalogSensorDamageControl)
IT	AL
BLAL	L_SensorDamage13
;alarm_func.c,50 :: 		case 0b00000001:           bs_damage_signal();              break;
L_SensorDamage15:
BL	_bs_damage_signal+0
IT	AL
BLAL	L_SensorDamage14
;alarm_func.c,51 :: 		case 0b00000010:           fs_damage_signal();              break;
L_SensorDamage16:
BL	_fs_damage_signal+0
IT	AL
BLAL	L_SensorDamage14
;alarm_func.c,52 :: 		case 0b00000100:           bcs_damage_signal();             break;
L_SensorDamage17:
BL	_bcs_damage_signal+0
IT	AL
BLAL	L_SensorDamage14
;alarm_func.c,53 :: 		case 0b00000011:           bs_fs_damage_signal();           break;
L_SensorDamage18:
BL	_bs_fs_damage_signal+0
IT	AL
BLAL	L_SensorDamage14
;alarm_func.c,54 :: 		case 0b00000111:           bs_fs_bcs_damage_signal();       break;
L_SensorDamage19:
BL	_bs_fs_bcs_damage_signal+0
IT	AL
BLAL	L_SensorDamage14
;alarm_func.c,55 :: 		case 0b00000110:           fs_bcs_damage_signal();          break;
L_SensorDamage20:
BL	_fs_bcs_damage_signal+0
IT	AL
BLAL	L_SensorDamage14
;alarm_func.c,56 :: 		case 0b00000101:           bs_bcs_damage_signal();          break;
L_SensorDamage21:
BL	_bs_bcs_damage_signal+0
IT	AL
BLAL	L_SensorDamage14
;alarm_func.c,57 :: 		case 0b00000000:           resetLB();
L_SensorDamage22:
BL	_resetLB+0
;alarm_func.c,58 :: 		setState(control_calibration);               break;
MOVS	R0, #1
BL	_setState+0
IT	AL
BLAL	L_SensorDamage14
;alarm_func.c,59 :: 		}
L_SensorDamage13:
MOVW	R0, #lo_addr(_AnalogSensorDamageControl+0)
MOVT	R0, #hi_addr(_AnalogSensorDamageControl+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BLEQ	L_SensorDamage15
MOVW	R0, #lo_addr(_AnalogSensorDamageControl+0)
MOVT	R0, #hi_addr(_AnalogSensorDamageControl+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BLEQ	L_SensorDamage16
MOVW	R0, #lo_addr(_AnalogSensorDamageControl+0)
MOVT	R0, #hi_addr(_AnalogSensorDamageControl+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BLEQ	L_SensorDamage17
MOVW	R0, #lo_addr(_AnalogSensorDamageControl+0)
MOVT	R0, #hi_addr(_AnalogSensorDamageControl+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BLEQ	L_SensorDamage18
MOVW	R0, #lo_addr(_AnalogSensorDamageControl+0)
MOVT	R0, #hi_addr(_AnalogSensorDamageControl+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	EQ
BLEQ	L_SensorDamage19
MOVW	R0, #lo_addr(_AnalogSensorDamageControl+0)
MOVT	R0, #hi_addr(_AnalogSensorDamageControl+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	EQ
BLEQ	L_SensorDamage20
MOVW	R0, #lo_addr(_AnalogSensorDamageControl+0)
MOVT	R0, #hi_addr(_AnalogSensorDamageControl+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BLEQ	L_SensorDamage21
MOVW	R0, #lo_addr(_AnalogSensorDamageControl+0)
MOVT	R0, #hi_addr(_AnalogSensorDamageControl+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_SensorDamage22
L_SensorDamage14:
;alarm_func.c,61 :: 		}
IT	AL
BLAL	L_SensorDamage23
L_SensorDamage12:
;alarm_func.c,64 :: 		resetLB();
BL	_resetLB+0
;alarm_func.c,65 :: 		setState(control_calibration);
MOVS	R0, #1
BL	_setState+0
;alarm_func.c,66 :: 		}
L_SensorDamage23:
;alarm_func.c,67 :: 		}
L_end_SensorDamage:
POP	(R15)
; end of _SensorDamage
_bs_alarm_signal:
;alarm_func.c,69 :: 		void bs_alarm_signal()
PUSH	(R14)
;alarm_func.c,71 :: 		WriteVarToArray(data_ar, bs_var,32);
MOVW	R0, #lo_addr(_bs_var+0)
MOVT	R0, #hi_addr(_bs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,72 :: 		Sequence(data_ar,14,TRUE);
MOVS	R2, #1
MOVS	R1, #14
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,73 :: 		}
L_end_bs_alarm_signal:
POP	(R15)
; end of _bs_alarm_signal
_fs_alarm_signal:
;alarm_func.c,75 :: 		void fs_alarm_signal()
PUSH	(R14)
;alarm_func.c,77 :: 		WriteVarToArray(data_ar, fs_var,32);
MOVW	R0, #lo_addr(_fs_var+0)
MOVT	R0, #hi_addr(_fs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,78 :: 		Sequence(data_ar,16,TRUE);
MOVS	R2, #1
MOVS	R1, #16
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,79 :: 		}
L_end_fs_alarm_signal:
POP	(R15)
; end of _fs_alarm_signal
_bcs_alarm_signal:
;alarm_func.c,81 :: 		void bcs_alarm_signal()
PUSH	(R14)
;alarm_func.c,83 :: 		WriteVarToArray(data_ar, bcs_var,32);
MOVW	R0, #lo_addr(_bcs_var+0)
MOVT	R0, #hi_addr(_bcs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,84 :: 		Sequence(data_ar,18,TRUE);
MOVS	R2, #1
MOVS	R1, #18
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,85 :: 		}
L_end_bcs_alarm_signal:
POP	(R15)
; end of _bcs_alarm_signal
_bs_fs_alarm_signal:
;alarm_func.c,87 :: 		void bs_fs_alarm_signal()
PUSH	(R14)
;alarm_func.c,89 :: 		WriteVarToArray(data_ar, bs_fs_var,32);
MOVW	R0, #lo_addr(_bs_fs_var+0)
MOVT	R0, #hi_addr(_bs_fs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,90 :: 		Sequence(data_ar,21,TRUE);
MOVS	R2, #1
MOVS	R1, #21
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,91 :: 		}
L_end_bs_fs_alarm_signal:
POP	(R15)
; end of _bs_fs_alarm_signal
_bs_bcs_alarm_signal:
;alarm_func.c,93 :: 		void bs_bcs_alarm_signal()
PUSH	(R14)
;alarm_func.c,95 :: 		WriteVarToArray(data_ar, bs_bcs_var,32);
MOVW	R0, #lo_addr(_bs_bcs_var+0)
MOVT	R0, #hi_addr(_bs_bcs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,96 :: 		Sequence(data_ar,23,TRUE);
MOVS	R2, #1
MOVS	R1, #23
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,97 :: 		}
L_end_bs_bcs_alarm_signal:
POP	(R15)
; end of _bs_bcs_alarm_signal
_fs_bcs_alarm_signal:
;alarm_func.c,99 :: 		void fs_bcs_alarm_signal()
PUSH	(R14)
;alarm_func.c,101 :: 		WriteVarToArray(data_ar, fs_bcs_var,32);
MOVW	R0, #lo_addr(_fs_bcs_var+0)
MOVT	R0, #hi_addr(_fs_bcs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,102 :: 		Sequence(data_ar,25,TRUE);
MOVS	R2, #1
MOVS	R1, #25
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,103 :: 		}
L_end_fs_bcs_alarm_signal:
POP	(R15)
; end of _fs_bcs_alarm_signal
_bs_fs_bcs_alarm_signal:
;alarm_func.c,106 :: 		void bs_fs_bcs_alarm_signal()
PUSH	(R14)
;alarm_func.c,108 :: 		WriteVarToArray(data_ar, bs_fs_bcs_var,32);
MOVW	R0, #lo_addr(_bs_fs_bcs_var+0)
MOVT	R0, #hi_addr(_bs_fs_bcs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,109 :: 		Sequence(data_ar,30,TRUE);
MOVS	R2, #1
MOVS	R1, #30
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,110 :: 		}
L_end_bs_fs_bcs_alarm_signal:
POP	(R15)
; end of _bs_fs_bcs_alarm_signal
_bs_damage_signal:
;alarm_func.c,113 :: 		void bs_damage_signal()
PUSH	(R14)
;alarm_func.c,115 :: 		WriteVarToArray(data_ar, bs_var,32);
MOVW	R0, #lo_addr(_bs_var+0)
MOVT	R0, #hi_addr(_bs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,116 :: 		Sequence(data_ar,14,FALSE);
MOVS	R2, #0
MOVS	R1, #14
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,117 :: 		}
L_end_bs_damage_signal:
POP	(R15)
; end of _bs_damage_signal
_fs_damage_signal:
;alarm_func.c,119 :: 		void fs_damage_signal()
PUSH	(R14)
;alarm_func.c,121 :: 		WriteVarToArray(data_ar, fs_var,32);
MOVW	R0, #lo_addr(_fs_var+0)
MOVT	R0, #hi_addr(_fs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,122 :: 		Sequence(data_ar,16,FALSE);
MOVS	R2, #0
MOVS	R1, #16
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,123 :: 		}
L_end_fs_damage_signal:
POP	(R15)
; end of _fs_damage_signal
_bcs_damage_signal:
;alarm_func.c,125 :: 		void bcs_damage_signal()
PUSH	(R14)
;alarm_func.c,127 :: 		WriteVarToArray(data_ar, bcs_var,32);
MOVW	R0, #lo_addr(_bcs_var+0)
MOVT	R0, #hi_addr(_bcs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,128 :: 		Sequence(data_ar,18,FALSE);
MOVS	R2, #0
MOVS	R1, #18
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,129 :: 		}
L_end_bcs_damage_signal:
POP	(R15)
; end of _bcs_damage_signal
_bs_fs_damage_signal:
;alarm_func.c,131 :: 		void bs_fs_damage_signal()
PUSH	(R14)
;alarm_func.c,133 :: 		WriteVarToArray(data_ar, bs_fs_var,32);
MOVW	R0, #lo_addr(_bs_fs_var+0)
MOVT	R0, #hi_addr(_bs_fs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,134 :: 		Sequence(data_ar,21,FALSE);
MOVS	R2, #0
MOVS	R1, #21
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,135 :: 		}
L_end_bs_fs_damage_signal:
POP	(R15)
; end of _bs_fs_damage_signal
_bs_bcs_damage_signal:
;alarm_func.c,137 :: 		void bs_bcs_damage_signal()
PUSH	(R14)
;alarm_func.c,139 :: 		WriteVarToArray(data_ar, bs_bcs_var,32);
MOVW	R0, #lo_addr(_bs_bcs_var+0)
MOVT	R0, #hi_addr(_bs_bcs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,140 :: 		Sequence(data_ar,23,FALSE);
MOVS	R2, #0
MOVS	R1, #23
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,141 :: 		}
L_end_bs_bcs_damage_signal:
POP	(R15)
; end of _bs_bcs_damage_signal
_fs_bcs_damage_signal:
;alarm_func.c,143 :: 		void fs_bcs_damage_signal()
PUSH	(R14)
;alarm_func.c,145 :: 		WriteVarToArray(data_ar, fs_bcs_var,32);
MOVW	R0, #lo_addr(_fs_bcs_var+0)
MOVT	R0, #hi_addr(_fs_bcs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,146 :: 		Sequence(data_ar,25,FALSE);
MOVS	R2, #0
MOVS	R1, #25
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,147 :: 		}
L_end_fs_bcs_damage_signal:
POP	(R15)
; end of _fs_bcs_damage_signal
_bs_fs_bcs_damage_signal:
;alarm_func.c,150 :: 		void bs_fs_bcs_damage_signal()
PUSH	(R14)
;alarm_func.c,152 :: 		WriteVarToArray(data_ar, bs_fs_bcs_var,32);
MOVW	R0, #lo_addr(_bs_fs_bcs_var+0)
MOVT	R0, #hi_addr(_bs_fs_bcs_var+0)
LDR	R0, [R0, #0]
MOVS	R2, #32
MOV	R1, R0
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_WriteVarToArray+0
;alarm_func.c,153 :: 		Sequence(data_ar,30,FALSE);
MOVS	R2, #0
MOVS	R1, #30
MOVW	R0, #lo_addr(_data_ar+0)
MOVT	R0, #hi_addr(_data_ar+0)
BL	_Sequence+0
;alarm_func.c,154 :: 		}
L_end_bs_fs_bcs_damage_signal:
POP	(R15)
; end of _bs_fs_bcs_damage_signal
_WriteVarToArray:
;alarm_func.c,156 :: 		void WriteVarToArray(unsigned char* data_ar_local, unsigned long var,unsigned char num_of_char)
; num_of_char start address is: 8 (R2)
; var start address is: 4 (R1)
; data_ar_local start address is: 0 (R0)
PUSH	(R14)
UXTB	R3, R2
; num_of_char end address is: 8 (R2)
; var end address is: 4 (R1)
; data_ar_local end address is: 0 (R0)
; data_ar_local start address is: 0 (R0)
; var start address is: 4 (R1)
; num_of_char start address is: 12 (R3)
;alarm_func.c,159 :: 		for(i = 0;i < num_of_char;i++)
; i start address is: 8 (R2)
MOVS	R2, #0
; data_ar_local end address is: 0 (R0)
; var end address is: 4 (R1)
; num_of_char end address is: 12 (R3)
; i end address is: 8 (R2)
MOV	R5, R1
MOV	R1, R0
UXTB	R0, R3
L_WriteVarToArray24:
; i start address is: 8 (R2)
; data_ar_local start address is: 4 (R1)
; num_of_char start address is: 0 (R0)
; var start address is: 20 (R5)
; data_ar_local start address is: 4 (R1)
; data_ar_local end address is: 4 (R1)
CMP	R2, R0
IT	CS
BLCS	L_WriteVarToArray25
; data_ar_local end address is: 4 (R1)
;alarm_func.c,161 :: 		data_ar_local[i] = 0;
; data_ar_local start address is: 4 (R1)
ADDS	R4, R1, R2
MOVS	R3, #0
STRB	R3, [R4, #0]
;alarm_func.c,162 :: 		data_ar_local[i] = ((var&0x80000000)>>31);
ADDS	R4, R1, R2
MOVW	R3, #0
MOVT	R3, #32768
ANDS	R3, R5
LSRS	R3, R3, #31
STRB	R3, [R4, #0]
;alarm_func.c,163 :: 		var = var<<1;
LSLS	R5, R5, #1
;alarm_func.c,159 :: 		for(i = 0;i < num_of_char;i++)
ADDS	R2, #1
UXTB	R2, R2
;alarm_func.c,164 :: 		}
; num_of_char end address is: 0 (R0)
; data_ar_local end address is: 4 (R1)
; var end address is: 20 (R5)
; i end address is: 8 (R2)
IT	AL
BLAL	L_WriteVarToArray24
L_WriteVarToArray25:
;alarm_func.c,165 :: 		}
L_end_WriteVarToArray:
POP	(R15)
; end of _WriteVarToArray
_Sequence:
;alarm_func.c,167 :: 		void Sequence(unsigned char* seq_data,unsigned char count_digit_led,unsigned char buz_en)
; buz_en start address is: 8 (R2)
; count_digit_led start address is: 4 (R1)
; seq_data start address is: 0 (R0)
PUSH	(R14)
; buz_en end address is: 8 (R2)
; count_digit_led end address is: 4 (R1)
; seq_data end address is: 0 (R0)
; seq_data start address is: 0 (R0)
; count_digit_led start address is: 4 (R1)
; buz_en start address is: 8 (R2)
;alarm_func.c,170 :: 		if((loop_count++)>9)
MOVW	R5, #lo_addr(Sequence_loop_count_L0+0)
MOVT	R5, #hi_addr(Sequence_loop_count_L0+0)
LDRB	R4, [R5, #0]
MOV	R3, R5
LDRB	R3, [R3, #0]
ADDS	R3, #1
STRB	R3, [R5, #0]
CMP	R4, #9
IT	LS
BLLS	L_Sequence27
;alarm_func.c,172 :: 		loop_count = 0;
MOVS	R4, #0
MOVW	R3, #lo_addr(Sequence_loop_count_L0+0)
MOVT	R3, #hi_addr(Sequence_loop_count_L0+0)
STRB	R4, [R3, #0]
;alarm_func.c,173 :: 		if( seq_data[blink_loop_led]==SET)
MOVW	R3, #lo_addr(Sequence_blink_loop_led_L0+0)
MOVT	R3, #hi_addr(Sequence_blink_loop_led_L0+0)
LDRB	R3, [R3, #0]
ADDS	R3, R0, R3
; seq_data end address is: 0 (R0)
LDRB	R3, [R3, #0]
CMP	R3, #1
IT	NE
BLNE	L_Sequence28
;alarm_func.c,175 :: 		LED_RED        = ON;
MOVW	R5, #lo_addr(LED_RED+0)
MOVT	R5, #hi_addr(LED_RED+0)
_LX	[R5, ByteOffset(LED_RED+0)]
MOVS	R4, #1
LSLS	R4, R4, BitPos(LED_RED+0)
ORRS	R3, R4
_SX	[R5, ByteOffset(LED_RED+0)]
;alarm_func.c,176 :: 		if(buz_en)
CMP	R2, #0
IT	EQ
BLEQ	L_Sequence29
; buz_en end address is: 8 (R2)
;alarm_func.c,178 :: 		BUZER          = ON;
MOVW	R5, #lo_addr(BUZER+0)
MOVT	R5, #hi_addr(BUZER+0)
_LX	[R5, ByteOffset(BUZER+0)]
MOVS	R4, #1
LSLS	R4, R4, BitPos(BUZER+0)
ORRS	R3, R4
_SX	[R5, ByteOffset(BUZER+0)]
;alarm_func.c,179 :: 		}
IT	AL
BLAL	L_Sequence30
L_Sequence29:
;alarm_func.c,182 :: 		BUZER          = OFF;
MOVW	R5, #lo_addr(BUZER+0)
MOVT	R5, #hi_addr(BUZER+0)
_LX	[R5, ByteOffset(BUZER+0)]
MOVS	R4, #1
LSLS	R4, R4, BitPos(BUZER+0)
BICS	R3, R4
_SX	[R5, ByteOffset(BUZER+0)]
;alarm_func.c,183 :: 		}
L_Sequence30:
;alarm_func.c,185 :: 		}
IT	AL
BLAL	L_Sequence31
L_Sequence28:
;alarm_func.c,188 :: 		LED_RED        = OFF;
MOVW	R5, #lo_addr(LED_RED+0)
MOVT	R5, #hi_addr(LED_RED+0)
_LX	[R5, ByteOffset(LED_RED+0)]
MOVS	R4, #1
LSLS	R4, R4, BitPos(LED_RED+0)
BICS	R3, R4
_SX	[R5, ByteOffset(LED_RED+0)]
;alarm_func.c,189 :: 		BUZER          = OFF;
MOVW	R5, #lo_addr(BUZER+0)
MOVT	R5, #hi_addr(BUZER+0)
_LX	[R5, ByteOffset(BUZER+0)]
MOVS	R4, #1
LSLS	R4, R4, BitPos(BUZER+0)
BICS	R3, R4
_SX	[R5, ByteOffset(BUZER+0)]
;alarm_func.c,190 :: 		}
L_Sequence31:
;alarm_func.c,192 :: 		if((blink_loop_led++)>=count_digit_led)
MOVW	R5, #lo_addr(Sequence_blink_loop_led_L0+0)
MOVT	R5, #hi_addr(Sequence_blink_loop_led_L0+0)
LDRB	R4, [R5, #0]
MOV	R3, R5
LDRB	R3, [R3, #0]
ADDS	R3, #1
STRB	R3, [R5, #0]
CMP	R4, R1
IT	CC
BLCC	L_Sequence32
; count_digit_led end address is: 4 (R1)
;alarm_func.c,194 :: 		blink_loop_led = 0;
MOVS	R4, #0
MOVW	R3, #lo_addr(Sequence_blink_loop_led_L0+0)
MOVT	R3, #hi_addr(Sequence_blink_loop_led_L0+0)
STRB	R4, [R3, #0]
;alarm_func.c,195 :: 		}
L_Sequence32:
;alarm_func.c,196 :: 		}
L_Sequence27:
;alarm_func.c,197 :: 		}
L_end_Sequence:
POP	(R15)
; end of _Sequence
_resetLB:
;alarm_func.c,199 :: 		void resetLB()
;alarm_func.c,201 :: 		LED_RED        = OFF;
MOVW	R2, #lo_addr(LED_RED+0)
MOVT	R2, #hi_addr(LED_RED+0)
_LX	[R2, ByteOffset(LED_RED+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
BICS	R0, R1
_SX	[R2, ByteOffset(LED_RED+0)]
;alarm_func.c,202 :: 		LED_GREEN      = OFF;
MOVW	R2, #lo_addr(LED_GREEN+0)
MOVT	R2, #hi_addr(LED_GREEN+0)
_LX	[R2, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
BICS	R0, R1
_SX	[R2, ByteOffset(LED_GREEN+0)]
;alarm_func.c,203 :: 		BUZER          = OFF;
MOVW	R2, #lo_addr(BUZER+0)
MOVT	R2, #hi_addr(BUZER+0)
_LX	[R2, ByteOffset(BUZER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(BUZER+0)
BICS	R0, R1
_SX	[R2, ByteOffset(BUZER+0)]
;alarm_func.c,204 :: 		}
L_end_resetLB:
BX	LR
; end of _resetLB
_setLB:
;alarm_func.c,206 :: 		void setLB()
;alarm_func.c,208 :: 		LED_RED        = ON;
MOVW	R2, #lo_addr(LED_RED+0)
MOVT	R2, #hi_addr(LED_RED+0)
_LX	[R2, ByteOffset(LED_RED+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_RED+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_RED+0)]
;alarm_func.c,209 :: 		LED_GREEN      = ON;
MOVW	R2, #lo_addr(LED_GREEN+0)
MOVT	R2, #hi_addr(LED_GREEN+0)
_LX	[R2, ByteOffset(LED_GREEN+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_GREEN+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_GREEN+0)]
;alarm_func.c,210 :: 		BUZER          = ON;
MOVW	R2, #lo_addr(BUZER+0)
MOVT	R2, #hi_addr(BUZER+0)
_LX	[R2, ByteOffset(BUZER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(BUZER+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(BUZER+0)]
;alarm_func.c,211 :: 		}
L_end_setLB:
BX	LR
; end of _setLB
_resetAllHeater:
;alarm_func.c,213 :: 		void resetAllHeater()
;alarm_func.c,215 :: 		BOARD_HEATER     = OFF;
MOVW	R2, #lo_addr(BOARD_HEATER+0)
MOVT	R2, #hi_addr(BOARD_HEATER+0)
_LX	[R2, ByteOffset(BOARD_HEATER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(BOARD_HEATER+0)
BICS	R0, R1
_SX	[R2, ByteOffset(BOARD_HEATER+0)]
;alarm_func.c,216 :: 		FORWARD_HEATER   = OFF;
MOVW	R2, #lo_addr(FORWARD_HEATER+0)
MOVT	R2, #hi_addr(FORWARD_HEATER+0)
_LX	[R2, ByteOffset(FORWARD_HEATER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(FORWARD_HEATER+0)
BICS	R0, R1
_SX	[R2, ByteOffset(FORWARD_HEATER+0)]
;alarm_func.c,217 :: 		BACKWARD_HEATER  = OFF;
MOVW	R2, #lo_addr(BACKWARD_HEATER+0)
MOVT	R2, #hi_addr(BACKWARD_HEATER+0)
_LX	[R2, ByteOffset(BACKWARD_HEATER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(BACKWARD_HEATER+0)
BICS	R0, R1
_SX	[R2, ByteOffset(BACKWARD_HEATER+0)]
;alarm_func.c,218 :: 		}
L_end_resetAllHeater:
BX	LR
; end of _resetAllHeater
_setAllHeater:
;alarm_func.c,220 :: 		void setAllHeater()
;alarm_func.c,222 :: 		BOARD_HEATER     = ON;
MOVW	R2, #lo_addr(BOARD_HEATER+0)
MOVT	R2, #hi_addr(BOARD_HEATER+0)
_LX	[R2, ByteOffset(BOARD_HEATER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(BOARD_HEATER+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(BOARD_HEATER+0)]
;alarm_func.c,223 :: 		FORWARD_HEATER   = ON;
MOVW	R2, #lo_addr(FORWARD_HEATER+0)
MOVT	R2, #hi_addr(FORWARD_HEATER+0)
_LX	[R2, ByteOffset(FORWARD_HEATER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(FORWARD_HEATER+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(FORWARD_HEATER+0)]
;alarm_func.c,224 :: 		BACKWARD_HEATER  = ON;
MOVW	R2, #lo_addr(BACKWARD_HEATER+0)
MOVT	R2, #hi_addr(BACKWARD_HEATER+0)
_LX	[R2, ByteOffset(BACKWARD_HEATER+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(BACKWARD_HEATER+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(BACKWARD_HEATER+0)]
;alarm_func.c,225 :: 		}
L_end_setAllHeater:
BX	LR
; end of _setAllHeater
