;=================================================
; Name: Sabrina Wong
; Email: swong040@ucr.edu
; 
; Lab: lab 4
; Lab section: B21
; TA: Jason Goulding
; 
;=================================================

.ORIG x3000
;--------------
;INSTRUCTIONS
;--------------
LEA R0, PROMPT
PUTS

LD R1, ARRAY
LD R5, ENTER
	NOT R5, R5
	ADD R5, R5, #1

DO_INPUT
	GETC
	STR R0, R1, #0
	ADD R1, R1, #1

	ADD R6, R0, R5
	BRnp DO_INPUT

LD R2, ARRAY
DO_PRINT
	LDR R0, R2, #0
	OUT
	ADD R2, R2, #1

	ADD R3, R0, #0

	LD R0, ENTER
	OUT

	ADD R6, R3, R5
	BRnp DO_PRINT

HALT

;--------------
;DATA
;--------------
PROMPT .STRINGZ "ENTER 10 CHARACTERS FORM KEYBOARD. PRESS (ENTER) WHEN FINISHED\n"
ENTER .FILL #10
ARRAY .FILL x4000


HALT
