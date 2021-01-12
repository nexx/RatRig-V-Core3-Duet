; homez.g
; Called to home the Z axis
;

; BLTouch preperation
M280 P0 S160														; Precautionary alarm release
M280 P0 S90															; Ensure the pin is raised

; Home Z using the Z-Probe
M290 R0 S0															; Reset baby-stepping to 0
G91																	; Relative positioning
G1 Z10 F1200 H2														; Lift Z relative to current position
G90																	; Absolute positioning
G1 X179.75 Y163.50 F6000											; Move T0 to probing point (X150, Y150), including probe offset
G30																	; Probe the bed and set Z to the probe offset
