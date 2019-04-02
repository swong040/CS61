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
STR R2, R1, #0
LD R3, DEC_9

DO_WHILE
	ADD R1, R1, #1
	ADD R2, R2, #1
	STR R2, R1, #0

	ADD R3, R3, #-1
	BRnp DO_WHILE

LD R1, ARRAY
ADD R1, R1, #6
LDR R2, R1, #0



HALT
;-----------------------
;DATA
;-----------------------
ARRAY .FILL x4000
DEC_9 .FILL #9





.ORIG x4000
	.BLKW #10

.END
