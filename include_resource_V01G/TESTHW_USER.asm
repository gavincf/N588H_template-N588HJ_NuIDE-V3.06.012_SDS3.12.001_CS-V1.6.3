

M0S0_CH1END_PCC_TESTHW EQU	C_TRUE
.IF(M0S0_CH1END_PCC_TESTHW.EQ.C_FALSE)
	
	MR_SET_AUTOCNT2
	
.ENDIF;M0S0_CH1END_PCC_TESTHW

;========================================
M0S0_CNT0_PCC_TESTHW EQU C_TRUE
.IF(M0S0_CNT0_PCC_TESTHW.EQ.C_FALSE)

	LDA	CNT0_CNT
	ASL	A
	TAX
	JMP	(M0S0_CNT0_TBL,X)


M0S0_CNT0_TBL:
	DW	M0S0_CNT0_0		;IO PULSE ON
	DW	M0S0_CNT0_1		;IO PULSE OFF
	DW	M0S0_CNT0_2		;IO PULSE ON
	DW	M0S0_CNT0_3		;IO PULSE OFF
	DW	M0S0_CNT0_4		;IO PULSE ON
	DW	M0S0_CNT0_5		;IO PULSE OFF
	DW	M0S0_CNT0_6		;IO PULSE ON
	DW	M0S0_CNT0_7		;IO PULSE OFF
	DW	M0S0_CNT0_8		;IO PULSE ON
	DW	M0S0_CNT0_9		;IO PULSE OFF
	DW	M0S0_CNT0_10		;IO PULSE ON
	DW	M0S0_CNT0_11		;IO PULSE OFF
	DW	M0S0_CNT0_12		;IO PULSE ON
	DW	M0S0_CNT0_13		;IO PULSE OFF
	DW	M0S0_CNT0_14		;IO PULSE ON
	DW	M0S0_CNT0_15		;IO PULSE OFF
	DW	M0S0_CNT0_16		;IO PULSE ON
	DW	M0S0_CNT0_17		;IO PULSE OFF
	DW	M0S0_CNT0_18		;IO PULSE ON
	DW	M0S0_CNT0_19		;IO PULSE OFF
	DW	M0S0_CNT0_20		;IO PULSE ON
	DW	M0S0_CNT0_21		;IO PULSE OFF
	DW	M0S0_CNT0_22		;IO PULSE ON
	DW	M0S0_CNT0_23		;IO PULSE OFF
	DW	M0S0_CNT0_24		;IO PULSE ON
	DW	M0S0_CNT0_25		;IO PULSE OFF
	DW	M0S0_CNT0_26		;IO PULSE ON
	DW	M0S0_CNT0_27		;IO PULSE OFF
	DW	M0S0_CNT0_28		;IO PULSE ON
	DW	M0S0_CNT0_29		;IO PULSE OFF
	DW	M0S0_CNT0_30		;IO PULSE ON
	DW	M0S0_CNT0_31		;IO PULSE OFF
	DW	M0S0_CNT0_32		;IO PULSE ON
	DW	M0S0_CNT0_33		;IO PULSE OFF
	DW	M0S0_CNT0_34		;IO PULSE ON
	DW	M0S0_CNT0_35		;IO PULSE OFF
	DW	M0S0_CNT0_36		;IO PULSE ON
	DW	M0S0_CNT0_37		;IO PULSE OFF
	DW	M0S0_CNT0_38		;IO PULSE ON
	DW	M0S0_CNT0_39		;IO PULSE OFF
	DW	M0S0_CNT0_40		;IO PULSE ON
	DW	M0S0_CNT0_41		;IO PULSE OFF
	DW	M0S0_CNT0_42		;IO PULSE ON
	DW	M0S0_CNT0_43		;IO PULSE OFF
	DW	M0S0_CNT0_44		;IO PULSE ON
	DW	M0S0_CNT0_45		;IO PULSE OFF
	DW	M0S0_CNT0_46		;IO PULSE ON
	DW	M0S0_CNT0_47		 ;IO PULSE OFF
	
	DW	M0S0_CNT0_48 ; END
	

M0S0_CNT0_0: ;IO PULSE ON
	LDA	#C_BIT0|C_BIT1 ;---------- **
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_0_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_0_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_1
	LDA	#C_BIT0|C_BIT1;---------- **
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_1_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_1_S01
	
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_1_S01:
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_1_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

	
M0S0_CNT0_2
	LDA	#C_BIT2|C_BIT3;---------- **
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_2_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_2_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_3
	LDA	#C_BIT2|C_BIT3;---------- **
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_3_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_3_S01
	
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_3_S01:
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_3_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_4
	LDA	#C_BIT4|C_BIT5;---------- **
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_4_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_4_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_5
	LDA	#C_BIT4|C_BIT5;---------- **
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_5_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_5_S01
	
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_5_S01:
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_5_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_6
	LDA	#C_SPECIAL_BIT
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_6_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_6_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_7
	LDA	#C_SPECIAL_BIT
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_7_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_7_S01
	
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
	
