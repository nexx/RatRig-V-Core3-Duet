; Configuration file for Duet WiFi (firmware version 3.1.1)
; executed by the firmware on start-up

; General preferences
G90																	; Send absolute coordinates...
M83																	; ...but relative extruder moves

; Network
M550 P"VCore3"														; Set machine name
M552 S1	P0.0.0.0													; Enable network and obtain IP via DHCP

; Machine Settings
M669 K1																; Select CoreXY kinematics

; Drives
M569 P0.0 S1														; Drive 0 (CoreXY A) goes forwards
M569 P0.1 S1														; Drive 1 (CoreXY B) goes forwards
M569 P0.2 S1														; Drive 2 (Z1) goes forwards
M569 P0.3 S1														; Drive 3 (Z2) goes forwards
M569 P0.4 S1														; Drive 4 (Z3) goes forwards
M569 P0.5 S0														; Drive 5 (E0) goes backwards
M584 X0.0 Y0.1 Z0.2:0.3:0.4 E0.5									; Driver 0=X, 1=Y, 2/3/4=Z, 5=E0
M92 X80 Y80 Z800 E830												; Set steps/mm
M350 X16 Y16 Z16 I1													; Configure micro-stepping with interpolation for X, Y, and Z
M350 E16 I0															; Configure micro-stepping without interpolation for E
M203 X18000 Y18000 Z6000 E3600										; Set maximum speeds (mm/min)
M201 X1500 Y1500 Z1000 E10000											; Set accelerations (mm/s^2)
M566 X600 Y600 Z60 E1200											; Set maximum instantaneous speed changes (mm/min)
M906 X1800 Y1800 Z1200 E700 I50										; Set motor currents (mA) and motor idle factor in per cent
M84 S60																; Set idle timeout

; Axis Limits
M208 X-11.4 Y-4.3 Z0 S1												; Set axes minima
M208 X313.2 Y299.5 Z340 S0											; Set axes maxima

; Endstops
M574 X1 S1 P"io1.in"												; Use an endstop on X, stop at low end
M574 Y2 S1 P"io2.in"												; Use an endstop on Y, stop at low end

; BLTouch Z-Probe
M574 Z1 S2															; Define Z endstop at a probe
M950 S0 C"io7.out"													; Create a servo pin on io7
M558 P9 C"io7.in" H5.0 F120 T18000 A5								; Set Z-Probe to type 9 for BLTouch mode, 5mm dive at 2mm/s, 5 attempts

G31 P25 X-29.75 Y-13.50 Z1.15										; Set Z probe trigger value, nozzle offsets, and trigger height
M557 X5:280 Y5:285 P4												; Define a 4x4 bed mesh

; Heaters
M308 S0 P"temp0" Y"thermistor" T100000 B3950 C0						; Define Sensor0 as the heated bed temperature
M950 H0 C"out0" T0 Q10												; Define Heater0 as the heated bed, bind to Sensor0
M140 H0 P0															; Define Heated Bed
M307 H0 R1.099 C297.8 D4.67 S0.50 B0								; PID Tuning for Heater0, Heated Bed (85C)
;M307 H0 R0.860 C439.9 D11.80 S1.00 B0							; PID Tuning for Heater0, Heated Bed (45C)
M143 H0 S120														; Set temperature limit for Heater0 to 120C

M308 S1 P"temp1" Y"thermistor" T500000 B4723 C1.19622e-7			; Define Sensor1 as Extruder0 temperature (Slice Engineering Thermistor)
M950 H1 C"out1" T1													; Define Heater1 as Extruder0 heater, bind to Sensor1
;M307 H1 R2.517 C121.8:105.0 D3.66 S1.00 V24.1					; PID Tuning for Heater1, Extruder0 (230C)
M307 H1 R2.794 C119.4:105.8 D3.09 S1.00 V24.1 B0					; PID Tuning for Heater1, Extruder0 (200C)
M143 H1 S285														; Set temperature limit for heater 1 to 285C
;M308 S2 P"temp2" Y"thermistor" A"Chamber" T100000 B4725 C7.060000e-8; Define Sensor2 as Chamber temperature (Semitec 104GT2)
M308 S3 Y"mcu-temp" A"MCU"											; Define Sensor3 as the integrated MCU temperature sensor
M308 S4 Y"drivers" A"TMC Drivers"									; Define Sensor4 as the TMC overheat sensor

; Fans
M950 F0 C"out4" Q20000												; Define Fan0 for T0 Part Cooling
M106 P0 S0 H-1 L1.0 C"Part Cooling"									; Set Fan0 to default off, manual control, minimum PWM=100%
M950 F1 C"out5"	Q500												; Define Fan1 for T0 Hotend cooling
M106 P1 H1 T45														; Set Fan1 to Thermostatic control, max RPM at 45C
M950 F7 C"out7"	Q500												; Define Fan7 for Electronics Cooling (12v DC 40x40x20mm)
M106 P7 H3 T15														; Set Fan7 to Thermostatic control, max RPM at 15C
M950 F8 C"out8"	Q500												; Define Fan8 for Electronics Cooling (12v DC 40x40x20mm)
M106 P8 H3 T15														; Set Fan8 to Thermostatic control, max RPM at 15C

; Tools
M563 P0 D0 H1 F0													; Tool0 uses Extruder0, Heater1 and Fan0
G10 P0 X0 Y0 Z0 R0 S0												; Set Tool0 axis offsets and temperatures

; Additional Settings
M671 X-12.5:312.5:150 Y-12.50:-12.50:312.50 S10.0					; Define Z-axis leadscrew positions for G32
M404 N1.75															; Define filament diameter for print monitor
T0																	; Activate T0 by default
