; homex.g
; Called to home the X-axis
;

; Home the X-axis
G91																	; Relative positioning
G1 X-999 F4800 H1													; Move X-axis to the endstop and stop (first pass)
G1 X5 F360															; Go back a few mm
G1 X-999 F360 H1													; Move X-axis to the endstop once more (second pass)
G90																	; Absolute positioning
