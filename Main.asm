	CHIP		N588

	INCLUDE		PGM_HEAD_N588H.INI

	EXTERN		FXF_ISR_DELAY_COUNT_DEFAULT
	EXTERN		STOP_TM_FXF_PROC
	EXTERN		INIT_TM_FXF_PROC

	EXTERN		VC_TMV_TABLE
	EXTERN		VC_TMC_TABLE

.ifdef	FW_PWM_TIMER_FXF10
	EXTERN		FW_PWM_TIMER_DOWNCOUNT
	PUBLIC		FW_TIMER_DWONCOUNT_RET
.endif
.ifdef	FW_PWM_TIMER_TM0
	EXTERN		FW_PWM_TIMER_DOWNCOUNT
	PUBLIC		FW_TIMER_DWONCOUNT_RET
.endif
.ifdef	FW_PWM_TIMER_TM1
	EXTERN		FW_PWM_TIMER_DOWNCOUNT
	PUBLIC		FW_TIMER_DWONCOUNT_RET
.endif
.ifdef	FW_PWM_TIMER_TMG0
	EXTERN		FW_PWM_TIMER_DOWNCOUNT
	PUBLIC		FW_TIMER_DWONCOUNT_RET
.endif
.ifdef	FW_BAM_TIMER
	EXTERN		UIO_TIMER_INT
	EXTERN		UIO_BIT_COUNT
	EXTERN		UIO_TIMER_CH_FLAG
	EXTERN		IEF0_BAK
	EXTERN		IEF0_FLAG
.endif

	PUBLIC		QUIT_LIB_ISR
;==========================================================================
; Initial For Main.asm Macro
;--------------------------------------------------------------------------


;==========================================================================
;	DECLARE VARIABLES INSIDE THIS SECTION
;	EXAMPLE => VAR1	DS	3
;		   VAR2	DS	1
;==========================================================================
	USER_RAM: SECTION             
	INCLUDE ALL_CONST_FILES.H
	INCLUDE ALL_RAM_FILES.H
R_USER_STACK_ST	DS	0
	INCLUDE ALL_MR_FILES.H
	;-----------------------
	; User s RAM for Program
	;-----------------------




	ENDS
	
.IF	(WITH_RAM_OVER_STACK .EQ. 1)
	USER_RAM_AFTER_RESERVED: SECTION

	ENDS
.ENDIF

;=======================================================================
;	WRITE PROGRAM CODES & TABLES INSIDE THIS SECTION
;==========================================================================
	CODE: SECTION


;==================================================
FXF15_ISR:
;*********   pls insert your FXF15 USER ISR  **********

	LDA #INT0_FXF15
	STA !EFC0					;CLEAR EVF OF FXF15
	ENABLE_BAM_INT_EXCEPT				;User can insert program from here

	MR_SET_GAPTIME_FLAG

	QUIT_ENABLE_BAM_INT_EXCEPT
	PLA
	RTI
;==================================================
FXF10_ISR:
	LDA #INT0_FXF10
	STA !EFC0					;CLEAR EVF OF FXF10
	ENABLE_BAM_INT_EXCEPT		;User can insert program from here
	
.ifdef	FW_PWM_TIMER_FXF10
	JMP FW_PWM_TIMER_DOWNCOUNT
FW_TIMER_DWONCOUNT_RET:	
.endif

	QUIT_ENABLE_BAM_INT_EXCEPT
	PLA
	RTI	
;=================================================================
;PORT ISR
;==================================================================
PORT_ISR:
	PHA
	LDA #INT0_PORT
	STA !EFC0
	ENABLE_BAM_INT_EXCEPT			;User can insert program from here
	
	QUIT_ENABLE_BAM_INT_EXCEPT
	PLA
	RTI	
;***************************************************************
; INTERRUPT SERVICE ROUTINES
;***************************************************************
IRQ_ISR:
	PHA

	LDA !IEF0
	AND !EVF0

 	BIT #INT0_FXF13
	BNE FXF13_ISR
	
	BIT #INT0_FXF15
	BEQ 3
	JMP FXF15_ISR
	
	BIT #INT0_FXF10
	BEQ 3
	JMP FXF10_ISR

