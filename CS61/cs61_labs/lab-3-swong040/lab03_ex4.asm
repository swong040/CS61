;=================================================
; Name: Sabrina Wong
; Email:  swong040@ucr.edu
; 
; Lab: lab 3
; Lab section: B21
; TA: Jason Goulding
; 
;=================================================

.ORIG x3000
;-------------
;INSTRUCTION
;-------------
	LD R0, HEX_61
	LD R1, HEX_1A

DO_WHILE
	OUT
	ADD R0, R0, #1
	ADD R1, R1, #-1
	BRp DO_WHILE

HALT
;-------------
;DATA
;-------------
	HEX_61 .FILL x61
	HEX_1A .FILL x1A

.END
