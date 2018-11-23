;=======================================
;	<< PROJ_MACRO.ASM >>
;===========================================



MR_DET_MUTE MACRO
	LDA	#1
	ENDM



MR_SET_TM1_05MS MACRO
	LDA	#
	STA	TM1C
	LDA	#
	STA	TM1V
	LDA #INT0_TM1
	TSB !IEF0     			;SET IEF FLAG
	
	
	ENDM

MR_LED1_ON  MACRO
;	SET_PORT_OUTPUT_0 0, 00000001b

	ENDM
MR_LED1_OFF  MACRO
;	SET_PORT_OUTPUT_1 0, 00000001b
	ENDM
