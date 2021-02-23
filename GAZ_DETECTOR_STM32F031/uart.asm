_InitUartModuleBTU:
;uart.c,7 :: 		void InitUartModuleBTU()
PUSH	(R14)
;uart.c,9 :: 		UART1_Init_Advanced(BAUD_RATE, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART1_PA9_10);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART1_PA9_10+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART1_PA9_10+0)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVS	R1, #0
MOVW	R0, #9600
MOVT	R0, #0
BL	_UART1_Init_Advanced+0
ADD	SP, SP, #4
;uart.c,10 :: 		USART1_CR1 = USART_CR1_RXNEIE | USART_CR1_RE | USART_CR1_UE|USART_CR1_TE;
MOVS	R1, #45
MOVW	R0, 1073821696
MOVT	R0, 16385
STR	R1, [R0, #0]
;uart.c,11 :: 		NVIC_IntEnable(IVT_INT_USART1);
MOVS	R0, #43
BL	_NVIC_IntEnable+0
;uart.c,12 :: 		}
L_end_InitUartModuleBTU:
POP	(R15)
; end of _InitUartModuleBTU
_UART_INT:
;uart.c,15 :: 		void UART_INT() iv IVT_INT_USART1 ics ICS_AUTO
PUSH	(R14)
;uart.c,18 :: 		if((USART1_ISR & USART_ISR_RXNE) == USART_ISR_RXNE)
MOVW	R0, 1073821724
MOVT	R0, 16385
LDR	R1, [R0, #0]
MOVS	R0, #32
ANDS	R0, R1
CMP	R0, #32
IT	NE
BLNE	L_UART_INT0
;uart.c,20 :: 		in_data = USART1_RDR;
MOVW	R0, 1073821732
MOVT	R0, 16385
; in_data start address is: 8 (R2)
LDR	R2, [R0, #0]
;uart.c,21 :: 		if(in<INPUT_BUFFER_SIZE)
MOVW	R0, #lo_addr(uart_in+0)
MOVT	R0, #hi_addr(uart_in+0)
LDRB	R0, [R0, #0]
CMP	R0, #25
IT	CS
BLCS	L_UART_INT1
;uart.c,23 :: 		input_buffer[in++] = in_data;
MOVW	R0, #lo_addr(uart_in+0)
MOVT	R0, #hi_addr(uart_in+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_input_buffer+0)
MOVT	R0, #hi_addr(_input_buffer+0)
ADDS	R0, R0, R1
STRB	R2, [R0, #0]
; in_data end address is: 8 (R2)
MOVW	R0, #lo_addr(uart_in+0)
MOVT	R0, #hi_addr(uart_in+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(uart_in+0)
MOVT	R0, #hi_addr(uart_in+0)
STRB	R1, [R0, #0]
;uart.c,24 :: 		}
IT	AL
BLAL	L_UART_INT2
L_UART_INT1:
;uart.c,27 :: 		in = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(uart_in+0)
MOVT	R0, #hi_addr(uart_in+0)
STRB	R1, [R0, #0]
;uart.c,28 :: 		Clear_buffer(input_buffer,INPUT_BUFFER_SIZE );
MOVS	R1, #25
MOVW	R0, #lo_addr(_input_buffer+0)
MOVT	R0, #hi_addr(_input_buffer+0)
BL	_Clear_buffer+0
;uart.c,29 :: 		flag_t.request_uart_status = SET;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+18)
MOVT	R0, #hi_addr(_flag_t+18)
STRB	R1, [R0, #0]
;uart.c,30 :: 		}
L_UART_INT2:
;uart.c,31 :: 		}
L_UART_INT0:
;uart.c,32 :: 		}
L_end_UART_INT:
POP	(R15)
; end of _UART_INT
_ControlInputData:
;uart.c,34 :: 		void ControlInputData()
PUSH	(R14)
;uart.c,37 :: 		if(flag_t.start_process_status)
MOVW	R0, #lo_addr(_flag_t+19)
MOVT	R0, #hi_addr(_flag_t+19)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_ControlInputData3
;uart.c,39 :: 		if(strstr(input_buffer,request_string))
MOVW	R1, #lo_addr(_request_string+0)
MOVT	R1, #hi_addr(_request_string+0)
MOVW	R0, #lo_addr(_input_buffer+0)
MOVT	R0, #hi_addr(_input_buffer+0)
BL	_strstr+0
CMP	R0, #0
IT	EQ
BLEQ	L_ControlInputData4
;uart.c,41 :: 		flag_t.response_status = SET;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+20)
MOVT	R0, #hi_addr(_flag_t+20)
STRB	R1, [R0, #0]
;uart.c,42 :: 		Clear_buffer(input_buffer,INPUT_BUFFER_SIZE );
MOVS	R1, #25
MOVW	R0, #lo_addr(_input_buffer+0)
MOVT	R0, #hi_addr(_input_buffer+0)
BL	_Clear_buffer+0
;uart.c,43 :: 		in = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(uart_in+0)
MOVT	R0, #hi_addr(uart_in+0)
STRB	R1, [R0, #0]
;uart.c,44 :: 		}
L_ControlInputData4:
;uart.c,45 :: 		if(strstr(input_buffer,"CONNECT"))
MOVW	R0, #lo_addr(?lstr1_uart+0)
MOVT	R0, #hi_addr(?lstr1_uart+0)
MOV	R1, R0
MOVW	R0, #lo_addr(_input_buffer+0)
MOVT	R0, #hi_addr(_input_buffer+0)
BL	_strstr+0
CMP	R0, #0
IT	EQ
BLEQ	L_ControlInputData5
;uart.c,47 :: 		Clear_buffer(input_buffer,INPUT_BUFFER_SIZE );
MOVS	R1, #25
MOVW	R0, #lo_addr(_input_buffer+0)
MOVT	R0, #hi_addr(_input_buffer+0)
BL	_Clear_buffer+0
;uart.c,48 :: 		in = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(uart_in+0)
MOVT	R0, #hi_addr(uart_in+0)
STRB	R1, [R0, #0]
;uart.c,49 :: 		}
L_ControlInputData5:
;uart.c,50 :: 		}
L_ControlInputData3:
;uart.c,51 :: 		}
L_end_ControlInputData:
POP	(R15)
; end of _ControlInputData
_NegativeLimiter:
;uart.c,53 :: 		float NegativeLimiter(float value)
; value start address is: 0 (R0)
PUSH	(R14)
MOV	R3, R0
; value end address is: 0 (R0)
; value start address is: 12 (R3)
;uart.c,55 :: 		if(value<=0)
MOVS	R0, #0
MOV	R2, R3
BL	__Compare_FP+0
BLT	L__NegativeLimiter22
MOVS	R0, #1
B	L__NegativeLimiter23
L__NegativeLimiter22:
MOVS	R0, #0
L__NegativeLimiter23:
CMP	R0, #0
IT	EQ
BLEQ	L_NegativeLimiter6
; value end address is: 12 (R3)
;uart.c,57 :: 		return 0;
MOVS	R0, #0
IT	AL
BLAL	L_end_NegativeLimiter
;uart.c,58 :: 		}
L_NegativeLimiter6:
;uart.c,61 :: 		return value;
; value start address is: 12 (R3)
MOV	R0, R3
; value end address is: 12 (R3)
;uart.c,63 :: 		}
L_end_NegativeLimiter:
POP	(R15)
; end of _NegativeLimiter
_WriteDataToAndroid:
;uart.c,65 :: 		void WriteDataToAndroid()
PUSH	(R14)
;uart.c,68 :: 		unsigned int tmp = 0;
;uart.c,69 :: 		if(flag_t.response_status)
MOVW	R0, #lo_addr(_flag_t+20)
MOVT	R0, #hi_addr(_flag_t+20)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BLEQ	L_WriteDataToAndroid8
;uart.c,71 :: 		LED_UART_TR = ON;
MOVW	R2, #lo_addr(LED_UART_TR+0)
MOVT	R2, #hi_addr(LED_UART_TR+0)
_LX	[R2, ByteOffset(LED_UART_TR+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_UART_TR+0)
ORRS	R0, R1
_SX	[R2, ByteOffset(LED_UART_TR+0)]
;uart.c,72 :: 		for(out_count=0;out_count<OUT_BUFFER_SIZE;out_count++)
MOVS	R1, #0
MOVW	R0, #lo_addr(WriteDataToAndroid_out_count_L0+0)
MOVT	R0, #hi_addr(WriteDataToAndroid_out_count_L0+0)
STRB	R1, [R0, #0]
L_WriteDataToAndroid9:
MOVW	R0, #lo_addr(WriteDataToAndroid_out_count_L0+0)
MOVT	R0, #hi_addr(WriteDataToAndroid_out_count_L0+0)
LDRB	R0, [R0, #0]
CMP	R0, #22
IT	CS
BLCS	L_WriteDataToAndroid10
;uart.c,74 :: 		out_buffer[out_count] = 0;
MOVW	R2, #lo_addr(WriteDataToAndroid_out_count_L0+0)
MOVT	R2, #hi_addr(WriteDataToAndroid_out_count_L0+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_out_buffer+0)
MOVT	R0, #hi_addr(_out_buffer+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;uart.c,72 :: 		for(out_count=0;out_count<OUT_BUFFER_SIZE;out_count++)
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, #1
STRB	R0, [R2, #0]
;uart.c,75 :: 		}
IT	AL
BLAL	L_WriteDataToAndroid9
L_WriteDataToAndroid10:
;uart.c,76 :: 		out_buffer[0] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_out_buffer+0)
MOVT	R0, #hi_addr(_out_buffer+0)
STRB	R1, [R0, #0]
;uart.c,77 :: 		out_buffer[1] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_out_buffer+1)
MOVT	R0, #hi_addr(_out_buffer+1)
STRB	R1, [R0, #0]
;uart.c,78 :: 		tmp = (unsigned int)(NegativeLimiter(BoardSensorPPM));
MOVW	R0, #lo_addr(_BoardSensorPPM+0)
MOVT	R0, #hi_addr(_BoardSensorPPM+0)
LDR	R0, [R0, #0]
BL	_NegativeLimiter+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
;uart.c,79 :: 		out_buffer[2] = (unsigned char)(tmp>>8);
LSRS	R1, R0, #8
UXTB	R2, R1
MOVW	R1, #lo_addr(_out_buffer+2)
MOVT	R1, #hi_addr(_out_buffer+2)
STRB	R2, [R1, #0]
;uart.c,80 :: 		out_buffer[3] = (unsigned char)(tmp);
UXTB	R1, R0
MOVW	R0, #lo_addr(_out_buffer+3)
MOVT	R0, #hi_addr(_out_buffer+3)
STRB	R1, [R0, #0]
;uart.c,82 :: 		tmp = (unsigned int)(NegativeLimiter(ForwardSensorPPM));
MOVW	R0, #lo_addr(_ForwardSensorPPM+0)
MOVT	R0, #hi_addr(_ForwardSensorPPM+0)
LDR	R0, [R0, #0]
BL	_NegativeLimiter+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
;uart.c,83 :: 		out_buffer[4] = (unsigned char)(tmp>>8);
LSRS	R1, R0, #8
UXTB	R2, R1
MOVW	R1, #lo_addr(_out_buffer+4)
MOVT	R1, #hi_addr(_out_buffer+4)
STRB	R2, [R1, #0]
;uart.c,84 :: 		out_buffer[5] = (unsigned char)(tmp);
UXTB	R1, R0
MOVW	R0, #lo_addr(_out_buffer+5)
MOVT	R0, #hi_addr(_out_buffer+5)
STRB	R1, [R0, #0]
;uart.c,86 :: 		tmp = (unsigned int)(NegativeLimiter(BackwardSensorPPM));
MOVW	R0, #lo_addr(_BackwardSensorPPM+0)
MOVT	R0, #hi_addr(_BackwardSensorPPM+0)
LDR	R0, [R0, #0]
BL	_NegativeLimiter+0
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
;uart.c,87 :: 		out_buffer[6] = (unsigned char)(tmp>>8);
LSRS	R1, R0, #8
UXTB	R2, R1
MOVW	R1, #lo_addr(_out_buffer+6)
MOVT	R1, #hi_addr(_out_buffer+6)
STRB	R2, [R1, #0]
;uart.c,88 :: 		out_buffer[7] = (unsigned char)(tmp);
UXTB	R1, R0
MOVW	R0, #lo_addr(_out_buffer+7)
MOVT	R0, #hi_addr(_out_buffer+7)
STRB	R1, [R0, #0]
;uart.c,90 :: 		out_buffer[8] = (unsigned char)(((unsigned int)BoardSensorR0)>>8);
MOVW	R0, #lo_addr(_BoardSensorR0+0)
MOVT	R0, #hi_addr(_BoardSensorR0+0)
LDR	R0, [R0, #0]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
LSRS	R0, R0, #8
UXTB	R1, R0
MOVW	R0, #lo_addr(_out_buffer+8)
MOVT	R0, #hi_addr(_out_buffer+8)
STRB	R1, [R0, #0]
;uart.c,91 :: 		out_buffer[9] = (unsigned char)((unsigned int)BoardSensorR0);
MOVW	R0, #lo_addr(_BoardSensorR0+0)
MOVT	R0, #hi_addr(_BoardSensorR0+0)
LDR	R0, [R0, #0]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
UXTB	R1, R0
MOVW	R0, #lo_addr(_out_buffer+9)
MOVT	R0, #hi_addr(_out_buffer+9)
STRB	R1, [R0, #0]
;uart.c,93 :: 		out_buffer[10] = (unsigned char)(((unsigned int)ForwardSensorR0)>>8);
MOVW	R0, #lo_addr(_ForwardSensorR0+0)
MOVT	R0, #hi_addr(_ForwardSensorR0+0)
LDR	R0, [R0, #0]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
LSRS	R0, R0, #8
UXTB	R1, R0
MOVW	R0, #lo_addr(_out_buffer+10)
MOVT	R0, #hi_addr(_out_buffer+10)
STRB	R1, [R0, #0]
;uart.c,94 :: 		out_buffer[11] = (unsigned char)((unsigned int)ForwardSensorR0);
MOVW	R0, #lo_addr(_ForwardSensorR0+0)
MOVT	R0, #hi_addr(_ForwardSensorR0+0)
LDR	R0, [R0, #0]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
UXTB	R1, R0
MOVW	R0, #lo_addr(_out_buffer+11)
MOVT	R0, #hi_addr(_out_buffer+11)
STRB	R1, [R0, #0]
;uart.c,96 :: 		out_buffer[12] = (unsigned char)(((unsigned int)BackwardSensorR0)>>8);
MOVW	R0, #lo_addr(_BackwardSensorR0+0)
MOVT	R0, #hi_addr(_BackwardSensorR0+0)
LDR	R0, [R0, #0]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
LSRS	R0, R0, #8
UXTB	R1, R0
MOVW	R0, #lo_addr(_out_buffer+12)
MOVT	R0, #hi_addr(_out_buffer+12)
STRB	R1, [R0, #0]
;uart.c,97 :: 		out_buffer[13] = (unsigned char)((unsigned int)BackwardSensorR0);
MOVW	R0, #lo_addr(_BackwardSensorR0+0)
MOVT	R0, #hi_addr(_BackwardSensorR0+0)
LDR	R0, [R0, #0]
BL	__FloatToUnsignedIntegral+0
UXTH	R0, R0
UXTB	R1, R0
MOVW	R0, #lo_addr(_out_buffer+13)
MOVT	R0, #hi_addr(_out_buffer+13)
STRB	R1, [R0, #0]
;uart.c,99 :: 		out_buffer[14] = (unsigned char)flag_t.board_sensor_status;
MOVW	R0, #lo_addr(_flag_t+1)
MOVT	R0, #hi_addr(_flag_t+1)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_out_buffer+14)
MOVT	R0, #hi_addr(_out_buffer+14)
STRB	R1, [R0, #0]
;uart.c,100 :: 		out_buffer[15] = (unsigned char)flag_t.forward_sensor_status;
MOVW	R0, #lo_addr(_flag_t+2)
MOVT	R0, #hi_addr(_flag_t+2)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_out_buffer+15)
MOVT	R0, #hi_addr(_out_buffer+15)
STRB	R1, [R0, #0]
;uart.c,101 :: 		out_buffer[16] = (unsigned char)flag_t.backward_sensor_status;
MOVW	R0, #lo_addr(_flag_t+3)
MOVT	R0, #hi_addr(_flag_t+3)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_out_buffer+16)
MOVT	R0, #hi_addr(_out_buffer+16)
STRB	R1, [R0, #0]
;uart.c,103 :: 		out_buffer[17] = (unsigned char)(!flag_t.board_sensor_damage);
MOVW	R0, #lo_addr(_flag_t+9)
MOVT	R0, #hi_addr(_flag_t+9)
LDRB	R0, [R0, #0]
CMP	R0, #0
BNE	L__WriteDataToAndroid25
MOVS	R1, #1
B	L__WriteDataToAndroid26
L__WriteDataToAndroid25:
MOVS	R1, #0
L__WriteDataToAndroid26:
MOVW	R0, #lo_addr(_out_buffer+17)
MOVT	R0, #hi_addr(_out_buffer+17)
STRB	R1, [R0, #0]
;uart.c,104 :: 		out_buffer[18] = (unsigned char)(!flag_t.forward_sensor_damage);
MOVW	R0, #lo_addr(_flag_t+10)
MOVT	R0, #hi_addr(_flag_t+10)
LDRB	R0, [R0, #0]
CMP	R0, #0
BNE	L__WriteDataToAndroid27
MOVS	R1, #1
B	L__WriteDataToAndroid28
L__WriteDataToAndroid27:
MOVS	R1, #0
L__WriteDataToAndroid28:
MOVW	R0, #lo_addr(_out_buffer+18)
MOVT	R0, #hi_addr(_out_buffer+18)
STRB	R1, [R0, #0]
;uart.c,105 :: 		out_buffer[19] = (unsigned char)(!flag_t.backward_sensor_damage);
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
LDRB	R0, [R0, #0]
CMP	R0, #0
BNE	L__WriteDataToAndroid29
MOVS	R1, #1
B	L__WriteDataToAndroid30
L__WriteDataToAndroid29:
MOVS	R1, #0
L__WriteDataToAndroid30:
MOVW	R0, #lo_addr(_out_buffer+19)
MOVT	R0, #hi_addr(_out_buffer+19)
STRB	R1, [R0, #0]
;uart.c,107 :: 		out_buffer[20] = (unsigned char)13;
MOVS	R1, #13
MOVW	R0, #lo_addr(_out_buffer+20)
MOVT	R0, #hi_addr(_out_buffer+20)
STRB	R1, [R0, #0]
;uart.c,108 :: 		out_buffer[21] = (unsigned char)10;
MOVS	R1, #10
MOVW	R0, #lo_addr(_out_buffer+21)
MOVT	R0, #hi_addr(_out_buffer+21)
STRB	R1, [R0, #0]
;uart.c,110 :: 		for(out_count=0;out_count<OUT_BUFFER_SIZE;out_count++)
MOVS	R1, #0
MOVW	R0, #lo_addr(WriteDataToAndroid_out_count_L0+0)
MOVT	R0, #hi_addr(WriteDataToAndroid_out_count_L0+0)
STRB	R1, [R0, #0]
L_WriteDataToAndroid12:
MOVW	R0, #lo_addr(WriteDataToAndroid_out_count_L0+0)
MOVT	R0, #hi_addr(WriteDataToAndroid_out_count_L0+0)
LDRB	R0, [R0, #0]
CMP	R0, #22
IT	CS
BLCS	L_WriteDataToAndroid13
;uart.c,112 :: 		UART1_Write(out_buffer[out_count]);
MOVW	R0, #lo_addr(WriteDataToAndroid_out_count_L0+0)
MOVT	R0, #hi_addr(WriteDataToAndroid_out_count_L0+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_out_buffer+0)
MOVT	R0, #hi_addr(_out_buffer+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
BL	_UART1_Write+0
;uart.c,110 :: 		for(out_count=0;out_count<OUT_BUFFER_SIZE;out_count++)
MOVW	R1, #lo_addr(WriteDataToAndroid_out_count_L0+0)
MOVT	R1, #hi_addr(WriteDataToAndroid_out_count_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, #1
STRB	R0, [R1, #0]
;uart.c,113 :: 		}
IT	AL
BLAL	L_WriteDataToAndroid12
L_WriteDataToAndroid13:
;uart.c,114 :: 		flag_t.response_status = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+20)
MOVT	R0, #hi_addr(_flag_t+20)
STRB	R1, [R0, #0]
;uart.c,115 :: 		LED_UART_TR = OFF;
MOVW	R2, #lo_addr(LED_UART_TR+0)
MOVT	R2, #hi_addr(LED_UART_TR+0)
_LX	[R2, ByteOffset(LED_UART_TR+0)]
MOVS	R1, #1
LSLS	R1, R1, BitPos(LED_UART_TR+0)
BICS	R0, R1
_SX	[R2, ByteOffset(LED_UART_TR+0)]
;uart.c,116 :: 		}
L_WriteDataToAndroid8:
;uart.c,117 :: 		}
L_end_WriteDataToAndroid:
POP	(R15)
; end of _WriteDataToAndroid
_Clear_buffer:
;uart.c,119 :: 		void Clear_buffer(char* buf,unsigned int len)
; len start address is: 4 (R1)
; buf start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #4
; len end address is: 4 (R1)
; buf end address is: 0 (R0)
; buf start address is: 0 (R0)
; len start address is: 4 (R1)
;uart.c,122 :: 		for(count_buf = 0;count_buf<len;count_buf++)
; count_buf start address is: 16 (R4)
MOVS	R4, #0
; buf end address is: 0 (R0)
; len end address is: 4 (R1)
; count_buf end address is: 16 (R4)
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
UXTH	R0, R0
L_Clear_buffer15:
; count_buf start address is: 16 (R4)
; buf start address is: 4 (R1)
; len start address is: 0 (R0)
; buf start address is: 4 (R1)
; buf end address is: 4 (R1)
CMP	R4, R0
IT	CS
BLCS	L_Clear_buffer16
; buf end address is: 4 (R1)
;uart.c,124 :: 		buf[count_buf] = 0;
; buf start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #0
STRB	R2, [R3, #0]
;uart.c,122 :: 		for(count_buf = 0;count_buf<len;count_buf++)
ADDS	R4, #1
UXTB	R4, R4
;uart.c,125 :: 		}
; len end address is: 0 (R0)
; buf end address is: 4 (R1)
; count_buf end address is: 16 (R4)
IT	AL
BLAL	L_Clear_buffer15
L_Clear_buffer16:
;uart.c,126 :: 		}
L_end_Clear_buffer:
ADD	SP, SP, #4
POP	(R15)
; end of _Clear_buffer