M0S0_CNT0_7_S01:
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_7_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_8
	LDA	#C_SPECIAL_BIT
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_8_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_8_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_9
	LDA	#C_SPECIAL_BIT
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_9_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_9_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_9_S01:
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_9_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_10
	LDA	#C_SPECIAL_BIT
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_10_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_10_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_11
	LDA	#C_SPECIAL_BIT
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_11_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_11_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_11_S01:
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_11_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_12
	LDA	#C_BIT6
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_12_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_12_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_13
	LDA	#C_BIT6
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_13_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_13_S01

	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_13_S01:
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_13_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_14
	LDA	#C_BIT7
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_14_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_14_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_15
	LDA	#C_BIT7
	AND	#C_CHK_OP_BP0
	BEQ	M0S0_CNT0_15_S10
	EOR	R_BP0
	STA	R_BP0
	STA	!BP0
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_15_S01

	MACRO_SET_DLYCNT0 C_CNT0_TIME2
	
M0S0_CNT0_15_S01:
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_15_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT


M0S0_CNT0_16
	LDA	#C_BIT0
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_16_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_16_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_17
	LDA	#C_BIT0
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_17_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_17_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
	
M0S0_CNT0_17_S01:
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_17_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_18
	LDA	#C_BIT1
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_18_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_18_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_19
	LDA	#C_BIT1
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_19_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_19_S01
	
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
	
M0S0_CNT0_19_S01:
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_19_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_20
	LDA	#C_BIT2
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_20_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_20_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_21
	LDA	#C_BIT2
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_21_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_21_S01

	MACRO_SET_DLYCNT0 C_CNT0_TIME2
	
M0S0_CNT0_21_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_21_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_22
	LDA	#C_BIT3
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_22_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_22_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_23
	LDA	#C_BIT3
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_23_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_23_S01
	
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_23_S01:
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_23_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_24
	LDA	#C_BIT4
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_24_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_24_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_25
	LDA	#C_BIT4
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_25_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_25_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_25_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_25_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_26
	LDA	#C_BIT5
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_26_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_26_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_27
	LDA	#C_BIT5
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_27_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_27_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_27_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_27_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_28
	LDA	#C_BIT6
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_28_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_28_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_29
	LDA	#C_BIT6
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_29_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_29_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_29_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_29_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_30
	LDA	#C_BIT7
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_30_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_30_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_31
	LDA	#C_BIT7
	AND	#C_CHK_OP_BP1
	BEQ	M0S0_CNT0_31_S10
	EOR	R_BP1
	STA	R_BP1
	STA	!BP1
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_31_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_31_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_31_S10:
	INC	CNT0_CNT
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_32
.IFDEF	BP2
	LDA	#C_BIT0
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_32_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_32_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_33
.IFDEF	BP2
	LDA	#C_BIT0
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_33_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_33_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_33_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_33_S10:
	INC	CNT0_CNT
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_34
.IFDEF	BP2
	LDA	#C_BIT1
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_34_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_34_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_35
.IFDEF	BP2
	LDA	#C_BIT1
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_35_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_35_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_35_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_35_S10:
	INC	CNT0_CNT
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_36
.IFDEF	BP2
	LDA	#C_BIT2
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_36_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_36_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_37
.IFDEF	BP2
	LDA	#C_BIT2
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_37_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_37_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_37_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_37_S10:
	INC	CNT0_CNT
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_38
.IFDEF	BP2
	LDA	#C_BIT3
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_38_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_38_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_39
.IFDEF	BP2
	LDA	#C_BIT3
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_39_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_39_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_39_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_39_S10:
	INC	CNT0_CNT
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_40
.IFDEF	BP2
	LDA	#C_BIT4
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_40_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_40_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_41
.IFDEF	BP2
	LDA	#C_BIT4
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_41_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_41_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_41_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_41_S10:
	INC	CNT0_CNT
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_42
.IFDEF	BP2
	LDA	#C_BIT5
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_42_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_42_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_43
.IFDEF	BP2
	LDA	#C_BIT5
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_43_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_43_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_43_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_43_S10:
	INC	CNT0_CNT
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_44
.IFDEF	BP2
	LDA	#C_BIT6
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_44_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_44_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_45
.IFDEF	BP2
	LDA	#C_BIT6
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_45_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_45_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_45_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_45_S10:
	INC	CNT0_CNT
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_46
.IFDEF	BP2
	LDA	#C_BIT7
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_46_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	MACRO_SET_DLYCNT0 C_CNT0_TIME1
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_46_S10:
	INC	CNT0_CNT
	INC	CNT0_CNT; +2
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

M0S0_CNT0_47 
.IFDEF	BP2
	LDA	#C_BIT7
	AND	#C_CHK_OP_BP2
	BEQ	M0S0_CNT0_47_S10
	EOR	R_BP2
	STA	R_BP2
	STA	!BP2
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BNE	M0S0_CNT0_47_S01
	MACRO_SET_DLYCNT0 C_CNT0_TIME2
