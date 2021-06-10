; bed.g
; Called on G32 to tram the gantry to the bed
;
; NOTE: With a 3 point kinematic bed, we specify the pivot points as the
; leadscrew locations. We probe as close as possible to those locations
; and RRF will calculate the corrections.

; Pivot positions:
;   Front Left : X-12.50, Y-12.50
;   Rear Middle: X150.00, Y312.50
;   Front Right: X312.50, Y-12.50
;
; Probe offset:  X-29.75, Y-13.50

M558 H5.0															; Increase BLTouch dive height to 5mm

if !move.axes[0].homed || !move.axes[1].homed
    G28																; Home all axes
else
    G28	Z															; Home the Z-axis
    
G30 P0 X5 Y5 Z-99999												; Probe a 3 points near the kinematic pivots
G30 P1 X280 Y5 Z-99999												; This is the first pass
G30 P2 X150 Y275 Z-99999 S3

M558 H5.0															; Reset BLTouch dive height to 5mm

G28	Z																; Re-home the Z-axis
G30 P0 X5 Y5 Z-99999												; Probe a 3 points near the kinematic pivots
G30 P1 X280 Y5 Z-99999												; This is the first pass
G30 P2 X150 Y275 Z-99999 S3
