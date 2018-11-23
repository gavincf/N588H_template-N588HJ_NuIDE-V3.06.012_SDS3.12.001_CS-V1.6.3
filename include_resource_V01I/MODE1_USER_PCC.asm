

;==================================================
;note:
;	JMP	PWOFF_LOOP_WAITSP
;	MR_SET_AUTOCNT1_1B ; --------------- not directly to enter sleep 

;==================================================

;=========================================
;		M1
;=========================================

C_M1_0 EQU 00H ; ;POWERON
C_M1_1 EQU 01H ; ;WAKEUP
C_M1_2 EQU 02H ;
C_M1_3 EQU 03H ;
C_M1_4 EQU 04H ;
C_M1_5 EQU 05H ;


;=========================================
M1_WAKEUP:

	MR_SET_DLYCNT0 CNT_STOP
	
	BRA	M1_PRE2
M1_PRE:
	
	MR_SET_DLYCNT0 CNT_STOP
;===================================
M1_PRE_PCC:
	

;===================================
	

M1_PRE2:
	

	MR_SET_MODE_NO C_M1_0
;
;--------------------------------------------
M1:

	JSR WAITKEY
	
;==========================================
M1_CHK_USER_FLAG:
	LDA	USER_FLAG_A
	BIT	#C_KEYCH0_BIT
	BNE	M1S0_KEYCH0_J1
	BIT	#C_KEYCH1_BIT
	BNE	M1S0_KEYCH1_J1
	BIT	#C_KEYCH2_BIT
	BNE	M1S0_KEYCH2_J1
	BIT	#C_KEYCH3_BIT
	BNE	M1S0_KEYCH3_J1
	BIT	#C_SPCH1_BIT
	BNE	M1S0_CH1END
	BIT	#C_SPCH2_BIT
	BNE	M1S0_CH2END_J1

	LDA	USER_FLAG_B
	BIT	#C_CNT0_BIT
	BNE	M1S0_CNT0_J1
	BIT	#C_CNT1_BIT
	BNE	M1S0_CNT1_J1
	BIT	#C_AUTO_CNT_BIT
	BNE	M1S0_AUTOCNT_J1
	
	JMP	M1

M1S0_AUTOCNT_J1
	JMP	M1S0_AUTOCNT
	
M1S0_CH2END_J1:
	JMP	M1S0_CH2END
M1S0_KEYCH0_J1:
	JMP	M1S0_KEYCH0
M1S0_KEYCH1_J1:
	JMP	M1S0_KEYCH1
M1S0_KEYCH2_J1:
	JMP	M1S0_KEYCH2
M1S0_KEYCH3_J1:
	JMP	M1S0_KEYCH3
	
	
M1S0_CNT0_J1:
	JMP	M1S0_CNT0
M1S0_CNT1_J1		
	JMP	M1S0_CNT1
		
M1S0_CH1END:
	MACRO_CLR_CH1_FLAG

M1S0_CH1END_PCC:
	
	
	MR_DET_EQU_FG
	BNE	M1S0_CH1END_S100
;Speech CH1 END

	JMP	M1_CHK_USER_FLAG

M1S0_CH1END_S11:
	

	JMP	M1_CHK_USER_FLAG
M1S0_CH1END_S12:

	
	JMP	M1_CHK_USER_FLAG

M1S0_CH1END_S100: ;EQU
;
	MR_DET_EVT_EQU
	BEQ	M1S0_CH1END_S110
;
;WAIT EVT

	JMP	M1_CHK_USER_FLAG
	
M1S0_CH1END_S110: ;EVT reach
	JSR	BK0_PLAY_EQU_NEXT
	BNE	M1S0_CH1END_EQU_NEXT
;EQU END
	MR_SET_SP_FG ;clr EQU FLAG
	MR_NRL_EQU

	
	JMP	M1_CHK_USER_FLAG
	
M1S0_CH1END_EQU_NEXT:

	JMP	M1_CHK_USER_FLAG


M1S0_CH2END:
	MACRO_CLR_CH2_FLAG
	
	JMP	M1_CHK_USER_FLAG

M1S0_AUTOCNT_S20:

	MR_SET_AUTOCNT1
	
	JMP	M1_CHK_USER_FLAG
		
M1S0_AUTOCNT:
	MACRO_CLR_AUTOCNT_FLAG

M1S0_AUTOCNT_PCC:



.IFDEF  C_CHKSKEY_EN
.IF ( C_S_KEY1_ENABLE .EQ. 1)
	LDA	R_S_KEY1_DEBOUNCE
	BNE	M1S0_AUTOCNT_S20
.ENDIF
.IF ( C_S_KEY2_ENABLE .EQ. 1)
	LDA	R_S_KEY2_DEBOUNCE
	BNE	M1S0_AUTOCNT_S20
.ENDIF
.IF ( C_S_KEY3_ENABLE .EQ. 1)
	LDA	R_S_KEY3_DEBOUNCE
	BNE	M1S0_AUTOCNT_S20
.ENDIF
.IF ( C_S_KEY4_ENABLE .EQ. 1)
	LDA	R_S_KEY4_DEBOUNCE
	BNE	M1S0_AUTOCNT_S20
.ENDIF
.IF ( C_S_KEY5_ENABLE .EQ. 1)
	LDA	R_S_KEY5_DEBOUNCE
	BNE	M1S0_AUTOCNT_S20
