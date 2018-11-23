
C_TESTM0_0 EQU E0H ;
C_TESTM0_1 EQU E1H ;
C_TESTM0_2 EQU E2H ; 
C_TESTM0_3 EQU E3H ;
C_TESTM0_4 EQU E4H ;
C_TESTM0_5 EQU E5H ;

;==============================
;	hasbro test way
;==============================
;
HASBRO_TESTPCBA_ENTER_SOUND:
	PLAY	TinyPong_SFX_Hit_v2_01
	RTS

TESTPCBA_PRE:
	MACRO_INT_ENABLE FXF15_INT_BIT
.IF ( C_TMG0_EN .EQ. 1 )
	JSR	BK0_START_TMG0_05MS ; 2MS
.ENDIF

;DEBUG
;	JMP	P40_LOOP_PRE
;check real test mode
;SW1 
	
	LDA	SR_S_KEY1_PORT
	AND	#B_S_KEY1
	BNE	POI_TEST_S100_J1
;tummy
;delay 1sec
	LDY	#256-100
POI_TEST_S11:
	MACRO_CLR_WDT

	JSR	BK0_DELAY61440CYCLE ; 10MS
	LDA	SR_S_KEY1_PORT
	AND	#B_S_KEY1
	BEQ	POI_TEST_S12
;LOW TO HIGH
	
POI_TEST_S100_J1:
	JMP	POI_TEST_S100
	
POI_TEST_S12:
	INY
	BNE	POI_TEST_S11
; 1SEC REACH	
;
;step2: check sw2  3 times
	JSR	HASBRO_TESTPCBA_ENTER_SOUND
	
	MR_SET_DLYCNT0 T002000MS
;debug
;	MR_SET_DLYCNT0 T005000MS

	STZ	WB_DLYCNT0_IDX ; TEMP USE
	STZ	WB_DLYCNT1_IDX
	
POI_CHK_LOOP:
	JSR	BK0_WAITKEY
POI_CHK_LOOP_S10:
	
	LDA	USER_FLAG_A
	BIT	#C_KEYCH0_BIT
	BNE	POI_CHK_LOOP_KEYCH0
	BIT	#C_KEYCH1_BIT
	BNE	POI_CHK_LOOP_KEYCH1
	BIT	#C_KEYCH2_BIT
	BNE	POI_CHK_LOOP_KEYCH2
	
	LDA	USER_FLAG_B
	BIT	#C_CNT0_BIT
	BNE	POI_CHK_LOOP_CNT0
	
	JMP	POI_CHK_LOOP

POI_CHK_LOOP_KEYCH0:
; key channel 0
	MACRO_CLR_KEYCH0_FLAG

	LDA	WB_KEYCH_CODE
	ASL	A
	TAX
	JMP	(POI_CHK_LOOP_KEYCH0_TBL,X)
POI_CHK_LOOP_KEYCH0_TBL:
	DW	POI_CHK_LOOP_KEYCH0_0
	DW	POI_CHK_LOOP_KEYCH0_1

POI_CHK_LOOP_KEYCH0_0:
POI_CHK_LOOP_KEYCH0_1
	JMP	POI_CHK_LOOP_S10

POI_CHK_LOOP_KEYCH1:
	MACRO_CLR_KEYCH1_FLAG

	INC	WB_DLYCNT0_IDX
	JMP	POI_CHK_LOOP_S10
	
POI_CHK_LOOP_KEYCH2:
	MACRO_CLR_KEYCH2_FLAG

	INC	WB_DLYCNT1_IDX
	JMP	POI_CHK_LOOP_S10
	
POI_CHK_LOOP_CNT0:
	MACRO_CLR_CNT0_FLAG
; TIME OUT

	LDA	WB_DLYCNT0_IDX
	CMP	#3
	BNE	POI_CHK_LOOP_CNT0_S10
	LDA	WB_DLYCNT1_IDX
	CMP	#3
	BNE	POI_CHK_LOOP_CNT0_S10
	
	JMP	L_P10
	
POI_CHK_LOOP_CNT0_S10:
POI_TEST_S100:
	JMP	TESTPCBA_RET


