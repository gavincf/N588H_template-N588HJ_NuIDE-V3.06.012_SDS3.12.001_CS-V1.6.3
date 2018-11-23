
;USER_FLAG20 DS	1
;.7 = 0/1: SPEECH / EQU
;.6 = 0/1: normal eqution / EVT driver equation
	
	
EQU_NO	DS	1
EQU_NO_CNT DS	1

.IF ( C_EQU_BUF_EN .EQ. 1 )
EQU_IDX	DS	1
EQU_BUF	DS	16
.ENDIF

EQU_DLYCNT DS	2

R_EQU_NO_BK	DS	1 ;不要和上一个EQU相同

P0_ADDR DS	2
