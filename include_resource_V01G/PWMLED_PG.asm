;BK0_LED_PATT_ST
;L_PWMS_STOP_W_CHK
;L_PWMS_SOLVE_SUB



;=====================================
L_PWMS_STOP_W_CHK:
	
	LDA	#C_BIT0
	BIT	PWM_FLAG; only check bit0 as patt flag
	BEQ	L_PWMS_STOP_W_CHK_END

	MR_STOP_PWMX_TM
	
	PWM0_DISABLE
	M_PWM0_OFF
.IF ( C_PWMS_MAX .GT. 1 )
	PWM1_DISABLE
	M_PWM1_OFF
.ENDIF
.IF ( C_PWMS_MAX .GT. 2 )
	PWM2_DISABLE
	M_PWM2_OFF
.ENDIF
.IF ( C_PWMS_MAX .GT. 3 )
	PWM3_DISABLE
	M_PWM3_OFF
.ENDIF
	
L_PWMS_STOP_W_CHK_END:
	RTS

;=====================================
;  BK0_LED_PATT_ST
;=====================================
BK0_LED_PATT_ST:
	
	PWM0_ENABLE ; as led pattern enable flag
	
;	PWM1_ENABLE
;	PWM2_ENABLE
;.IF ( C_PWMS_MAX .GT. 3 )
;	PWM3_ENABLE
;.ENDIF

	M_PWM0_OFF
.IF ( C_PWMS_MAX .GT. 1 )
	M_PWM1_OFF
.ENDIF
.IF ( C_PWMS_MAX .GT. 2 )
	M_PWM2_OFF
.ENDIF
.IF ( C_PWMS_MAX .GT. 3 )
	M_PWM3_OFF
.ENDIF

	STZ	LED_TBL_PT
	STZ	LED_TBL_PT+1
	
	MR_START_PWMX_TM
	
	MR_CHK_PATT_EN
	
	JMP	LOAD_PWMS_PATT
	
;=================================
; Check patt end in main loop
;=================================
;	MR_DET_CHK_PATT
;	BEQ	DET_PATT_QUIT
;	LDA	PWM_FLAG
;	AND	#0FH
;	BNE	DET_PATT_QUIT
;;PATT END
;	MR_CHK_PATT_DIS
;	
;	LDA	#C_BIT7
;	TSB	USER_FLAG_A ;SET FLAG
;
;DET_PATT_QUIT:
;====================================
	
;======================================
; Load new patt table
;=====================================
LOAD_PWMS_PATT:
	PHY

LOAD_PWMS_PATT_RE:
	LDA	R_LED_PATT
	ASL	A
	TAY
	LDA	LED_PATT_TBL,Y
	STA	REG_EA
	INY
	LDA	LED_PATT_TBL,Y
	STA	REG_HL
;
	LDA	<LED_TBL_PT
	STA	<P0_TEMP0
	LDA	<LED_TBL_PT+1
	STA	<P0_TEMP0+1
	
	CLC
	ROL	<P0_TEMP0
	ROL	<P0_TEMP0+1
	CLC
	ROL	<P0_TEMP0
	ROL	<P0_TEMP0+1
;
	CLC
	LDA	REG_EA
	ADC	P0_TEMP0
	STA	P0_TEMP0
	LDA	REG_HL
	ADC	P0_TEMP0+1
	STA	P0_TEMP0+1

	LDY	#0
	LDA	(<P0_TEMP0),Y
	CMP	#0FFH
	BEQ	LOAD_PWMS_PATT_LOOP
	CMP	#0FEH
	BNE	LOAD_PWMS_PATT_DATA
	
;-------------------------- pattern end
	JSR	L_PWMS_STOP_W_CHK
	PLY
	RTS
	
LOAD_PWMS_PATT_LOOP:
	
	STZ	LED_TBL_PT
	STZ	LED_TBL_PT+1
	BRA	LOAD_PWMS_PATT_RE
	
LOAD_PWMS_PATT_DATA:
;-------------------------------------
	STA	<PWM0_LEVEL
.IF ( C_PWMS_MAX .GT. 1 )
	INY
	LDA	(<P0_TEMP0),Y
	STA	<PWM1_LEVEL
.ENDIF	
.IF ( C_PWMS_MAX .GT. 2 )
	INY
	LDA	(<P0_TEMP0),Y
	STA	<PWM2_LEVEL