;===========================================
; TESTPCBA FLOWCHART
;============================================

;-------------------------------
L_P10:
;-------------------------------
;
	MR_SET_MODE_NO C_TESTM0_0

	MACRO_INT_ENABLE FXF15_INT_BIT

	PLAY English6k+N001+[300MSEC]+N000 ; INT LANG AND CODE VERSION
;WAIT EQU END
	JSR	WAIT_SPCH1_W_CHK
;***: key release to interrup
;=======================================
; insert new sub mode
;=======================================

	PLAY	0*T1KHZ_8K

	MR_SET_DLYCNT0 T015000MS
	JSR	BK0_LEDS_ON

P11_LOOP:
	JSR	BK0_WAITKEY
P11_LOOP_S10:
	LDA	USER_FLAG_A
	BIT	#C_KEYCH0_BIT
	BNE	P11_LOOP_KEYCH0
	
	LDA	USER_FLAG_B
	BIT	#C_CNT0_BIT
	BNE	P11_LOOP_CNT0
	BIT	#C_AUTO_CNT_BIT
	BNE	P11_LOOP_AUTOCNT
	
	BRA	P11_LOOP
	
P11_LOOP_AUTOCNT:
	MACRO_CLR_AUTOCNT_FLAG
	
	JMP	L_P50B
	
P11_LOOP_KEYCH0:
	MACRO_CLR_KEYCH0_FLAG
	
	LDA	WB_KEYCH_CODE
	ASL	A
	TAX
	JMP	(P11_LOOP_KEYCH0_TBL,X)
P11_LOOP_KEYCH0_TBL:
	DW	P11_LOOP_KEYCH0_0
	DW	P11_LOOP_KEYCH0_1
	
P11_LOOP_KEYCH0_0:
	
	JSR	BK0_LEDS_OFF

	JSR	BK0_STOP_CH1
	
	JMP	L_P19
	
P11_LOOP_KEYCH0_1:

	JMP	P11_LOOP_S10
	
P11_LOOP_CNT0:
	MACRO_CLR_CNT0_FLAG
	
	JSR	BK0_LEDS_OFF
	JSR	BK0_STOP_CH1
	JMP	L_P19

;========================================
;	checksum
;========================================
L_P19:
;DEBUG
;	JMP	P50_LOOP_PRE
;1,Play language and code version
;2,Run checksum; BIT
;3,Play 1khz tone
;	PLAY English6k+PN01 ; INT LANG AND CODE VERSION
;WAIT EQU END
;	JSR	WAIT_SPCH1_W_CHK
	
	CHECKSUM
	LDA	<CHECK_RESULT
	BNE	CHECKSUM_ERROR
	LDA	<CHECK_RESULT+1
	BNE	CHECKSUM_ERROR
;checksum ok
CHECKSUM_OK:
;	MR_PLAY_SP	CS_T1KHZ_8K

	LDA #00000011B
	TRB	R_BP0
	LDA	R_BP0
	STA	BP0
	
	JMP	CHECKSUM_END
CHECKSUM_ERROR:
;DEBUG
;	BRA	CHECKSUM_OK

	LDA #00001100B
	TRB	R_BP0
	LDA	R_BP0
	STA	BP0
	
;	JMP	L_P50B
CHECKSUM_END:
;
;	JSR	WAIT_SPCH1_W_CHK

;-------------------------------
L_P20:
;-------------------------------
;=======================================
; insert new sub mode
;=======================================
;


;==========================
; wait checksum
;==========================
P20_LOOP_PRE:
;	MR_SET_DLYCNT0_IDX T000256MS,0
;	LDA	#0
;	STA	R_LED_TBL_CNT
	MR_SET_MODE_NO C_TESTM0_1

	MR_SET_AUTOCNT2_TEST

P20_LOOP:
	JSR	BK0_WAITKEY
