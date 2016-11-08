EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:particle-boards
LIBS:pololu_a4988
LIBS:sensor-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Placa controladora stepper"
Date ""
Rev ""
Comp "Proyecto SOMA"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L PHOTON uC1
U 1 1 5749D94C
P 3150 3950
F 0 "uC1" H 3150 3350 60  0000 C CNN
F 1 "PHOTON" H 3150 4650 60  0000 C CNN
F 2 "particle-boards:PHOTON" H 3150 4050 60  0001 C CNN
F 3 "" H 3150 4050 60  0000 C CNN
	1    3150 3950
	1    0    0    -1  
$EndComp
$Comp
L POLOLU_A4988 MC1
U 1 1 5749D9FB
P 7700 3050
F 0 "MC1" H 7700 3500 60  0000 C CNN
F 1 "POLOLU_A4988" V 7700 3050 50  0000 C CNN
F 2 "polulu_a4988:SWDIP8_.6W" H 7700 3050 60  0001 C CNN
F 3 "" H 7700 3050 60  0000 C CNN
	1    7700 3050
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR01
U 1 1 5749DEFA
P 2150 3100
F 0 "#PWR01" H 2150 2950 50  0001 C CNN
F 1 "+3.3V" H 2150 3240 50  0000 C CNN
F 2 "" H 2150 3100 50  0000 C CNN
F 3 "" H 2150 3100 50  0000 C CNN
	1    2150 3100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 5749DFD8
P 2050 3600
F 0 "#PWR02" H 2050 3350 50  0001 C CNN
F 1 "GND" H 2050 3450 50  0000 C CNN
F 2 "" H 2050 3600 50  0000 C CNN
F 3 "" H 2050 3600 50  0000 C CNN
	1    2050 3600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 5749E040
P 6900 2700
F 0 "#PWR03" H 6900 2450 50  0001 C CNN
F 1 "GND" H 6900 2550 50  0000 C CNN
F 2 "" H 6900 2700 50  0000 C CNN
F 3 "" H 6900 2700 50  0000 C CNN
	1    6900 2700
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR04
U 1 1 5749E11F
P 2250 2750
F 0 "#PWR04" H 2250 2600 50  0001 C CNN
F 1 "+5V" H 2250 2890 50  0000 C CNN
F 2 "" H 2250 2750 50  0000 C CNN
F 3 "" H 2250 2750 50  0000 C CNN
	1    2250 2750
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR05
U 1 1 5749E149
P 6700 2800
F 0 "#PWR05" H 6700 2650 50  0001 C CNN
F 1 "+3.3V" H 6700 2940 50  0000 C CNN
F 2 "" H 6700 2800 50  0000 C CNN
F 3 "" H 6700 2800 50  0000 C CNN
	1    6700 2800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3950 4550 4300 4550
Wire Wire Line
	3950 4450 4300 4450
Wire Wire Line
	8300 2700 8600 2700
Wire Wire Line
	8300 2800 8600 2800
Wire Wire Line
	8300 2900 8450 2900
Wire Wire Line
	8450 2900 8450 3000
Wire Wire Line
	8450 3000 8300 3000
Wire Wire Line
	6900 2700 7100 2700
Wire Wire Line
	6700 2800 7100 2800
$Comp
L LM358 OAMP1
U 1 1 5749E44A
P 6150 4800
F 0 "OAMP1" H 6100 5000 50  0000 L CNN
F 1 "LM358" H 6100 4550 50  0000 L CNN
F 2 "Housings_DIP:DIP-8_W7.62mm_LongPads" H 6150 4800 50  0001 C CNN
F 3 "" H 6150 4800 50  0000 C CNN
	1    6150 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 4800 7250 4800
Wire Wire Line
	5850 4900 5650 4900
Wire Wire Line
	5650 4900 5650 5600
Wire Wire Line
	5650 5600 6000 5600
Connection ~ 6700 4800
$Comp
L GND #PWR06
U 1 1 5749E564
P 5700 4700
F 0 "#PWR06" H 5700 4450 50  0001 C CNN
F 1 "GND" H 5700 4550 50  0000 C CNN
F 2 "" H 5700 4700 50  0000 C CNN
F 3 "" H 5700 4700 50  0000 C CNN
	1    5700 4700
	0    1    1    0   
