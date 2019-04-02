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
;---------------
;INSTRUCTION
;---------------
	LD R3, DEC_65
	LD R4, HEX_41

HALT
;----------------
;LOCAL DATA
;----------------
	DEC_65	.FILL #65
	HEX_41	.FILL x41

.END
