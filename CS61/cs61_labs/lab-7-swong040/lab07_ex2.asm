;=================================================
; Name: Sabrina Wong
; Email:  swong040@ucr.edu
; 
; Lab: lab 7
; Lab section: B21
; TA: Jason Goulding
; 
;=================================================

.ORIG x3000
	LEA R0, intro
	PUTS

	GETC
	OUT

	LD R1, SUB_PRINT
	JSRR R1

HALT
	intro .STRINGZ "ENTER ONE CHARACTER\n"
	SUB_PRINT .FILL x3200

;=======================================================================
; Subroutine: SUB_PRINT
; Parameter (Register you are “passing” as a parameter): R0 - BINARY OF USER INPUT
; Postcondition: PRINTS OUT 2'S COMPLEMENT OF USER INPUT CHARACTER
; Return Value: [which register (if any) has a return value and what it means]

.ORIG x3200	;PRINT
	ST R7, BU_R7_PRINT
	ST R1, BU_R1_PRINT
	ST R0, BU_R0_PRINT

	ADD R1, R0, #0

	LEA R0, NEWLINE
	PUTS
	LD R0, ASCII_b
	OUT

	LD R3, DEC_15
	LD R5, DEC_4
	LD R4, DEC_0

DO_WHILE
	ADD R1, R1, R4
	BRzp IF_POS
	BRn END
IF_POS
	LD R0, ASCII_0
	OUT
END
	BRn IF_NEG
	BRzp END2
IF_NEG
	LD R0, ASCII_1
	OUT
END2
	ADD R4, R1, #0
	ADD R5, R5, #-1
	BRz IF_4
	BRnp END3
IF_4
	LD R0, SPACE
	OUT
	LD R5, DEC_4
END3
	ADD R3, R3, #-1
	BRnp DO_WHILE
END_DO_WHILE

	ADD R1, R1, R4
	BRzp IF_POS2
	BRn END4
IF_POS2
	LD R0, ASCII_0
	OUT
END4
	BRn IF_NEG2
	BRzp END5
IF_NEG2
	LD R0, ASCII_1
	OUT
END5

LEA R0, NEWLINE
PUTS
	LD R0, BU_R0_PRINT
	LD R1, BU_R1_PRINT

	LD R2, SUB_COUNT
	JSRR R2

	LEA R0, NEWLINE
	PUTS

	LD R7, BU_R7_PRINT

RET
;---------------	
;Data
;---------------

ASCII_0 .FILL #48
ASCII_1 .FILL #49
ASCII_b .FILL #98

DEC_15 .FILL #15
DEC_4 .FILL #4
DEC_0 .FILL #0

SPACE .FILL #32
NEWLINE .STRINGZ "\n"

SUB_COUNT .FILL x3400
BU_R0_PRINT .BLKW #1
BU_R1_PRINT .BLKW #1
BU_R7_PRINT .BLKW #1

;=======================================================================
; Subroutine: SUB_COUNT
; Parameter (Register you are “passing” as a parameter): R0 - USERINPUT
; Postcondition: COUNTS THE NUMBER OF 1'S IN BINARY OF THE USER INPUT CHARACTER
; Return Value: [which register (if any) has a return value and what it means]


.ORIG x3400	;COUNT
	ST R7, BU_R7_COUNT
	ST R0, BU_R0_COUNT

	AND R1, R1, #0		;COUNTER

	ADD R3, R0, #0		;R3 <- USER INPUT IF NEGATIVE
	BRzp NEXT
	ADD R1, R1, #1
NEXT
	AND R2, R2, #0
	ADD R2, R2, #-15	;COUNT BITS
LOOP
	ADD R3, R3, R3		;IF NEGATIVE
	BRzp AGAIN
	ADD R1, R1, #1
AGAIN
	ADD R2, R2, #1		;NEXT BIT
	BRn LOOP

	LEA R0, count
	PUTS

	LD R3, ASCII
	ADD R0, R1, R3
	OUT
	
	LD R0, BU_R0_COUNT
	LD R7, BU_R7_COUNT
RET
	count .STRINGZ "NUMBER OF 1'S: "
	BU_R0_COUNT .BLKW #1
	BU_R7_COUNT .BLKW #1
	ASCII .FILL #48

	