$EndComp
Wire Wire Line
	5700 4700 5850 4700
$Comp
L GND #PWR07
U 1 1 5749E595
P 6050 5200
F 0 "#PWR07" H 6050 4950 50  0001 C CNN
F 1 "GND" H 6050 5050 50  0000 C CNN
F 2 "" H 6050 5200 50  0000 C CNN
F 3 "" H 6050 5200 50  0000 C CNN
	1    6050 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 5200 6050 5100
$Comp
L POT RV1
U 1 1 5749E5E1
P 6150 5600
F 0 "RV1" H 6150 5500 50  0000 C CNN
F 1 "10K" H 6150 5600 50  0000 C CNN
F 2 "Potentiometers:Potentiometer_Bourns_3296W_3-8Zoll_Inline_ScrewUp" H 6150 5600 50  0001 C CNN
F 3 "" H 6150 5600 50  0000 C CNN
	1    6150 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 5450 6150 5400
Wire Wire Line
	6150 5400 6700 5400
Wire Wire Line
	6700 5400 6700 4800
$Comp
L +5V #PWR08
U 1 1 5749E742
P 6050 4350
F 0 "#PWR08" H 6050 4200 50  0001 C CNN
F 1 "+5V" H 6050 4490 50  0000 C CNN
F 2 "" H 6050 4350 50  0000 C CNN
F 3 "" H 6050 4350 50  0000 C CNN
	1    6050 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 4350 6050 4500
Text Label 4150 4450 0    60   ~ 0
STEP
Text Label 4200 4550 0    60   ~ 0
DIR
Text Label 8500 2700 0    60   ~ 0
DIR
Text Label 8500 2800 0    60   ~ 0
STEP
Wire Wire Line
	8300 3100 8650 3100
Wire Wire Line
	8300 3200 8650 3200
Wire Wire Line
	8300 3300 8650 3300
Wire Wire Line
	2050 3350 2350 3350
Wire Wire Line
	2150 3450 2350 3450
Wire Wire Line
	2050 3350 2050 3600
Wire Wire Line
	2150 3100 2150 3450
$Comp
L CONN_01X02 VMOT1
U 1 1 5749FBFC
P 10100 2950
F 0 "VMOT1" H 10100 3100 50  0000 C CNN
F 1 "CONN_01X02" V 10200 2950 50  0001 C CNN
F 2 "Connectors_Molex:Molex_KK_6410-02" H 10100 2950 50  0001 C CNN
F 3 "" H 10100 2950 50  0000 C CNN
	1    10100 2950
	1    0    0    -1  
$EndComp
$Comp
L +12V #PWR09
U 1 1 5749FD04
P 9700 2700
F 0 "#PWR09" H 9700 2550 50  0001 C CNN
F 1 "+12V" H 9700 2840 50  0000 C CNN
F 2 "" H 9700 2700 50  0000 C CNN
F 3 "" H 9700 2700 50  0000 C CNN
	1    9700 2700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR010
U 1 1 5749FD1E
P 9700 3250
F 0 "#PWR010" H 9700 3000 50  0001 C CNN
F 1 "GND" H 9700 3100 50  0000 C CNN
F 2 "" H 9700 3250 50  0000 C CNN
F 3 "" H 9700 3250 50  0000 C CNN
	1    9700 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9700 2900 9900 2900
Wire Wire Line
	9700 3000 9900 3000
$Comp
L CONN_01X04 MOT1
U 1 1 5749FDC2
P 6350 3050
F 0 "MOT1" H 6350 3300 50  0000 C CNN
F 1 "CONN_01X04" V 6450 3050 50  0001 C CNN
F 2 "Connectors_Molex:Molex_KK_6410-04" H 6350 3050 50  0001 C CNN
F 3 "" H 6350 3050 50  0000 C CNN
	1    6350 3050
	-1   0    0    1   
$EndComp
Wire Wire Line
	6550 2900 7100 2900
Wire Wire Line
	6550 3000 7100 3000
Wire Wire Line
	6550 3100 7100 3100
