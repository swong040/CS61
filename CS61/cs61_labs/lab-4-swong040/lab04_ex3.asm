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

DO_GET
	GETC
	STR R0, R5, #0

	ADD R5, R5, #1
	ADD R2, R2, #-1
	BRnp DO_GET

LEA R1, ARRAY
LD R3, COUNT
DO_PRINT
	LDR R0, R1, #0
	OUT
	ADD R1, R1, #1

	LD R0, NEWLINE
	OUT

	ADD R3, R3, #-1
	BRnp DO_PRINT


HALT
;---------------
;DATA
;---------------
ARRAY .BLKW #10
PROMPT .STRINGZ "ENTER 10 CHARACTERS FORM KEYBOARD\n"
COUNT	.FILL #10
NEWLINE .FILL x0A

.END
