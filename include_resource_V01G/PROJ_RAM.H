;=======================================
;	<< PROJ_RAM.ASM >>
;===========================================


CONST_LED0_ON	EQU	00100000B
CONST_LED1_ON	EQU	00010000B
CONST_LED2_ON	EQU	00110000B
CONST_ALL_LED_ON EQU	00000000B
CONST_ALL_LED_OFF EQU	00110000B


;===========================================
;C_MAX_VOL_IDX	EQU	0A0H
;C_MAX_TPO_IDX	EQU	0AH
;===========================================
;C_DEFAULT_TPO_IDX	EQU	05H
;C_DEFAULT_VOL_IDX	EQU	90H

;===================================
;
C_PWON_MODE	EQU	00H



;VOL_TPO_IDX	DS	1
;.3:.0:TPO LEVEL
;.7:.4:VOL LEVEL


SYS_MODE_NO	DS	1
;.7:.5:SUB MODE
;.4:.0: mode
;SYS_EVENT_CNT DS	1


SPCH1_SOUND_NO	DS	1
SPCH2_SOUND_NO	DS	1



;USER_FLAG20	DS	1
;.7 = 0/1: SPEECH / EQU
;.6 = 0/1: normal eqution / EVT driver equation
;.5 = 0 / 1: CMPB ;detect
;.4 = 0 / 1: CMPA ;detect

;.3=0/1: VOL + / -
;.1=0: 

;.0 = 0/1: POWER OFF /POWER ON

REG_EA		DS	1
REG_HL		DS	1


R_LED_TBL_CNT	DS	1
;0:normal
;1-x: flash led
