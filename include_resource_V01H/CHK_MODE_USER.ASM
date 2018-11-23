
;=============================
;	检测一般的模式开关;
; 每个模式对应一个INPUT IO
; N588H V01
;==================================
;
;
BK0_CHK_MODE_CHG:
	LDA	R_MODE_FG
	AND	#0F0H
	ORA	REG_EA
	STA	R_MODE_FG ;SET NEW MODE
;
;建议设置单独的标志
	MACRO_SET_KEYCH2

	JMP	BK0_CHK_MODE_CHG_RETURN




