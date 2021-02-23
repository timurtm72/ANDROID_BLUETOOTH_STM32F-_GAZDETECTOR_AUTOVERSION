_Init_pin:
;init_func.c,19 :: 		void Init_pin()
PUSH	(R14)
;init_func.c,22 :: 		GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_4|_GPIO_PINMASK_5|_GPIO_PINMASK_6,_GPIO_CFG_DIGITAL_OUTPUT);
MOVW	R2, #20
MOVT	R2, #8
MOVS	R1, #112
MOVW	R0, #1024
MOVT	R0, #18432
BL	_GPIO_Config+0
;init_func.c,24 :: 		GPIO_Config(&GPIOA_BASE,_GPIO_PINMASK_8,_GPIO_CFG_MODE_INPUT | _GPIO_CFG_PULL_UP);
MOVS	R2, #130
MOVS	R1, #255
ADDS	R1, #1
MOVW	R0, #0
MOVT	R0, #18432
BL	_GPIO_Config+0
;init_func.c,27 :: 		GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_1,_GPIO_CFG_DIGITAL_OUTPUT);
MOVW	R2, #20
MOVT	R2, #8
MOVS	R1, #2
MOVW	R0, #1024
MOVT	R0, #18432
BL	_GPIO_Config+0
;init_func.c,29 :: 		GPIO_Config(&GPIOB_BASE,_GPIO_PINMASK_0|_GPIO_PINMASK_3,_GPIO_CFG_DIGITAL_OUTPUT);
MOVW	R2, #20
MOVT	R2, #8
MOVS	R1, #9
MOVW	R0, #1024
MOVT	R0, #18432
BL	_GPIO_Config+0
;init_func.c,31 :: 		GPIO_Config(&GPIOA_BASE,_GPIO_PINMASK_11,_GPIO_CFG_DIGITAL_OUTPUT);
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #2048
MOVT	R1, #0
MOVW	R0, #0
MOVT	R0, #18432
BL	_GPIO_Config+0
;init_func.c,32 :: 		}
L_end_Init_pin:
POP	(R15)
; end of _Init_pin
_Init_flags:
;init_func.c,34 :: 		void Init_flags()
;init_func.c,36 :: 		flag_t.ovf_flag                                       = 0;
MOVS	R0, #0
MOVW	R2, #lo_addr(_flag_t+0)
MOVT	R2, #hi_addr(_flag_t+0)
STRB	R0, [R2, #0]
;init_func.c,37 :: 		flag_t.board_sensor_status                            = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+1)
MOVT	R0, #hi_addr(_flag_t+1)
STRB	R1, [R0, #0]
;init_func.c,38 :: 		flag_t.forward_sensor_status                          = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+2)
MOVT	R0, #hi_addr(_flag_t+2)
STRB	R1, [R0, #0]
;init_func.c,39 :: 		flag_t.backward_sensor_status                         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+3)
MOVT	R0, #hi_addr(_flag_t+3)
STRB	R1, [R0, #0]
;init_func.c,40 :: 		flag_t.cal_button_status                              = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+4)
MOVT	R0, #hi_addr(_flag_t+4)
STRB	R1, [R0, #0]
;init_func.c,41 :: 		flag_t.start_sensor_control                           = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+5)
MOVT	R0, #hi_addr(_flag_t+5)
STRB	R1, [R0, #0]
;init_func.c,42 :: 		flag_t.heater_status                                  = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+6)
MOVT	R0, #hi_addr(_flag_t+6)
STRB	R1, [R0, #0]
;init_func.c,43 :: 		flag_t.ready_calibration_prog                         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+7)
MOVT	R0, #hi_addr(_flag_t+7)
STRB	R1, [R0, #0]
;init_func.c,44 :: 		flag_t.alarm_enable_status                            = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+8)
MOVT	R0, #hi_addr(_flag_t+8)
STRB	R1, [R0, #0]
;init_func.c,45 :: 		flag_t.board_sensor_damage                            = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+9)
MOVT	R0, #hi_addr(_flag_t+9)
STRB	R1, [R0, #0]
;init_func.c,46 :: 		flag_t.forward_sensor_damage                          = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+10)
MOVT	R0, #hi_addr(_flag_t+10)
STRB	R1, [R0, #0]
;init_func.c,47 :: 		flag_t.backward_sensor_damage                         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
STRB	R1, [R0, #0]
;init_func.c,48 :: 		flag_t.calibrate_status                               = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+12)
MOVT	R0, #hi_addr(_flag_t+12)
STRB	R1, [R0, #0]
;init_func.c,49 :: 		flag_t.ovf_flag                                       = 0;
MOVS	R0, #0
STRB	R0, [R2, #0]
;init_func.c,50 :: 		flag_t.board_cal_status                               = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+14)
MOVT	R0, #hi_addr(_flag_t+14)
STRB	R1, [R0, #0]
;init_func.c,51 :: 		flag_t.forward_cal_status                             = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+15)
MOVT	R0, #hi_addr(_flag_t+15)
STRB	R1, [R0, #0]
;init_func.c,52 :: 		flag_t.backward_cal_status                            = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+16)
MOVT	R0, #hi_addr(_flag_t+16)
STRB	R1, [R0, #0]
;init_func.c,53 :: 		flag_t.enable_status                                  = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+17)
MOVT	R0, #hi_addr(_flag_t+17)
STRB	R1, [R0, #0]
;init_func.c,54 :: 		flag_t.request_uart_status                            = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+18)
MOVT	R0, #hi_addr(_flag_t+18)
STRB	R1, [R0, #0]
;init_func.c,55 :: 		flag_t.start_process_status                           = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+19)
MOVT	R0, #hi_addr(_flag_t+19)
STRB	R1, [R0, #0]
;init_func.c,56 :: 		flag_t.response_status                                = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+20)
MOVT	R0, #hi_addr(_flag_t+20)
STRB	R1, [R0, #0]
;init_func.c,57 :: 		flag_t.process_start_status                           = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+21)
MOVT	R0, #hi_addr(_flag_t+21)
STRB	R1, [R0, #0]
;init_func.c,58 :: 		flag_t.first_start                                    = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+22)
MOVT	R0, #hi_addr(_flag_t+22)
STRB	R1, [R0, #0]
;init_func.c,59 :: 		flag_t.alarm_sensor_status                            = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+23)
MOVT	R0, #hi_addr(_flag_t+23)
STRB	R1, [R0, #0]
;init_func.c,60 :: 		}
L_end_Init_flags:
BX	LR
; end of _Init_flags
_Init_flash_cal:
;init_func.c,62 :: 		void Init_flash_cal()
;init_func.c,64 :: 		parameters_t.forward_sensor_ready  = (unsigned int)READY_DATA;
MOVW	R1, #43690
MOVT	R1, #0
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
STRH	R1, [R0, #0]
;init_func.c,65 :: 		parameters_t.backward_sensor_ready = (unsigned int)READY_DATA;
MOVW	R1, #43690
MOVT	R1, #0
MOVW	R0, #lo_addr(_parameters_t+14)
MOVT	R0, #hi_addr(_parameters_t+14)
STRH	R1, [R0, #0]
;init_func.c,66 :: 		parameters_t.board_sensor_ready    = (unsigned int)READY_DATA;
MOVW	R1, #43690
MOVT	R1, #0
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
STRH	R1, [R0, #0]
;init_func.c,68 :: 		+parameters_t.backward_sensor_cal_data
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+6)
MOVT	R0, #hi_addr(_parameters_t+6)
LDRH	R0, [R0, #0]
ADDS	R1, R0, R1
UXTH	R1, R1
;init_func.c,69 :: 		+parameters_t.board_sensor_cal_data
MOVW	R0, #lo_addr(_parameters_t+10)
MOVT	R0, #hi_addr(_parameters_t+10)
LDRH	R0, [R0, #0]
ADDS	R1, R1, R0
UXTH	R1, R1
;init_func.c,70 :: 		+parameters_t.forward_sensor_v0_cal_data
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
LDRH	R0, [R0, #0]
ADDS	R1, R1, R0
UXTH	R1, R1
;init_func.c,71 :: 		+parameters_t.backward_sensor_v0_cal_data
MOVW	R0, #lo_addr(_parameters_t+2)
MOVT	R0, #hi_addr(_parameters_t+2)
LDRH	R0, [R0, #0]
ADDS	R1, R1, R0
UXTH	R1, R1
;init_func.c,72 :: 		+parameters_t.board_sensor_v0_cal_data;
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
LDRH	R0, [R0, #0]
ADDS	R1, R1, R0
MOVW	R0, #lo_addr(_parameters_t+24)
MOVT	R0, #hi_addr(_parameters_t+24)
STRH	R1, [R0, #0]
;init_func.c,73 :: 		}
L_end_Init_flash_cal:
BX	LR
; end of _Init_flash_cal
_InitVar:
;init_func.c,75 :: 		void InitVar()
;init_func.c,77 :: 		parameters_t.forward_sensor_v0_cal_data            = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
STRH	R1, [R0, #0]
;init_func.c,78 :: 		parameters_t.backward_sensor_v0_cal_data           = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_parameters_t+2)
MOVT	R0, #hi_addr(_parameters_t+2)
STRH	R1, [R0, #0]
;init_func.c,79 :: 		parameters_t.board_sensor_v0_cal_data              = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
STRH	R1, [R0, #0]
;init_func.c,80 :: 		parameters_t.forward_sensor_cal_data               = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_parameters_t+6)
MOVT	R0, #hi_addr(_parameters_t+6)
STRH	R1, [R0, #0]
;init_func.c,81 :: 		parameters_t.backward_sensor_cal_data              = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
STRH	R1, [R0, #0]
;init_func.c,82 :: 		parameters_t.board_sensor_cal_data                 = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_parameters_t+10)
MOVT	R0, #hi_addr(_parameters_t+10)
STRH	R1, [R0, #0]
;init_func.c,86 :: 		}
L_end_InitVar:
BX	LR
; end of _InitVar
