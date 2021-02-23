_main:
;main.c,3 :: 		void main()
;main.c,6 :: 		Init_flags();
BL	_Init_flags+0
;main.c,7 :: 		InitVar();
BL	_InitVar+0
;main.c,8 :: 		Init_pin();
BL	_Init_pin+0
;main.c,9 :: 		Init_ADC_chanell();
BL	_Init_ADC_chanell+0
;main.c,10 :: 		StartTimer3_10ms();
BL	_StartTimer3_10ms+0
;main.c,11 :: 		InitUartModuleBTU();
BL	_InitUartModuleBTU+0
;main.c,12 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;main.c,13 :: 		WDT_Init();
BL	_WDT_Init+0
;main.c,14 :: 		ChekTrue();
BL	_ChekTrue+0
;main.c,15 :: 		while(TRUE)
L_main0:
;main.c,17 :: 		globalProcess();
BL	_globalProcess+0
;main.c,18 :: 		}
IT	AL
BLAL	L_main0
;main.c,19 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
