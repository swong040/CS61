;=================================================
; Name: Sabrina Wong
; Email:  swong040@ucr.edu
; 
; Lab: lab 6
; Lab section: B21
; TA: Jason Goulding
; 
;=================================================

.ORIG x3000
;instructions
	LD R2, DEC_0

	LD R3, SUB_GV_3400		;calls subroutine
	JSRR R3

	LEA R0, NEWLINE
	PUTS

	LD R7, SUB_PV_3200		;calls subroutine
	JSRR R7

HALT
;data


	NEWLINE .STRINGZ "\n"
	DEC_0 .FILL #0

	SUB_PV_3200 .FILL x3200
	SUB_GV_3400 .FILL x3400

;--------------------------------------------------------
;subroutine: sub_gv_3200
;parameter: none
;postcondition: get binary value from user input into R2
;return value: R2 contains binval from user input
;--------------------------------------------------------

.ORIG 3400
;instructions
	ST R3, BU_R3_3400
	ST R7, BU_R7_3400

	LEA R0, intro
	PUTS

b_CHECK
	LD R6, DEC_16
	LEA R0, b_STATEMENT
	PUTS
	LD R1, b
	NOT R1, R1
	ADD R1, R1, #1

	GETC
	OUT	
	ADD R0, R0, R1
	BRnp b_CHECK

LD R5, ascii_0
NOT R5, R5
ADD R5, R5, #1
LD R3, ascii_1
NOT R3, R3
ADD R3, R3, #1
LD R4, SPACE
NOT R4, R4
ADD R4, R4, #1

DO_WHILE_INPUT
	GETC
	OUT
;IF SPACE
	ADD R1, R0, #0
	ADD R1, R1, R4
	BRz DO_WHILE_INPUT
;IF ZERO
	ADD R1, R0, #0
	ADD R1, R1, R5
	BRz GOOD
;IF ONE
	ADD R1, R0, #0
	ADD R1, R1, R3
	BRz GOOD
	BRnp DO_WHILE_INPUT

GOOD
	ADD R0, R0, R5
	ADD R2, R2, R2
	ADD R2, R2, R0

	ADD R6, R6, #-1
	BRp DO_WHILE_INPUT

	LD R3, BU_R3_3400
	LD R7, BU_R7_3400
RET
HALT
;data
	BU_R3_3400 .BLKW #1
	BU_R7_3400 .BLKW #1

	intro .STRINGZ "ENTER BINARY VALUE STARTING WITH 'b'\n"
	
	b_STATEMENT .STRINGZ "START WITH 'b'\n"

	b .FILL #98
	DEC_16 .FILL #16
	ascii_0 .FILL #48
	ascii_1 .FILL #49
	SPACE .FILL #32

;--------------------------------------------------------
;subroutine: sub_pv_3200
;parameter (r2): contains binary value
;postcondition: prints out user input
;return value: none
;--------------------------------------------------------
.ORIG x3200
;instructions
	ST R0, BU_R0_3200
	ST R6, BU_R6_3200
	ST R5, BU_R5_3200
	ST R4, BU_R4_3200
	ST R7, BU_R7_3200
	ST R3, BU_R3_3200

	LD R0, b_SUB
	OUT
;START OF OUTPUT OF ARRAY

	LD R6, DEC_15_SUB
	LD R5, DEC_4_SUB
	LD R4, DEC_0_SUB
	
	DO_LOOP
		ADD R2, R2, R4
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
		ADD R4, R2, #0
		ADD R5, R5, #-1
		BRz IF_4
		BRnp END3
	IF_4
		LD R0, SPACE_SUB
		OUT
		LD R5, DEC_4_SUB
	END3
		ADD R6, R6, #-1
		BRnp DO_LOOP

		ADD R2, R2, R4
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
	LEA R0, NEWLINE_SUB
	PUTS

	LD R0, BU_R0_3200
	LD R6, BU_R6_3200
	LD R5, BU_R5_3200
	LD R4, BU_R4_3200
	LD R7, BU_R7_3200
	LD R3, BU_R3_3200

	RET
HALT
;data
	BU_R0_3200 .BLKW #1
	BU_R6_3200 .BLKW #1
	BU_R5_3200 .BLKW #1
	BU_R4_3200 .BLKW #1
	BU_R7_3200 .BLKW #1
	BU_R3_3200 .BLKW #1

	ASCII_0 .FILL #48
	ASCII_1 .FILL #49
	DEC_15_SUB .FILL #15
	DEC_4_SUB .FILL #4
	DEC_0_SUB .FILL #0
	SPACE_SUB .FILL #32
	NEWLINE_SUB .STRINGZ "\n"
	b_SUB .FILL #98
.END
