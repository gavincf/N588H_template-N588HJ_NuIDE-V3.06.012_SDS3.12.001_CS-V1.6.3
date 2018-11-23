;=======================================
;	<< PWMLED_COLOR_RAM.H >>
;===========================================
;PWMLED_COLOR: V02

C_RGB_TABLE_EN  EQU 0
C_3LED_TABLE0_EN  EQU 1


;=================== ram =====================
	
;>=64HZ,32level,500us/T
C_MAX_LEVEL	EQU	16 ;32
C_PWM_SPEED	EQU	256-16 ; UP TO 0

C_T3LED_TABLE0_CNT EQU	175

		
PWM_FLAG	DS	1
;.0=1: PWM0 ENABLE
;.1=1: PWM1 ENABLE
;.2=1: PWM2 ENABLE

;.4=1: PWM0 CIRCLE END
;.5=1: PWM1 CIRCLE END
;.6=1: PWM2 CIRCLE END

PWM0_LEVEL	DS	1
PWM1_LEVEL	DS	1
PWM2_LEVEL	DS	1
PWM_CNT			DS	1
LED_TBL_PT	DS	2
;+0: 0-255
P0_TEMP0		DS	2
PWM_SPEED		DS	1




