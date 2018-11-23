
;================================================
;
;		LED PWM CONTROL
;单独控制每个PWMLED 的LEVEL。不使用table.更换LEVEL时间同步.
;
;================================================

C_PWMS_MAX EQU	5 ;max: 8

;========================== PWM =================
;>=64HZ,32level,500us/T ; for all pwms
C_MAX_LEVEL	EQU	16


;C_PWMS_TBL1_MAX EQU	256

		
PWM_FLAG	DS	1
;.0=1: PWM0 ENABLE
;.1=1: PWM1 ENABLE
;.2=1: PWM2 ENABLE
;.3=1: PWM3 ENABLE
;.4=1: PWM4 ENABLE

;.7=1: pwm PATT FLAG

PWM_FLAG1	DS	1
;.0=1: PWM0 CIRCLE END
;.1=1: PWM1 CIRCLE END
;.2=1: PWM2 CIRCLE END
;.3=1: PWM3 CIRCLE END
;.4=1: PWM4 CIRCLE END

;.7=1: all pwm PATT end FLAG

PWM_FLAG2	DS	1
;.7=1:check all pwm PATT end
;.0=1: check pwm0 PATT end
;.1=1: check pwm1 PATT end
;.2=1: check pwm2 PATT end
;.3=1: check pwm3 PATT end
;.4=1: check pwm4 PATT end
	
	
PWM_LEVEL	DS	C_PWMS_MAX


PWM_LEVEL_CNT	DS	1; all pwm share 1 cnt 
;LED_TBL_PT	DS	2
;+0: 0-255
P0_TEMP0	DS	2
R_PWMLED_DIV		DS	1
R_PWMLED_DIV_BUF	DS	1

PWM_TBL_IDX	DS	C_PWMS_MAX



;================================
;----  LED PATT  ----------------
;================================
;R_LED_PATT	DS	1



