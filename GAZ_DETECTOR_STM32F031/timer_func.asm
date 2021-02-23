_StartTimer3_10ms:
;timer_func.c,4 :: 		void StartTimer3_10ms(){
PUSH	(R14)
;timer_func.c,5 :: 		RCC_APB1ENRbits.TIM3EN = ON;
MOVW	R2, #4124
MOVT	R2, #16386
_LX	[R2, ByteOffset(1073877020)]
MOVS	R1, #2
ORRS	R0, R1
_SX	[R2, ByteOffset(1073877020)]
;timer_func.c,6 :: 		TIM3_CR1bits.CEN = OFF;
MOVW	R2, #1024
MOVT	R2, #16384
_LX	[R2, ByteOffset(1073742848)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(1073742848)]
;timer_func.c,7 :: 		TIM3_PSC = 7;
MOVS	R1, #7
MOVW	R0, 1073742888
MOVT	R0, 16384
STR	R1, [R0, #0]
;timer_func.c,8 :: 		TIM3_ARR = 59999;
MOVW	R1, #59999
MOVT	R1, #0
MOVW	R0, 1073742892
MOVT	R0, 16384
STR	R1, [R0, #0]
;timer_func.c,9 :: 		NVIC_IntEnable(IVT_INT_TIM3);
MOVS	R0, #32
BL	_NVIC_IntEnable+0
;timer_func.c,10 :: 		TIM3_DIERbits.UIE = ON;
MOVW	R2, #1036
MOVT	R2, #16384
_LX	[R2, ByteOffset(1073742860)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(1073742860)]
;timer_func.c,11 :: 		TIM3_CR1bits.CEN = ON;
MOVW	R2, #1024
MOVT	R2, #16384
_LX	[R2, ByteOffset(1073742848)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(1073742848)]
;timer_func.c,12 :: 		}
L_end_StartTimer3_10ms:
POP	(R15)
; end of _StartTimer3_10ms
_Timer3_10ms_int:
;timer_func.c,15 :: 		void Timer3_10ms_int() iv IVT_INT_TIM3 ics ICS_AUTO
;timer_func.c,19 :: 		TIM3_SRbits.UIF = 0;
MOVW	R2, #1040
MOVT	R2, #16384
_LX	[R2, ByteOffset(1073742864)]
MOVS	R1, #1
BICS	R0, R1
_SX	[R2, ByteOffset(1073742864)]
;timer_func.c,20 :: 		flag_t.ovf_flag = SET;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STRB	R1, [R0, #0]
;timer_func.c,69 :: 		}
L_end_Timer3_10ms_int:
BX	LR
; end of _Timer3_10ms_int
_WDT_Init:
;timer_func.c,71 :: 		void WDT_Init()
PUSH	(R14)
;timer_func.c,73 :: 		RCC_CSRbits.LSION = 1;
MOVW	R2, #4132
MOVT	R2, #16386
_LX	[R2, ByteOffset(1073877028)]
MOVS	R1, #1
ORRS	R0, R1
_SX	[R2, ByteOffset(1073877028)]
;timer_func.c,74 :: 		while(!RCC_CSRbits.LSIRDY);
L_WDT_Init0:
MOVW	R0, #4132
MOVT	R0, #16386
_LX	[R0, ByteOffset(1073877028)]
MOVS	R0, #2
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L_WDT_Init1
IT	AL
BLAL	L_WDT_Init0
L_WDT_Init1:
;timer_func.c,75 :: 		IWDG_KR = 0x5555;      //write with protect
MOVW	R1, #21845
MOVT	R1, #0
MOVW	R0, 1073754112
MOVT	R0, 16384
STR	R1, [R0, #0]
;timer_func.c,76 :: 		IWDG_PRbits.PR = 0x00;  //prescaler
MOVW	R0, #12292
MOVT	R0, #16384
LDRB	R1, [R0, #0]
MOVS	R0, #248
ANDS	R1, R0
LSLS	R1, R1, #29
LSRS	R1, R1, #29
MOVW	R0, #12292
MOVT	R0, #16384
STRB	R1, [R0, #0]
;timer_func.c,77 :: 		IWDG_KR = 0xCCCC;      //start watchdog
MOVW	R1, #52428
MOVT	R1, #0
MOVW	R0, 1073754112
MOVT	R0, 16384
STR	R1, [R0, #0]
;timer_func.c,78 :: 		IWDG_KR = 0xAAAA;      //reset watchdog
MOVW	R1, #43690
MOVT	R1, #0
MOVW	R0, 1073754112
MOVT	R0, 16384
STR	R1, [R0, #0]
;timer_func.c,89 :: 		}
L_end_WDT_Init:
POP	(R15)
; end of _WDT_Init
_clear_WDT:
;timer_func.c,91 :: 		void clear_WDT()
;timer_func.c,93 :: 		IWDG_KR = 0xAAAA;      //reset watchdog
MOVW	R1, #43690
MOVT	R1, #0
MOVW	R0, 1073754112
MOVT	R0, 16384
STR	R1, [R0, #0]
;timer_func.c,94 :: 		}
L_end_clear_WDT:
BX	LR
; end of _clear_WDT
