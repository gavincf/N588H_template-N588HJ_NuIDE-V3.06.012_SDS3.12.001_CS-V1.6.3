
;==============================
;=================================
;	检查单独拉线的按键
;=================================
;
.IF ( C_CMPA_EN .EQ. 1)
CHK_STS0_F:; 
;	MR_SET_AUTOCNT2

;	MACRO_SET_DLYCNT0 T000504MS
;	MACRO_SET_DLYCNT1 CNT_STOP
	
	JMP	CHK_STS0_F_RET
CHK_STS0_R:
;	MR_SET_AUTOCNT2

;	MACRO_SET_DLYCNT1 T000104MS
;	MACRO_SET_DLYCNT0 CNT_STOP

	JMP	CHK_STS0_R_RET
.ENDIF




