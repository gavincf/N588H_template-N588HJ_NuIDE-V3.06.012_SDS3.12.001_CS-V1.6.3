

IRRX_RECEIVED_SOLVE:
	
	MACRO_SET_KEYCH1
	
;;===========================================
;	clr the flag after rec data solved
;============================================
;	MR_IRRX_CLR_REC_FLAG
	JMP	IRRX_RECEIVED_SOLVE_RET
	