Wire Wire Line
	6550 3200 7100 3200
$Comp
L GND #PWR011
U 1 1 5749FF7E
P 6900 3300
F 0 "#PWR011" H 6900 3050 50  0001 C CNN
F 1 "GND" H 6900 3150 50  0000 C CNN
F 2 "" H 6900 3300 50  0000 C CNN
F 3 "" H 6900 3300 50  0000 C CNN
	1    6900 3300
	0    1    1    0   
$EndComp
Wire Wire Line
	7100 3300 6900 3300
Wire Wire Line
	9700 2700 9700 2900
Wire Wire Line
	9700 3000 9700 3250
$Comp
L CP C1
U 1 1 574A0144
P 9400 2950
F 0 "C1" H 9425 3050 50  0000 L CNN
F 1 "100uF" H 9425 2850 50  0000 L CNN
F 2 "Discret:C1V8" H 9438 2800 50  0001 C CNN
F 3 "" H 9400 2950 50  0000 C CNN
	1    9400 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	9400 2800 9400 2750
Wire Wire Line
	9400 3100 9400 3150
Wire Wire Line
	9400 2750 9700 2750
Connection ~ 9700 2750
Wire Wire Line
	9400 3150 9700 3150
Connection ~ 9700 3150
Text Label 7150 4800 0    60   ~ 0
ADC
NoConn ~ 3950 3350
NoConn ~ 3950 3250
NoConn ~ 3950 4150
NoConn ~ 3950 4250
NoConn ~ 3950 4350
NoConn ~ 2350 3750
NoConn ~ 2350 3650
NoConn ~ 2350 3550
NoConn ~ 2350 3950
NoConn ~ 2350 4050
NoConn ~ 2350 4150
NoConn ~ 2350 4250
NoConn ~ 2350 4350
NoConn ~ 2350 4450
NoConn ~ 8300 3400
NoConn ~ 6400 5600
$Comp
L PWR_FLAG #VMOT012
U 1 1 574A2FDF
P 2650 6850
F 0 "#VMOT012" H 2650 6945 50  0001 C CNN
F 1 "PWR_FLAG" H 2650 7030 50  0000 C CNN
F 2 "" H 2650 6850 50  0000 C CNN
F 3 "" H 2650 6850 50  0000 C CNN
	1    2650 6850
	1    0    0    -1  
$EndComp
$Comp
L +12V #PWR013
U 1 1 574A3020
P 2650 6950
F 0 "#PWR013" H 2650 6800 50  0001 C CNN
F 1 "+12V" H 2650 7090 50  0000 C CNN
F 2 "" H 2650 6950 50  0000 C CNN
F 3 "" H 2650 6950 50  0000 C CNN
	1    2650 6950
	-1   0    0    1   
$EndComp
Wire Wire Line
	2650 6950 2650 6850
$Comp
L +12V #PWR014
U 1 1 574A30AE
P 6650 3400
F 0 "#PWR014" H 6650 3250 50  0001 C CNN
F 1 "+12V" H 6650 3540 50  0000 C CNN
F 2 "" H 6650 3400 50  0000 C CNN
F 3 "" H 6650 3400 50  0000 C CNN
	1    6650 3400
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6650 3400 7100 3400
$Comp
L PWR_FLAG #GND015
U 1 1 574A3149
P 3050 6850
F 0 "#GND015" H 3050 6945 50  0001 C CNN
F 1 "PWR_FLAG" H 3050 7030 50  0000 C CNN
F 2 "" H 3050 6850 50  0000 C CNN
F 3 "" H 3050 6850 50  0000 C CNN
	1    3050 6850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR016
U 1 1 574A3169
P 3050 6950
F 0 "#PWR016" H 3050 6700 50  0001 C CNN
F 1 "GND" H 3050 6800 50  0000 C CNN
F 2 "" H 3050 6950 50  0000 C CNN
F 3 "" H 3050 6950 50  0000 C CNN
	1    3050 6950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3050 6950 3050 6850
Wire Wire Line
	2350 3250 2250 3250
Wire Wire Line
	2250 3250 2250 2750
