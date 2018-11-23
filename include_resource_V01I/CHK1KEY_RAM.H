



;--------------------------------------
;>>>> 	configure    <<<<
;--------------------------------------
;关于扫描按键通道和扫描状态
;
;关于扫描按键通道:
; 是一个触发状态，有对应的事件处理：
;
;关于扫描状态:
; 更新状态，记录状态，不一定需要处理
;

C_CHK1KEY_MULTIKEY_EN EQU 0
.IF ( C_CHK1KEY_MULTIKEY_EN .EQ. 1)
C_CHK1KEY_MULTI_0 EQU	0
C_CHK1KEY_MULTI_1 EQU	1
	
.ENDIF



C_CHK1KEY_EN1	EQU	0
C_CHK1KEY_EN2		EQU	0


;
;--------------------------------
;	input port
;-------------------------------

;----------------------------------------------
;-----------------------------------------------
;<<<<     fixed     >>>>
;------------------------------------------------
;=========================================
C_CHK1KEY_V_MASK  EQU	03FH
C_KEY_HOLD      EQU	 		80H
C_KEY_HOLD_RELEASE	EQU	 		40H


.IF (C_CHK1KEY_EN1 .EQ. 1) .OR. (C_CHK1KEY_EN2 .EQ. 1)
C_CHK1KEY_LONG0	EQU	03AAH; * 5.33ms, 5000MS; HOLD KEY
C_CHK1KEY_LONG1	EQU	0521H; * 5.33ms, 7000MS; HOLD KEY

;
C_CHK1KEY_LONG0_V0	EQU	0; * 5.33ms, 5000MS; HOLD KEY
;
C_CHK1KEY_LONG1_V0	EQU	1; * 5.33ms, 7000MS; HOLD KEY
;
C_CHK1KEY_DEB		EQU	8 ;* 5.33ms, key press valid debounce ; >=2

;C_CHK1KEY_LONG_MAX EQU C_CHK1KEY_LONG1
C_CHK1KEY_LONG_MAX EQU C_CHK1KEY_DEB ;- NO long key


R_CHK1KEY_DEB		DS	1
R_CHK1KEY_DLYCNT0		DS	2; 1: <1364MS
R_CHK1KEY_PREPRESS DS	1
R_CHK1KEY_PRESS DS	1
.ENDIF