P20_LOOP_S10:
	LDA	USER_FLAG_A
	BIT	#C_KEYCH0_BIT
	BNE	P20_LOOP_KEYCH0_J1
	BIT	#C_KEYCH1_BIT
	BNE	P20_LOOP_KEYCH1_J1
	BIT	#C_KEYCH2_BIT
	BNE	P20_LOOP_KEYCH2_J1
	BIT	#C_KEYCH3_BIT
	BNE	P20_LOOP_KEYCH3_J1
	BIT	#C_SPCH1_BIT
	BNE	P20_LOOP_CH1END_J1
	BIT	#C_SPCH2_BIT
	BNE	P20_LOOP_CH2END_J1
	
	LDA	USER_FLAG_B
	BIT	#C_CNT0_BIT
	BNE	P20_LOOP_CNT0
	BIT	#C_CNT1_BIT
	BNE	P20_LOOP_CNT1
	BIT	#C_AUTO_CNT_BIT
	BNE	P20_LOOP_AUTOCNT_J1
	
	JMP	P20_LOOP
P20_LOOP_KEYCH0_J1:
	JMP	P20_LOOP_KEYCH0
P20_LOOP_KEYCH1_J1:
	JMP	P20_LOOP_KEYCH1
P20_LOOP_KEYCH2_J1:
	JMP	P20_LOOP_KEYCH2
P20_LOOP_KEYCH3_J1:
	JMP	P20_LOOP_KEYCH3
P20_LOOP_AUTOCNT_J1:
	JMP P20_LOOP_AUTOCNT
P20_LOOP_CH1END_J1:
	JMP P20_LOOP_CH1END
P20_LOOP_CH2END_J1:
	JMP P20_LOOP_CH2END
P20_LOOP_CNT0:; IDLE TIMER
	MACRO_CLR_CNT0_FLAG
;
P20_LOOP_CNT0_0: ;led flow flash

	JMP	P20_LOOP_S10
P20_LOOP_CNT1:
	MACRO_CLR_CNT1_FLAG
;

	JMP	P20_LOOP_S10
P20_LOOP_CNT2:
	MACRO_CLR_CNT2_FLAG
	
	JMP	P20_LOOP_S10
P20_LOOP_CNT3:
	MACRO_CLR_CNT3_FLAG
	
	JMP	P20_LOOP_S10
P20_LOOP_CH1END:
	MACRO_CLR_CH1_FLAG
;
;
	
	JMP	P20_LOOP_S10
	
P20_LOOP_CH2END:
	MACRO_CLR_CH2_FLAG
;
;	
;	
	JMP	P20_LOOP_S10

P20_LOOP_AUTOCNT:
	MACRO_CLR_AUTOCNT_FLAG
;

	JMP	L_P50B
	
P20_LOOP_KEYCH1:
	MACRO_CLR_KEYCH1_FLAG
;


;
	JMP	P20_LOOP_S10
P20_LOOP_KEYCH2:
	MACRO_CLR_KEYCH2_FLAG
;

	JMP	P20_LOOP_S10
P20_LOOP_KEYCH3:
	MACRO_CLR_KEYCH3_FLAG
	
	JMP	P20_LOOP_S10

P20_LOOP_KEYCH0:
	MACRO_CLR_KEYCH0_FLAG
; key channel 0
	LDA	WB_KEYCH_CODE
	ASL	A
	TAX
	JMP	(P20_LOOP_KEYCH0_TBL,X)
P20_LOOP_KEYCH0_TBL
	DW	P20_LOOP_KEYCH0_0
	DW	P20_LOOP_KEYCH0_1
	
P20_LOOP_KEYCH0_0
	
	JMP	P20_LOOP_S10
	
P20_LOOP_KEYCH0_1:

	JMP	L_P30
	


;-------------------------------
L_P30:
;-------------------------------
;=======================================
; insert new sub mode
;=======================================

;=====================
;check KEY
;=====================
P30_LOOP_PRE: ;KEY


	MR_SET_DLYCNT0 CNT_STOP
	JSR	BK0_LEDS_OFF
	MR_SET_MODE_NO C_TESTM0_2

	MR_SET_AUTOCNT2_TEST

P30_LOOP:
	JSR	BK0_WAITKEY
