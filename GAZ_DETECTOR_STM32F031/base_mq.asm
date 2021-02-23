_calculatePPM:
;base_mq.c,3 :: 		double calculatePPM(double adcValue,double R0,double cal_data)
; cal_data start address is: 8 (R2)
; R0 start address is: 4 (R1)
; adcValue start address is: 0 (R0)
PUSH	(R14)
; cal_data end address is: 8 (R2)
; R0 end address is: 4 (R1)
; adcValue end address is: 0 (R0)
; adcValue start address is: 0 (R0)
; R0 start address is: 4 (R1)
; cal_data start address is: 8 (R2)
;base_mq.c,5 :: 		return  (double) map((double)adcValue,(double)R0,(double)cal_data,0,MAX_GAS_LEVEL);
MOVW	R3, #16384
MOVT	R3, #17948
PUSH	(R3)
MOVS	R3, #0
; cal_data end address is: 8 (R2)
; R0 end address is: 4 (R1)
; adcValue end address is: 0 (R0)
BL	_map+0
ADD	SP, SP, #4
;base_mq.c,6 :: 		}
L_end_calculatePPM:
POP	(R15)
; end of _calculatePPM
_map:
;base_mq.c,8 :: 		double map(double x, double in_min, double in_max, double out_min, double out_max)
; x start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #24
STR	R1, [SP, #0]
STR	R2, [SP, #4]
STR	R3, [SP, #8]
; x end address is: 0 (R0)
; x start address is: 0 (R0)
LDR	R4, [SP, #28]
STR	R4, [SP, #28]
;base_mq.c,10 :: 		return (double)(x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
LDR	R2, [SP, #0]
BL	__Sub_FP+0
; x end address is: 0 (R0)
MOV	R4, R0
STR	R4, [SP, #20]
LDR	R2, [SP, #8]
LDR	R0, [SP, #28]
BL	__Sub_FP+0
LDR	R2, [SP, #20]
BL	__Mul_FP+0
STR	R0, [SP, #20]
LDR	R2, [SP, #0]
LDR	R0, [SP, #4]
BL	__Sub_FP+0
STR	R0, [SP, #12]
LDR	R2, [SP, #12]
LDR	R0, [SP, #20]
BL	__Div_FP+0
LDR	R2, [SP, #8]
BL	__Add_FP+0
;base_mq.c,11 :: 		}
L_end_map:
ADD	SP, SP, #24
POP	(R15)
; end of _map
_getR0:
;base_mq.c,13 :: 		float getR0(float Rl,float  adcValue,float koef, float volt, float adcRange)
; volt start address is: 12 (R3)
; adcValue start address is: 4 (R1)
PUSH	(R14)
SUB	SP, SP, #20
STR	R0, [SP, #4]
MOV	R0, R1
STR	R2, [SP, #8]
MOV	R7, R3
; volt end address is: 12 (R3)
; adcValue end address is: 4 (R1)
; adcValue start address is: 0 (R0)
; volt start address is: 28 (R7)
; adcRange start address is: 4 (R1)
LDR	R1, [SP, #24]
;base_mq.c,18 :: 		Vrl = (float)adcValue * (volt / adcRange); //Convert analog values to voltage
MOV	R4, R0
; adcValue end address is: 0 (R0)
STR	R4, [SP, #16]
MOV	R2, R1
MOV	R0, R7
BL	__Div_FP+0
; adcRange end address is: 4 (R1)
LDR	R2, [SP, #16]
BL	__Mul_FP+0
STR	R0, [SP, #12]
LDR	R4, [SP, #12]
STR	R4, [SP, #0]
;base_mq.c,19 :: 		Rs  = (((volt - Vrl) / Vrl) * Rl);         //Calculate sensor resistance
LDR	R2, [SP, #12]
MOV	R0, R7
BL	__Sub_FP+0
; volt end address is: 28 (R7)
LDR	R2, [SP, #0]
BL	__Div_FP+0
LDR	R2, [SP, #4]
BL	__Mul_FP+0
;base_mq.c,20 :: 		R0 = (Rs / koef);
LDR	R2, [SP, #8]
BL	__Div_FP+0
;base_mq.c,21 :: 		return R0;
;base_mq.c,22 :: 		}
L_end_getR0:
ADD	SP, SP, #20
POP	(R15)
; end of _getR0
