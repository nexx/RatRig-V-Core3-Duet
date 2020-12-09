; homeall.g
; Called to home all axes
;

; BLTouch preperation
M280 P0 S160														; Precautionary alarm release
M280 P0 S90															; Make sure the pin is raised

; Home X and Y simultaneously
G91																	; Relative positioning
G1 Z10 F6000 H2														; Lift Z relative to current position
G1 X-999 Y999 F4800 H1												; Move X and Y-axes to the endstops and stop (first pass)
G1 X-999 F4800 H1													; Move X-axis to the endstop and stop (first pass)
G1 Y999 F4800 H1													; Move Y-axis to the endstop and stop (first pass)
G1 X5 Y-5 F360														; Go back a few mm
G1 X-999 F360 H1													; Move X-axis to the endstop once more (second pass)
G1 Y999 F360 H1														; Move X-axis to the endstop once more (second pass)
G90																	; Absolute positioning

; Home Z using the Z-Probe
M290 R0 S0															; Reset baby-stepping to 0
G1 X179.75 Y164.50 F4800											; Move T0 to probing point (X150, Y150), including probe offset
G30																	; Probe the bed and set Z to the probe offset