P30_LOOP_S10:
	LDA	USER_FLAG_A
	BIT	#C_KEYCH0_BIT
	BNE	P30_LOOP_KEYCH0_J1
	BIT	#C_KEYCH1_BIT
	BNE	P30_LOOP_KEYCH1_J1
	BIT	#C_KEYCH2_BIT
	BNE	P30_LOOP_KEYCH2_J1
	BIT	#C_KEYCH3_BIT
	BNE	P30_LOOP_KEYCH3_J1
	BIT	#C_SPCH1_BIT
	BNE	P30_LOOP_CH1END_J1
	BIT	#C_SPCH2_BIT
	BNE	P30_LOOP_CH2END_J1
	
	LDA	USER_FLAG_B
	BIT	#C_CNT0_BIT
	BNE	P30_LOOP_CNT0
	BIT	#C_CNT1_BIT
	BNE	P30_LOOP_CNT1
	BIT	#C_AUTO_CNT_BIT
	BNE	P30_LOOP_AUTOCNT_J1
	
	JMP	P30_LOOP
P30_LOOP_KEYCH0_J1:
	JMP	P30_LOOP_KEYCH0
P30_LOOP_KEYCH1_J1:
	JMP	P30_LOOP_KEYCH1
P30_LOOP_KEYCH2_J1:
	JMP	P30_LOOP_KEYCH2
P30_LOOP_KEYCH3_J1:
	JMP	P30_LOOP_KEYCH3
P30_LOOP_AUTOCNT_J1:
	JMP P30_LOOP_AUTOCNT
P30_LOOP_CH1END_J1:
	JMP P30_LOOP_CH1END
P30_LOOP_CH2END_J1:
	JMP P30_LOOP_CH2END
P30_LOOP_CNT0:; 
	MACRO_CLR_CNT0_FLAG
;
	LDA	R_BP0
	EOR	WB_DLYCNT0_IDX
	STA	R_BP0
	LDA	R_BP0
	STA	BP0
	MR_SET_DLYCNT0 T000504MS

	JMP	P30_LOOP_S10
P30_LOOP_CNT1:
	MACRO_CLR_CNT1_FLAG
;

	JMP	P30_LOOP_S10
P30_LOOP_CNT2:
	MACRO_CLR_CNT2_FLAG
	
	JMP	P30_LOOP_S10
P30_LOOP_CNT3:
	MACRO_CLR_CNT3_FLAG
	
	JMP	P30_LOOP_S10
P30_LOOP_CH1END:
	MACRO_CLR_CH1_FLAG
;
;
	
	JMP	P30_LOOP_S10
	
P30_LOOP_CH2END:
	MACRO_CLR_CH2_FLAG
;
;	
;	
	JMP	P30_LOOP_S10

P30_LOOP_AUTOCNT:
	MACRO_CLR_AUTOCNT_FLAG
;

	JMP	L_P50B
	
P30_LOOP_KEYCH1:
	MACRO_CLR_KEYCH1_FLAG
;
	MR_SET_DLYCNT0 T000504MS
	JSR	BK0_LEDS_OFF
	LDA	#0011B
	STA	WB_DLYCNT0_IDX ;STORE
	TRB	R_BP0
	LDA	R_BP0
	STA	BP0
	PLAY	di_6k

	JMP	P30_LOOP_S10
P30_LOOP_KEYCH2:
	MACRO_CLR_KEYCH2_FLAG
;
	MR_SET_DLYCNT0 T000504MS
	JSR	BK0_LEDS_OFF
	LDA	#1100B
	STA	WB_DLYCNT0_IDX ;STORE
	TRB	R_BP0
	LDA	R_BP0
	STA	BP0
	PLAY	di_6k

	JMP	P30_LOOP_S10
P30_LOOP_KEYCH3:
	MACRO_CLR_KEYCH3_FLAG
	
	JMP	P30_LOOP_S10

P30_LOOP_KEYCH0:
	MACRO_CLR_KEYCH0_FLAG
; key channel 0

	LDA	WB_KEYCH_CODE
	ASL	A
	TAX
	JMP	(P30_LOOP_KEYCH0_TBL,X)
P30_LOOP_KEYCH0_TBL
	DW	P30_LOOP_KEYCH0_0
	DW	P30_LOOP_KEYCH0_1
	
