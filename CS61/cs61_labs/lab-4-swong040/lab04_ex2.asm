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
;INSTRUCTIONS
;---------------
LEA R0, PROMPT
PUTS

LEA R5, ARRAY
LD R2, COUNT

DO_WHILE
	GETC
	STR R0, R5, #0

	ADD R5, R5, #1
	ADD R2, R2, #-1
	BRnp DO_WHILE


HALT
;---------------
;DATA
;---------------
ARRAY .BLKW #10
PROMPT .STRINGZ "ENTER 10 CHARACTERS FORM KEYBOARD\n"
COUNT	.FILL #10

.END
