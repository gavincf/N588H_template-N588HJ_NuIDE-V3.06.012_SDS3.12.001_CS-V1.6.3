


;LVR+LVD ->SLEEP,不开始功能。

;RESET_F.0=1;LVR
;RESET_F.3=1;POR
;RESET_F.4=1;RESET PIN

POI_USER:

;计算RAM的使用情况
	LDA	#R_USER_STACK_ST
	CMP	#R_USER_RAM_ST
	BCC	POI_USER
	SEC
	SBC	#R_USER_RAM_ST
	CMP	#C_RESERVE_BYTE_USER_STACK
	BCS	POI_RAM_OK
;

	BRA	POI_USER ; reset
	
POI_RAM_OK:

.IF ( C_BP0_ULTRAIO_EN .EQ. 1 )
	
	LDA	#C_PWON_BP0D
	STA	!BP0D
	LDA	#C_PWON_BP0M_BAK
	STA	BP0M_BAK
	ORA	#C_PWON_BP0_OP
	STA	!BP0
.ELSE
	LDA	#C_PWON_BP0D
	STA	!BP0D
	LDA	#C_PWON_R_BP0
	.IF ( C_R_BP0_USED .EQ. 1 )
	STA	R_BP0
	.ENDIF
	STA	!BP0
.ENDIF

.IF ( C_BP1_ULTRAIO_EN .EQ. 1 )
	
	LDA	#C_PWON_BP1D
	STA	!BP1D
	LDA	#C_PWON_BP1M_BAK
	STA	BP1M_BAK
	ORA	#C_PWON_BP1_OP
	STA	!BP1
.ELSE
	LDA	#C_PWON_BP1D
	STA	!BP1D
	LDA	#C_PWON_R_BP1
	STA	R_BP1
	STA	!BP1
.ENDIF

.IF ( C_BP2_ULTRAIO_EN .EQ. 1 )
	
	LDA	#C_PWON_BP2D
	STA	!BP2D
	LDA	#C_PWON_BP2M_BAK
	STA	BP2M_BAK
	ORA	#C_PWON_BP2_OP
	STA	!BP2
.ELSE
	.IFDEF	BP2
	LDA	#C_PWON_BP2D
	STA	!BP2D
	LDA	#C_PWON_R_BP2
	.IF ( C_R_BP2_USED .EQ. 1 )
		STA	R_BP2
	.ENDIF
	STA	!BP2
	.ENDIF
.ENDIF
	JSR	BK0_DELAY61440CYCLE

.IFDEF C_CMPA_EN
	JSR	BK0_CMPA_ON
	JSR	FRESH_STS0
.ENDIF ; C_CMPA_EN

POI_WAIT_CPU:
	JSR	BK0_STORE_BPX

	JSR	BK0_DELAY61440CYCLE
	JSR	BK0_DELAY61440CYCLE
	JSR	BK0_DELAY61440CYCLE
	
;CHECK AGAIN
.IF ( C_BP0_STATUS_EN .EQ. 1 )
	LDA	!BP0
	CMP	BP0_STATUS
	BNE	POI_WAIT_CPU
.ENDIF
.IF ( C_BP1_STATUS_EN .EQ. 1 )
	LDA	!BP1
	CMP	BP1_STATUS
	BNE	POI_WAIT_CPU
.ENDIF
.IF ( C_BP2_STATUS_EN .EQ. 1 )
	LDA	!BP2
	CMP	BP2_STATUS
	BNE	POI_WAIT_CPU
.ENDIF


.IF	(C_MS_ENABLE .EQ. 1)
	EN_GLOBALVOL_VOL_MIDI1
.ENDIF

.IF	(C_SPCH1_ENABLE .EQ. 1)
	.IF ( Speech_Volume_Adjustment .EQ. 1 )
	EN_GLOBALVOL_VOL1
	.ENDIF
.ENDIF
	
.IF	(C_SPCH2_ENABLE .EQ. 1)
	.IF ( Speech_Volume_Adjustment .EQ. 1 )
	EN_GLOBALVOL_VOL2
	.ENDIF	
.ENDIF	

	.IF ( Speech_Volume_Adjustment .EQ. 1 )
	LDA	#C_DEFAULT_TPO_IDX|C_DEFAULT_VOL_IDX
	STA	VOL_TPO_IDX
	JSR	BK0_SET_VOL
	.ENDIF	

	JSR	CHKKEY_INIT
;========================================================
;========================================================
POI_MODULE_PCC:



;========================================================
	