P30_LOOP_KEYCH0_0
	
	JMP	L_P40
	
P30_LOOP_KEYCH0_1:

	JMP	P30_LOOP_S10


;-------------------------------
L_P40:
;-------------------------------
;=======================================
; insert new sub mode
;=======================================

	JMP	L_P50

P40_LOOP_PRE: ;LED PATT

	MR_SET_MODE_NO C_TESTM0_3

	MR_SET_AUTOCNT2_TEST

	STZ	WB_DLYCNT0_IDX

	JMP	P40_LOOP_KEYCH3_S10

P40_LOOP:
	JSR	BK0_WAITKEY
P40_LOOP_S10:
	LDA	USER_FLAG_A
	BIT	#C_KEYCH0_BIT
	BNE	P40_LOOP_KEYCH0_J1
	BIT	#C_KEYCH1_BIT
	BNE	P40_LOOP_KEYCH1_J1
	BIT	#C_KEYCH2_BIT
	BNE	P40_LOOP_KEYCH2_J1
	BIT	#C_KEYCH3_BIT
	BNE	P40_LOOP_KEYCH3_J1
	BIT	#C_SPCH1_BIT
	BNE	P40_LOOP_CH1END_J1
	BIT	#C_SPCH2_BIT
	BNE	P40_LOOP_CH2END_J1
	
	LDA	USER_FLAG_B
	BIT	#C_CNT0_BIT
	BNE	P40_LOOP_CNT0
	BIT	#C_CNT1_BIT
	BNE	P40_LOOP_CNT1
	BIT	#C_AUTO_CNT_BIT
	BNE	P40_LOOP_AUTOCNT_J1
	
	JMP	P40_LOOP
P40_LOOP_KEYCH0_J1:
	JMP	P40_LOOP_KEYCH0
P40_LOOP_KEYCH1_J1:
	JMP	P40_LOOP_KEYCH1
P40_LOOP_KEYCH2_J1:
	JMP	P40_LOOP_KEYCH2
P40_LOOP_KEYCH3_J1:
	JMP	P40_LOOP_KEYCH3
P40_LOOP_AUTOCNT_J1:
	JMP P40_LOOP_AUTOCNT
P40_LOOP_CH1END_J1:
	JMP P40_LOOP_CH1END
P40_LOOP_CH2END_J1:
	JMP P40_LOOP_CH2END
P40_LOOP_CNT0:; IDLE TIMER
	MACRO_CLR_CNT0_FLAG
;IDLE


	JMP	P40_LOOP_S10
P40_LOOP_CNT1:
	MACRO_CLR_CNT1_FLAG
;

	JMP	P40_LOOP_S10
P40_LOOP_CNT2:
	MACRO_CLR_CNT2_FLAG
	
	JMP	P40_LOOP_S10
P40_LOOP_CNT3:
	MACRO_CLR_CNT3_FLAG
	
	JMP	P40_LOOP_S10
P40_LOOP_CH1END:
	MACRO_CLR_CH1_FLAG
;
;
	
	JMP	P40_LOOP_S10
	
P40_LOOP_CH2END:
	MACRO_CLR_CH2_FLAG
;
;	
;	
	JMP	P40_LOOP_S10

P40_LOOP_AUTOCNT:
	MACRO_CLR_AUTOCNT_FLAG
;

	JMP	L_P50B
	
P40_LOOP_KEYCH1:
	MACRO_CLR_KEYCH1_FLAG


	JMP	P40_LOOP_S10
P40_LOOP_KEYCH2:
	MACRO_CLR_KEYCH2_FLAG
;MODE

	JMP	P40_LOOP_S10
P40_LOOP_KEYCH3:
	MACRO_CLR_KEYCH3_FLAG

	INC	WB_DLYCNT0_IDX
	LDA	WB_DLYCNT0_IDX
	CMP	#11
	BCC	P40_LOOP_KEYCH3_S10
	JMP	L_P50B
