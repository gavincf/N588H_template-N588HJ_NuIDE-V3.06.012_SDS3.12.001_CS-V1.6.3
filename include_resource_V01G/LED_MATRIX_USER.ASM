

PCC_WAKEUP_ANYKEY_LED_MATRIX EQU C_TRUE
.IF(PCC_WAKEUP_ANYKEY_LED_MATRIX.EQ.C_FALSE)
	JSR	BK0_LED_MATRIX_RAM_INIT

.ENDIF;PCC_WAKEUP_ANYKEY_LED_MATRIX