.IFDEF C_CMPA_EN
;CHECK CMPA
	JSR	STORE_STS0
	
	LDA	#B_CHK_STS0_ST
	BIT	<R_CHK_STS0_ST
	BNE	POI_LVD_S10
;0: BP10<BP11

.IF ( DEBUG_CMPA .EQ. 1 )
	BRA POI_LVD_S10
.ENDIF ; DEBUG_CMPA
	
	JMP	ENTER_STOP

POI_LVD_S10:
.ENDIF ; C_CMPA_EN

;CHECK LVR
.IFDEF C_CHK_LVR_EN
	LDA	RESET_F
	AND	#11001B
	CMP	#00001B
	BNE	POI_LVR_S10
	LDA	#0FFH
	STA	RESET_F
;LVR->ENTER STOP
	JMP	ENTER_STOP

POI_LVR_S10:
	LDA	#0FFH
	STA	RESET_F
.ENDIF

;===============================
;CHECK TEST MODE
;===============================
POI_CHKTEST_PCC:



;========================================

	
;===============================
;CHECK TEST MODE end
;=======================================


;not TEST MODE
;========================================
;	JMP	ENTER_STOP


.IF ( C_TMG0_EN .EQ. 1 )
	JSR	BK0_START_TMG0_0625MS
.ENDIF
	MACRO_INT_ENABLE FXF15_INT_BIT

;	JMP	M0_PRE
	JMP	PWON_CHK_MODE



;=======================================
MAIN_WAKEUP: ; wakeup from sleep

	MACRO_INT_ENABLE FXF15_INT_BIT
.IF ( C_TMG0_EN .EQ. 1 )
	JSR	BK0_START_TMG0_0625MS
.ENDIF
;======================================

.IF ( C_BP0_ULTRAIO_EN .EQ. 1 )
	
	LDA	#C_WAKEUP_BP0D
	STA	!BP0D
	LDA	#C_WAKEUP_BP0M_BAK
	STA	BP0M_BAK
	ORA	#C_WAKEUP_BP0_OP
	STA	!BP0
.ELSE
	LDA	#C_WAKEUP_BP0D
	STA	!BP0D
	LDA	#C_WAKEUP_R_BP0
	.IF ( C_R_BP0_USED .EQ. 1 )
	STA	R_BP0
	.ENDIF
	STA	!BP0
.ENDIF

.IF ( C_BP1_ULTRAIO_EN .EQ. 1 )
	
	LDA	#C_WAKEUP_BP1D
	STA	!BP1D
	LDA	#C_WAKEUP_BP1M_BAK
	STA	BP1M_BAK
	ORA	#C_WAKEUP_BP1_OP
	STA	!BP1
.ELSE
	LDA	#C_WAKEUP_BP1D
	STA	!BP1D
	LDA	#C_WAKEUP_R_BP1
	STA	R_BP1
	STA	!BP1
.ENDIF

.IF ( C_BP2_ULTRAIO_EN .EQ. 1 )
	
	LDA	#C_WAKEUP_BP2D
	STA	!BP2D
	LDA	#C_WAKEUP_BP2M_BAK
	STA	BP2M_BAK
	ORA	#C_WAKEUP_BP2_OP
	STA	!BP2
.ELSE
	.IFDEF	BP2
	LDA	#C_WAKEUP_BP2D
	STA	!BP2D
	LDA	#C_WAKEUP_R_BP2
	.IF ( C_R_BP2_USED .EQ. 1 )
		STA	R_BP2
	.ENDIF
	STA	!BP2
	.ENDIF
.ENDIF


;if some IO change to input from output ;->;DELAY1MS
;	JSR	BK0_DELAY1MS

	MR_SET_AUTOCNT1
	
;=================================
MAIN_WAKEUP_PCC:
;

;=================================
.IF ( C_MODESWITCH_CHK_EN .EQ. 1 )
	MR_SET_AUTOCNT1
	JMP	WAKEUP_CHKKEY_LOOP_PRE
.ELSE
;===============================
;check any key in mode

	MR_SET_AUTOCNT1

	JMP	M0_WAKEUP
.ENDIF

;=======================================
; 	wakeup From key or mode key
;need to check mode key firstly
;need to check keys before mode enter
;=======================================
WAKEUP_CHKKEY_LOOP_PRE:
;
;

WAKEUP_CHKKEY_LOOP:
	JSR	WAITKEY