PLA_RTI:    
	PLA
    	RTI

;===============================================================
;  SR_NAME: FXF13_ISR				;FXF13_ISR FOR MELODY
;  INPUT  : MS_DATA_ADDR			;OUTPUT : SP0AT, SP0BT
;===============================================================
FXF13_ISR:
	LDA #INT0_FXF13
	STA !EFC0     					;CLEAR EVF OF FXF13
	
.IF ((WITH_MS .EQ. 0)&&(WITH_EVO .EQ. 0))
	ENABLE_BAM_INT_EXCEPT
.ENDIF
	
	.IF(WITH_MS .EQ. 1).OR.(WITH_EVO .EQ. 1)
		PHX
		PHY
		
		STORE_SW_CS		
		LDA !BANK
		PHA
		
		.IF	 (PARTNO='N588H000')	
		    	LDA !IEF1			;DISABLE FXF15
			PHA
		    	STZ !IEF1
		.ENDIF
		    	
	    	LDA !IEF0
		PHA
		AND #(INT0_TM0+INT0_TM1+INT0_TMG0)	;KEEP TMG0/G1/0/1 INTERRUPT ONLY
		STA !IEF0 
	    					
		CLI					;ENABLE INTERRUPT
	
		FXF13_ISR_PROC
;-------------------------------------------------------------------------
		PUBLIC		QUIT_LIB_FXF_ISR
QUIT_LIB_FXF_ISR:
		SEI
		
		PLA
		AND #FFH^(INT0_TM0+INT0_TM1+INT0_TMG0)
		ORA !IEF0
		STA !IEF0

		QUIT_LIB_FXF_ISR_CONT
		
QUIT_LIB_FXF_ISR_END:
		.IF	 (PARTNO='N588H000')	
		PLA					;RESTORE FXF15
		STA !IEF1
		.ENDIF
	
		PLA
		STA !BANK
		RELOAD_SW_CS
		PLY
		PLX
	.ENDIF 
	
.IF ((WITH_MS .EQ. 0)&&(WITH_EVO .EQ. 0))
	QUIT_ENABLE_BAM_INT_EXCEPT
.ENDIF
	PLA 
	RTI

;===============================================================
;  SR_NAME: TIMERG1_ISR			;
;===============================================================
.IF	 (PARTNO='N588H000')	
TMG1_ISR:
	PHA
	LDA #INT0_TMG1
	STA !EFC0							;CLEAR EVF OF TIMERG1
									;User can insert program from here
	PLA
	RTI
.ENDIF 
;===============================================================
;  SR_NAME: TIMERG0_ISR			;
;  INPUT  : ISR0_NEXT_SYNTH_START	;OUTPUT : SP0CLT, SP0CT
;===============================================================
TMG0_ISR:
;*********   pls insert your TMG0 USER ISR  **********

LIB_VS0_ISR:
LIB_VS0A_ISR:
	PHA
	LDA #INT0_TMG0
	STA !EFC0				;CLEAR EVF OF TIMERG
;SET 2MS FLAGd

	MR_SET_TMG0_GAP_FLAG

.ifdef	FW_BAM_TIMER	
.ifndef	FW_PWM_TIMER_TMG0	
	ENABLE_BAM_INT_EXCEPT
.endif
.ifdef	FW_PWM_TIMER_TMG0	
	ENABLE_SPEECH_INT_EXCEPT
.endif
.endif
	
.IF(WITH_FW_CAP_SENSOR_KEYS .GT. 0)
    CAP_TMG_OVER
.ENDIF 

.ifdef	FW_PWM_TIMER_TMG0
	JMP FW_PWM_TIMER_DOWNCOUNT
FW_TIMER_DWONCOUNT_RET:
.endif  	
	
.IF (WITH_VS0A .EQ. 1H)
	PHX
	PHY

	STORE_SW_CS
	LDA !BANK
	PHA

	JMP_CH1_ISR_ACTION