P40_LOOP_KEYCH3_S10:
;PATT END
	LDX	WB_DLYCNT0_IDX
	LDA	TEST_LED_PATT_TBL,X
	TAX
	
	STX	R_LED_PATT
	LDA	LED_PATT_DIV_TBL,X
	STA	R_LED_PATT_DIV
	STA	R_LED_PATT_DIV_BUF
	JSR BK0_LED_PATT_ST

	JMP	P40_LOOP_S10

P40_LOOP_KEYCH0:
	MACRO_CLR_KEYCH0_FLAG
; key channel 0

	LDA	WB_KEYCH_CODE
	ASL	A
	TAX
	JMP	(P40_LOOP_KEYCH0_TBL,X)
P40_LOOP_KEYCH0_TBL:
	DW	P40_LOOP_KEYCH0_0
	DW	P40_LOOP_KEYCH0_1
	
P40_LOOP_KEYCH0_0:
	
	JSR	L_PWMS_STOP_W_CHK
	
	JMP	L_P50B
	
P40_LOOP_KEYCH0_1:
	
	JMP	P40_LOOP_S10

;==========================================
L_P50A:
	
	JSR	WAIT_SPCH1_W_CHK

	PLAY	di_6k
	JSR	WAIT_SPCH1_W_CHK

	JMP	P50_LOOP_PRE
L_P50B:
;	PLAY	di_6k+[200MSEC]+di_6k+[200MSEC]+di_6k+[200MSEC]+di_6k+[200MSEC]+di_6k+[200MSEC]+di_6k+[200MSEC]+di_6k+[200MSEC]+di_6k+[200MSEC]+di_6k+[200MSEC]+di_6k
;	JSR	WAIT_SPCH1_W_CHK

	JSR	BK0_LEDS_OFF
HB_TEST_END:

	JMP	ENTER_STOP	
;return to main loop
	JMP	POI_USER

;-------------------------------
L_P50:
;-------------------------------
;
;=================================
;	insert sub mode
;=================================




;=================================
P50_LOOP_PRE:;speech dump
	
	MR_SET_MODE_NO C_TESTM0_4

	MR_STOP_AUTOCNT

	STZ	WB_DLYCNT0_IDX
	JMP	P50_LOOP_CNT0

P50_LOOP:
	JSR	BK0_WAITKEY
P50_LOOP_S10:
	LDA	USER_FLAG_A
	BIT	#C_KEYCH0_BIT
	BNE	P50_LOOP_KEYCH0_J1
	BIT	#C_KEYCH1_BIT
	BNE	P50_LOOP_KEYCH1_J1
	BIT	#C_KEYCH2_BIT
	BNE	P50_LOOP_KEYCH2_J1
	BIT	#C_KEYCH3_BIT
	BNE	P50_LOOP_KEYCH3_J1
	BIT	#C_SPCH1_BIT
	BNE	P50_LOOP_CH1END_J1
	BIT	#C_SPCH2_BIT
	BNE	P50_LOOP_CH2END_J1
	
	LDA	USER_FLAG_B
	BIT	#C_CNT0_BIT
	BNE	P50_LOOP_CNT0
	BIT	#C_CNT1_BIT
	BNE	P50_LOOP_CNT1
	BIT	#C_CNT2_BIT
	BNE	P50_LOOP_CNT2
	BIT	#C_AUTO_CNT_BIT
	BNE	P50_LOOP_AUTOCNT_J1
	
	JMP	P50_LOOP
P50_LOOP_KEYCH0_J1:
	JMP	P50_LOOP_KEYCH0
P50_LOOP_KEYCH1_J1:
	JMP	P50_LOOP_KEYCH1
P50_LOOP_KEYCH2_J1:
	JMP	P50_LOOP_KEYCH2
P50_LOOP_KEYCH3_J1:
	JMP	P50_LOOP_KEYCH3
P50_LOOP_AUTOCNT_J1:
	JMP P50_LOOP_AUTOCNT
P50_LOOP_CH1END_J1:
	JMP P50_LOOP_CH1END
P50_LOOP_CH2END_J1:
	JMP P50_LOOP_CH2END
P50_LOOP_CNT0:; IDLE TIMER
	MACRO_CLR_CNT0_FLAG
