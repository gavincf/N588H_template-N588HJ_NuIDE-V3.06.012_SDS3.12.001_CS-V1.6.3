;=======================================
;	<< PROJ_CONST.H >>
;===========================================
;	IO�� ����
;=========================================
;�ϵ�״̬
;==================================================
;IO configure:

.IF ( C_BP0_ULTRAIO_EN .EQ. 1 )
C_PWON_BP0D		EQU	00000000B
C_PWON_BP0M_BAK	EQU	00000000B ; 1: input:pullhigh / 0:output / Floating
C_PWON_BP0_OP	EQU	11111111B
	
.ELSE
C_PWON_BP0D		EQU	00000000B
C_PWON_R_BP0	EQU	11111111B;1: input:pullhigh / output: CMOS
.ENDIF

.IF ( C_BP1_ULTRAIO_EN .EQ. 1 )
	
C_PWON_BP1D		EQU	11111111B
C_PWON_BP1M_BAK	EQU	11111111B; 1: input:pullhigh / 0:output / Floating
C_PWON_BP1_OP	EQU	11111111B
.ELSE
C_PWON_BP1D		EQU	11111111B
C_PWON_R_BP1	EQU	11111111B;1: input:pullhigh ; BP10 input floating
.ENDIF

.IF ( C_BP2_ULTRAIO_EN .EQ. 1 )
	
C_PWON_BP2D		EQU	11B;BP2D[0], and BP24~BP27 by BP2D[1]
C_PWON_BP2M_BAK	EQU	11111111B; 1: input:pullhigh / 0:output / Floating
C_PWON_BP1_OP	EQU	11111111B
.ELSE
C_PWON_BP2D		EQU	11B;BP2D[0], and BP24~BP27 by BP2D[1]
C_PWON_R_BP2	EQU	11111111B;1: input:pullhigh
.ENDIF

;=============================================
;����״̬��
.IF ( C_BP0_ULTRAIO_EN .EQ. 1 )
C_WAKEUP_BP0D		EQU	00000000B
C_WAKEUP_BP0M_BAK	EQU	00000000B ; 1: input:pullhigh / 0:output / Floating
C_WAKEUP_BP0_OP	EQU	11111111B

C_WAKEUP1_BP0D		EQU	C_WAKEUP_BP0D
C_WAKEUP1_BP0M_BAK	EQU	C_WAKEUP_BP0M_BAK
C_WAKEUP1_BP0_OP	EQU	C_WAKEUP_BP0_OP
	
.ELSE
C_WAKEUP_BP0D		EQU	00000000B
C_WAKEUP_R_BP0	EQU	11111111B;1: input:pullhigh / output: CMOS
	
C_WAKEUP1_BP0D		EQU	C_WAKEUP_BP0D
C_WAKEUP1_R_BP0	EQU	C_WAKEUP_R_BP0;1: input:pullhigh / output: CMOS
.ENDIF

.IF ( C_BP1_ULTRAIO_EN .EQ. 1 )
	
C_WAKEUP_BP1D		EQU	11111111B
C_WAKEUP_BP1M_BAK	EQU	11111111B; 1: input:pullhigh / 0:output / Floating
C_WAKEUP_BP1_OP	EQU	11111111B

C_WAKEUP1_BP1D		EQU	C_WAKEUP_BP1D
C_WAKEUP1_BP1M_BAK	EQU	C_WAKEUP_BP1M_BAK
C_WAKEUP1_BP1_OP	EQU	C_WAKEUP_BP1_OP

.ELSE
C_WAKEUP_BP1D		EQU	11111111B
C_WAKEUP_R_BP1	EQU	11111111B;1: input:pullhigh ; BP10 input floating
	
C_WAKEUP1_BP1D		EQU	C_WAKEUP_BP1D
C_WAKEUP1_R_BP1	EQU	C_WAKEUP_R_BP1 ;input:pullhigh;float
.ENDIF

.IF ( C_BP2_ULTRAIO_EN .EQ. 1 )
	
C_WAKEUP_BP2D		EQU	11B;BP2D[0], and BP24~BP27 by BP2D[1]
C_WAKEUP_BP2M_BAK	EQU	11111111B; 1: input:pullhigh / 0:output / Floating
C_WAKEUP_BP1_OP	EQU	11111111B

C_WAKEUP1_BP2D		EQU	C_WAKEUP_BP2D;BP2D[0], and BP24~BP27 by BP2D[1]
C_WAKEUP1_BP2M_BAK	EQU	C_WAKEUP_BP2M_BAK; 1: input:pullhigh / 0:output / Floating
C_WAKEUP1_BP1_OP	EQU	C_WAKEUP_BP1_OP

.ELSE
C_WAKEUP_BP2D		EQU	11B;BP2D[0], and BP24~BP27 by BP2D[1]
C_WAKEUP_R_BP2	EQU	11111111B;1: input:pullhigh
	
C_WAKEUP1_BP2D		EQU	C_WAKEUP_BP2D;BP2D[0], and BP24~BP27 by BP2D[1]
C_WAKEUP1_R_BP2	EQU	C_WAKEUP_R_BP2;1: input:pullhigh
.ENDIF
;

;
;=========================================
;����״̬��
.IF ( C_BP0_ULTRAIO_EN .EQ. 1 )
C_PWOFF_BP0D		EQU	00000000B
C_PWOFF_BP0M_BAK	EQU	00000000B ; 1: input:pullhigh / 0:output / Floating
C_PWOFF_BP0_OP	EQU	11111111B
.ELSE
C_PWOFF_BP0D	EQU	00000000B
C_PWOFF_R_BP0	EQU	11111111B ; 
.ENDIF

.IF ( C_BP1_ULTRAIO_EN .EQ. 1 )
C_PWOFF_BP1D		EQU	00000000B
C_PWOFF_BP1M_BAK	EQU	00000000B ; 1: input:pullhigh / 0:output / Floating
C_PWOFF_BP1_OP	EQU	11111111B
.ELSE
C_PWOFF_BP1D		EQU	11111111B;ֻ��BP1���ܻ���
C_PWOFF_R_BP1	EQU	11111111B ;
.ENDIF

.IF ( C_BP2_ULTRAIO_EN .EQ. 1 )
C_PWOFF_BP2D		EQU	00000000B
C_PWOFF_BP2M_BAK	EQU	00000000B ; 1: input:pullhigh / 0:output / Floating
C_PWOFF_BP2_OP	EQU	11111111B
.ELSE
C_PWOFF_BP2D	EQU	11B;BP2D[0], BP20~BP23 by BP2D[0] and BP24~BP27 by BP2D[1]
C_PWOFF_R_BP2	EQU	11111111B;1: input:pullhigh
.ENDIF

; For 'BK0_STORE_BPX_WO_BOND'
C_BP0_BOND EQU	00000000B
C_BP1_BOND EQU	00000000B
C_BP2_BOND EQU	00000000B

;================================
;����������wakeup enable
C_BP1EN_PWOFF	EQU	00000011B

;==========================================