.ENDIF 
	
	QUIT_ENABLE_BAM_INT_EXCEPT
	PLA
	RTI
;===============================================================
;  SR_NAME: TIMER0_ISR			;
;  INPUT  : ISR1_NEXT_SYNTH_START	;OUTPUT : SP0ALT, SP0AT
;===============================================================
TM0_ISR:
LIB_VS1_ISR:
LIB_VS1A_ISR:
	PHA
	LDA #INT0_TM0
	STA !EFC0			;CLEAR EVF OF TIMERG

.ifdef	FW_BAM_TIMER	
.ifndef	FW_PWM_TIMER_TM0	
	ENABLE_BAM_INT_EXCEPT
.endif
.ifdef	FW_PWM_TIMER_TM0	
	ENABLE_SPEECH_INT_EXCEPT
.endif
.endif
	
.ifdef	FW_PWM_TIMER_TM0
	JMP FW_PWM_TIMER_DOWNCOUNT
FW_TIMER_DWONCOUNT_RET:
.endif
	
.IF (WITH_VS1A .EQ. 1H)	
	PHX
	PHY
	
	STORE_SW_CS
	LDA !BANK
	PHA

	JMP_CH2_ISR_ACTION
.ENDIF 

	QUIT_ENABLE_BAM_INT_EXCEPT
	PLA
	RTI
;===============================================================
;  SR_NAME: TIMER2_ISR			;
;  INPUT  : ISR2_NEXT_SYNTH_START	;OUTPUT : SP0BLT, SP0BT
;===============================================================
TM1_ISR:
LIB_VS2_ISR:
LIB_VS2A_ISR:
	PHA
	LDA #INT0_TM1
	STA !EFC0     			;CLEAR EVF OF TIMER1
	
.ifdef	FW_BAM_TIMER	
.ifndef	FW_PWM_TIMER_TM1	
	ENABLE_BAM_INT_EXCEPT
.endif
.ifdef	FW_PWM_TIMER_TM1	
	ENABLE_SPEECH_INT_EXCEPT
.endif
.endif

.ifdef	FW_PWM_TIMER_TM1
	JMP FW_PWM_TIMER_DOWNCOUNT
FW_TIMER_DWONCOUNT_RET:
.endif

.IF (WITH_VS2A .EQ. 1H)
	PHX
	PHY
	
	STORE_SW_CS
	LDA !BANK
	PHA

	JMP_CH3_ISR_ACTION
.ENDIF 
	
	QUIT_ENABLE_BAM_INT_EXCEPT
	PLA
	RTI
;===============================================================
;  Quit Libary ISR Lable
;===============================================================
QUIT_LIB_ISR:
	PLA
	STA !BANK
	RELOAD_SW_CS
	
	PLY
	PLX
	QUIT_ENABLE_BAM_INT_EXCEPT
	PLA
	RTI
                  
;===============================================
; Main program start here after resetting
;===============================================
MAIN_START:
	SET_STACK_POINTER_TO STACK_END			;USER CAN CHANGE THE VALUE
    SYSTEM_INIT_PROCEDURE				;SYSTEM INITIALIZATION PROCEDURE
	CLEAR_RAM_RANGE RAM_BEGIN,RAM_END			;USER CAN CHANGE THE VALUE
 	CLI
	SPECIAL_REGISTERS_INIT
     .IF(WITH_FW_CAP_SENSOR_KEYS .GT. 0)
        EN_CAP_SENSOR
        ;EXTERN CAP_SENSOR_INIT_API
		;JSR 	CAP_SENSOR_INIT_API
     .ENDIF
