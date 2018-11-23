	CHIP		N588

	INCLUDE		PGM_HEAD_N588H.INI
	
	GLOBAL 		COMMAND_ADDR_TABLE
	GLOBAL		NOTE_ON_CH1_NOTIFY
	GLOBAL		NOTE_OFF_CH1_NOTIFY

;==========================================================================
;	DECLARE VARIABLES INSIDE THIS SECTION
;	EXAMPLE => VAR1	DS	3
;	           VAR2	DS	1
;==========================================================================
	USER_RAM: SECTION
	ORG	0000H

.IF	(WITH_RAM_OVER_STACK .EQ. 1)
	USER_RAM_AFTER_RESERVED: SECTION

	ENDS
.ENDIF

	ENDS

;==========================================================================
;	WRITE COMMAND SUBROUTINE INSIDE THIS SECTION
;	EACH SUBOUTINE SHOULD BE ENDED BY 'RTS'
;==========================================================================
	CODE: SECTION
;==========================================================================
;	MIDI CHANNEL1 NOTE ON/OFF NOTIFY
;==========================================================================
NOTE_ON_CH1_NOTIFY:
NOTE_OFF_CH1_NOTIFY:
	RTS	

CMD00:
CMD01:
CMD02:
CMD03:
CMD04:
CMD05:
CMD06:
CMD07:
CMD08:
CMD09:
CMD10:
CMD11:
CMD12:
	RTS


COMMAND_ADDR_TABLE:
	DW	CMD00
	DW	CMD01
	DW	CMD02
	DW	CMD03
	DW	CMD04
	DW	CMD05
	DW	CMD06
	DW	CMD07
	DW	CMD08
	DW	CMD09
	DW	CMD10
	DW	CMD11
	DW	CMD12

	ENDS
