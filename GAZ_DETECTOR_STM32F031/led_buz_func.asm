_Blink_buz_func:
;led_buz_func.c,5 :: 		char out,char count_digit,char new_state,char enable_new_state,unsigned char after_count)
; count_digit start address is: 12 (R3)
; count_loop1 start address is: 4 (R1)
; blink_mode start address is: 0 (R0)
PUSH	(R14)
UXTH	R5, R0
UXTB	R7, R1
; count_digit end address is: 12 (R3)
; count_loop1 end address is: 4 (R1)
; blink_mode end address is: 0 (R0)
; blink_mode start address is: 20 (R5)
; count_loop1 start address is: 28 (R7)
; count_digit start address is: 12 (R3)
; new_state start address is: 0 (R0)
LDR	R0, [SP, #4]
UXTB	R0, R0
; enable_new_state start address is: 4 (R1)
LDR	R1, [SP, #8]
UXTB	R1, R1
; after_count start address is: 8 (R2)
LDR	R2, [SP, #12]
UXTB	R2, R2
;led_buz_func.c,11 :: 		s_blink_mode = blink_mode;
MOVW	R4, #lo_addr(Blink_buz_func_s_blink_mode_L0+0)
MOVT	R4, #hi_addr(Blink_buz_func_s_blink_mode_L0+0)
STRH	R5, [R4, #0]
; blink_mode end address is: 20 (R5)
;led_buz_func.c,13 :: 		if(((count_loop++)>=count_loop1)&&end_buzzer==RESET)
MOVW	R6, #lo_addr(Blink_buz_func_count_loop_L0+0)
MOVT	R6, #hi_addr(Blink_buz_func_count_loop_L0+0)
LDRB	R5, [R6, #0]
MOV	R4, R6
LDRB	R4, [R4, #0]
ADDS	R4, #1
STRB	R4, [R6, #0]
CMP	R5, R7
IT	CC
BLCC	L__Blink_buz_func34
; count_loop1 end address is: 28 (R7)
MOVW	R4, #lo_addr(Blink_buz_func_end_buzzer_L0+0)
MOVT	R4, #hi_addr(Blink_buz_func_end_buzzer_L0+0)
LDRB	R4, [R4, #0]
CMP	R4, #0
IT	NE
BLNE	L__Blink_buz_func33
L__Blink_buz_func32:
;led_buz_func.c,15 :: 		count_loop = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_buz_func_count_loop_L0+0)
MOVT	R4, #hi_addr(Blink_buz_func_count_loop_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,17 :: 		if(s_blink_mode & 1<<(blink_loop&0x07))
MOVW	R4, #lo_addr(Blink_buz_func_blink_loop_L0+0)
MOVT	R4, #hi_addr(Blink_buz_func_blink_loop_L0+0)
LDRB	R5, [R4, #0]
MOVS	R4, #7
MOV	R6, R5
ANDS	R6, R4
UXTB	R6, R6
MOVS	R4, #1
MOV	R5, R4
LSLS	R5, R6
SXTH	R5, R5
MOVW	R4, #lo_addr(Blink_buz_func_s_blink_mode_L0+0)
MOVT	R4, #hi_addr(Blink_buz_func_s_blink_mode_L0+0)
LDRH	R4, [R4, #0]
ANDS	R4, R5
UXTH	R4, R4
CMP	R4, #0
IT	EQ
BLEQ	L_Blink_buz_func3
;led_buz_func.c,19 :: 		BUZER = ON;
MOVW	R6, #lo_addr(BUZER+0)
MOVT	R6, #hi_addr(BUZER+0)
_LX	[R6, ByteOffset(BUZER+0)]
MOVS	R5, #1
LSLS	R5, R5, BitPos(BUZER+0)
ORRS	R4, R5
_SX	[R6, ByteOffset(BUZER+0)]
;led_buz_func.c,20 :: 		}
IT	AL
BLAL	L_Blink_buz_func4
L_Blink_buz_func3:
;led_buz_func.c,23 :: 		BUZER = OFF;
MOVW	R6, #lo_addr(BUZER+0)
MOVT	R6, #hi_addr(BUZER+0)
_LX	[R6, ByteOffset(BUZER+0)]
MOVS	R5, #1
LSLS	R5, R5, BitPos(BUZER+0)
BICS	R4, R5
_SX	[R6, ByteOffset(BUZER+0)]
;led_buz_func.c,24 :: 		}
L_Blink_buz_func4:
;led_buz_func.c,26 :: 		if((blink_loop++)>=count_digit)
MOVW	R6, #lo_addr(Blink_buz_func_blink_loop_L0+0)
MOVT	R6, #hi_addr(Blink_buz_func_blink_loop_L0+0)
LDRB	R5, [R6, #0]
MOV	R4, R6
LDRB	R4, [R4, #0]
ADDS	R4, #1
STRB	R4, [R6, #0]
CMP	R5, R3
IT	CC
BLCC	L_Blink_buz_func5
; count_digit end address is: 12 (R3)
;led_buz_func.c,28 :: 		blink_loop = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_buz_func_blink_loop_L0+0)
MOVT	R4, #hi_addr(Blink_buz_func_blink_loop_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,29 :: 		end_buzzer=SET;
MOVS	R5, #1
MOVW	R4, #lo_addr(Blink_buz_func_end_buzzer_L0+0)
MOVT	R4, #hi_addr(Blink_buz_func_end_buzzer_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,31 :: 		}
L_Blink_buz_func5:
;led_buz_func.c,13 :: 		if(((count_loop++)>=count_loop1)&&end_buzzer==RESET)
L__Blink_buz_func34:
L__Blink_buz_func33:
;led_buz_func.c,35 :: 		if((end_buzzer==SET)&&((after_count_s++)>=after_count))
MOVW	R4, #lo_addr(Blink_buz_func_end_buzzer_L0+0)
MOVT	R4, #hi_addr(Blink_buz_func_end_buzzer_L0+0)
LDRB	R4, [R4, #0]
CMP	R4, #1
IT	NE
BLNE	L__Blink_buz_func36
MOVW	R6, #lo_addr(Blink_buz_func_after_count_s_L0+0)
MOVT	R6, #hi_addr(Blink_buz_func_after_count_s_L0+0)
LDRB	R5, [R6, #0]
MOV	R4, R6
LDRB	R4, [R4, #0]
ADDS	R4, #1
STRB	R4, [R6, #0]
CMP	R5, R2
IT	CC
BLCC	L__Blink_buz_func35
; after_count end address is: 8 (R2)
L__Blink_buz_func31:
;led_buz_func.c,37 :: 		BUZER = OFF;
MOVW	R6, #lo_addr(BUZER+0)
MOVT	R6, #hi_addr(BUZER+0)
_LX	[R6, ByteOffset(BUZER+0)]
MOVS	R5, #1
LSLS	R5, R5, BitPos(BUZER+0)
BICS	R4, R5
_SX	[R6, ByteOffset(BUZER+0)]
;led_buz_func.c,38 :: 		end_buzzer=RESET;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_buz_func_end_buzzer_L0+0)
MOVT	R4, #hi_addr(Blink_buz_func_end_buzzer_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,39 :: 		after_count_s = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_buz_func_after_count_s_L0+0)
MOVT	R4, #hi_addr(Blink_buz_func_after_count_s_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,40 :: 		count_loop = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_buz_func_count_loop_L0+0)
MOVT	R4, #hi_addr(Blink_buz_func_count_loop_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,41 :: 		if(enable_new_state)
CMP	R1, #0
IT	EQ
BLEQ	L_Blink_buz_func9
; enable_new_state end address is: 4 (R1)
;led_buz_func.c,43 :: 		setState(new_state);
; new_state end address is: 0 (R0)
BL	_setState+0
;led_buz_func.c,44 :: 		}
L_Blink_buz_func9:
;led_buz_func.c,35 :: 		if((end_buzzer==SET)&&((after_count_s++)>=after_count))
L__Blink_buz_func36:
L__Blink_buz_func35:
;led_buz_func.c,46 :: 		}
L_end_Blink_buz_func:
POP	(R15)
; end of _Blink_buz_func
_Blink_leds_func:
;led_buz_func.c,50 :: 		unsigned char after_count,unsigned char enable_buzzer)
; count_digit_led start address is: 12 (R3)
; count_loop1 start address is: 4 (R1)
; blink_mode_led start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #4
UXTH	R5, R0
; count_digit_led end address is: 12 (R3)
; count_loop1 end address is: 4 (R1)
; blink_mode_led end address is: 0 (R0)
; blink_mode_led start address is: 20 (R5)
; count_loop1 start address is: 4 (R1)
; count_digit_led start address is: 12 (R3)
; new_state start address is: 0 (R0)
LDR	R0, [SP, #8]
UXTB	R0, R0
; enable_new_state start address is: 8 (R2)
LDR	R2, [SP, #12]
UXTB	R2, R2
; after_count start address is: 28 (R7)
LDR	R7, [SP, #16]
UXTB	R7, R7
LDR	R4, [SP, #20]
UXTB	R4, R4
STR	R4, [SP, #20]
;led_buz_func.c,60 :: 		s_blink_mode_led = blink_mode_led;
MOVW	R4, #lo_addr(Blink_leds_func_s_blink_mode_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_s_blink_mode_led_L0+0)
STRH	R5, [R4, #0]
; blink_mode_led end address is: 20 (R5)
;led_buz_func.c,62 :: 		if(led_red_status==RESET)
MOVW	R4, #lo_addr(Blink_leds_func_led_red_status_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_led_red_status_L0+0)
LDRB	R4, [R4, #0]
CMP	R4, #0
IT	NE
BLNE	L_Blink_leds_func10
;led_buz_func.c,64 :: 		LED_GREEN = ON;//LED_RED = ON;
MOVW	R6, #lo_addr(LED_GREEN+0)
MOVT	R6, #hi_addr(LED_GREEN+0)
_LX	[R6, ByteOffset(LED_GREEN+0)]
MOVS	R5, #1
LSLS	R5, R5, BitPos(LED_GREEN+0)
ORRS	R4, R5
_SX	[R6, ByteOffset(LED_GREEN+0)]
;led_buz_func.c,66 :: 		if((count_start_red_led++)>=10)
MOVW	R6, #lo_addr(Blink_leds_func_count_start_red_led_L0+0)
MOVT	R6, #hi_addr(Blink_leds_func_count_start_red_led_L0+0)
LDRB	R5, [R6, #0]
MOV	R4, R6
LDRB	R4, [R4, #0]
ADDS	R4, #1
STRB	R4, [R6, #0]
CMP	R5, #10
IT	CC
BLCC	L_Blink_leds_func11
;led_buz_func.c,68 :: 		count_start_red_led = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_leds_func_count_start_red_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_count_start_red_led_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,69 :: 		led_red_status = SET;
MOVS	R5, #1
MOVW	R4, #lo_addr(Blink_leds_func_led_red_status_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_led_red_status_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,70 :: 		LED_GREEN = ON;//LED_RED = OFF;
MOVW	R6, #lo_addr(LED_GREEN+0)
MOVT	R6, #hi_addr(LED_GREEN+0)
_LX	[R6, ByteOffset(LED_GREEN+0)]
MOVS	R5, #1
LSLS	R5, R5, BitPos(LED_GREEN+0)
ORRS	R4, R5
_SX	[R6, ByteOffset(LED_GREEN+0)]
;led_buz_func.c,71 :: 		}
L_Blink_leds_func11:
;led_buz_func.c,73 :: 		}
L_Blink_leds_func10:
;led_buz_func.c,74 :: 		if(((count_loop_led++)>=count_loop1)&&end_led==RESET)
MOVW	R6, #lo_addr(Blink_leds_func_count_loop_led_L0+0)
MOVT	R6, #hi_addr(Blink_leds_func_count_loop_led_L0+0)
LDRB	R5, [R6, #0]
MOV	R4, R6
LDRB	R4, [R4, #0]
ADDS	R4, #1
STRB	R4, [R6, #0]
CMP	R5, R1
IT	CC
BLCC	L__Blink_leds_func40
; count_loop1 end address is: 4 (R1)
MOVW	R4, #lo_addr(Blink_leds_func_end_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_end_led_L0+0)
LDRB	R4, [R4, #0]
CMP	R4, #0
IT	NE
BLNE	L__Blink_leds_func39
L__Blink_leds_func38:
;led_buz_func.c,76 :: 		count_loop_led = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_leds_func_count_loop_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_count_loop_led_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,78 :: 		if(s_blink_mode_led & 1<<(blink_loop_led&0x07))
MOVW	R4, #lo_addr(Blink_leds_func_blink_loop_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_blink_loop_led_L0+0)
LDRB	R5, [R4, #0]
MOVS	R4, #7
MOV	R6, R5
ANDS	R6, R4
UXTB	R6, R6
MOVS	R4, #1
MOV	R5, R4
LSLS	R5, R6
SXTH	R5, R5
MOVW	R4, #lo_addr(Blink_leds_func_s_blink_mode_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_s_blink_mode_led_L0+0)
LDRH	R4, [R4, #0]
ANDS	R4, R5
UXTH	R4, R4
CMP	R4, #0
IT	EQ
BLEQ	L_Blink_leds_func15
;led_buz_func.c,80 :: 		LED_RED = ON;//LED_GREEN = ON;
MOVW	R6, #lo_addr(LED_RED+0)
MOVT	R6, #hi_addr(LED_RED+0)
_LX	[R6, ByteOffset(LED_RED+0)]
MOVS	R5, #1
LSLS	R5, R5, BitPos(LED_RED+0)
ORRS	R4, R5
_SX	[R6, ByteOffset(LED_RED+0)]
;led_buz_func.c,81 :: 		if(enable_buzzer == SET)
LDR	R4, [SP, #20]
UXTB	R4, R4
CMP	R4, #1
IT	NE
BLNE	L_Blink_leds_func16
;led_buz_func.c,83 :: 		BUZER = ON;
MOVW	R6, #lo_addr(BUZER+0)
MOVT	R6, #hi_addr(BUZER+0)
_LX	[R6, ByteOffset(BUZER+0)]
MOVS	R5, #1
LSLS	R5, R5, BitPos(BUZER+0)
ORRS	R4, R5
_SX	[R6, ByteOffset(BUZER+0)]
;led_buz_func.c,84 :: 		}
L_Blink_leds_func16:
;led_buz_func.c,85 :: 		}
IT	AL
BLAL	L_Blink_leds_func17
L_Blink_leds_func15:
;led_buz_func.c,88 :: 		LED_RED = OFF;//LED_GREEN = OFF;
MOVW	R6, #lo_addr(LED_RED+0)
MOVT	R6, #hi_addr(LED_RED+0)
_LX	[R6, ByteOffset(LED_RED+0)]
MOVS	R5, #1
LSLS	R5, R5, BitPos(LED_RED+0)
BICS	R4, R5
_SX	[R6, ByteOffset(LED_RED+0)]
;led_buz_func.c,89 :: 		BUZER = OFF;
MOVW	R6, #lo_addr(BUZER+0)
MOVT	R6, #hi_addr(BUZER+0)
_LX	[R6, ByteOffset(BUZER+0)]
MOVS	R5, #1
LSLS	R5, R5, BitPos(BUZER+0)
BICS	R4, R5
_SX	[R6, ByteOffset(BUZER+0)]
;led_buz_func.c,90 :: 		}
L_Blink_leds_func17:
;led_buz_func.c,92 :: 		if((blink_loop_led++)>=count_digit_led)
MOVW	R6, #lo_addr(Blink_leds_func_blink_loop_led_L0+0)
MOVT	R6, #hi_addr(Blink_leds_func_blink_loop_led_L0+0)
LDRB	R5, [R6, #0]
MOV	R4, R6
LDRB	R4, [R4, #0]
ADDS	R4, #1
STRB	R4, [R6, #0]
CMP	R5, R3
IT	CC
BLCC	L_Blink_leds_func18
; count_digit_led end address is: 12 (R3)
;led_buz_func.c,94 :: 		blink_loop_led = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_leds_func_blink_loop_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_blink_loop_led_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,95 :: 		end_led=SET;
MOVS	R5, #1
MOVW	R4, #lo_addr(Blink_leds_func_end_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_end_led_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,97 :: 		}
L_Blink_leds_func18:
;led_buz_func.c,74 :: 		if(((count_loop_led++)>=count_loop1)&&end_led==RESET)
L__Blink_leds_func40:
L__Blink_leds_func39:
;led_buz_func.c,100 :: 		if((end_led==SET)&&((after_count_s_led++)>=after_count))
MOVW	R4, #lo_addr(Blink_leds_func_end_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_end_led_L0+0)
LDRB	R4, [R4, #0]
CMP	R4, #1
IT	NE
BLNE	L__Blink_leds_func42
MOVW	R6, #lo_addr(Blink_leds_func_after_count_s_led_L0+0)
MOVT	R6, #hi_addr(Blink_leds_func_after_count_s_led_L0+0)
LDRB	R5, [R6, #0]
MOV	R4, R6
LDRB	R4, [R4, #0]
ADDS	R4, #1
STRB	R4, [R6, #0]
CMP	R5, R7
IT	CC
BLCC	L__Blink_leds_func41
; after_count end address is: 28 (R7)
L__Blink_leds_func37:
;led_buz_func.c,102 :: 		LED_RED = OFF;//LED_GREEN = OFF;
MOVW	R6, #lo_addr(LED_RED+0)
MOVT	R6, #hi_addr(LED_RED+0)
_LX	[R6, ByteOffset(LED_RED+0)]
MOVS	R5, #1
LSLS	R5, R5, BitPos(LED_RED+0)
BICS	R4, R5
_SX	[R6, ByteOffset(LED_RED+0)]
;led_buz_func.c,103 :: 		end_led=RESET;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_leds_func_end_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_end_led_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,104 :: 		after_count_s_led = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_leds_func_after_count_s_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_after_count_s_led_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,105 :: 		count_loop_led = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_leds_func_count_loop_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_count_loop_led_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,106 :: 		led_red_status=RESET;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_leds_func_led_red_status_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_led_red_status_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,107 :: 		blink_loop_led = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(Blink_leds_func_blink_loop_led_L0+0)
MOVT	R4, #hi_addr(Blink_leds_func_blink_loop_led_L0+0)
STRB	R5, [R4, #0]
;led_buz_func.c,108 :: 		if(enable_new_state)
CMP	R2, #0
IT	EQ
BLEQ	L_Blink_leds_func22
; enable_new_state end address is: 8 (R2)
;led_buz_func.c,110 :: 		resetLB();
STR	R0, [SP, #0]
BL	_resetLB+0
LDR	R0, [SP, #0]
UXTB	R0, R0
;led_buz_func.c,111 :: 		setState(new_state);
; new_state end address is: 0 (R0)
BL	_setState+0
;led_buz_func.c,112 :: 		}
L_Blink_leds_func22:
;led_buz_func.c,100 :: 		if((end_led==SET)&&((after_count_s_led++)>=after_count))
L__Blink_leds_func42:
L__Blink_leds_func41:
;led_buz_func.c,115 :: 		}
L_end_Blink_leds_func:
ADD	SP, SP, #4
POP	(R15)
; end of _Blink_leds_func
_heaterMode:
;led_buz_func.c,117 :: 		void heaterMode(unsigned char mode)
; mode start address is: 0 (R0)
PUSH	(R14)
; mode end address is: 0 (R0)
; mode start address is: 0 (R0)
;led_buz_func.c,121 :: 		if(!mode)
CMP	R0, #0
IT	NE
BLNE	L_heaterMode23
;led_buz_func.c,123 :: 		switch(phase_normal_count++)
MOVW	R2, #lo_addr(heaterMode_phase_normal_count_L0+0)
MOVT	R2, #hi_addr(heaterMode_phase_normal_count_L0+0)
LDR	R4, [R2, #0]
MOV	R1, R2
LDR	R1, [R1, #0]
ADDS	R1, #1
STR	R1, [R2, #0]
IT	AL
BLAL	L_heaterMode24
;led_buz_func.c,125 :: 		case 1:                          BOARD_HEATER     = ON;    break;
L_heaterMode26:
MOVW	R3, #lo_addr(BOARD_HEATER+0)
MOVT	R3, #hi_addr(BOARD_HEATER+0)
_LX	[R3, ByteOffset(BOARD_HEATER+0)]
MOVS	R2, #1
LSLS	R2, R2, BitPos(BOARD_HEATER+0)
ORRS	R1, R2
_SX	[R3, ByteOffset(BOARD_HEATER+0)]
IT	AL
BLAL	L_heaterMode25
;led_buz_func.c,127 :: 		case HEATER_CYCLE*10:            BOARD_HEATER     = OFF;
L_heaterMode27:
MOVW	R3, #lo_addr(BOARD_HEATER+0)
MOVT	R3, #hi_addr(BOARD_HEATER+0)
_LX	[R3, ByteOffset(BOARD_HEATER+0)]
MOVS	R2, #1
LSLS	R2, R2, BitPos(BOARD_HEATER+0)
BICS	R1, R2
_SX	[R3, ByteOffset(BOARD_HEATER+0)]
;led_buz_func.c,128 :: 		BACKWARD_HEATER  = ON;    break;
MOVW	R3, #lo_addr(BACKWARD_HEATER+0)
MOVT	R3, #hi_addr(BACKWARD_HEATER+0)
_LX	[R3, ByteOffset(BACKWARD_HEATER+0)]
MOVS	R2, #1
LSLS	R2, R2, BitPos(BACKWARD_HEATER+0)
ORRS	R1, R2
_SX	[R3, ByteOffset(BACKWARD_HEATER+0)]
IT	AL
BLAL	L_heaterMode25
;led_buz_func.c,130 :: 		case HEATER_CYCLE*20:            BACKWARD_HEATER  = OFF;
L_heaterMode28:
MOVW	R3, #lo_addr(BACKWARD_HEATER+0)
MOVT	R3, #hi_addr(BACKWARD_HEATER+0)
_LX	[R3, ByteOffset(BACKWARD_HEATER+0)]
MOVS	R2, #1
LSLS	R2, R2, BitPos(BACKWARD_HEATER+0)
BICS	R1, R2
_SX	[R3, ByteOffset(BACKWARD_HEATER+0)]
;led_buz_func.c,131 :: 		FORWARD_HEATER   = ON;    break;
MOVW	R3, #lo_addr(FORWARD_HEATER+0)
MOVT	R3, #hi_addr(FORWARD_HEATER+0)
_LX	[R3, ByteOffset(FORWARD_HEATER+0)]
MOVS	R2, #1
LSLS	R2, R2, BitPos(FORWARD_HEATER+0)
ORRS	R1, R2
_SX	[R3, ByteOffset(FORWARD_HEATER+0)]
IT	AL
BLAL	L_heaterMode25
;led_buz_func.c,133 :: 		case HEATER_CYCLE*30:           FORWARD_HEATER   = OFF;
L_heaterMode29:
MOVW	R3, #lo_addr(FORWARD_HEATER+0)
MOVT	R3, #hi_addr(FORWARD_HEATER+0)
_LX	[R3, ByteOffset(FORWARD_HEATER+0)]
MOVS	R2, #1
LSLS	R2, R2, BitPos(FORWARD_HEATER+0)
BICS	R1, R2
_SX	[R3, ByteOffset(FORWARD_HEATER+0)]
;led_buz_func.c,134 :: 		BOARD_HEATER     = OFF;
MOVW	R3, #lo_addr(BOARD_HEATER+0)
MOVT	R3, #hi_addr(BOARD_HEATER+0)
_LX	[R3, ByteOffset(BOARD_HEATER+0)]
MOVS	R2, #1
LSLS	R2, R2, BitPos(BOARD_HEATER+0)
BICS	R1, R2
_SX	[R3, ByteOffset(BOARD_HEATER+0)]
;led_buz_func.c,135 :: 		phase_normal_count = 0;  break;
MOVS	R2, #0
MOVW	R1, #lo_addr(heaterMode_phase_normal_count_L0+0)
MOVT	R1, #hi_addr(heaterMode_phase_normal_count_L0+0)
STR	R2, [R1, #0]
IT	AL
BLAL	L_heaterMode25
;led_buz_func.c,136 :: 		}
L_heaterMode24:
CMP	R4, #1
IT	EQ
BLEQ	L_heaterMode26
CMP	R4, #100
IT	EQ
BLEQ	L_heaterMode27
CMP	R4, #200
IT	EQ
BLEQ	L_heaterMode28
MOVS	R1, #255
ADDS	R1, #45
CMP	R4, R1
IT	EQ
BLEQ	L_heaterMode29
L_heaterMode25:
;led_buz_func.c,137 :: 		}
L_heaterMode23:
;led_buz_func.c,139 :: 		if(mode)
CMP	R0, #0
IT	EQ
BLEQ	L_heaterMode30
; mode end address is: 0 (R0)
;led_buz_func.c,141 :: 		phase_normal_count = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(heaterMode_phase_normal_count_L0+0)
MOVT	R1, #hi_addr(heaterMode_phase_normal_count_L0+0)
STR	R2, [R1, #0]
;led_buz_func.c,142 :: 		setAllHeater();
BL	_setAllHeater+0
;led_buz_func.c,143 :: 		}
L_heaterMode30:
;led_buz_func.c,144 :: 		}
L_end_heaterMode:
POP	(R15)
; end of _heaterMode