$Comp
L +5V #PWR017
U 1 1 574A3323
P 2250 6950
F 0 "#PWR017" H 2250 6800 50  0001 C CNN
F 1 "+5V" H 2250 7090 50  0000 C CNN
F 2 "" H 2250 6950 50  0000 C CNN
F 3 "" H 2250 6950 50  0000 C CNN
	1    2250 6950
	-1   0    0    1   
$EndComp
$Comp
L PWR_FLAG #5V018
U 1 1 574A3438
P 2250 6800
F 0 "#5V018" H 2250 6895 50  0001 C CNN
F 1 "PWR_FLAG" H 2250 6980 50  0000 C CNN
F 2 "" H 2250 6800 50  0000 C CNN
F 3 "" H 2250 6800 50  0000 C CNN
	1    2250 6800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2250 6950 2250 6800
Wire Wire Line
	2350 4550 2000 4550
Text Label 2050 4550 0    60   ~ 0
ADC
Wire Wire Line
	3950 3850 4300 3850
Wire Wire Line
	3950 3950 4300 3950
Wire Wire Line
	3950 4050 4300 4050
Text Label 4150 3850 0    60   ~ 0
MS1
Text Label 4150 3950 0    60   ~ 0
MS2
Text Label 4150 4050 0    60   ~ 0
MS3
Text Label 8550 3100 0    60   ~ 0
MS3
Text Label 8550 3200 0    60   ~ 0
MS2
Text Label 8550 3300 0    60   ~ 0
MS1
$Comp
L ZENERsmall D1
U 1 1 5752F6E4
P 6950 5000
F 0 "D1" H 6950 5100 50  0000 C CNN
F 1 "3.3V" H 6950 5200 50  0000 C CNN
F 2 "Diodes_ThroughHole:Diode_DO-35_SOD27_Horizontal_RM10" H 6950 5000 50  0001 C CNN
F 3 "" H 6950 5000 50  0000 C CNN
	1    6950 5000
	0    1    1    0   
$EndComp
Wire Wire Line
	6950 4900 6950 4800
Connection ~ 6950 4800
$Comp
L GND #PWR019
U 1 1 5752F8C3
P 6950 5200
F 0 "#PWR019" H 6950 4950 50  0001 C CNN
F 1 "GND" H 6950 5050 50  0000 C CNN
F 2 "" H 6950 5200 50  0000 C CNN
F 3 "" H 6950 5200 50  0000 C CNN
	1    6950 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 5200 6950 5100
$Comp
L 7805 U1
U 1 1 5814FDFB
P 5400 2650
F 0 "U1" H 5550 2454 50  0000 C CNN
F 1 "7805" H 5400 2850 50  0000 C CNN
F 2 "Power_Integrations:TO-220" H 5400 2650 50  0001 C CNN
F 3 "" H 5400 2650 50  0000 C CNN
	1    5400 2650
	1    0    0    -1  
$EndComp
$Comp
L +12V #PWR020
U 1 1 5814FFDF
P 4850 2500
F 0 "#PWR020" H 4850 2350 50  0001 C CNN
F 1 "+12V" H 4850 2640 50  0000 C CNN
F 2 "" H 4850 2500 50  0000 C CNN
F 3 "" H 4850 2500 50  0000 C CNN
	1    4850 2500
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR021
U 1 1 58150134
P 5850 2450
F 0 "#PWR021" H 5850 2300 50  0001 C CNN
F 1 "+5V" H 5850 2590 50  0000 C CNN
F 2 "" H 5850 2450 50  0000 C CNN
F 3 "" H 5850 2450 50  0000 C CNN
	1    5850 2450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR022
U 1 1 5815015D
P 5400 3000
F 0 "#PWR022" H 5400 2750 50  0001 C CNN
F 1 "GND" H 5400 2850 50  0000 C CNN
F 2 "" H 5400 3000 50  0000 C CNN
F 3 "" H 5400 3000 50  0000 C CNN
	1    5400 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 2500 4850 2600
Wire Wire Line
	4850 2600 5000 2600
Wire Wire Line
	5400 2900 5400 3000
Wire Wire Line
	5800 2600 5850 2600
Wire Wire Line
	5850 2600 5850 2450
$EndSCHEMATC
