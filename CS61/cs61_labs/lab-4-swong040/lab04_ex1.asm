;=================================================
; Name: Sabrina Wong
; Email:  swong040@ucr.edu
; 
; Lab: lab 4
; Lab section: B21
; TA: Jason Goulding
; 
;=================================================

.ORIG x3000
;---------------
;INSTRUCTION
;---------------
	LD R5, DATA_PTR
	ADD R6, R5, #1

	LDR R3, R5, #0
	LDR R4, R6, #0

	ADD R3, R3, #1
	ADD R4, R4, #1

	STR R3, R5, #0
	STR R4, R6, #0

HALT
;----------------
;LOCAL DATA
;----------------
	DATA_PTR .FILL x4000


;----------------
;REMOTE DATA
;----------------
.ORIG x4000
	NEW_DEC_65 .FILL #65
	NEW_HEX_41 .FILL x41

.END
