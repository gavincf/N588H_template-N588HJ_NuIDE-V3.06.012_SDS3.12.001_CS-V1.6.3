;===================================================
; 2018/8/30 星期四 上午 11:19:58

;===================================================



;; ===========================  NEC_V3
;简化头码
;T = 0.625MS / unit
;RX PART
;；LOW： carrier
;头：10T LOW
;0：1T HIGH, 1T LOW，
;1：3T HIGH, 1T LOW，
;有校验位码
;;-------------------------------
;;NEC_V3
;;简化头码
;;T = 0.625MS / unit
;;TX PART
;;；HIGH： carrier
;;头：10T HIGH
;;0：1T LOW, 1T HIGH，
;;1：3T LOW, 1T HIGH，
;;有校验位码
; --------- DATA 从高到低： 方便接收

;信号位定义： 
;D  07 06 05 04 03 02 01 00
;                          

;IRTX_DATA_BUF: save the data.
;max length: 21.25MS

;--------------------------


BK0_IRTX_INIT:
	LDA	#0FCH
	STA	IRTX_DLYCNT

	MR_IR_OFF
	JSR	BK0_START_TMG0_0625MS
;===========================
;used TM1 For IR carrier: SET 38KHZ	
	LDA	#0011B
	STA	TM1C
	LDA	#19
	STA	TM1V
;--------------- no interrup	
	RTS

BK0_IRTX_STOP:
	
	JMP	BKX_IRTX_END

;-----------------------------------
BK0_DET_IR_SENDING:
	LDA	#C_BIT7
	BIT	IRTX_FLAG
	BNE	BK0_DET_IR_SENDING_S10;BUSY
	LDA	#0
	RTS
	
BK0_DET_IR_SENDING_S10:
	LDA	#1
	RTS
	
	
;===============================
;in: 	IRTX_DATA_BUF[3:0]
;===============================
BK0_IRTX_START_AT:
;set data and checksum
	LDA	IRTX_DATA_BUF
	AND	#0FH
	STA	REG_EA
	
	ASL	IRTX_DATA_BUF
	ASL	IRTX_DATA_BUF
	ASL	IRTX_DATA_BUF
	ASL	IRTX_DATA_BUF
	LDA	IRTX_DATA_BUF
	EOR	#0F0H
	ORA	REG_EA
	STA	IRTX_DATA

	JMP	BK0_IRTX_START_S10

BK0_IRTX_START:

	LDA	#C_BIT7
	BIT	IRTX_FLAG
	BNE	BKX_IRTX_BUSY

BK0_IRTX_START_S10: ; set TX data
	LDA	#C_BIT7
	TRB	IRTX_FLAG ;CLOSE firstly
;
	LDA	IRTX_DATA_BUF
	STA	IRTX_DATA
	
	LDA	#0
	STA	IRTX_PT

	LDA	#C_BIT7
	TSB	IRTX_FLAG; enable TX
		
	JMP	BKX_IRTX_SEND
		
BKX_IRTX_BUSY:; not interrupt
	
	RTS

;------------------------------------

BKX_IRTX_HEAD:
	MR_IR_ON
	LDA	#10
	STA	IRTX_DOWN_DLYCNT
	JMP	BKX_IRTX_NEXT
;
BKX_IRTX_ON:
	MR_IR_ON
	LDA	#1
	STA	IRTX_DOWN_DLYCNT
	JMP	BKX_IRTX_NEXT

BKX_IRTX_SEND:
	LDA	IRTX_PT
	BEQ	BKX_IRTX_HEAD
	CMP	#17
	BEQ	BKX_IRTX_END
	AND	#01H
	BEQ	BKX_IRTX_ON
	JMP	BKX_IRTX_OFF

BKX_IRTX_END:
	MR_IR_OFF
;
	JMP	BKX_IRTX_END_SOLVE
BKX_IRTX_END_SOLVE_RET

	RTS
	
BKX_IRTX_NEXT:
	INC	IRTX_PT
	RTS

;
	
BKX_IRTX_OFF: ; 1/3/5/7/9
	MR_IR_OFF
; CHECK DATA

	LDX	IRTX_PT
	DEX
	LDA	BKX_DATA_BIT_TBL,X
	TAY
	INX
	LDA	BKX_DATA_BIT_TBL,X
	AND	IRTX_DATA,Y
	BNE	BKX_IRTX_OFF_D1
; DATA 0
	LDA	#1
	STA	IRTX_DOWN_DLYCNT
	JMP	BKX_IRTX_NEXT
BKX_IRTX_OFF_D1:
	LDA	#3
	STA	IRTX_DOWN_DLYCNT
	JMP	BKX_IRTX_NEXT
	

BKX_DATA_BIT_TBL:
	DB	0,C_BIT7
	DB	0,C_BIT6
	DB	0,C_BIT5
	DB	0,C_BIT4
	DB	0,C_BIT3
	DB	0,C_BIT2
	DB	0,C_BIT1
	DB	0,C_BIT0

	DB	0,C_BIT0
	

