
;: IDX
;IN: A
;not use REG_HL,REG_EA
;
BK0_PLAY_EQU_ACTION:
	
	AND	#0FH
	ASL	A
	TAX

	JMP	(BK0_PLAY_EQU_ACTION_TBL,X)
BK0_PLAY_EQU_ACTION_TBL:
	DW	BK0_PLAY_EQU_ACTION_0 ;default: nop
	DW	BK0_PLAY_EQU_ACTION_1
	DW	BK0_PLAY_EQU_ACTION_4
	DW	BK0_PLAY_EQU_ACTION_5
	DW	BK0_PLAY_EQU_ACTION_4
	DW	BK0_PLAY_EQU_ACTION_5
	DW	BK0_PLAY_EQU_ACTION_6; 6:NOP
	
	
BK0_PLAY_EQU_ACTION_0: ; EXT
	
	JMP	BK0_PLAY_EQU_ACTION_RET

BK0_PLAY_EQU_ACTION_1: ; PEE
	

	JMP	BK0_PLAY_EQU_ACTION_RET
	
BK0_PLAY_EQU_ACTION_4:

	JMP	BK0_PLAY_EQU_ACTION_RET

BK0_PLAY_EQU_ACTION_5:

	JMP	BK0_PLAY_EQU_ACTION_RET
	
BK0_PLAY_EQU_ACTION_6:; 

	JMP	BK0_PLAY_EQU_ACTION_RET
;=======================================
;: IDX
;IN: A
BK0_PLAY_EQU_DELAY_IDX_USER:
	
	AND	#07FH
	ASL	A
	TAX

	JMP	(BK0_PLAY_EQU_DELAY_IDX_USER_TBL,X)
	
BK0_PLAY_EQU_DELAY_IDX_USER_TBL:
	DW	BK0_PLAY_EQU_DELAY_IDX_USER_0
	DW	BK0_PLAY_EQU_DELAY_IDX_USER_1
	DW	BK0_PLAY_EQU_DELAY_IDX_USER_2
	DW	BK0_PLAY_EQU_DELAY_IDX_USER_3


BK0_PLAY_EQU_DELAY_IDX_USER_0:
	MR_SET_EQU_DLYCNT T000504MS
	JMP	BK0_PLAY_EQU_DELAY_IDX_USER_RET
	
BK0_PLAY_EQU_DELAY_IDX_USER_1:
	MR_SET_EQU_DLYCNT T001000MS
	JMP	BK0_PLAY_EQU_DELAY_IDX_USER_RET

BK0_PLAY_EQU_DELAY_IDX_USER_2:
	MR_SET_EQU_DLYCNT T000504MS
	JMP	BK0_PLAY_EQU_DELAY_IDX_USER_RET

BK0_PLAY_EQU_DELAY_IDX_USER_3:
	MR_SET_EQU_DLYCNT T000504MS
	JMP	BK0_PLAY_EQU_DELAY_IDX_USER_RET