.ENDIF
.IF ( C_S_KEY6_ENABLE .EQ. 1)
	LDA	R_S_KEY6_DEBOUNCE
	BNE	M1S0_AUTOCNT_S20
.ENDIF
.IF ( C_S_KEY7_ENABLE .EQ. 1)
	LDA	R_S_KEY7_DEBOUNCE
	BNE	M1S0_AUTOCNT_S20
.ENDIF
.IF ( C_S_KEY8_ENABLE .EQ. 1)
	LDA	R_S_KEY8_DEBOUNCE
	BNE	M1S0_AUTOCNT_S20
.ENDIF
.IF ( C_S_KEY9_ENABLE .EQ. 1)
	LDA	R_S_KEY9_DEBOUNCE
	BNE	M1S0_AUTOCNT_S20
.ENDIF
.IF ( C_S_KEY10_ENABLE .EQ. 1)
	LDA	R_S_KEY10_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY11_ENABLE .EQ. 1)
	LDA	R_S_KEY11_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY12_ENABLE .EQ. 1)
	LDA	R_S_KEY12_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY13_ENABLE .EQ. 1)
	LDA	R_S_KEY13_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY14_ENABLE .EQ. 1)
	LDA	R_S_KEY14_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY15_ENABLE .EQ. 1)
	LDA	R_S_KEY15_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY16_ENABLE .EQ. 1)
	LDA	R_S_KEY16_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY17_ENABLE .EQ. 1)
	LDA	R_S_KEY17_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY18_ENABLE .EQ. 1)
	LDA	R_S_KEY18_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY19_ENABLE .EQ. 1)
	LDA	R_S_KEY19_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY20_ENABLE .EQ. 1)
	LDA	R_S_KEY20_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY21_ENABLE .EQ. 1)
	LDA	R_S_KEY21_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY22_ENABLE .EQ. 1)
	LDA	R_S_KEY22_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY23_ENABLE .EQ. 1)
	LDA	R_S_KEY23_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.IF ( C_S_KEY24_ENABLE .EQ. 1)
	LDA	R_S_KEY24_DEBOUNCE
	BNE	M1S0_AUTOCNT_S10
.ENDIF
.ENDIF

.IFDEF C_CHK1KEY_EN
	JSR	BK0_DET_CHK1KEY
	BNE	M1S0_AUTOCNT_S10
.ENDIF

.IFDEF C_CHKMKEY_EN
	JSR	BK0_DET_CHKMKEY
	BNE	M1S0_AUTOCNT_S10
.ENDIF

	JMP	PWOFF_LOOP_WAITSP

M1S0_AUTOCNT_S10:

	MR_SET_AUTOCNT1
	
	JMP	M1_CHK_USER_FLAG
M1S0_KEYCH3:
	MACRO_CLR_KEYCH3_FLAG

	
	JMP	M1_CHK_USER_FLAG
	
M1S0_KEYCH2:
	MACRO_CLR_KEYCH2_FLAG
	
	
	JMP	M1_CHK_USER_FLAG
	
M1S0_KEYCH1:
	MACRO_CLR_KEYCH1_FLAG
	
;

	JMP	M1_CHK_USER_FLAG
	
M1S0_KEYCH0:
; key channel 0
	MACRO_CLR_KEYCH0_FLAG

M1S0_KEYCH0_PCC:
	LDA	WB_KEYCH_CODE
M1S0_KEYCH0_S20:
	ASL	A
	TAX
		
	JMP	(M1S0_KEYCH0_TBL,X)
;------------------------------------------------------

M1S0_CNT0:
	MACRO_CLR_CNT0_FLAG

M1S0_CNT0_PCC:
	LDA	WB_DLYCNT0_IDX
	ASL	A
	TAX
	JMP	(M1S0_CNT0_TBL,X)
M1S0_CNT0_TBL:
	DW	M1S0_CNT0_0
	DW	M1S0_CNT0_1
	DW	M1S0_CNT0_2
	DW	M1S0_CNT0_3
	DW	M1S0_CNT0_4
	
M1S0_CNT0_0:

	JMP	M1_CHK_USER_FLAG
M1S0_CNT0_1:

	JMP	M1_CHK_USER_FLAG
M1S0_CNT0_2:

	JMP	M1_CHK_USER_FLAG
M1S0_CNT0_3:

	JMP	M1_CHK_USER_FLAG
M1S0_CNT0_4:
	
	
	JMP	M1_CHK_USER_FLAG

M1S0_CNT1:
	MACRO_CLR_CNT1_FLAG
	JMP	M1_CHK_USER_FLAG
;-----------------------------------------------------

M1S0_KEYCH0_TBL:
	DW	M1S0_KEYCH0_0
	DW	M1S0_KEYCH0_1
	DW	M1S0_KEYCH0_2
	DW	M1S0_KEYCH0_3
	DW	M1S0_KEYCH0_4
	DW	M1S0_KEYCH0_5
	DW	M1S0_KEYCH0_6
	DW	M1S0_KEYCH0_7
	DW	M1S0_KEYCH0_8

	
M1S0_KEYCH0_0:
M1S0_KEYCH0_1:
M1S0_KEYCH0_2:
M1S0_KEYCH0_3:
M1S0_KEYCH0_4:
M1S0_KEYCH0_5:
M1S0_KEYCH0_6:
M1S0_KEYCH0_7:
M1S0_KEYCH0_8:

	JMP	M1_CHK_USER_FLAG

;=====================================
;	SUBROUTINE,TABLE
;=======================================

