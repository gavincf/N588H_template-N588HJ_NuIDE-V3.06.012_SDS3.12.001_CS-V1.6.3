
;=============================
;	检测一般的模式开关;
; 每个模式对应一个INPUT IO
; N588H V01
;==================================
;
;
MR_DET_MODE_NO MACRO
	LDA	<R_MODE_FG
	AND	#0FH
	ENDM
