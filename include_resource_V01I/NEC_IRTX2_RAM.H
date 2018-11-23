;

;C_IRRX_DLYCNT_MAX	.EQU	32

;======================================================================
; RAM define
;======================================================================
;


IRTX_PT		DS	1
IRTX_FLAG	DS	1
;.7=0/1: disable/enable IRTX
;.3-0: data update times 
	
IRTX_DATA	DS	1
IRTX_DATA1	DS	1
; DATA 从高到低： 方便接收
IRTX_DATA_CNT DS	1
IRTX_DATA_BUF	DS	1
IRTX_DATA_BUF1	DS	1

IRTX_DOWN_DLYCNT	DS	1 ;count the dlycnt
;COUNTER

IRTX_DLYCNT	DS	1
IRTX_CNT		DS	1
;=0->1
