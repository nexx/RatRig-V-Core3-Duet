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
M569 P0.2 S0														; Drive 2 (Z1) goes backwards
M569 P0.3 S0														; Drive 3 (Z2) goes backwards
M569 P0.4 S0														; Drive 4 (Z3) goes backwards
M569 P0.5 S0														; Drive 5 (E0) goes forwards
M584 X0.0 Y0.1 Z0.2:0.3:0.4 E0.5									; Driver 0=X, 1=Y, 2/3/4=Z, 5=E0
M92 X160 Y160 Z400 E830												; Set steps/mm
M350 X16 Y16 Z16 E16 I1												; Configure micro-stepping with interpolation for all drives
M203 X18000 Y18000 Z800 E3600										; Set maximum speeds (mm/min)
M201 X500 Y500 Z100 E10000											; Set accelerations (mm/s^2)
M566 X600 Y600 Z6 E1200												; Set maximum instantaneous speed changes (mm/min)
M906 X1800 Y1800 Z1200 E700 I50										; Set motor currents (mA) and motor idle factor in per cent
M84 S60																; Set idle timeout

; Axis Limits
M208 X-11.4 Y-4.3 Z0 S1												; Set axes minima
M208 X313.2 Y299.5 Z300 S0											; Set axes maxima

; Endstops
M574 X1 S1 P"io1.in"												; Use an endstop on X, stop at low end
M574 Y2 S1 P"io2.in"												; Use an endstop on Y, stop at high end

; BLTouch Z-Probe
M574 Z1 S2															; Define Z endstop as a probe
M950 S0 C"io7.out"													; Create a servo pin on io7
M558 P9 C"io7.in" H5.0 F240 T18000 A5								; Set Z-Probe to type 9 for BLTouch, 5mm dive at 4mm/s 5 attempts

G31 P25 X-29.75 Y-13.50 Z0.70										; Set Z probe trigger value, nozzle offsets, and trigger height
M557 X5:280 Y5:285 P10												; Define a 10x10 bed mesh

; Heaters
M308 S0 P"temp0" Y"thermistor" T100000 B3950 C0						; Define Sensor0 as the heated bed temperature
M950 H0 C"out0" T0													; Define Heater0 as the heated bed, bind to Sensor0
M140 H0 P0															; Define Heated Bed
M307 H0 A256.0 C287.0 D2.7 S1.00 V24.0 B0							; PID Tuning for Heater0, Heated Bed (45C)
M143 H0 S120														; Set temperature limit for Heater0 to 120C

M308 S1 P"temp1" Y"thermistor" T500000 B4723 C1.19622e-7			; Define Sensor1 as Extruder0 temperature (Slice Engineering Thermistor)
M950 H1 C"out1" T1													; Define Heater1 as Extruder0 heater, bind to Sensor1
M307 H1 A416.0 C138.0 D2.8 S1.00 V23.9 B0							; PID Tuning for Heater1, Extruder0 (200C)
M143 H1 S285														; Set temperature limit for heater 1 to 285C
M308 S2 Y"mcu-temp" A"MCU"											; Define Sensor3 as the integrated MCU temperature sensor
M308 S3 Y"drivers" A"TMC Drivers"									; Define Sensor4 as the TMC overheat sensor

; Fans
M950 F0 C"out4" Q500												; Define Fan0 for T0 Part Cooling
M106 P0 S0 L1 H-1 C"Part Cooling"									; Set Fan0 to default off, manual control (Min PWM=100%)
M950 F1 C"out5"	Q500												; Define Fan1 for T0 Hotend cooling
M106 P1 H1 T45														; Set Fan1 to Thermostatic control, max RPM at 45C
M950 F7 C"out7"	Q500												; Define Fan7 for Electronics Cooling (12v DC 40x40x20mm)
M106 P7 H2 T15														; Set Fan7 to Thermostatic control, max RPM at 15C
M950 F8 C"out8"	Q500												; Define Fan8 for Electronics Cooling (12v DC 40x40x20mm)
M106 P8 H2 T15														; Set Fan8 to Thermostatic control, max RPM at 15C

; Tools
M563 P0 D0 H1 F0													; Tool0 uses Extruder0, Heater1 and Fan0
G10 P0 X0 Y0 Z0 R0 S0												; Set Tool0 axis offsets and temperatures

; Additional Settings
M671 X-12.5:150:312.5 Y-12.50:312.5:-12.5 S10.0						; Define Z-axis leadscrew positions for G32
M404 N1.75															; Define filament diameter for print monitor
T0																	; Activate T0 by default