;IDLE
; SPEECH DUMP
	LDX	WB_DLYCNT0_IDX
	LDA	T_SPEECH_DUMP_TBL0,X
	CMP	#0FFH
	BNE	P50_LOOP_CNT0_S001

	JMP	P40_LOOP_PRE ;led patt

P50_LOOP_CNT0_S001:
	STA	SOUND_NO
	JSR	BK0_PLAY_SP_REAL

	INC	WB_DLYCNT0_IDX
;----------------------------

	JMP	P50_LOOP_S10
P50_LOOP_CNT1:
	MACRO_CLR_CNT1_FLAG
;

	JMP	P50_LOOP_S10
P50_LOOP_CNT2:
	MACRO_CLR_CNT2_FLAG
;
	JMP	P50_LOOP_S10
P50_LOOP_CNT3:
	MACRO_CLR_CNT3_FLAG
	
	JMP	P50_LOOP_S10
P50_LOOP_CH1END:
	MACRO_CLR_CH1_FLAG
;
	MR_SET_DLYCNT0 T001000MS

	JMP	P50_LOOP_S10

	
P50_LOOP_CH2END:
	MACRO_CLR_CH2_FLAG
;
	MR_SET_DLYCNT0 T001000MS

	JMP	P50_LOOP_S10

P50_LOOP_AUTOCNT:
	MACRO_CLR_AUTOCNT_FLAG
;

	JMP	L_P50B
	
P50_LOOP_KEYCH1:
	MACRO_CLR_KEYCH1_FLAG
;WIPER

	JMP	P50_LOOP_S10
P50_LOOP_KEYCH2:
	MACRO_CLR_KEYCH2_FLAG
;MODE

	JMP	P50_LOOP_S10
P50_LOOP_KEYCH3:
	MACRO_CLR_KEYCH3_FLAG
	
	JMP	P50_LOOP_S10

P50_LOOP_KEYCH0:
	MACRO_CLR_KEYCH0_FLAG
; key channel 0

	LDA	WB_KEYCH_CODE
	ASL	A
	TAX
	JMP	(P50_LOOP_KEYCH0_TBL,X)
P50_LOOP_KEYCH0_TBL:
	DW	P50_LOOP_KEYCH0_0
	DW	P50_LOOP_KEYCH0_1
	
P50_LOOP_KEYCH0_0:
	
	JSR	BK0_STOP_ALL
	
	JMP	P50_LOOP_S10
	
P50_LOOP_KEYCH0_1:

	JMP	P40_LOOP_PRE ;led patt