;---------------------------SPEECH EQUATION -------------------------------------------------------------------------------
;	PLAY MANSPEAK_MDM<CH=1/2/3,VOL=8,SR=8000>
;		MANSPEAK_MDM is speech file name with MDPCM format
;		CH is speech channel assignment
;		CH: 1->TIMER0  2:TIMER1 3:TIMERG0(for N588H,no tone or speech&midi not play simultaneity)
;		CH: 1->TIMERG0 2:TIMER0 3:TIMER1 (for N588H,has tone when speech&midi play simultaneity)
;		CH: 1->TIMER0			 (for N588J)
;		VOL=4 is volume level(0~8)
;		SR=8000 is sampling rate,
;		if user not assign value to SR then use the default S.R. in speech file
;---------------------------MELODY EQUATION-------------------------------------------------------------------------------
;	PLAY MARCH<CH=MS,VOL=8,TPO=120>
;		March is melody file name with MIDI format 0
;		MS is melody channel assignment
;		VOL=5 is volume level(0~8)
;		TPO=120 is tempo value
;		For N588H:Support midi
;		For N588J:NOT support midi
;		if user not assign value to TPO then use the default tempo in MIDI file
;---------------------------EVO EQUATION ---------------------------------------------------------------------------------
;	PLAY CLAP_1PIN<CH=EVO1/EVO2/EVO3,FORMAT=EVO>
;		CLAP_1PIN is file name with WIO format(speech with event or UIO command)
;		CH is evo channel assignment
;		For N588H:EVO1/EVO2/EVO3
;		For N588J:EVO1
;		if user not assign FORMAT then use the default EVO FORMAT(no audio data,only event and UIO command)
;-------------------------------------------------------------------------------------------------------------------------

	
	JMP	POI_USER
	INCLUDE BK0_ASM_FILES.ASM

;------ original code start ------
MAIN_LOOP:
	LDA #CTL_CPU_WDT
	TSB !CTL_CPU
	
	.IF(WITH_FW_CAP_SENSOR_KEYS .GT. 0)
	    CAP_SENSOR_ACTION    
	    CAP_SENSOR_KEY_DETECTION  
	.ENDIF
	
	.IF (N55P_DEVICE_UIO_USED .GT. 0H)
	    N55P_EXPANDER_PROCESS
	.ENDIF

	JMP	MAIN_LOOP
;============================================;
; CAP SENSOR KEYS LABLE LIST
;============================================;
     PUBLIC     CAP_SENSOR_TOUCHED_KEY1
     PUBLIC     CAP_SENSOR_TOUCHED_KEY2
     PUBLIC     CAP_SENSOR_TOUCHED_KEY3
     PUBLIC     CAP_SENSOR_TOUCHED_KEY4
     PUBLIC     CAP_SENSOR_TOUCHED_KEY5
     PUBLIC     CAP_SENSOR_TOUCHED_KEY6
     PUBLIC     CAP_SENSOR_TOUCHED_KEY7
     PUBLIC     CAP_SENSOR_TOUCHED_KEY8
     PUBLIC     CAP_SENSOR_TOUCHED_KEY9
     PUBLIC     CAP_SENSOR_TOUCHED_KEY10
     PUBLIC     CAP_SENSOR_TOUCHED_KEY11
     PUBLIC     CAP_SENSOR_TOUCHED_KEY12
     PUBLIC     CAP_SENSOR_TOUCHED_KEY13
     PUBLIC     CAP_SENSOR_TOUCHED_KEY14
     PUBLIC     CAP_SENSOR_TOUCHED_KEY15
     PUBLIC     CAP_SENSOR_TOUCHED_KEY16
     PUBLIC     CAP_SENSOR_TOUCHED_KEY17
     PUBLIC     CAP_SENSOR_TOUCHED_KEY18
     PUBLIC     CAP_SENSOR_TOUCHED_KEY19
     PUBLIC     CAP_SENSOR_TOUCHED_KEY20
     PUBLIC     CAP_SENSOR_TOUCHED_KEY21
     PUBLIC     CAP_SENSOR_TOUCHED_KEY22
     PUBLIC     CAP_SENSOR_TOUCHED_KEY23
     PUBLIC     CAP_SENSOR_TOUCHED_KEY24

     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY1
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY2
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY3
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY4
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY5
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY6
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY7
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY8
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY9
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY10
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY11
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY12
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY13
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY14
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY15
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY16
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY17
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY18
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY19
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY20
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY21
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY22
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY23
     PUBLIC     CAP_SENSOR_UNTOUCHED_KEY24