.ENDIF	
.IF ( C_PWMS_MAX .GT. 3 )
	INY
	LDA	(<P0_TEMP0),Y
	STA	<PWM3_LEVEL
.ENDIF	
;==================================
; PWM SHOW PART
;==================================
L_PWM_SOLVE_W_DLY:

	LDA	<PWM0_LEVEL
	BEQ	L_PWM_SOLVE_S010
	M_PWM0_ON
	BRA	L_PWM_SOLVE_S011
L_PWM_SOLVE_S010:
	M_PWM0_OFF
L_PWM_SOLVE_S011:
	
.IF ( C_PWMS_MAX .GT. 1 )
	LDA	<PWM1_LEVEL
	BEQ	L_PWM_SOLVE_S020
	M_PWM1_ON
	BRA	L_PWM_SOLVE_S021
L_PWM_SOLVE_S020:
	M_PWM1_OFF
L_PWM_SOLVE_S021:
.ENDIF
.IF ( C_PWMS_MAX .GT. 2 )
	LDA	<PWM2_LEVEL
	BEQ	L_PWM_SOLVE_S030
	M_PWM2_ON
	BRA	L_PWM_SOLVE_S031
L_PWM_SOLVE_S030:
	M_PWM2_OFF
L_PWM_SOLVE_S031:
.ENDIF
.IF ( C_PWMS_MAX .GT. 3 )
	LDA	<PWM3_LEVEL
	BEQ	L_PWM_SOLVE_S040
	M_PWM3_ON
	BRA	L_PWM_SOLVE_S041
L_PWM_SOLVE_S040:
	M_PWM3_OFF
L_PWM_SOLVE_S041:
.ENDIF

	PLY
	RTS
	
;===================================================
; Loop in 'ISR'
; USE: Y
;T=500US
;===================================================
L_PWMS_SOLVE_SUB:
; 7 colors show
;0;0-31
	
	LDA	#C_BIT0
	BIT	PWM_FLAG
	BEQ	L_PWM_SOLVE_SUB_END
;PWM0 as pattern ENABLE
	INC	<PWM_LEVEL_CNT ; 0-16 ; PWM level
	LDA	<PWM_LEVEL_CNT
	CMP	#C_MAX_LEVEL
	BNE	L_PWM_SOLVE_S100
	STZ	<PWM_LEVEL_CNT
;PWM CIRCLE END;-> next level/Table data
;------------------------ PWM speed
	DEC	R_LED_PATT_DIV
	LDA	R_LED_PATT_DIV
	BEQ	L_PWMS_SOLVE_SUB_S10

;	
	PHY
	JMP	L_PWM_SOLVE_W_DLY

L_PWMS_SOLVE_SUB_S10:
	LDA	R_LED_PATT_DIV_BUF
	STA	R_LED_PATT_DIV
	
	INC	<LED_TBL_PT
	
	JMP	LOAD_PWMS_PATT
L_PWM_SOLVE_SUB_END:
	RTS
L_PWM_SOLVE_S100:
	LDA	<PWM_LEVEL_CNT
	CMP	<PWM0_LEVEL
	BNE	L_PWM_SOLVE_S110
	M_PWM0_OFF
L_PWM_SOLVE_S110:
.IF ( C_PWMS_MAX .GT. 1 )
	LDA	<PWM_LEVEL_CNT
	CMP	<PWM1_LEVEL
	BNE	L_PWM_SOLVE_S120
	M_PWM1_OFF
L_PWM_SOLVE_S120
.ENDIF
.IF ( C_PWMS_MAX .GT. 2 )
	LDA	<PWM_LEVEL_CNT
	CMP	<PWM2_LEVEL
	BNE	L_PWM_SOLVE_S130
	M_PWM2_OFF
L_PWM_SOLVE_S130:
.ENDIF
.IF ( C_PWMS_MAX .GT. 3 )
	LDA	<PWM_LEVEL_CNT
	CMP	<PWM3_LEVEL
	BNE	L_PWM_SOLVE_S140
	M_PWM3_OFF
L_PWM_SOLVE_S140:
.ENDIF
	RTS
;
;=================================================
;要做PWM的渐亮灭，
;色度为16级以上才平滑。
;500Us作为一个计数
;为不闪，频率应在64以上