M0S0_CNT0_47_S01
	INC	CNT0_CNT
	JMP	PWON_LOOP_S10

M0S0_CNT0_47_S10:
	INC	CNT0_CNT
.ENDIF
	JMP	M0S0_CNT0 ; NEXT

;=====================================
M0S0_CNT0_48 ; END; LOOP CHECK THE OUTPUT

	MACRO_SET_DLYCNT0 CNT_STOP
	STZ	CNT0_CNT
	
	JMP	M0S0_CNT0 ; LOOP


.ENDIF;M0S0_CNT0_PCC_TESTHW
;=================================================
.IF
	MR_SET_AUTOCNT2


M0S0_KEYCH0_PCC_TESTHW EQU	C_TRUE
.IF(M0S0_KEYCH0_PCC_TESTHW.EQ.C_FALSE)
	MR_SET_AUTOCNT2

	LDA	WB_KEYCH_CODE
	ASL	A
	TAX
	JMP	(M0S0_KEYCH0_PCC_TESTHW_TBL,X)
M0S0_KEYCH0_PCC_TESTHW_TBL:
	DW	M0S0_KEYCH0_PCC_TESTHW_0
	DW	M0S0_KEYCH0_PCC_TESTHW_1
	DW	M0S0_KEYCH0_PCC_TESTHW_2
	DW	M0S0_KEYCH0_PCC_TESTHW_3
	DW	M0S0_KEYCH0_PCC_TESTHW_4
	DW	M0S0_KEYCH0_PCC_TESTHW_5
	DW	M0S0_KEYCH0_PCC_TESTHW_6
	DW	M0S0_KEYCH0_PCC_TESTHW_7
	DW	M0S0_KEYCH0_PCC_TESTHW_8
	DW	M0S0_KEYCH0_PCC_TESTHW_9
	DW	M0S0_KEYCH0_PCC_TESTHW_10
	DW	M0S0_KEYCH0_PCC_TESTHW_11
	DW	M0S0_KEYCH0_PCC_TESTHW_12
	DW	M0S0_KEYCH0_PCC_TESTHW_13
	DW	M0S0_KEYCH0_PCC_TESTHW_14
	DW	M0S0_KEYCH0_PCC_TESTHW_15
	DW	M0S0_KEYCH0_PCC_TESTHW_16
	DW	M0S0_KEYCH0_PCC_TESTHW_17
	DW	M0S0_KEYCH0_PCC_TESTHW_18
	DW	M0S0_KEYCH0_PCC_TESTHW_19
	DW	M0S0_KEYCH0_PCC_TESTHW_20
	DW	M0S0_KEYCH0_PCC_TESTHW_21
	DW	M0S0_KEYCH0_PCC_TESTHW_22
	DW	M0S0_KEYCH0_PCC_TESTHW_23

M0S0_KEYCH0_PCC_TESTHW_0
	MR_PLAY_SP CS_N00
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_1
	MR_PLAY_SP CS_N01
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_2
	MR_PLAY_SP CS_N02
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_3
	MR_PLAY_SP CS_N03
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_4
	MR_PLAY_SP CS_N04
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_5
	MR_PLAY_SP CS_N05
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_6
	MR_PLAY_SP CS_N06
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_7
	MR_PLAY_SP CS_N07
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_8
	MR_PLAY_SP CS_N08
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_9
	MR_PLAY_SP CS_N09
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_10
	MR_PLAY_SP CS_N10
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_11
	MR_PLAY_SP CS_N11
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_12
	MR_PLAY_SP CS_N12
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_13
	MR_PLAY_SP CS_N13
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_14
	MR_PLAY_SP CS_N14
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_15
	MR_PLAY_SP CS_N15
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_16
	MR_PLAY_SP CS_N16
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_17
	MR_PLAY_SP CS_N17
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_18
	MR_PLAY_SP CS_N18
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_19
	MR_PLAY_SP CS_N19
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_20
	MR_PLAY_SP CS_N20
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_21
	MR_PLAY_SP CS_N21
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_22
	MR_PLAY_SP CS_N22
	JMP	M0_CHK_USER_FLAG
M0S0_KEYCH0_PCC_TESTHW_23
	MR_PLAY_SP CS_N23
	JMP	M0_CHK_USER_FLAG
	
.ENDIF;M0S0_KEYCH0_PCC_TESTHW


M0_PRE_PCC_TESTHW EQU C_TRUE
.IF(M0_PRE_PCC_TESTHW.EQ.C_FALSE)
	LDA	#C_TRIG_CNT0_BP0
	ORA	#C_TRIG_CNT0_BP1
	ORA	#C_TRIG_CNT0_BP2
	BEQ	M0_PRE_PCC_TESTHW_S10
	
	MACRO_SET_DLYCNT0 CNT_STOP
	BRA	M0_PRE_PCC_TESTHW_S20
	
M0_PRE_PCC_TESTHW_S10:
	MACRO_SET_DLYCNT0 C_CNT0_TIME2

M0_PRE_PCC_TESTHW_S20:
.ENDIF;M0_PRE_PCC_TESTHW