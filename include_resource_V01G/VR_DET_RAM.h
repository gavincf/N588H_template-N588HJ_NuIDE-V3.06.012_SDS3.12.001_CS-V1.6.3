
;100K VR
;+0.22uF
;放电时间discharge:90*0.5ms
;L+R   :
;10+90:25,0C
;20+82:23,0F
;30+68:20,14
;39+62:1D,16
;51+51:19,19



VR_STEP	DS	1
;0:STOP
;1:discharge
;2:LEFT_charge
;3:discharge
;4:right_charge
;5:end

VR_DLYCNT	DS 1
VR_RIGHT_BUF	DS 2
VR_LEFT_BUF	DS 2

VR_LEVEL DS 1
;0-8
