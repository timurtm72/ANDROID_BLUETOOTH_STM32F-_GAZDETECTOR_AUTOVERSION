_save_data_to_eeprom_one:
;eeprom_func.c,8 :: 		char save_data_to_eeprom_one(unsigned long adr,unsigned unsigned char sample,unsigned char* status)
; sample start address is: 4 (R1)
PUSH	(R14)
SUB	SP, SP, #8
STR	R0, [SP, #0]
UXTB	R4, R1
STR	R2, [SP, #4]
; sample end address is: 4 (R1)
; sample start address is: 16 (R4)
;eeprom_func.c,10 :: 		unsigned int tmp_data = 0;
;eeprom_func.c,11 :: 		DisableInterrupts();
BL	_DisableInterrupts+0
;eeprom_func.c,12 :: 		tmp_data = (unsigned int)read_from_eeprom_one(adr);
LDR	R0, [SP, #0]
BL	_read_from_eeprom_one+0
; tmp_data start address is: 28 (R7)
UXTH	R7, R0
;eeprom_func.c,14 :: 		if((tmp_data>=sample)&&(tmp_data!=0xFFFF))
CMP	R0, R4
IT	CC
BLCC	L__save_data_to_eeprom_one39
; sample end address is: 16 (R4)
MOVW	R3, #65535
MOVT	R3, #0
CMP	R7, R3
IT	EQ
BLEQ	L__save_data_to_eeprom_one38
; tmp_data end address is: 28 (R7)
L__save_data_to_eeprom_one37:
;eeprom_func.c,16 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;eeprom_func.c,17 :: 		*status = SET;
MOVS	R4, #1
LDR	R3, [SP, #4]
STRB	R4, [R3, #0]
;eeprom_func.c,18 :: 		return 0;
MOVS	R0, #0
IT	AL
BLAL	L_end_save_data_to_eeprom_one
;eeprom_func.c,14 :: 		if((tmp_data>=sample)&&(tmp_data!=0xFFFF))
L__save_data_to_eeprom_one39:
; tmp_data start address is: 28 (R7)
L__save_data_to_eeprom_one38:
;eeprom_func.c,20 :: 		if(tmp_data==0xFFFF)
MOVW	R3, #65535
MOVT	R3, #0
CMP	R7, R3
IT	NE
BLNE	L_save_data_to_eeprom_one3
; tmp_data end address is: 28 (R7)
;eeprom_func.c,22 :: 		FLASH_Unlock();
BL	_FLASH_Unlock+0
;eeprom_func.c,23 :: 		FLASH_ErasePage(adr);
LDR	R0, [SP, #0]
BL	_FLASH_ErasePage+0
;eeprom_func.c,24 :: 		FLASH_Write_HalfWord(adr,0);
MOVS	R1, #0
LDR	R0, [SP, #0]
BL	_FLASH_Write_HalfWord+0
;eeprom_func.c,25 :: 		FLASH_Write_HalfWord(adr+2, 0);
LDR	R3, [SP, #0]
ADDS	R3, #2
MOVS	R1, #0
MOV	R0, R3
BL	_FLASH_Write_HalfWord+0
;eeprom_func.c,26 :: 		*status = RESET;
MOVS	R4, #0
LDR	R3, [SP, #4]
STRB	R4, [R3, #0]
;eeprom_func.c,27 :: 		}
IT	AL
BLAL	L_save_data_to_eeprom_one4
L_save_data_to_eeprom_one3:
;eeprom_func.c,30 :: 		FLASH_Unlock();
; tmp_data start address is: 28 (R7)
BL	_FLASH_Unlock+0
;eeprom_func.c,31 :: 		FLASH_ErasePage(adr);
LDR	R0, [SP, #0]
BL	_FLASH_ErasePage+0
;eeprom_func.c,32 :: 		++tmp_data;
ADDS	R3, R7, #1
; tmp_data end address is: 28 (R7)
;eeprom_func.c,33 :: 		FLASH_Write_HalfWord(adr,tmp_data);
UXTH	R1, R3
LDR	R0, [SP, #0]
BL	_FLASH_Write_HalfWord+0
;eeprom_func.c,34 :: 		*status = RESET;
MOVS	R4, #0
LDR	R3, [SP, #4]
STRB	R4, [R3, #0]
;eeprom_func.c,35 :: 		}
L_save_data_to_eeprom_one4:
;eeprom_func.c,36 :: 		}
L_end_save_data_to_eeprom_one:
ADD	SP, SP, #8
POP	(R15)
; end of _save_data_to_eeprom_one
_ChekTrue:
;eeprom_func.c,38 :: 		void ChekTrue()
PUSH	(R14)
;eeprom_func.c,40 :: 		save_data_to_eeprom_one(ADDRESS2,DEMO_START_COUNT,&flag_t.enable_status);
MOVW	R0, #lo_addr(_ADDRESS2+0)
MOVT	R0, #hi_addr(_ADDRESS2+0)
LDR	R0, [R0, #0]
MOVW	R2, #lo_addr(_flag_t+17)
MOVT	R2, #hi_addr(_flag_t+17)
MOVS	R1, #200
BL	_save_data_to_eeprom_one+0
;eeprom_func.c,41 :: 		if(!flag_t.enable_status)
MOVW	R0, #lo_addr(_flag_t+17)
MOVT	R0, #hi_addr(_flag_t+17)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BLNE	L_ChekTrue5
;eeprom_func.c,43 :: 		setState(control_calibration);
MOVS	R0, #1
BL	_setState+0
;eeprom_func.c,44 :: 		}
IT	AL
BLAL	L_ChekTrue6
L_ChekTrue5:
;eeprom_func.c,47 :: 		setState(error_calibration);
MOVS	R0, #2
BL	_setState+0
;eeprom_func.c,48 :: 		}
L_ChekTrue6:
;eeprom_func.c,49 :: 		}
L_end_ChekTrue:
POP	(R15)
; end of _ChekTrue
_read_from_eeprom_one:
;eeprom_func.c,51 :: 		unsigned int read_from_eeprom_one(unsigned long adr)
; adr start address is: 0 (R0)
PUSH	(R14)
; adr end address is: 0 (R0)
; adr start address is: 0 (R0)
;eeprom_func.c,53 :: 		unsigned int tmp_data = 0;
;eeprom_func.c,55 :: 		ptr = (unsigned long*)adr;
; ptr start address is: 8 (R2)
MOV	R2, R0
; adr end address is: 0 (R0)
;eeprom_func.c,56 :: 		DisableInterrupts();
BL	_DisableInterrupts+0
;eeprom_func.c,57 :: 		tmp_data = (unsigned int)(*ptr);
LDR	R1, [R2, #0]
; ptr end address is: 8 (R2)
; tmp_data start address is: 4 (R1)
UXTH	R1, R1
;eeprom_func.c,58 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;eeprom_func.c,59 :: 		return  (unsigned int)tmp_data;
UXTH	R0, R1
; tmp_data end address is: 4 (R1)
;eeprom_func.c,60 :: 		}
L_end_read_from_eeprom_one:
POP	(R15)
; end of _read_from_eeprom_one
_save_data_to_eeprom:
;eeprom_func.c,62 :: 		char save_data_to_eeprom(unsigned char len_array)
PUSH	(R14)
SUB	SP, SP, #12
STR	R0, [SP, #8]
;eeprom_func.c,64 :: 		unsigned char position=0;
;eeprom_func.c,67 :: 		array_struct = (unsigned long*)&parameters_t;
MOVW	R1, #lo_addr(_parameters_t+0)
MOVT	R1, #hi_addr(_parameters_t+0)
STR	R1, [SP, #4]
;eeprom_func.c,68 :: 		DisableInterrupts();
BL	_DisableInterrupts+0
;eeprom_func.c,69 :: 		FLASH_Unlock();
BL	_FLASH_Unlock+0
;eeprom_func.c,70 :: 		FLASH_ErasePage(ADDRESS);
MOVW	R1, #lo_addr(_ADDRESS+0)
MOVT	R1, #hi_addr(_ADDRESS+0)
LDR	R1, [R1, #0]
MOV	R0, R1
BL	_FLASH_ErasePage+0
;eeprom_func.c,71 :: 		Init_flash_cal();
BL	_Init_flash_cal+0
;eeprom_func.c,72 :: 		for(position=0;position<len_array;position++)
; position start address is: 0 (R0)
MOVS	R0, #0
; position end address is: 0 (R0)
L_save_data_to_eeprom7:
; position start address is: 0 (R0)
LDR	R1, [SP, #8]
UXTB	R1, R1
CMP	R0, R1
IT	CS
BLCS	L_save_data_to_eeprom8
;eeprom_func.c,74 :: 		FLASH_Write_HalfWord(ADDRESS+(position*4-2), 0);
LSLS	R1, R0, #2
SXTH	R1, R1
SUBS	R2, R1, #2
SXTH	R2, R2
MOVW	R1, #lo_addr(_ADDRESS+0)
MOVT	R1, #hi_addr(_ADDRESS+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, R2
STR	R0, [SP, #0]
MOV	R0, R1
MOVS	R1, #0
BL	_FLASH_Write_HalfWord+0
LDR	R0, [SP, #0]
UXTB	R0, R0
;eeprom_func.c,75 :: 		FLASH_Write_HalfWord(ADDRESS+position*4, (*array_struct));
LDR	R1, [SP, #4]
LDRH	R1, [R1, #0]
UXTH	R3, R1
LSLS	R2, R0, #2
SXTH	R2, R2
MOVW	R1, #lo_addr(_ADDRESS+0)
MOVT	R1, #hi_addr(_ADDRESS+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, R2
STR	R0, [SP, #0]
MOV	R0, R1
UXTH	R1, R3
BL	_FLASH_Write_HalfWord+0
LDR	R0, [SP, #0]
UXTB	R0, R0
;eeprom_func.c,76 :: 		array_struct++;
LDR	R1, [SP, #4]
ADDS	R1, #2
STR	R1, [SP, #4]
;eeprom_func.c,72 :: 		for(position=0;position<len_array;position++)
ADDS	R1, R0, #1
; position end address is: 0 (R0)
; position start address is: 4 (R1)
;eeprom_func.c,77 :: 		}
UXTB	R0, R1
; position end address is: 4 (R1)
IT	AL
BLAL	L_save_data_to_eeprom7
L_save_data_to_eeprom8:
;eeprom_func.c,78 :: 		FLASH_Write_HalfWord(ADDRESS+(position*4-2), 0);
; position start address is: 0 (R0)
LSLS	R1, R0, #2
SXTH	R1, R1
; position end address is: 0 (R0)
SUBS	R2, R1, #2
SXTH	R2, R2
MOVW	R1, #lo_addr(_ADDRESS+0)
MOVT	R1, #hi_addr(_ADDRESS+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, R2
MOV	R0, R1
MOVS	R1, #0
BL	_FLASH_Write_HalfWord+0
;eeprom_func.c,79 :: 		FLASH_Lock();
BL	_FLASH_Lock+0
;eeprom_func.c,80 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;eeprom_func.c,81 :: 		return 1;
MOVS	R0, #1
;eeprom_func.c,82 :: 		}
L_end_save_data_to_eeprom:
ADD	SP, SP, #12
POP	(R15)
; end of _save_data_to_eeprom
_read_data_from_eeprom:
;eeprom_func.c,85 :: 		char read_data_from_eeprom(unsigned char len_array)
; len_array start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #4
UXTB	R2, R0
; len_array end address is: 0 (R0)
; len_array start address is: 8 (R2)
;eeprom_func.c,87 :: 		unsigned char position = 0;
;eeprom_func.c,88 :: 		unsigned int temp = 0,crc=0;
;eeprom_func.c,92 :: 		array_struct = (unsigned long*)&parameters_t;
; array_struct start address is: 16 (R4)
MOVW	R4, #lo_addr(_parameters_t+0)
MOVT	R4, #hi_addr(_parameters_t+0)
;eeprom_func.c,93 :: 		ptr = (unsigned long*)ADDRESS;
MOVW	R1, #lo_addr(_ADDRESS+0)
MOVT	R1, #hi_addr(_ADDRESS+0)
; ptr start address is: 12 (R3)
LDR	R3, [R1, #0]
;eeprom_func.c,94 :: 		DisableInterrupts();
BL	_DisableInterrupts+0
;eeprom_func.c,95 :: 		for(position=0; position<len_array; position++)
; position start address is: 0 (R0)
MOVS	R0, #0
; len_array end address is: 8 (R2)
; position end address is: 0 (R0)
; ptr end address is: 12 (R3)
; array_struct end address is: 16 (R4)
STR	R0, [SP, #0]
UXTB	R0, R2
LDR	R2, [SP, #0]
UXTB	R2, R2
L_read_data_from_eeprom10:
; position start address is: 8 (R2)
; ptr start address is: 12 (R3)
; array_struct start address is: 16 (R4)
; len_array start address is: 0 (R0)
CMP	R2, R0
IT	CS
BLCS	L_read_data_from_eeprom11
;eeprom_func.c,97 :: 		(*array_struct) = (unsigned int)(*ptr);
LDR	R1, [R3, #0]
UXTH	R1, R1
STRH	R1, [R4, #0]
;eeprom_func.c,98 :: 		ptr++;
ADDS	R3, #4
;eeprom_func.c,99 :: 		array_struct++;
ADDS	R4, #2
;eeprom_func.c,95 :: 		for(position=0; position<len_array; position++)
ADDS	R2, #1
UXTB	R2, R2
;eeprom_func.c,100 :: 		}
; len_array end address is: 0 (R0)
; ptr end address is: 12 (R3)
; array_struct end address is: 16 (R4)
; position end address is: 8 (R2)
IT	AL
BLAL	L_read_data_from_eeprom10
L_read_data_from_eeprom11:
;eeprom_func.c,102 :: 		+parameters_t.backward_sensor_cal_data
MOVW	R1, #lo_addr(_parameters_t+8)
MOVT	R1, #hi_addr(_parameters_t+8)
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_parameters_t+6)
MOVT	R1, #hi_addr(_parameters_t+6)
LDRH	R1, [R1, #0]
ADDS	R2, R1, R2
UXTH	R2, R2
;eeprom_func.c,103 :: 		+parameters_t.board_sensor_cal_data
MOVW	R1, #lo_addr(_parameters_t+10)
MOVT	R1, #hi_addr(_parameters_t+10)
LDRH	R1, [R1, #0]
ADDS	R2, R2, R1
UXTH	R2, R2
;eeprom_func.c,104 :: 		+parameters_t.forward_sensor_v0_cal_data
MOVW	R1, #lo_addr(_parameters_t+0)
MOVT	R1, #hi_addr(_parameters_t+0)
LDRH	R1, [R1, #0]
ADDS	R2, R2, R1
UXTH	R2, R2
;eeprom_func.c,105 :: 		+parameters_t.backward_sensor_v0_cal_data
MOVW	R1, #lo_addr(_parameters_t+2)
MOVT	R1, #hi_addr(_parameters_t+2)
LDRH	R1, [R1, #0]
ADDS	R2, R2, R1
UXTH	R2, R2
;eeprom_func.c,106 :: 		+parameters_t.board_sensor_v0_cal_data;
MOVW	R1, #lo_addr(_parameters_t+4)
MOVT	R1, #hi_addr(_parameters_t+4)
LDRH	R1, [R1, #0]
ADDS	R1, R2, R1
; temp start address is: 8 (R2)
UXTH	R2, R1
;eeprom_func.c,111 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;eeprom_func.c,112 :: 		if(ControlData())
STR	R2, [SP, #0]
BL	_ControlData+0
LDR	R2, [SP, #0]
UXTH	R2, R2
CMP	R0, #0
IT	EQ
BLEQ	L_read_data_from_eeprom13
;eeprom_func.c,114 :: 		if(temp==parameters_t.crc_adc)
MOVW	R1, #lo_addr(_parameters_t+24)
MOVT	R1, #hi_addr(_parameters_t+24)
LDRH	R1, [R1, #0]
CMP	R2, R1
IT	NE
BLNE	L_read_data_from_eeprom14
; temp end address is: 8 (R2)
;eeprom_func.c,116 :: 		return 0;
MOVS	R0, #0
IT	AL
BLAL	L_end_read_data_from_eeprom
;eeprom_func.c,117 :: 		}
L_read_data_from_eeprom14:
;eeprom_func.c,118 :: 		}
; temp start address is: 8 (R2)
IT	AL
BLAL	L_read_data_from_eeprom15
; temp end address is: 8 (R2)
L_read_data_from_eeprom13:
;eeprom_func.c,121 :: 		return 1;
MOVS	R0, #1
IT	AL
BLAL	L_end_read_data_from_eeprom
;eeprom_func.c,122 :: 		}
L_read_data_from_eeprom15:
;eeprom_func.c,123 :: 		if(temp!=parameters_t.crc_adc)
; temp start address is: 8 (R2)
MOVW	R1, #lo_addr(_parameters_t+24)
MOVT	R1, #hi_addr(_parameters_t+24)
LDRH	R1, [R1, #0]
CMP	R2, R1
IT	EQ
BLEQ	L_read_data_from_eeprom16
; temp end address is: 8 (R2)
;eeprom_func.c,125 :: 		return 1;
MOVS	R0, #1
IT	AL
BLAL	L_end_read_data_from_eeprom
;eeprom_func.c,126 :: 		}
L_read_data_from_eeprom16:
;eeprom_func.c,127 :: 		}
L_end_read_data_from_eeprom:
ADD	SP, SP, #4
POP	(R15)
; end of _read_data_from_eeprom
_FLASH_ReadOutProtection:
;eeprom_func.c,129 :: 		char FLASH_ReadOutProtection(unsigned char new_state)
; new_state start address is: 0 (R0)
PUSH	(R14)
UXTB	R3, R0
; new_state end address is: 0 (R0)
; new_state start address is: 12 (R3)
;eeprom_func.c,135 :: 		DisableInterrupts();
BL	_DisableInterrupts+0
;eeprom_func.c,136 :: 		status = FLASH_WaitForLastOperation();
BL	_FLASH_WaitForLastOperation+0
MOVW	R1, #lo_addr(FLASH_ReadOutProtection_status_L0+0)
MOVT	R1, #hi_addr(FLASH_ReadOutProtection_status_L0+0)
STRB	R0, [R1, #0]
;eeprom_func.c,137 :: 		if(status == SET)
CMP	R0, #1
IT	NE
BLNE	L_FLASH_ReadOutProtection17
;eeprom_func.c,140 :: 		FLASH_OPTKEYR = FLASH_FKEY1 ;
MOVW	R2, #291
MOVT	R2, #17767
MOVW	R1, 1073881096
MOVT	R1, 16386
STR	R2, [R1, #0]
;eeprom_func.c,141 :: 		FLASH_OPTKEYR = FLASH_FKEY2 ;
MOVW	R2, #35243
MOVT	R2, #52719
MOVW	R1, 1073881096
MOVT	R1, 16386
STR	R2, [R1, #0]
;eeprom_func.c,143 :: 		FLASH_CR |= FLASH_CR_OPTER;
MOVW	R1, 1073881104
MOVT	R1, 16386
LDR	R2, [R1, #0]
MOVS	R1, #32
ORRS	R2, R1
MOVW	R1, 1073881104
MOVT	R1, 16386
STR	R2, [R1, #0]
;eeprom_func.c,144 :: 		FLASH_CR |= FLASH_CR_STRT;
MOVW	R1, 1073881104
MOVT	R1, 16386
LDR	R2, [R1, #0]
MOVS	R1, #64
ORRS	R2, R1
MOVW	R1, 1073881104
MOVT	R1, 16386
STR	R2, [R1, #0]
;eeprom_func.c,146 :: 		status = FLASH_WaitForLastOperation();
BL	_FLASH_WaitForLastOperation+0
MOVW	R1, #lo_addr(FLASH_ReadOutProtection_status_L0+0)
MOVT	R1, #hi_addr(FLASH_ReadOutProtection_status_L0+0)
STRB	R0, [R1, #0]
;eeprom_func.c,147 :: 		if(status == SET)
CMP	R0, #1
IT	NE
BLNE	L_FLASH_ReadOutProtection18
;eeprom_func.c,150 :: 		FLASH_CR &= FLASH_CR_OPTER;
MOVW	R1, 1073881104
MOVT	R1, 16386
LDR	R2, [R1, #0]
MOVS	R1, #32
ANDS	R2, R1
MOVW	R1, 1073881104
MOVT	R1, 16386
STR	R2, [R1, #0]
;eeprom_func.c,152 :: 		FLASH_CR |= FLASH_CR_OPTPG;
MOVW	R1, 1073881104
MOVT	R1, 16386
LDR	R2, [R1, #0]
MOVS	R1, #16
ORRS	R2, R1
MOVW	R1, 1073881104
MOVT	R1, 16386
STR	R2, [R1, #0]
;eeprom_func.c,153 :: 		if(new_state == SET)
CMP	R3, #1
IT	NE
BLNE	L_FLASH_ReadOutProtection19
; new_state end address is: 12 (R3)
;eeprom_func.c,155 :: 		LEVEL1_PROT_bit = SET;
MOVW	R3, 1073881116
MOVT	R3, 16386
_LX	[R3, ByteOffset(1073881116)]
MOVS	R2, #1
LSLS	R2, R2, #1
ORRS	R1, R2
_SX	[R3, ByteOffset(4)]
;eeprom_func.c,156 :: 		LEVEL2_PROT_bit = RESET;
MOVW	R3, 1073881116
MOVT	R3, 16386
_LX	[R3, ByteOffset(1073881116)]
MOVS	R2, #1
LSLS	R2, R2, #2
BICS	R1, R2
_SX	[R3, ByteOffset(4)]
;eeprom_func.c,157 :: 		}
IT	AL
BLAL	L_FLASH_ReadOutProtection20
L_FLASH_ReadOutProtection19:
;eeprom_func.c,160 :: 		LEVEL1_PROT_bit = RESET;
MOVW	R3, 1073881116
MOVT	R3, 16386
_LX	[R3, ByteOffset(4)]
MOVS	R2, #1
LSLS	R2, R2, #1
BICS	R1, R2
_SX	[R3, ByteOffset(4)]
;eeprom_func.c,161 :: 		LEVEL2_PROT_bit = RESET;
MOVW	R3, 1073881116
MOVT	R3, 16386
_LX	[R3, ByteOffset(4)]
MOVS	R2, #1
LSLS	R2, R2, #2
BICS	R1, R2
_SX	[R3, ByteOffset(4)]
;eeprom_func.c,162 :: 		}
L_FLASH_ReadOutProtection20:
;eeprom_func.c,164 :: 		status = FLASH_WaitForLastOperation();
BL	_FLASH_WaitForLastOperation+0
MOVW	R1, #lo_addr(FLASH_ReadOutProtection_status_L0+0)
MOVT	R1, #hi_addr(FLASH_ReadOutProtection_status_L0+0)
STRB	R0, [R1, #0]
;eeprom_func.c,169 :: 		FLASH_CR &= ~(FLASH_CR_OPTPG);
MOVW	R1, 1073881104
MOVT	R1, 16386
LDR	R2, [R1, #0]
MOVW	R1, #65519
MOVT	R1, #65535
ANDS	R2, R1
MOVW	R1, 1073881104
MOVT	R1, 16386
STR	R2, [R1, #0]
;eeprom_func.c,171 :: 		}
IT	AL
BLAL	L_FLASH_ReadOutProtection21
L_FLASH_ReadOutProtection18:
;eeprom_func.c,177 :: 		FLASH_CR &= ~(FLASH_CR_OPTER);
MOVW	R1, 1073881104
MOVT	R1, 16386
LDR	R2, [R1, #0]
MOVW	R1, #65503
MOVT	R1, #65535
ANDS	R2, R1
MOVW	R1, 1073881104
MOVT	R1, 16386
STR	R2, [R1, #0]
;eeprom_func.c,178 :: 		FLASH_Lock();
BL	_FLASH_Lock+0
;eeprom_func.c,179 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;eeprom_func.c,181 :: 		return -1;
MOVS	R0, #255
IT	AL
BLAL	L_end_FLASH_ReadOutProtection
;eeprom_func.c,183 :: 		}
L_FLASH_ReadOutProtection21:
;eeprom_func.c,184 :: 		}
L_FLASH_ReadOutProtection17:
;eeprom_func.c,186 :: 		FLASH_Lock();
BL	_FLASH_Lock+0
;eeprom_func.c,187 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;eeprom_func.c,188 :: 		return status;
MOVW	R1, #lo_addr(FLASH_ReadOutProtection_status_L0+0)
MOVT	R1, #hi_addr(FLASH_ReadOutProtection_status_L0+0)
LDRB	R0, [R1, #0]
;eeprom_func.c,189 :: 		}
L_end_FLASH_ReadOutProtection:
POP	(R15)
; end of _FLASH_ReadOutProtection
_FLASH_WaitForLastOperation:
;eeprom_func.c,198 :: 		char FLASH_WaitForLastOperation()
PUSH	(R14)
;eeprom_func.c,204 :: 		while ((FLASH_SR & FLASH_SR_BSY) != 0) /* (3) */
L_FLASH_WaitForLastOperation22:
MOVW	R0, 1073881100
MOVT	R0, 16386
LDR	R1, [R0, #0]
MOVS	R0, #1
ANDS	R0, R1
CMP	R0, #0
IT	EQ
BLEQ	L_FLASH_WaitForLastOperation23
;eeprom_func.c,207 :: 		}
IT	AL
BLAL	L_FLASH_WaitForLastOperation22
L_FLASH_WaitForLastOperation23:
;eeprom_func.c,210 :: 		if((FLASH_SR & FLASH_SR_EOP) == RESET)
MOVW	R0, 1073881100
MOVT	R0, 16386
LDR	R1, [R0, #0]
MOVS	R0, #32
ANDS	R0, R1
CMP	R0, #0
IT	NE
BLNE	L_FLASH_WaitForLastOperation24
;eeprom_func.c,212 :: 		FLASH_SR |= FLASH_SR_EOP;
MOVW	R0, 1073881100
MOVT	R0, 16386
LDR	R1, [R0, #0]
MOVS	R0, #32
ORRS	R1, R0
MOVW	R0, 1073881100
MOVT	R0, 16386
STR	R1, [R0, #0]
;eeprom_func.c,213 :: 		}
L_FLASH_WaitForLastOperation24:
;eeprom_func.c,214 :: 		if((FLASH_SR & FLASH_SR_WRPERR) || (FLASH_SR & FLASH_SR_PGERR))
MOVW	R0, 1073881100
MOVT	R0, 16386
LDR	R1, [R0, #0]
MOVS	R0, #16
ANDS	R0, R1
CMP	R0, #0
IT	NE
BLNE	L__FLASH_WaitForLastOperation42
MOVW	R0, 1073881100
MOVT	R0, 16386
LDR	R1, [R0, #0]
MOVS	R0, #4
ANDS	R0, R1
CMP	R0, #0
IT	NE
BLNE	L__FLASH_WaitForLastOperation41
IT	AL
BLAL	L_FLASH_WaitForLastOperation27
L__FLASH_WaitForLastOperation42:
L__FLASH_WaitForLastOperation41:
;eeprom_func.c,216 :: 		return -1;
MOVS	R0, #255
IT	AL
BLAL	L_end_FLASH_WaitForLastOperation
;eeprom_func.c,218 :: 		}
L_FLASH_WaitForLastOperation27:
;eeprom_func.c,219 :: 		return 1;
MOVS	R0, #1
;eeprom_func.c,220 :: 		}
L_end_FLASH_WaitForLastOperation:
POP	(R15)
; end of _FLASH_WaitForLastOperation
_FLASH_GetReadOutProtectionStatus:
;eeprom_func.c,222 :: 		char FLASH_GetReadOutProtectionStatus()
PUSH	(R14)
;eeprom_func.c,224 :: 		if ((LEVEL1_PROT_bit == RESET)&&(LEVEL2_PROT_bit == RESET))
MOVW	R0, 1073881116
MOVT	R0, 16386
_LX	[R0, ByteOffset(4)]
MOVS	R0, #1
LSLS	R0, R0, #1
ANDS	R0, R1
LSRS	R0, R0, #1
CMP	R0, #0
IT	NE
BLNE	L__FLASH_GetReadOutProtectionStatus45
MOVW	R0, 1073881116
MOVT	R0, 16386
_LX	[R0, ByteOffset(4)]
MOVS	R0, #1
LSLS	R0, R0, #2
ANDS	R0, R1
LSRS	R0, R0, #2
CMP	R0, #0
IT	NE
BLNE	L__FLASH_GetReadOutProtectionStatus44
L__FLASH_GetReadOutProtectionStatus43:
;eeprom_func.c,226 :: 		return RESET;
MOVS	R0, #0
IT	AL
BLAL	L_end_FLASH_GetReadOutProtectionStatus
;eeprom_func.c,224 :: 		if ((LEVEL1_PROT_bit == RESET)&&(LEVEL2_PROT_bit == RESET))
L__FLASH_GetReadOutProtectionStatus45:
L__FLASH_GetReadOutProtectionStatus44:
;eeprom_func.c,230 :: 		return SET;
MOVS	R0, #1
;eeprom_func.c,232 :: 		}
L_end_FLASH_GetReadOutProtectionStatus:
POP	(R15)
; end of _FLASH_GetReadOutProtectionStatus
_ControlReadOutProtection:
;eeprom_func.c,234 :: 		void ControlReadOutProtection()
PUSH	(R14)
;eeprom_func.c,236 :: 		if (FLASH_GetReadOutProtectionStatus() == RESET)
BL	_FLASH_GetReadOutProtectionStatus+0
CMP	R0, #0
IT	NE
BLNE	L_ControlReadOutProtection32
;eeprom_func.c,238 :: 		FLASH_Unlock();
BL	_FLASH_Unlock+0
;eeprom_func.c,239 :: 		FLASH_ReadOutProtection(SET);
MOVS	R0, #1
BL	_FLASH_ReadOutProtection+0
;eeprom_func.c,240 :: 		FLASH_Lock();
BL	_FLASH_Lock+0
;eeprom_func.c,241 :: 		}
L_ControlReadOutProtection32:
;eeprom_func.c,242 :: 		}
L_end_ControlReadOutProtection:
POP	(R15)
; end of _ControlReadOutProtection
_checkMaxValue:
;eeprom_func.c,247 :: 		int checkMaxValue(int* ar_data, int len)
; len start address is: 4 (R1)
; ar_data start address is: 0 (R0)
PUSH	(R14)
SXTH	R2, R1
MOV	R1, R0
; len end address is: 4 (R1)
; ar_data end address is: 0 (R0)
; ar_data start address is: 4 (R1)
; len start address is: 8 (R2)
;eeprom_func.c,249 :: 		int max = 0;
; max start address is: 16 (R4)
MOVS	R4, #0
;eeprom_func.c,250 :: 		unsigned char i = 0;
;eeprom_func.c,251 :: 		for(i = 0;i < len;i++)
; i start address is: 0 (R0)
MOVS	R0, #0
; len end address is: 8 (R2)
; i end address is: 0 (R0)
; max end address is: 16 (R4)
UXTB	R3, R0
SXTH	R0, R2
L_checkMaxValue33:
; i start address is: 12 (R3)
; max start address is: 16 (R4)
; len start address is: 0 (R0)
; ar_data start address is: 4 (R1)
; ar_data end address is: 4 (R1)
CMP	R3, R0
IT	GE
BLGE	L_checkMaxValue34
; ar_data end address is: 4 (R1)
;eeprom_func.c,253 :: 		if(ar_data[i] > max)
; ar_data start address is: 4 (R1)
LSLS	R2, R3, #1
ADDS	R2, R1, R2
LDRH	R2, [R2, #0]
SXTH	R2, R2
CMP	R2, R4
IT	LE
BLLE	L__checkMaxValue46
; max end address is: 16 (R4)
;eeprom_func.c,255 :: 		max = ar_data[i];
LSLS	R2, R3, #1
ADDS	R2, R1, R2
LDRH	R4, [R2, #0]
SXTH	R4, R4
; max start address is: 16 (R4)
; max end address is: 16 (R4)
;eeprom_func.c,256 :: 		}
IT	AL
BLAL	L_checkMaxValue36
L__checkMaxValue46:
;eeprom_func.c,253 :: 		if(ar_data[i] > max)
;eeprom_func.c,256 :: 		}
L_checkMaxValue36:
;eeprom_func.c,251 :: 		for(i = 0;i < len;i++)
; max start address is: 16 (R4)
ADDS	R3, #1
UXTB	R3, R3
;eeprom_func.c,257 :: 		}
; len end address is: 0 (R0)
; ar_data end address is: 4 (R1)
; i end address is: 12 (R3)
IT	AL
BLAL	L_checkMaxValue33
L_checkMaxValue34:
;eeprom_func.c,258 :: 		return max;
SXTH	R0, R4
; max end address is: 16 (R4)
;eeprom_func.c,259 :: 		}
L_end_checkMaxValue:
POP	(R15)
; end of _checkMaxValue
