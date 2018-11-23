
;----------------------------
;group index
;----------------------------
C_GROUP0_IDX	EQU	0
C_GROUP1_IDX	EQU	1
C_GROUP2_IDX	EQU	2
C_GROUP3_IDX	EQU	3
C_GROUP4_IDX	EQU	4
C_GROUP5_IDX	EQU	5

;EMPTY
C_GROUP_CNT	EQU	6 ;group ÊýÁ¿

C_GROUP_IDX_NOP	EQU	C_GROUP_CNT


;----------------------------
;GROUP MAX TABLE
;----------------------------
C_GROUP0_MAX	EQU	6
C_GROUP1_MAX	EQU	11
C_GROUP2_MAX	EQU	10
C_GROUP3_MAX	EQU	5
C_GROUP4_MAX	EQU	8
C_GROUP5_MAX	EQU	10


;----------------------------
;GROUP used RAM
;----------------------------
R_GROUP_NO	DS	1
R_GROUP_BUF	DS	C_GROUP_CNT

R_GROUP_SOUND_BK DS	1 ;for random

; check "GROUP_TABLE.ASM"



