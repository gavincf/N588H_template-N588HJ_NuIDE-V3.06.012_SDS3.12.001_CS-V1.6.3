

BK0_DIGIT_2_BUF:
	
	JSR	BK0_DIGIT_0_TO_BUF
	JSR	BK0_DIGIT_1_TO_BUF
	JSR	BK0_DIGIT_2_TO_BUF
	JSR	BK0_DIGIT_3_TO_BUF
	
	RTS

BK0_DIGIT_0_TO_BUF:
	LDA	R_DIGIT_0
	AND	#0FH
	TAX
	LDA	T_LED7SEG_TRANS_ND,X
	STA	REG_EA
	LDA	R_LED_BUF+3
	AND	#C_LED_MATRIX_LINE0_ANDV
	ORA	REG_EA
	STA	R_LED_BUF+3
	RTS

BK0_DIGIT_1_TO_BUF:
	LDA	R_DIGIT_1
	AND	#0FH
	TAX
	LDA	T_LED7SEG_TRANS_ND,X
	STA	REG_EA
	LDA	R_LED_BUF+2
	AND	#C_LED_MATRIX_LINE0_ANDV
	ORA	REG_EA
	STA	R_LED_BUF+2
	RTS

BK0_DIGIT_2_TO_BUF:
	LDA	R_DIGIT_2
	AND	#0FH
	TAX
	LDA	T_LED7SEG_TRANS_ND,X
	STA	REG_EA
	LDA	R_LED_BUF+1
	AND	#C_LED_MATRIX_LINE0_ANDV
	ORA	REG_EA
	STA	R_LED_BUF+1
	RTS

BK0_DIGIT_3_TO_BUF:
	LDA	R_DIGIT_3
	AND	#0FH
	TAX
	LDA	T_LED7SEG_TRANS_ND,X
	STA	REG_EA
	LDA	R_LED_BUF+0
	AND	#C_LED_MATRIX_LINE0_ANDV
	ORA	REG_EA
	STA	R_LED_BUF+0
	RTS





;T_LED7SEG_TRANS:
;        DB        0C0H;0
;        DB        0F9H;1
;        DB        0A4H;2
;        DB        0B0H;3
;        DB        099H;4
;        DB        092H;5
;        DB        082H;6
;        DB        0F8H;7
;        DB        080H;8
;        DB        090H;9
;        DB        0BFH;-:A
;      	DB        08CH;P;B
;        DB        0BFH;-:C
;        DB        0BFH;-:D
;        DB        0BFH;-:E
;
;        DB        0FFH; :F ;empty
;T_LED7SEG_TRANS_ND: ; no dot
;        DB        008H;0
;        DB        06BH;1
;        DB        012H;2
;        DB        042H;3
;        DB        061H;4
;        DB        044H;5
;        DB        004H;6
;        DB        0EAH;7
;        DB        000H;8
;        DB        040H;9
;        DB        077H;-
;        DB        09DH;L
;        DB        03FH;-:
;        DB        03FH;-:
;        DB        03FH;-:
;
;        DB        07FH; :F ;empty


;¹²Ñô
;0-a
;1-b
;2-c
;3-d
;4-e
;5-f
;6-g
;7-h
T_LED7SEG_TRANS:
        DB        0C0H;0
        DB        0F9H;1
        DB        0A4H;2
        DB        0B0H;3
        DB        099H;4
        DB        092H;5
        DB        082H;6
        DB        0F8H;7
        DB        080H;8
        DB        090H;9
        DB        08CH;P
        DB        0BFH;-
        DB        0C7H;L
        DB        0FFH;nop
        DB        0FFH;nop
        DB        0FFH;nop
T_LED7SEG_TRANS_ND:
        DB        040H;0
        DB        079H;1
        DB        024H;2
        DB        030H;3
        DB        019H;4
        DB        012H;5
        DB        002H;6
        DB        078H;7
        DB        000H;8
        DB        010H;9
        DB        00CH;P
        DB        03FH;-
        DB        047H;L
        DB        07FH;nop
        DB        07FH;nop
        DB        07FH;nop




