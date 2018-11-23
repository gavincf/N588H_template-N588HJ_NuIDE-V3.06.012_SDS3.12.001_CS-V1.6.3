;



MR_IR_ON .MACRO
	LDA	#C_BIT7
	TRB	R_BP0
	LDA R_BP0
	STA	BP0
	LDA	#C_BIT7
	TSB	BP0C
	.ENDM

MR_IR_OFF .MACRO
	LDA	#C_BIT7
	TRB	BP0C

	.ENDM






; //放在中断或定时到处理的宏
;0.625ms interrup service
;in interrupt: get exact wave time
;in main loop: not exact wave time
;===========================================
MR_IR_SOLVE MACRO
	LDA	IRTX_FLAG
	BIT	#C_BIT7
	BEQ	BKX_TIMERPS_ISR_S100
	
	DEC	IRTX_DOWN_DLYCNT
	LDA	IRTX_DOWN_DLYCNT
	BNE	BKX_TIMERPS_ISR_S100
	
	PHX
	PHY
;	JSR	BKX_IRTX_SET
	JSR	BKX_IRTX_SEND
	PLY
	PLX

BKX_TIMERPS_ISR_S100:
	ENDM