WAKEUP_CHKKEY_CHK_USER_FLAG:
	LDA	USER_FLAG_A
	BIT	#C_KEYCH0_BIT
	BNE	WAKEUP_CHKKEY_LOOP_KEYCH0_J1
	BIT	#C_KEYCH1_BIT
	BNE	WAKEUP_CHKKEY_LOOP_KEYCH1_J1
	BIT	#C_KEYCH2_BIT
	BNE	WAKEUP_CHKKEY_LOOP_KEYCH2_J1
	BIT	#C_KEYCH3_BIT
	BNE	WAKEUP_CHKKEY_LOOP_KEYCH3_J1
	BIT	#C_SPCH1_BIT
	BNE	WAKEUP_CHKKEY_LOOP_CH1END_J1
	BIT	#C_SPCH2_BIT
	BNE	WAKEUP_CHKKEY_LOOP_CH2END_J1
	
	LDA	USER_FLAG_B
	BIT	#C_CNT0_BIT
	BNE	WAKEUP_CHKKEY_LOOP_CNT0
	BIT	#C_CNT1_BIT
	BNE	WAKEUP_CHKKEY_LOOP_CNT1
	BIT	#C_AUTO_CNT_BIT
	BNE	WAKEUP_CHKKEY_LOOP_AUTOCNT_J1
	
	JMP	WAKEUP_CHKKEY_LOOP
WAKEUP_CHKKEY_LOOP_KEYCH0_J1:
	JMP	WAKEUP_CHKKEY_LOOP_KEYCH0
WAKEUP_CHKKEY_LOOP_KEYCH1_J1:
	JMP	WAKEUP_CHKKEY_LOOP_KEYCH1
WAKEUP_CHKKEY_LOOP_KEYCH2_J1:
	JMP	WAKEUP_CHKKEY_LOOP_KEYCH2
WAKEUP_CHKKEY_LOOP_KEYCH3_J1:
	JMP	WAKEUP_CHKKEY_LOOP_KEYCH3
WAKEUP_CHKKEY_LOOP_AUTOCNT_J1:
	JMP WAKEUP_CHKKEY_LOOP_AUTOCNT
WAKEUP_CHKKEY_LOOP_CH1END_J1:
	JMP WAKEUP_CHKKEY_LOOP_CH1END
WAKEUP_CHKKEY_LOOP_CH2END_J1:
	JMP WAKEUP_CHKKEY_LOOP_CH2END
WAKEUP_CHKKEY_LOOP_CNT0:; IDLE TIMER
	MACRO_CLR_CNT0_FLAG
;IDLE
	

	JMP	WAKEUP_CHKKEY_CHK_USER_FLAG
WAKEUP_CHKKEY_LOOP_CNT1:
	MACRO_CLR_CNT1_FLAG
;

	JMP	WAKEUP_CHKKEY_CHK_USER_FLAG
WAKEUP_CHKKEY_LOOP_CNT2:
	MACRO_CLR_CNT2_FLAG
	
	JMP	WAKEUP_CHKKEY_CHK_USER_FLAG
WAKEUP_CHKKEY_LOOP_CNT3:
	MACRO_CLR_CNT3_FLAG
	
	JMP	WAKEUP_CHKKEY_CHK_USER_FLAG
WAKEUP_CHKKEY_LOOP_CH1END:
	MACRO_CLR_CH1_FLAG
;
	
	JMP	WAKEUP_CHKKEY_CHK_USER_FLAG
	
WAKEUP_CHKKEY_LOOP_CH2END:
	MACRO_CLR_CH2_FLAG
;
	
	JMP	WAKEUP_CHKKEY_CHK_USER_FLAG

WAKEUP_CHKKEY_LOOP_AUTOCNT:
	MACRO_CLR_AUTOCNT_FLAG
;

	JMP	ENTER_STOP
	
WAKEUP_CHKKEY_LOOP_KEYCH1:
	MACRO_CLR_KEYCH1_FLAG
;

	JMP	WAKEUP_CHKKEY_END
	
WAKEUP_CHKKEY_LOOP_KEYCH2:
	MACRO_CLR_KEYCH2_FLAG
;MODE change
	
	JMP	WAKEUP_CHKKEY_END
	
WAKEUP_CHKKEY_LOOP_KEYCH3:
	MACRO_CLR_KEYCH3_FLAG
	
	JMP	WAKEUP_CHKKEY_END

WAKEUP_CHKKEY_LOOP_KEYCH0:
	MACRO_CLR_KEYCH0_FLAG
; key channel 0
;check ANYKEY_WAKEUP key
	
	JMP	WAKEUP_CHKKEY_END
;======================================
;=========================================
WAKEUP_CHKKEY_END:
	
;==================================================
WAKEUP_CHKKEY_END_PCC:

;==================================================

	.IFDEF C_LED_MATRIX_EN
	JSR	BK0_LED_MATRIX_RAM_INIT
	.ENDIF
	
	MACRO_INT_ENABLE FXF15_INT_BIT
	
.IF ( C_TMG0_EN .EQ. 1 )
	JSR	BK0_START_TMG0_0625MS
.ENDIF

;=============================

.IF ( C_BP0_ULTRAIO_EN .EQ. 1 )
	
	LDA	#C_WAKEUP1_BP0D
	STA	!BP0D
	LDA	#C_WAKEUP1_BP0M_BAK
	STA	BP0M_BAK
	ORA	#C_WAKEUP1_BP0_OP
	STA	!BP0
.ELSE
	LDA	#C_WAKEUP1_BP0D
	STA	!BP0D
	LDA	#C_WAKEUP1_R_BP0
	.IF ( C_R_BP0_USED .EQ. 1 )
	STA	R_BP0
	.ENDIF
	STA	!BP0
.ENDIF

.IF ( C_BP1_ULTRAIO_EN .EQ. 1 )
	
	LDA	#C_WAKEUP1_BP1D
	STA	!BP1D
	LDA	#C_WAKEUP1_BP1M_BAK
	STA	BP1M_BAK
	ORA	#C_WAKEUP1_BP1_OP
	STA	!BP1
.ELSE
	LDA	#C_WAKEUP1_BP1D
	STA	!BP1D
	LDA	#C_WAKEUP1_R_BP1
	STA	R_BP1
	STA	!BP1
.ENDIF

.IF ( C_BP2_ULTRAIO_EN .EQ. 1 )
	
	LDA	#C_WAKEUP1_BP2D
	STA	!BP2D
	LDA	#C_WAKEUP1_BP2M_BAK
	STA	BP2M_BAK
	ORA	#C_WAKEUP1_BP2_OP
	STA	!BP2
.ELSE
	.IFDEF	BP2
	LDA	#C_WAKEUP1_BP2D
	STA	!BP2D
	LDA	#C_WAKEUP1_R_BP2
	.IF ( C_R_BP2_USED .EQ. 1 )
		STA	R_BP2
	.ENDIF
	STA	!BP2
	.ENDIF
.ENDIF

;================================
;	LDA	#C_WAKEUP1_BP0D
;	STA	!BP0D
;	LDA	#C_WAKEUP1_R_BP0
;.IF ( C_R_BP0_USED .EQ. 1 )
;	STA	R_BP0
;.ENDIF
;	STA	!BP0
;	
;	LDA	#C_WAKEUP1_BP1D
;	STA	!BP1D
;	LDA	#C_WAKEUP1_R_BP1
;	STA	R_BP1
;	STA	!BP1
;
;	.IFDEF	BP2
;	LDA	#C_WAKEUP1_BP2D
;	STA	!BP2D
;	LDA	#C_WAKEUP1_R_BP2
;.IF ( C_R_BP2_USED .EQ. 1 )
;	STA	R_BP2
;.ENDIF
;	STA	!BP2
;	.ENDIF
	
;===============================
;after keys checked
;mode key check end: before other key
;===============================
WAKEUP_CHK_MODE:
;===============================
;===============================

.IF ( C_MODESWITCH_CHK_EN .EQ. 1 )
	MR_SET_AUTOCNT1
; check mode switch status
	MR_DET_MODESWITCH
	BNE	WAKEUP_CHK_MODE_S10

	JMP	M0_WAKEUP
WAKEUP_CHK_MODE_S10:

	JMP	M1_WAKEUP
;======================================
.ELSE
	JMP	M0_WAKEUP
	
.ENDIF
MODE_SWITCH:
.IF ( C_MODESWITCH_CHK_EN .EQ. 1 )
; check mode switch status
	MR_DET_MODESWITCH
	BNE	MODE_SWITCH_CHK_MODE_S10

	JMP	M0_WAKEUP
MODE_SWITCH_CHK_MODE_S10:

	JMP	M1_WAKEUP
.ELSE
	JMP	M0_WAKEUP
.ENDIF
;========================================
PWON_CHK_MODE:
.IF ( C_MODESWITCH_CHK_EN .EQ. 1 )
	MR_SET_AUTOCNT2
; check mode switch status
	MR_DET_MODESWITCH
	BNE	PWON_CHK_MODE_S10

	JMP	M0_PRE ; goto mode0
PWON_CHK_MODE_S10:

	JMP	M1_PRE ; goto mode1
.ELSE
	JMP	M0_PRE ; goto mode0
	
.ENDIF
;=======================================
;=======================================
