
;==========================================
;Module version: V01I;2018/11/12 ����һ ���� 1:45:50
;==========================================
;readme:
;used SPCH1





;============================================
; Configure
;============================================
C_EQU_BUF_EN EQU	0




;============================================
; EQU command:0-7
;============================================

;----------------------------------------
; .7:.4
C_EQU_EVT EQU	80H
;.7 = 0: normal eqution
;.7 = 1: EVT0 trigger next section,
C_EQU_END	EQU	0FFH ;
C_EQU_SOUND EQU	00H
C_EQU_DELAY EQU	10H
C_EQU_DELAY_IDX EQU	20H

;----------------------------------------
;------ EQU action
; .3��.0
;----------------------------------------
C_EQU_PEE 		EQU	01H