;-----------------------------------
;SPEECH DUMP TABLE
;-------------------------------------
T_SPEECH_DUMP_TBL0:
	DB	CS_1_DrumsOnly_trimmed
	DB	CS_2_Bass_Drums_Bass_3dB_trimmed
	DB	CS_3a_Melody1_Bass_3dB_trimmed
	DB	CS_3b_Melody2_Bass_3dB_trimmed
	DB	CS_JBP_TinyPong_SFX_StartGame1_GlobalOnly
	DB	CS_JBP_TinyPong_SFX_StartGame2_GlobalOnly
	DB	CS_TinyPong_SFX_GameOver_v3_01
	DB	CS_TinyPong_SFX_Hit_v2_01
	DB	CS_TinyPong_SFX_Hit_v2_02
	DB	CS_TinyPong_SFX_Hit_v2_03
	DB	CS_TinyPong_SFX_LevelUp_v1_05
	DB	CS_TinyPong_SFX_Start_v3_01
	DB	CS_TinyPong_SFX_Start_v3_02
	DB	CS_TP_AfterGameOver_Score_09
	DB	CS_TP_GameOver_AhhMan_01
	DB	CS_TP_GameOver_APhotoFinish_03
	DB	CS_TP_GameOver_AStarIsBornTodayFolks_01
	DB	CS_TP_GameOver_BackToTheLockerroom_03
	DB	CS_TP_GameOver_CantBeTheEnd_02
	DB	CS_TP_GameOver_DidYouForgetToWarmUp_02
	DB	CS_TP_GameOver_DownAtTheWordGo_02
	DB	CS_TP_GameOver_HallOfFamePerformance_02
	DB	CS_TP_GameOver_IsThisTheEnd_03
	DB	CS_TP_GameOver_KeepAtIt_05
	DB	CS_TP_GameOver_NiceJob_01
	DB	CS_TP_GameOver_No_01
	DB	CS_TP_GameOver_NotBadForARookie_02
	DB	CS_TP_GameOver_Oh_06
	DB	CS_TP_GameOver_PerformanceWasUnforgettable_02
	DB	CS_TP_GameOver_PlayerPerformAgain_03
	DB	CS_TP_GameOver_PlayerReturnToTheCourt_04
	DB	CS_TP_GameOver_SeeITEndLikeThis_03
	DB	CS_TP_GameOver_Shoot_02
	DB	CS_TP_GameOver_SkippingPractice_02
	DB	CS_TP_GameOver_SoClose_04
	DB	CS_TP_GameOver_SomeoneStillLearning_02
	DB	CS_TP_GameOver_SoMuchDrama_02
	DB	CS_TP_GameOver_ThatsGotToHurt_01
	DB	CS_TP_GameOver_ThatWasAmazing_02
	DB	CS_TP_GameOver_ThisPlayerHasSeriousPotential_05
	DB	CS_TP_GameOver_UhOh_01
	DB	CS_TP_GameOver_WatchSuchAnAmazingPlayer_01
	DB	CS_TP_GameOver_WeveGotAClearMVP_04
	DB	CS_TP_GameOver_WhatAPerformance_01
	DB	CS_TP_GameOver_WhatAWayToGo_01
	DB	CS_TP_GameOver_YoullGetTheHangOfIt_03
	DB	CS_TP_Gameplay_CrowdGoesWild_03
	DB	CS_TP_Gameplay_Fantastic_03
	DB	CS_TP_Gameplay_ForTheRecordBook_03
	DB	CS_TP_Gameplay_HeatingUp_04
	DB	CS_TP_Gameplay_InItToWinIt_02
	DB	CS_TP_Gameplay_KeepItUp_02
	DB	CS_TP_Gameplay_MakignItLookEasy_03
	DB	CS_TP_Gameplay_MyHeartsPounding_03
	DB	CS_TP_Gameplay_NeverBeTheSame_02
	DB	CS_TP_Gameplay_Unbelievable_01
	DB	CS_TP_Gameplay_Unreal_05
	DB	CS_TP_Gameplay_Unshakable_03
	DB	CS_TP_Gameplay_WhatAnAthlete_02
	DB	CS_TP_Gameplay_WhatAPlay_01
	DB	CS_TP_Gameplay_WhatAStreak_04
	DB	CS_TP_Gameplay_Whoa_03
	DB	CS_TP_Gameplay_Woo_03
	DB	CS_TP_Gameplay_YesYes_04
	DB	CS_TP_GameSetting_BeginnerMode_02
	DB	CS_TP_GameSetting_ExpertMode_04
	DB	CS_TP_GameSetting_YouBeatBeginnerMode_02
	DB	CS_TP_GameSetting_YouBeatExpertMode_03
	DB	CS_TP_HighScoreBeat_WeHaveANewRecord_07
	DB	CS_TP_TurnOn_OurCurrentRecordIs_05
	DB	CS_TP_TurnOn_WelcomeToTinyPong_01


	DB	0FFH ; END

T_SPEECH_DUMP_TBL1:


	DB	0FFH ; END

;=====================================
;	SUBROUTINE,TABLE
;=======================================
TEST_LED_FSH1_TBL:
	DB	00001000B
	DB	00000010B
	DB	00H

TEST_LED_PATT_TBL:
	DB	0
	DB	1
	DB	2
	DB	3
	DB	4
	DB	5
	DB	6
	DB	7
	DB	8
	DB	9
	DB	10
	
	DB	0FFH



BK0_LEDS_OFF:
	LDA #00001111B
	TSB	R_BP0
	LDA	R_BP0
	STA	BP0
	RTS

BK0_LEDS_ON:
	LDA #00001111B
	TRB	R_BP0
	LDA	R_BP0
	STA	BP0
	RTS

