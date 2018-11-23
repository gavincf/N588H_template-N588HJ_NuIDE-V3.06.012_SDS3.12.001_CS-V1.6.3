;
;===============================
;1T:0.625MS/0.25MS=2
;3T:1.875MS/0.25MS=7.5
;10T:6.25MS   / 0.25MS=25
C_DATA0_MIN	.EQU	2
C_DATA0_MAX	.EQU	4
C_DATA1_MIN	.EQU	6
C_DATA1_MAX	.EQU	10

C_HEAD_MIN	.EQU	12
C_HEAD_MAX	.EQU	28

C_BIT_MAX	.EQU	8 ;16

C_IRRX_DLYCNT_MAX EQU	30

;======================================================================
; RAM define
;======================================================================
;

IRRX_PT		DS	1
IRRX_FLAG	DS	1
;.7=1: received data
	
IRRX_DATA	DS	1
;IRRX_DATA1	DS	1

; DATA 从高到低： 方便接收
IRRX_DATA_CNT DS	1
;IRRX_DATA_BUF	DS	1
;IRRX_DATA_BUF1	DS	1
;IRRX_DATA_BUF2	DS	1

IRRX_DLYCNT	DS	1
;counter




