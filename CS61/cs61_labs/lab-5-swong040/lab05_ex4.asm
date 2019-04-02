;=================================================
; Name: Sabrina Wong
; Email:  swong040@ucr.edu
; 
; Lab: lab 5
; Lab section: B21
; TA: Jason Goulding
; 5;=================================================


.ORIG x3000
;-----------------------
;INSTRUCTIONS
;-----------------------
LD R1, ARRAY
AND R2, R2, #0
ADD R2, R2, #1			;2^0
STR R2, R1, #0
LD R3, DEC_9

DO_WHILE
	ADD R1, R1, #1		;next element
	ADD R2, R2, R2
	STR R2, R1, #0

	ADD R3, R3, #-1
	BRnp DO_WHILE

LD R1, ARRAY
;ADD R1, R1, #6
LD R3, DEC_9
	ADD R3, R3, #1

PRINT_B
LD R6, DEC_15
LD R5, DEC_4
LD R4, DEC_0


	LDR R2, R1, #0
	LD R0, B
	OUT

	DO_PRINT
		ADD R2, R2, R4

		BRzp POS
		BRn END_POS
	POS
		LD R0, ASCII_0
		OUT
	END_POS

		BRn NEG
		BRzp END_NEG
	NEG
		LD R0, ASCII_1
		OUT
	END_NEG

		ADD R5, R5, #-1
		BRnp NO_SPACE
	
		LD R0, SPACE
		OUT
		LD R5, DEC_4
	NO_SPACE

		ADD R4, R2, #0
		ADD R6, R6, #-1
		BRnp DO_PRINT
	
	ADD R2, R2, R4
	BRzp PO
	BRn END_PO

	PO
		LD R0, ASCII_0
		OUT
	END_PO

	BRn NE
	BRzp END_NE
	
	NE
		LD R0, ASCII_1
		OUT
	END_NE

	LD R0, NEWLINE
	OUT

	ADD R1, R1, #1
	ADD R3, R3, #-1
	BRnp PRINT_B

HALT
;-----------------------
;DATA
;-----------------------
ARRAY .FILL x4000
DEC_9 .FILL #9

B .FILL #98
DEC_15 .FILL #15
DEC_4 .FILL #4
DEC_0 .FILL #0

ASCII_0 .FILL #48
ASCII_1 .FILL #49
SPACE .FILL #32
NEWLINE .FILL x0A



.ORIG x4000
	.BLKW #10

.END
