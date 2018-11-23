
;================================================
;
;		LED PWM CONTROL
;
;================================================

C_PWMS_MAX EQU	3




;================================
;----  LED PATT  ----------------
;================================
C_LED_PATT1_IDX		 EQU	0
C_LED_PATT2_IDX    EQU	1



;========================== PWM =================
;>=64HZ,32level,500us/T ; for all pwms
C_MAX_LEVEL	EQU	16


C_PWMS_TBL1_MAX EQU	256

		
PWM_FLAG	DS	1
;.0=1: PWM0 ENABLE
;.1=1: PWM1 ENABLE
;.2=1: PWM2 ENABLE
;.3=1: PWM3 ENABLE

;.4=1: PWM0 CIRCLE END
;.5=1: PWM1 CIRCLE END
;.6=1: PWM2 CIRCLE END
;.7=1: PWM3 CIRCLE END
PWM_FLAG1	DS	1
;.7=1: check pwm PATT end
	
	
PWM0_LEVEL	DS	1
	.IF ( C_PWMS_MAX .GT. 1 )
PWM1_LEVEL	DS	1
	.ENDIF
	.IF ( C_PWMS_MAX .GT. 2 )
PWM2_LEVEL	DS	1
	.ENDIF
	.IF ( C_PWMS_MAX .GT. 3 )
PWM3_LEVEL	DS	1
	.ENDIF

PWM_LEVEL_CNT	DS	1
LED_TBL_PT	DS	2
;+0: 0-255
P0_TEMP0	DS	2


;================================
;----  LED PATT  ----------------
;================================
R_LED_PATT	DS	1
R_LED_PATT_DIV	DS	1
R_LED_PATT_DIV_BUF	DS	1