;============================================;
; Touched Key Labels                         ;
;============================================;
CAP_SENSOR_TOUCHED_KEY1:
     RTS

CAP_SENSOR_TOUCHED_KEY2:
     RTS

CAP_SENSOR_TOUCHED_KEY3:
     RTS

CAP_SENSOR_TOUCHED_KEY4:
     RTS

CAP_SENSOR_TOUCHED_KEY5:
     RTS

CAP_SENSOR_TOUCHED_KEY6:
     RTS

CAP_SENSOR_TOUCHED_KEY7:
     RTS

CAP_SENSOR_TOUCHED_KEY8:
     RTS

CAP_SENSOR_TOUCHED_KEY9:
     RTS

CAP_SENSOR_TOUCHED_KEY10:
     RTS

CAP_SENSOR_TOUCHED_KEY11:
     RTS

CAP_SENSOR_TOUCHED_KEY12:
     RTS

CAP_SENSOR_TOUCHED_KEY13:
     RTS

CAP_SENSOR_TOUCHED_KEY14:
     RTS

CAP_SENSOR_TOUCHED_KEY15:
     RTS

CAP_SENSOR_TOUCHED_KEY16:
     RTS

CAP_SENSOR_TOUCHED_KEY17:
     RTS

CAP_SENSOR_TOUCHED_KEY18:
     RTS

CAP_SENSOR_TOUCHED_KEY19:
     RTS

CAP_SENSOR_TOUCHED_KEY20:
     RTS

CAP_SENSOR_TOUCHED_KEY21:
     RTS

CAP_SENSOR_TOUCHED_KEY22:
     RTS

CAP_SENSOR_TOUCHED_KEY23:
     RTS

CAP_SENSOR_TOUCHED_KEY24:
     RTS
;============================================;
; Un-Touched Key Labels                      ;
;============================================;
CAP_SENSOR_UNTOUCHED_KEY1:
     RTS     

CAP_SENSOR_UNTOUCHED_KEY2:
     RTS    

CAP_SENSOR_UNTOUCHED_KEY3:
     RTS     

CAP_SENSOR_UNTOUCHED_KEY4:
     RTS     

CAP_SENSOR_UNTOUCHED_KEY5:
     RTS     

CAP_SENSOR_UNTOUCHED_KEY6:
     RTS     

CAP_SENSOR_UNTOUCHED_KEY7:
     RTS     

CAP_SENSOR_UNTOUCHED_KEY8:
     RTS     

CAP_SENSOR_UNTOUCHED_KEY9:
     RTS     

CAP_SENSOR_UNTOUCHED_KEY10:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY11:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY12:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY13:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY14:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY15:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY16:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY17:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY18:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY19:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY20:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY21:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY22:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY23:     
     RTS     

CAP_SENSOR_UNTOUCHED_KEY24:     
     RTS     

	ENDS
;==========================================================================
;	ASSIGN INTERRUPT VECTORS INSIDE THIS SECTION
;==========================================================================
	VECTOR:	SECTION	
	ORG	098EH
	DW	0900H			;IV OF BRK
	DW	TM0_ISR			;TIMER 0 ISR   ;DO NOT REMOVE
	DW 	TM1_ISR			;TIMER 1 ISR   ;DO NOT REMOVE
	DW 	TMG0_ISR		;TIEMRG 0 ISR  ;DO NOT REMOVE
	.IF	 (PARTNO='N588H000')	
	DW 	TMG1_ISR		;TIMERG 1 ISR 
	.ENDIF
	
	ORG	0998H
	DW	PORT_ISR		;DO NOT REMOVE
	
	ORG 	099CH
	DW	MAIN_START		;IV OF RESET
	DW 	IRQ_ISR			;IV OF IRQ
	ENDS
