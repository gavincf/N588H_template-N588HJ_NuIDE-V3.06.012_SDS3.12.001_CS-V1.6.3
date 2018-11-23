



;--------------------------------


; ----- CHECK KEY
WB_MKEYCH_CODE		DS	C_MKEYCH_MAX


;====================================================
;	USER IO configure
;====================================================
;--------------------------------
;	output port
;-------------------------------
;ROW
C_KEY_MATRIX_ROW_CNT0	EQU	3

R_ROW_PORT0		EQU	R_BP2
SR_ROW_PORT0		EQU	BP2
SR_ROW_PORT0_MODE		EQU	BP2D
C_ROW_PORT0_MASK_INV		EQU	10001111B

C_ROW_PORT1_ENABLE EQU	0 ; matrix第二组输出口PORT
.IF (C_ROW_PORT1_ENABLE .EQ. 1)
R_ROW_PORT1		EQU	R_BP0
SR_ROW_PORT1		EQU	BP0
SR_ROW_PORT1_MODE		EQU	BP0D
C_ROW_PORT1_MASK_INV	EQU	10111111B
.ENDIF

;--------------------------------
;	input port
;--------------------------------
;1st line port
SR_MATRIX_IP0_PORT	EQU	BP1
C_MATRIX_IP0_DIR		EQU	0 ;check bit order：0:low to high，1: high to low
C_MATRIX_IP0_MASK	EQU	00000111B
C_MATRIX_IP0_BIT_ST		EQU	C_BIT0
C_MATRIX_IP0_BIT_END 	EQU C_BIT2 ; last bit in port line

;2nd line port
C_MATRIX_IP1_EN		EQU	0 ;2nd input port
;
C_MATRIX_IP1_DIR	EQU	0 ;check bit order：0:low to high，1: high to low
SR_MATRIX_IP1_PORT	EQU	BP1
C_MATRIX_IP1_MASK	EQU	11111111B
C_MATRIX_IP1_BIT_ST		EQU	C_BIT2
C_MATRIX_IP1_BIT_END 	EQU C_BIT5; last bit in port line


;====================================================
;	SETTTING  END
;====================================================


;-----------------------------
WB_KEYCODE			DS	1

.IF (C_SCANKEY_4CH_LP .EQ. 1)
ROW_SCAN_PT		DS	1
BIT_SCAN				DS	1
.ENDIF

.IF (C_SCANKEY_4CH_LN .EQ. 1)
BIT_SCAN_ST				DS	1
BIT_SCAN_END				DS	1
.ENDIF

WB_KEY_FLAG			DS	1
;.0,.4 : KEYCH GET KEY FLAG, 	HOLD KEY FLAG
;.1,.5 : KEYCH+1 GET KEY FLAG,HOLD KEY FLAG
;WB_KEY_FLAG1		DS	1
;------------------------------.0=0/1:KEY WHITE KEY CONTROL LED OFF/ON
;.4=0/1:KEYCH0 KEY-NOTE CONTROL OFF/ON
;.5=0/1:KEYCH1 KEY-NOTE CONTROL OFF/ON
WB_KEYDLY				DS	2
;+0 : .3:.0: KEYCH0
;+0 : .7:.4: KEYCH1
;+1 : .3:.0: KEYCH2
;+1 : .7:.4: KEYCH3

MATRIX_IP_0			DS	1

.IF ( C_CHKMKEY_GND_AS_OP .EQ. 1 )
MATRIX_IP_0_GND	DS	1
.ENDIF

.IF ( C_MKEYCH_MAX_REVISE .EQ. 1 )
R_MKEYCH_MAX		DS	1
.ENDIF



M_SHARE_RAM01	DS	1




