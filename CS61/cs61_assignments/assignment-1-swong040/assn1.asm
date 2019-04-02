;=================================================
; Name: Sabrina Wong
; Email: swong040@ucr.edu
; 
; Assignment name: Assignment 1
; Lab section: B21
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

;----------------------------------------------------------------------------
;REG VALUES	R0	R1	R2	R3	R4	R5	R6	R7
;----------------------------------------------------------------------------
;PRE-LOOP	0	32767	0	0	0	0	0	1168
;ITERATION 01	0	6	0	0	0	0	0	1168
;ITERATION 02	0	6	12	0	0	0	0	1168
;ITERATION 03	0	6	12	0	0	0	0	1168
;ITERATION 04	0	6	12	12	0	0	0	1168
;ITERATION 05	0	5	12	12	0	0	0	1168
;ITERATION 06	0	5	12	12	0	0	0	1168
;ITERATION 07	0	5	12	24	0	0	0	1168
;ITERATION 08	0	4	12	24	0	0	0	1168
;ITERATION 09	0	4	12	24	0	0	0	1168
;ITERATION 10	0	4	12	36	0	0	0	1168
;ITERATION 11	0	3	12	36	0	0	0	1168
;ITERATION 12	0	3	12	36	0	0	0	1168
;ITERATION 13	0	3	12	48	0	0	0	1168
;ITERATION 14	0	2	12	48	0	0	0	1168
;ITERATION 15	0	2	12	48	0	0	0	1168
;ITERATION 16	0	2	12	60	0	0	0	1168
;ITERATION 17	0	1	12	60	0	0	0	1168
;ITERATION 18	0	1	12	60	0	0	0	1168
;ITERATION 19	0	1	12	72	0	0	0	1168
;ITERATION 20	0	0	12	72	0	0	0	1168
;END OF PROGRAM	0	0	12	72	0	0	0	1168
;----------------------------------------------------------------------------



.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R1, DEC_6
LD R2, DEC_12
LD R3, DEC_0

DO_WHILE
	ADD R3, R3, R2
	ADD R1, R1, #-1
	BRp DO_WHILE

HALT
;---------------	
;Data
;---------------
DEC_0 .FILL #0
DEC_6 .FILL #6
DEC_12 .FILL #12

;---------------	
;END of PROGRAM
;---------------	
.END


