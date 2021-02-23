_one_level_comparator_sec:
;compare_func.c,6 :: 		unsigned int* count_olc,unsigned int* count_olc1)
PUSH	(R14)
SUB	SP, SP, #28
STR	R0, [SP, #0]
STR	R1, [SP, #4]
STR	R2, [SP, #8]
STR	R3, [SP, #12]
LDR	R4, [SP, #32]
UXTH	R4, R4
STR	R4, [SP, #32]
LDR	R4, [SP, #36]
UXTH	R4, R4
STR	R4, [SP, #36]
LDR	R4, [SP, #40]
STR	R4, [SP, #40]
LDR	R4, [SP, #44]
STR	R4, [SP, #44]
LDR	R4, [SP, #48]
STR	R4, [SP, #48]
;compare_func.c,8 :: 		if(value>=(reference+gisteresis))
LDR	R2, [SP, #8]
LDR	R0, [SP, #0]
BL	__Add_FP+0
LDR	R2, [SP, #4]
BL	__Compare_FP+0
BGT	L__one_level_comparator_sec77
MOVS	R0, #1
B	L__one_level_comparator_sec78
L__one_level_comparator_sec77:
MOVS	R0, #0
L__one_level_comparator_sec78:
CMP	R0, #0
IT	EQ
BLEQ	L_one_level_comparator_sec0
;compare_func.c,10 :: 		if(++(*count_olc)>=(unsigned int)(delay_on_sec*(1000/ms_in_one_cycle)))
LDR	R4, [SP, #44]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #44]
STRH	R5, [R4, #0]
LDR	R4, [SP, #44]
LDRH	R4, [R4, #0]
STR	R4, [SP, #24]
LDR	R2, [SP, #36]
UXTH	R2, R2
MOVW	R0, #1000
MOVT	R0, #0
BL	__Div_32x32_U+0
UXTH	R0, R0
LDR	R4, [SP, #12]
UXTH	R4, R4
MOV	R5, R0
MULS	R5, R4, R5
UXTH	R5, R5
LDR	R4, [SP, #24]
UXTH	R4, R4
CMP	R4, R5
IT	CC
BLCC	L_one_level_comparator_sec1
;compare_func.c,12 :: 		*count_olc = 0;
MOVS	R5, #0
LDR	R4, [SP, #44]
STRH	R5, [R4, #0]
;compare_func.c,13 :: 		*count_olc1=0;
MOVS	R5, #0
LDR	R4, [SP, #48]
STRH	R5, [R4, #0]
;compare_func.c,15 :: 		if(value>=(reference+gisteresis))
LDR	R2, [SP, #8]
LDR	R0, [SP, #0]
BL	__Add_FP+0
LDR	R2, [SP, #4]
BL	__Compare_FP+0
BGT	L__one_level_comparator_sec79
MOVS	R0, #1
B	L__one_level_comparator_sec80
L__one_level_comparator_sec79:
MOVS	R0, #0
L__one_level_comparator_sec80:
CMP	R0, #0
IT	EQ
BLEQ	L_one_level_comparator_sec2
;compare_func.c,17 :: 		*status = 1;
MOVS	R5, #1
LDR	R4, [SP, #40]
STRB	R5, [R4, #0]
;compare_func.c,18 :: 		}
L_one_level_comparator_sec2:
;compare_func.c,19 :: 		}
L_one_level_comparator_sec1:
;compare_func.c,20 :: 		}
L_one_level_comparator_sec0:
;compare_func.c,24 :: 		if(value<=(reference-gisteresis))
LDR	R2, [SP, #8]
LDR	R0, [SP, #0]
BL	__Sub_FP+0
LDR	R2, [SP, #4]
BL	__Compare_FP+0
BLT	L__one_level_comparator_sec81
MOVS	R0, #1
B	L__one_level_comparator_sec82
L__one_level_comparator_sec81:
MOVS	R0, #0
L__one_level_comparator_sec82:
CMP	R0, #0
IT	EQ
BLEQ	L_one_level_comparator_sec3
;compare_func.c,26 :: 		if(++(*count_olc1)>=(unsigned int)(delay_off_sec*(1000/ms_in_one_cycle)))
LDR	R4, [SP, #48]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #48]
STRH	R5, [R4, #0]
LDR	R4, [SP, #48]
LDRH	R4, [R4, #0]
STR	R4, [SP, #24]
LDR	R2, [SP, #36]
UXTH	R2, R2
MOVW	R0, #1000
MOVT	R0, #0
BL	__Div_32x32_U+0
UXTH	R0, R0
LDR	R4, [SP, #32]
UXTH	R4, R4
MOV	R5, R0
MULS	R5, R4, R5
UXTH	R5, R5
LDR	R4, [SP, #24]
UXTH	R4, R4
CMP	R4, R5
IT	CC
BLCC	L_one_level_comparator_sec4
;compare_func.c,28 :: 		*count_olc = 0;
MOVS	R5, #0
LDR	R4, [SP, #44]
STRH	R5, [R4, #0]
;compare_func.c,29 :: 		*count_olc1=0;
MOVS	R5, #0
LDR	R4, [SP, #48]
STRH	R5, [R4, #0]
;compare_func.c,31 :: 		if(value<=(reference-gisteresis))
LDR	R2, [SP, #8]
LDR	R0, [SP, #0]
BL	__Sub_FP+0
LDR	R2, [SP, #4]
BL	__Compare_FP+0
BLT	L__one_level_comparator_sec83
MOVS	R0, #1
B	L__one_level_comparator_sec84
L__one_level_comparator_sec83:
MOVS	R0, #0
L__one_level_comparator_sec84:
CMP	R0, #0
IT	EQ
BLEQ	L_one_level_comparator_sec5
;compare_func.c,33 :: 		*status = 0;
MOVS	R5, #0
LDR	R4, [SP, #40]
STRB	R5, [R4, #0]
;compare_func.c,34 :: 		}
L_one_level_comparator_sec5:
;compare_func.c,35 :: 		}
L_one_level_comparator_sec4:
;compare_func.c,36 :: 		}
L_one_level_comparator_sec3:
;compare_func.c,37 :: 		}
L_end_one_level_comparator_sec:
ADD	SP, SP, #28
POP	(R15)
; end of _one_level_comparator_sec
_one_level_comparator_ms:
;compare_func.c,41 :: 		unsigned int* count_olc,unsigned int* count_olc1)
PUSH	(R14)
SUB	SP, SP, #32
STR	R0, [SP, #0]
STR	R1, [SP, #4]
STR	R2, [SP, #8]
STR	R3, [SP, #12]
LDR	R4, [SP, #36]
UXTH	R4, R4
STR	R4, [SP, #36]
LDR	R4, [SP, #40]
UXTH	R4, R4
STR	R4, [SP, #40]
LDR	R4, [SP, #44]
STR	R4, [SP, #44]
LDR	R4, [SP, #48]
STR	R4, [SP, #48]
LDR	R4, [SP, #52]
STR	R4, [SP, #52]
;compare_func.c,43 :: 		if(value>=(reference+gisteresis))
LDR	R2, [SP, #8]
LDR	R0, [SP, #0]
BL	__Add_FP+0
LDR	R2, [SP, #4]
BL	__Compare_FP+0
BGT	L__one_level_comparator_ms86
MOVS	R0, #1
B	L__one_level_comparator_ms87
L__one_level_comparator_ms86:
MOVS	R0, #0
L__one_level_comparator_ms87:
CMP	R0, #0
IT	EQ
BLEQ	L_one_level_comparator_ms6
;compare_func.c,45 :: 		if(++(*count_olc)>=(unsigned int)(delay_on_ms/ms_in_one_cycle))
LDR	R4, [SP, #48]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #48]
STRH	R5, [R4, #0]
LDR	R4, [SP, #48]
LDRH	R4, [R4, #0]
STR	R4, [SP, #28]
LDR	R2, [SP, #40]
UXTH	R2, R2
LDR	R0, [SP, #12]
UXTH	R0, R0
BL	__Div_32x32_U+0
UXTH	R0, R0
LDR	R4, [SP, #28]
UXTH	R4, R4
CMP	R4, R0
IT	CC
BLCC	L_one_level_comparator_ms7
;compare_func.c,47 :: 		*count_olc  = 0;
MOVS	R5, #0
LDR	R4, [SP, #48]
STRH	R5, [R4, #0]
;compare_func.c,48 :: 		*count_olc1 = 0;
MOVS	R5, #0
LDR	R4, [SP, #52]
STRH	R5, [R4, #0]
;compare_func.c,50 :: 		if(value>=(reference+gisteresis))
LDR	R2, [SP, #8]
LDR	R0, [SP, #0]
BL	__Add_FP+0
LDR	R2, [SP, #4]
BL	__Compare_FP+0
BGT	L__one_level_comparator_ms88
MOVS	R0, #1
B	L__one_level_comparator_ms89
L__one_level_comparator_ms88:
MOVS	R0, #0
L__one_level_comparator_ms89:
CMP	R0, #0
IT	EQ
BLEQ	L_one_level_comparator_ms8
;compare_func.c,52 :: 		*status = 1;
MOVS	R5, #1
LDR	R4, [SP, #44]
STRB	R5, [R4, #0]
;compare_func.c,53 :: 		}
L_one_level_comparator_ms8:
;compare_func.c,54 :: 		}
L_one_level_comparator_ms7:
;compare_func.c,55 :: 		}
L_one_level_comparator_ms6:
;compare_func.c,59 :: 		if(value<=(reference-gisteresis))
LDR	R2, [SP, #8]
LDR	R0, [SP, #0]
BL	__Sub_FP+0
LDR	R2, [SP, #4]
BL	__Compare_FP+0
BLT	L__one_level_comparator_ms90
MOVS	R0, #1
B	L__one_level_comparator_ms91
L__one_level_comparator_ms90:
MOVS	R0, #0
L__one_level_comparator_ms91:
CMP	R0, #0
IT	EQ
BLEQ	L_one_level_comparator_ms9
;compare_func.c,61 :: 		if(++(*count_olc1)>=(unsigned int)(delay_off_ms/ms_in_one_cycle))
LDR	R4, [SP, #52]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #52]
STRH	R5, [R4, #0]
LDR	R4, [SP, #52]
LDRH	R4, [R4, #0]
STR	R4, [SP, #28]
LDR	R2, [SP, #40]
UXTH	R2, R2
LDR	R0, [SP, #36]
UXTH	R0, R0
BL	__Div_32x32_U+0
UXTH	R0, R0
LDR	R4, [SP, #28]
UXTH	R4, R4
CMP	R4, R0
IT	CC
BLCC	L_one_level_comparator_ms10
;compare_func.c,63 :: 		*count_olc  = 0;
MOVS	R5, #0
LDR	R4, [SP, #48]
STRH	R5, [R4, #0]
;compare_func.c,64 :: 		*count_olc1 = 0;
MOVS	R5, #0
LDR	R4, [SP, #52]
STRH	R5, [R4, #0]
;compare_func.c,66 :: 		if(value<=(reference-gisteresis))
LDR	R2, [SP, #8]
LDR	R0, [SP, #0]
BL	__Sub_FP+0
LDR	R2, [SP, #4]
BL	__Compare_FP+0
BLT	L__one_level_comparator_ms92
MOVS	R0, #1
B	L__one_level_comparator_ms93
L__one_level_comparator_ms92:
MOVS	R0, #0
L__one_level_comparator_ms93:
CMP	R0, #0
IT	EQ
BLEQ	L_one_level_comparator_ms11
;compare_func.c,68 :: 		*status = 0;
MOVS	R5, #0
LDR	R4, [SP, #44]
STRB	R5, [R4, #0]
;compare_func.c,69 :: 		}
L_one_level_comparator_ms11:
;compare_func.c,70 :: 		}
L_one_level_comparator_ms10:
;compare_func.c,71 :: 		}
L_one_level_comparator_ms9:
;compare_func.c,72 :: 		}
L_end_one_level_comparator_ms:
ADD	SP, SP, #32
POP	(R15)
; end of _one_level_comparator_ms
_two_level_comparator:
;compare_func.c,77 :: 		unsigned int* count_tlc1)
PUSH	(R14)
SUB	SP, SP, #32
STR	R0, [SP, #0]
STR	R1, [SP, #4]
STR	R2, [SP, #8]
STR	R3, [SP, #12]
LDR	R4, [SP, #36]
UXTH	R4, R4
STR	R4, [SP, #36]
LDR	R4, [SP, #40]
UXTH	R4, R4
STR	R4, [SP, #40]
LDR	R4, [SP, #44]
UXTH	R4, R4
STR	R4, [SP, #44]
LDR	R4, [SP, #48]
STR	R4, [SP, #48]
LDR	R4, [SP, #52]
STR	R4, [SP, #52]
LDR	R4, [SP, #56]
STR	R4, [SP, #56]
;compare_func.c,79 :: 		if( (value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
LDR	R2, [SP, #12]
LDR	R0, [SP, #0]
BL	__Add_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BGT	L__two_level_comparator95
MOVS	R0, #1
B	L__two_level_comparator96
L__two_level_comparator95:
MOVS	R0, #0
L__two_level_comparator96:
CMP	R0, #0
IT	NE
BLNE	L__two_level_comparator57
LDR	R2, [SP, #12]
LDR	R0, [SP, #4]
BL	__Sub_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BLT	L__two_level_comparator97
MOVS	R0, #1
B	L__two_level_comparator98
L__two_level_comparator97:
MOVS	R0, #0
L__two_level_comparator98:
CMP	R0, #0
IT	NE
BLNE	L__two_level_comparator56
IT	AL
BLAL	L_two_level_comparator14
L__two_level_comparator57:
L__two_level_comparator56:
;compare_func.c,82 :: 		if(++(*count_tlc)>=(unsigned int)(delay_off_sec_tlc*(1000/ms_in_one_cycle_tlc)))
LDR	R4, [SP, #52]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #52]
STRH	R5, [R4, #0]
LDR	R4, [SP, #52]
LDRH	R4, [R4, #0]
STR	R4, [SP, #28]
LDR	R2, [SP, #44]
UXTH	R2, R2
MOVW	R0, #1000
MOVT	R0, #0
BL	__Div_32x32_U+0
UXTH	R0, R0
LDR	R4, [SP, #40]
UXTH	R4, R4
MOV	R5, R0
MULS	R5, R4, R5
UXTH	R5, R5
LDR	R4, [SP, #28]
UXTH	R4, R4
CMP	R4, R5
IT	CC
BLCC	L_two_level_comparator15
;compare_func.c,84 :: 		*count_tlc  = 0;
MOVS	R5, #0
LDR	R4, [SP, #52]
STRH	R5, [R4, #0]
;compare_func.c,85 :: 		*count_tlc1 = 0;
MOVS	R5, #0
LDR	R4, [SP, #56]
STRH	R5, [R4, #0]
;compare_func.c,86 :: 		if((value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
LDR	R2, [SP, #12]
LDR	R0, [SP, #0]
BL	__Add_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BGT	L__two_level_comparator99
MOVS	R0, #1
B	L__two_level_comparator100
L__two_level_comparator99:
MOVS	R0, #0
L__two_level_comparator100:
CMP	R0, #0
IT	NE
BLNE	L__two_level_comparator59
LDR	R2, [SP, #12]
LDR	R0, [SP, #4]
BL	__Sub_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BLT	L__two_level_comparator101
MOVS	R0, #1
B	L__two_level_comparator102
L__two_level_comparator101:
MOVS	R0, #0
L__two_level_comparator102:
CMP	R0, #0
IT	NE
BLNE	L__two_level_comparator58
IT	AL
BLAL	L_two_level_comparator18
L__two_level_comparator59:
L__two_level_comparator58:
;compare_func.c,88 :: 		*status_tlc = 0;
MOVS	R5, #0
LDR	R4, [SP, #48]
STRB	R5, [R4, #0]
;compare_func.c,89 :: 		}
L_two_level_comparator18:
;compare_func.c,91 :: 		}
L_two_level_comparator15:
;compare_func.c,93 :: 		}
L_two_level_comparator14:
;compare_func.c,95 :: 		if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
LDR	R2, [SP, #12]
LDR	R0, [SP, #0]
BL	__Sub_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BLT	L__two_level_comparator103
MOVS	R0, #1
B	L__two_level_comparator104
L__two_level_comparator103:
MOVS	R0, #0
L__two_level_comparator104:
CMP	R0, #0
IT	EQ
BLEQ	L__two_level_comparator63
LDR	R2, [SP, #12]
LDR	R0, [SP, #4]
BL	__Add_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BGT	L__two_level_comparator105
MOVS	R0, #1
B	L__two_level_comparator106
L__two_level_comparator105:
MOVS	R0, #0
L__two_level_comparator106:
CMP	R0, #0
IT	EQ
BLEQ	L__two_level_comparator62
L__two_level_comparator53:
;compare_func.c,98 :: 		if(++(*count_tlc1)>=(unsigned int)(delay_on_sec_tlc*(1000/ms_in_one_cycle_tlc)))
LDR	R4, [SP, #56]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #56]
STRH	R5, [R4, #0]
LDR	R4, [SP, #56]
LDRH	R4, [R4, #0]
STR	R4, [SP, #28]
LDR	R2, [SP, #44]
UXTH	R2, R2
MOVW	R0, #1000
MOVT	R0, #0
BL	__Div_32x32_U+0
UXTH	R0, R0
LDR	R4, [SP, #36]
UXTH	R4, R4
MOV	R5, R0
MULS	R5, R4, R5
UXTH	R5, R5
LDR	R4, [SP, #28]
UXTH	R4, R4
CMP	R4, R5
IT	CC
BLCC	L_two_level_comparator22
;compare_func.c,100 :: 		*count_tlc = 0;
MOVS	R5, #0
LDR	R4, [SP, #52]
STRH	R5, [R4, #0]
;compare_func.c,101 :: 		*count_tlc1=0;
MOVS	R5, #0
LDR	R4, [SP, #56]
STRH	R5, [R4, #0]
;compare_func.c,102 :: 		if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
LDR	R2, [SP, #12]
LDR	R0, [SP, #0]
BL	__Sub_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BLT	L__two_level_comparator107
MOVS	R0, #1
B	L__two_level_comparator108
L__two_level_comparator107:
MOVS	R0, #0
L__two_level_comparator108:
CMP	R0, #0
IT	EQ
BLEQ	L__two_level_comparator61
LDR	R2, [SP, #12]
LDR	R0, [SP, #4]
BL	__Add_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BGT	L__two_level_comparator109
MOVS	R0, #1
B	L__two_level_comparator110
L__two_level_comparator109:
MOVS	R0, #0
L__two_level_comparator110:
CMP	R0, #0
IT	EQ
BLEQ	L__two_level_comparator60
L__two_level_comparator52:
;compare_func.c,104 :: 		*status_tlc = 1;
MOVS	R5, #1
LDR	R4, [SP, #48]
STRB	R5, [R4, #0]
;compare_func.c,102 :: 		if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
L__two_level_comparator61:
L__two_level_comparator60:
;compare_func.c,107 :: 		}
L_two_level_comparator22:
;compare_func.c,95 :: 		if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
L__two_level_comparator63:
L__two_level_comparator62:
;compare_func.c,109 :: 		}
L_end_two_level_comparator:
ADD	SP, SP, #32
POP	(R15)
; end of _two_level_comparator
_two_level_comparator_ms:
;compare_func.c,114 :: 		unsigned int* count_tlc1)
PUSH	(R14)
SUB	SP, SP, #36
STR	R0, [SP, #0]
STR	R1, [SP, #4]
STR	R2, [SP, #8]
STR	R3, [SP, #12]
LDR	R4, [SP, #40]
UXTH	R4, R4
STR	R4, [SP, #40]
LDR	R4, [SP, #44]
UXTH	R4, R4
STR	R4, [SP, #44]
LDR	R4, [SP, #48]
UXTH	R4, R4
STR	R4, [SP, #48]
LDR	R4, [SP, #52]
STR	R4, [SP, #52]
LDR	R4, [SP, #56]
STR	R4, [SP, #56]
LDR	R4, [SP, #60]
STR	R4, [SP, #60]
;compare_func.c,116 :: 		if((value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
LDR	R2, [SP, #12]
LDR	R0, [SP, #0]
BL	__Add_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BGT	L__two_level_comparator_ms112
MOVS	R0, #1
B	L__two_level_comparator_ms113
L__two_level_comparator_ms112:
MOVS	R0, #0
L__two_level_comparator_ms113:
CMP	R0, #0
IT	NE
BLNE	L__two_level_comparator_ms69
LDR	R2, [SP, #12]
LDR	R0, [SP, #4]
BL	__Sub_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BLT	L__two_level_comparator_ms114
MOVS	R0, #1
B	L__two_level_comparator_ms115
L__two_level_comparator_ms114:
MOVS	R0, #0
L__two_level_comparator_ms115:
CMP	R0, #0
IT	NE
BLNE	L__two_level_comparator_ms68
IT	AL
BLAL	L_two_level_comparator_ms28
L__two_level_comparator_ms69:
L__two_level_comparator_ms68:
;compare_func.c,119 :: 		if(++(*count_tlc)>=(delay_on_ms_tlc/ms_in_one_cycle_tlc))
LDR	R4, [SP, #56]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #56]
STRH	R5, [R4, #0]
LDR	R4, [SP, #56]
LDRH	R4, [R4, #0]
STR	R4, [SP, #32]
LDR	R2, [SP, #48]
UXTH	R2, R2
LDR	R0, [SP, #40]
UXTH	R0, R0
BL	__Div_32x32_U+0
UXTH	R0, R0
LDR	R4, [SP, #32]
UXTH	R4, R4
CMP	R4, R0
IT	CC
BLCC	L_two_level_comparator_ms29
;compare_func.c,121 :: 		*count_tlc  = 0;
MOVS	R5, #0
LDR	R4, [SP, #56]
STRH	R5, [R4, #0]
;compare_func.c,122 :: 		*count_tlc1 = 0;
MOVS	R5, #0
LDR	R4, [SP, #60]
STRH	R5, [R4, #0]
;compare_func.c,123 :: 		if((value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
LDR	R2, [SP, #12]
LDR	R0, [SP, #0]
BL	__Add_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BGT	L__two_level_comparator_ms116
MOVS	R0, #1
B	L__two_level_comparator_ms117
L__two_level_comparator_ms116:
MOVS	R0, #0
L__two_level_comparator_ms117:
CMP	R0, #0
IT	NE
BLNE	L__two_level_comparator_ms71
LDR	R2, [SP, #12]
LDR	R0, [SP, #4]
BL	__Sub_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BLT	L__two_level_comparator_ms118
MOVS	R0, #1
B	L__two_level_comparator_ms119
L__two_level_comparator_ms118:
MOVS	R0, #0
L__two_level_comparator_ms119:
CMP	R0, #0
IT	NE
BLNE	L__two_level_comparator_ms70
IT	AL
BLAL	L_two_level_comparator_ms32
L__two_level_comparator_ms71:
L__two_level_comparator_ms70:
;compare_func.c,125 :: 		*status_tlc = 0;
MOVS	R5, #0
LDR	R4, [SP, #52]
STRB	R5, [R4, #0]
;compare_func.c,126 :: 		}
L_two_level_comparator_ms32:
;compare_func.c,128 :: 		}
L_two_level_comparator_ms29:
;compare_func.c,130 :: 		}
L_two_level_comparator_ms28:
;compare_func.c,132 :: 		if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
LDR	R2, [SP, #12]
LDR	R0, [SP, #0]
BL	__Sub_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BLT	L__two_level_comparator_ms120
MOVS	R0, #1
B	L__two_level_comparator_ms121
L__two_level_comparator_ms120:
MOVS	R0, #0
L__two_level_comparator_ms121:
CMP	R0, #0
IT	EQ
BLEQ	L__two_level_comparator_ms75
LDR	R2, [SP, #12]
LDR	R0, [SP, #4]
BL	__Add_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BGT	L__two_level_comparator_ms122
MOVS	R0, #1
B	L__two_level_comparator_ms123
L__two_level_comparator_ms122:
MOVS	R0, #0
L__two_level_comparator_ms123:
CMP	R0, #0
IT	EQ
BLEQ	L__two_level_comparator_ms74
L__two_level_comparator_ms65:
;compare_func.c,135 :: 		if(++(*count_tlc1)>=(delay_off_ms_tlc/ms_in_one_cycle_tlc))
LDR	R4, [SP, #60]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #60]
STRH	R5, [R4, #0]
LDR	R4, [SP, #60]
LDRH	R4, [R4, #0]
STR	R4, [SP, #32]
LDR	R2, [SP, #48]
UXTH	R2, R2
LDR	R0, [SP, #44]
UXTH	R0, R0
BL	__Div_32x32_U+0
UXTH	R0, R0
LDR	R4, [SP, #32]
UXTH	R4, R4
CMP	R4, R0
IT	CC
BLCC	L_two_level_comparator_ms36
;compare_func.c,137 :: 		*count_tlc = 0;
MOVS	R5, #0
LDR	R4, [SP, #56]
STRH	R5, [R4, #0]
;compare_func.c,138 :: 		*count_tlc1=0;
MOVS	R5, #0
LDR	R4, [SP, #60]
STRH	R5, [R4, #0]
;compare_func.c,139 :: 		if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
LDR	R2, [SP, #12]
LDR	R0, [SP, #0]
BL	__Sub_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BLT	L__two_level_comparator_ms124
MOVS	R0, #1
B	L__two_level_comparator_ms125
L__two_level_comparator_ms124:
MOVS	R0, #0
L__two_level_comparator_ms125:
CMP	R0, #0
IT	EQ
BLEQ	L__two_level_comparator_ms73
LDR	R2, [SP, #12]
LDR	R0, [SP, #4]
BL	__Add_FP+0
LDR	R2, [SP, #8]
BL	__Compare_FP+0
BGT	L__two_level_comparator_ms126
MOVS	R0, #1
B	L__two_level_comparator_ms127
L__two_level_comparator_ms126:
MOVS	R0, #0
L__two_level_comparator_ms127:
CMP	R0, #0
IT	EQ
BLEQ	L__two_level_comparator_ms72
L__two_level_comparator_ms64:
;compare_func.c,141 :: 		*status_tlc = 1;
MOVS	R5, #1
LDR	R4, [SP, #52]
STRB	R5, [R4, #0]
;compare_func.c,139 :: 		if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
L__two_level_comparator_ms73:
L__two_level_comparator_ms72:
;compare_func.c,144 :: 		}
L_two_level_comparator_ms36:
;compare_func.c,132 :: 		if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
L__two_level_comparator_ms75:
L__two_level_comparator_ms74:
;compare_func.c,146 :: 		}
L_end_two_level_comparator_ms:
ADD	SP, SP, #36
POP	(R15)
; end of _two_level_comparator_ms
_ControlDigit_sec:
;compare_func.c,152 :: 		unsigned int *count_ci, unsigned int* count_ci1)
; ms_in_one_cycle start address is: 12 (R3)
; delay_reset start address is: 8 (R2)
; in_value start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #24
UXTB	R6, R0
STR	R1, [SP, #12]
UXTH	R1, R3
UXTH	R7, R2
; ms_in_one_cycle end address is: 12 (R3)
; delay_reset end address is: 8 (R2)
; in_value end address is: 0 (R0)
; in_value start address is: 24 (R6)
; delay_reset start address is: 28 (R7)
; ms_in_one_cycle start address is: 4 (R1)
; status start address is: 8 (R2)
LDR	R2, [SP, #28]
; count_ci start address is: 12 (R3)
LDR	R3, [SP, #32]
LDR	R4, [SP, #36]
STR	R4, [SP, #36]
;compare_func.c,154 :: 		if (in_value == SET)
CMP	R6, #1
IT	NE
BLNE	L_ControlDigit_sec40
;compare_func.c,157 :: 		if ((++(*count_ci)) >= (unsigned int)(delay_set*(1000 / ms_in_one_cycle)))
LDRH	R4, [R3, #0]
ADDS	R4, #1
STRH	R4, [R3, #0]
LDRH	R4, [R3, #0]
STR	R4, [SP, #20]
MOVW	R0, #1000
MOVT	R0, #0
STR	R3, [SP, #0]
STR	R2, [SP, #4]
STR	R1, [SP, #8]
UXTH	R2, R1
BL	__Div_32x32_U+0
UXTH	R0, R0
LDR	R1, [SP, #8]
UXTH	R1, R1
LDR	R2, [SP, #4]
LDR	R3, [SP, #0]
LDR	R4, [SP, #12]
UXTH	R4, R4
MOV	R5, R0
MULS	R5, R4, R5
UXTH	R5, R5
LDR	R4, [SP, #20]
UXTH	R4, R4
CMP	R4, R5
IT	CC
BLCC	L_ControlDigit_sec41
;compare_func.c,159 :: 		*count_ci = 0;
MOVS	R4, #0
STRH	R4, [R3, #0]
;compare_func.c,160 :: 		*count_ci1 = 0;
MOVS	R5, #0
LDR	R4, [SP, #36]
STRH	R5, [R4, #0]
;compare_func.c,161 :: 		if (in_value == SET)
CMP	R6, #1
IT	NE
BLNE	L_ControlDigit_sec42
;compare_func.c,163 :: 		*status = 1;
MOVS	R4, #1
STRB	R4, [R2, #0]
;compare_func.c,164 :: 		}
L_ControlDigit_sec42:
;compare_func.c,165 :: 		}
L_ControlDigit_sec41:
;compare_func.c,167 :: 		}
L_ControlDigit_sec40:
;compare_func.c,169 :: 		if (in_value == RESET)
CMP	R6, #0
IT	NE
BLNE	L_ControlDigit_sec43
;compare_func.c,172 :: 		if ((++(*count_ci1)) >= (unsigned int)(delay_reset*(1000 / ms_in_one_cycle)))
LDR	R4, [SP, #36]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #36]
STRH	R5, [R4, #0]
LDR	R4, [SP, #36]
LDRH	R4, [R4, #0]
STR	R4, [SP, #20]
MOVW	R0, #1000
MOVT	R0, #0
STR	R3, [SP, #0]
; ms_in_one_cycle end address is: 4 (R1)
STR	R2, [SP, #4]
UXTH	R2, R1
BL	__Div_32x32_U+0
UXTH	R0, R0
LDR	R2, [SP, #4]
LDR	R3, [SP, #0]
MOV	R5, R0
MULS	R5, R7, R5
UXTH	R5, R5
; delay_reset end address is: 28 (R7)
LDR	R4, [SP, #20]
UXTH	R4, R4
CMP	R4, R5
IT	CC
BLCC	L_ControlDigit_sec44
;compare_func.c,174 :: 		*count_ci = 0;
MOVS	R4, #0
STRH	R4, [R3, #0]
; count_ci end address is: 12 (R3)
;compare_func.c,175 :: 		*count_ci1 = 0;
MOVS	R5, #0
LDR	R4, [SP, #36]
STRH	R5, [R4, #0]
;compare_func.c,176 :: 		if (in_value == RESET)
CMP	R6, #0
IT	NE
BLNE	L_ControlDigit_sec45
; in_value end address is: 24 (R6)
;compare_func.c,178 :: 		*status = 0;
MOVS	R4, #0
STRB	R4, [R2, #0]
; status end address is: 8 (R2)
;compare_func.c,179 :: 		}
L_ControlDigit_sec45:
;compare_func.c,180 :: 		}
L_ControlDigit_sec44:
;compare_func.c,182 :: 		}
L_ControlDigit_sec43:
;compare_func.c,183 :: 		}
L_end_ControlDigit_sec:
ADD	SP, SP, #24
POP	(R15)
; end of _ControlDigit_sec
_ControlDigit_ms:
;compare_func.c,188 :: 		unsigned int *count_ci, unsigned int* count_ci1)
; ms_in_one_cycle start address is: 12 (R3)
; delay_reset start address is: 8 (R2)
; delay_set start address is: 4 (R1)
; in_value start address is: 0 (R0)
PUSH	(R14)
SUB	SP, SP, #20
UXTB	R6, R0
UXTH	R0, R1
UXTH	R1, R3
UXTH	R7, R2
; ms_in_one_cycle end address is: 12 (R3)
; delay_reset end address is: 8 (R2)
; delay_set end address is: 4 (R1)
; in_value end address is: 0 (R0)
; in_value start address is: 24 (R6)
; delay_set start address is: 0 (R0)
; delay_reset start address is: 28 (R7)
; ms_in_one_cycle start address is: 4 (R1)
; status start address is: 8 (R2)
LDR	R2, [SP, #24]
; count_ci start address is: 12 (R3)
LDR	R3, [SP, #28]
; count_ci1 start address is: 20 (R5)
LDR	R5, [SP, #32]
;compare_func.c,190 :: 		if (in_value == SET)
CMP	R6, #1
IT	NE
BLNE	L_ControlDigit_ms46
;compare_func.c,193 :: 		if ((++(*count_ci)) >= (unsigned int)(delay_set / ms_in_one_cycle))
LDRH	R4, [R3, #0]
ADDS	R4, #1
STRH	R4, [R3, #0]
LDRH	R4, [R3, #0]
STR	R4, [SP, #16]
STR	R5, [SP, #0]
; delay_set end address is: 0 (R0)
STR	R3, [SP, #4]
STR	R2, [SP, #8]
STR	R1, [SP, #12]
UXTH	R2, R1
BL	__Div_32x32_U+0
UXTH	R0, R0
LDR	R1, [SP, #12]
UXTH	R1, R1
LDR	R2, [SP, #8]
LDR	R3, [SP, #4]
LDR	R5, [SP, #0]
LDR	R4, [SP, #16]
UXTH	R4, R4
CMP	R4, R0
IT	CC
BLCC	L_ControlDigit_ms47
;compare_func.c,195 :: 		*count_ci = 0;
MOVS	R4, #0
STRH	R4, [R3, #0]
;compare_func.c,196 :: 		*count_ci1 = 0;
MOVS	R4, #0
STRH	R4, [R5, #0]
;compare_func.c,197 :: 		if (in_value == SET)
CMP	R6, #1
IT	NE
BLNE	L_ControlDigit_ms48
;compare_func.c,199 :: 		*status = 1;
MOVS	R4, #1
STRB	R4, [R2, #0]
;compare_func.c,200 :: 		}
L_ControlDigit_ms48:
;compare_func.c,201 :: 		}
L_ControlDigit_ms47:
;compare_func.c,203 :: 		}
L_ControlDigit_ms46:
;compare_func.c,205 :: 		if (in_value == RESET)
CMP	R6, #0
IT	NE
BLNE	L_ControlDigit_ms49
;compare_func.c,208 :: 		if ((++(*count_ci1)) >= (unsigned int)(delay_reset / ms_in_one_cycle))
LDRH	R4, [R5, #0]
ADDS	R4, #1
STRH	R4, [R5, #0]
LDRH	R4, [R5, #0]
STR	R4, [SP, #16]
STR	R5, [SP, #0]
; delay_reset end address is: 28 (R7)
; ms_in_one_cycle end address is: 4 (R1)
STR	R3, [SP, #4]
STR	R2, [SP, #8]
UXTH	R2, R1
UXTH	R0, R7
BL	__Div_32x32_U+0
UXTH	R0, R0
LDR	R2, [SP, #8]
LDR	R3, [SP, #4]
LDR	R5, [SP, #0]
LDR	R4, [SP, #16]
UXTH	R4, R4
CMP	R4, R0
IT	CC
BLCC	L_ControlDigit_ms50
;compare_func.c,210 :: 		*count_ci = 0;
MOVS	R4, #0
STRH	R4, [R3, #0]
; count_ci end address is: 12 (R3)
;compare_func.c,211 :: 		*count_ci1 = 0;
MOVS	R4, #0
STRH	R4, [R5, #0]
; count_ci1 end address is: 20 (R5)
;compare_func.c,212 :: 		if (in_value == RESET)
CMP	R6, #0
IT	NE
BLNE	L_ControlDigit_ms51
; in_value end address is: 24 (R6)
;compare_func.c,214 :: 		*status = 0;
MOVS	R4, #0
STRB	R4, [R2, #0]
; status end address is: 8 (R2)
;compare_func.c,215 :: 		}
L_ControlDigit_ms51:
;compare_func.c,216 :: 		}
L_ControlDigit_ms50:
;compare_func.c,218 :: 		}
L_ControlDigit_ms49:
;compare_func.c,219 :: 		}
L_end_ControlDigit_ms:
ADD	SP, SP, #20
POP	(R15)
; end of _ControlDigit_ms
