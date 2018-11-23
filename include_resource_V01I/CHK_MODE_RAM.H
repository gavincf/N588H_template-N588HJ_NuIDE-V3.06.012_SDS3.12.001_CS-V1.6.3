


R_MODE_FG	DS	1
;.7=1:模式更改
;.4=0/1: scan control bit:CHECK MODE PIN 1ST / 2ND TIME

;.3:.0:current mode no
;0 - (C_MAX_MODE -1 )
;0FH:nop mode:invalid
R_MODE_CHK	DS	1
;0 - (C_MAX_MODE -1 )
;.3:.0: currecnt mode checked.
;.7:.4: save 1st mode checked
	

R_CHKMODE_DEB	DS	1




