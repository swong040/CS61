;=================================================
; Name: Sabrina Wong
; Email:  swong040@ucr.edu
; 
; Lab: lab 7
; Lab section: B21
; TA: Jason Goulding
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE 
;--------------------------------
;Example of how to Output Intro Message
LD R0, introMessage  ;Output Intro Message
PUTS

	LD R1, SUB_VALUE
	JSRR R1

HALT
	N .STRINGZ "\n"
;---------------	
;Data
;---------------

SUB_VALUE .FILL x3200

introMessage .FILL x6000
;errorMessage .FILL x6100

;------------
;Remote data
;------------

;=======================================================================
; Subroutine: SUB_VALUE
; Parameter (Register you are “passing” as a parameter): [description of parameter]
; Postcondition: GET VALUE FROM USER INPUT AND CALL SUB_PRINT
; Return Value: R5 CARRIES THE VALUE OF USER INPUT
.orig x3200
;=======================================================================

.ORIG x3200	;get value
	ST R1, BU_R1_VALUE
	ST R2, BU_R2_VALUE
	ST R4, BU_R4_VALUE
	ST R6, BU_R6_VALUE
	ST R7, BU_R7_VALUE

LD R1, ASCII_0_SUB
LD R2, ENTER_SUB
AND R5, R5, #0
AND R4, R4, #0
STI R4, S_FLAG

DO_LOOP
	GETC
	OUT

	LD R3, SUB_CHECK	;check for sign
	JSRR R3

	LD R3, DEC_1_SUB
	ADD R6, R6, R3
	BRz DO_LOOP

	ADD R6, R0, R1	;get actual value from ascii || wipes flag
	ADD R3, R0, R2	;if r0 is ENTER
	BRnp MULTIPLY
	BRz END
MULTIPLY
	ADD R5, R5, #0	
	ADD R5, R5, R4
	ADD R5, R5, R4
	ADD R5, R5, R4
	ADD R5, R5, R4

	ADD R5, R5, R4
	ADD R5, R5, R4
	ADD R5, R5, R4
	ADD R5, R5, R4
	ADD R5, R5, R4

	ADD R5, R5, R6
	ADD R4, R5, #0
END
	ADD R3, R0, R2	;if r0 is ENTER
	BRnp DO_LOOP

	;IF NEGATIVE
	LDI R3, FLAG
	LD R4, DEC_1_SUB
	ADD R3, R3, R4
	BRz CHANGE
	BRnp NOTHING
CHANGE
	NOT R5, R5
	ADD R5, R5, #1
NOTHING

;	ADD R5, R5, #1
	LD R2, SUB_PRINT
	JSRR R2

	LD R1, BU_R1_VALUE
	LD R2, BU_R2_VALUE
	LD R4, BU_R4_VALUE
	LD R6, BU_R6_VALUE
	LD R7, BU_R7_VALUE

RET
	ENTER_SUB .FILL #-10
	ASCII_0_SUB .FILL #-48
	NONE_SUB .FILL #-44
	DEC_1_SUB .FILL #1
	PLUS_SUB .FILL #-43

	FLAG .FILL x6200
	S_FLAG .FILL x6201
	SUB_CHECK .FILL x3400
	SUB_PRINT .FILL x3600

	BU_R1_VALUE .BLKW #1
	BU_R2_VALUE .BLKW #1
	BU_R4_VALUE .BLKW #1
	BU_R6_VALUE .BLKW #1
	BU_R7_VALUE .BLKW #1

;----------------------------------------------------------------------------
.ORIG x6000
;---------------
;messages
;---------------
intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
;---------------
;error_messages
;---------------
.ORIG x6100	
error_mes .STRINGZ	"\nERROR INVALID INPUT\n"

;-----------
.ORIG x6200
	.BLKW #1	;NEG FLAG
	.BLKW #1	;SIGN FLAG
;-----------
.ORIG x6300	;PLACES
	.FILL #10000
	.FILL #1000
	.FILL #100
	.FILL #10
	.FILL #1

;=======================================================================
; Subroutine: SUB_PRINT
; Parameter (R5): VALUE TRYING TO PRINT
; Postcondition: PRINT CONTENT IN R5
; Return Value: [which register (if any) has a return value and what it means]
.orig x3200
;=======================================================================

.ORIG x3600	; PRINT
	ST R1, BU_R1_PRINT
	ST R3, BU_R3_PRINT
	ST R4, BU_R4_PRINT
	ST R6, BU_R6_PRINT
	ST R5, BU_R5_PRINT
	ST R2, BU_R2_PRINT
	ST R7, BU_R7_PRINT
	ST R0, BU_R0_PRINT

	LEA R0, intro_print
	PUTS

;IF R5 IS NEGATIVE
	ADD R5, R5, #0
	BRn CHANGE1
	BRp PRINT
CHANGE1
	NOT R5, R5
	ADD R5, R5, #1
	LD R0, NEG_S
	OUT
;BEGIN PRINTING
PRINT
	LD R6, DEC_1
	LD R3, MATH
PRINT_LOOP
	AND R2, R2, #0		;COUNT
	LDR R4, R3, #0		;
	NOT R4, R4		;SUBTRACT 10000
	ADD R4, R4, #1

LOOP_COUNT
	ADD R2, R2, #1
	ADD R5, R5, R4
	BRn END_COUNT		;NO MORE VALUES AT PLACE
	BRz PRINTING
	BRp LOOP_COUNT
END_COUNT
	NOT R4, R4
	ADD R4, R4, #1
	ADD R5, R5, R4		;ADD BACK 10000
	ADD R2, R2, #-1		;TAKE OUT A COUNT
	BRz STOPPRINT

PRINTING
	ADD R0, R2, #15		;CHANGE COUNT TO ASCII
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #3

	OUT			;PRINT
STOPPRINT
	ADD R2, R2, #0
	BRz CHECK_PREV
	BRnp GO
CHECK_PREV
	LD R1, PREV
	ADD R1, R1, #0
	BRz GO
	ADD R0, R2, #15		;CHANGE COUNT TO ASCII
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #3

	OUT
	
GO
	ADD R3, R3, #1		;MOVE DOWN PLACES
	ADD R5, R5, #0		;HAS VALUE, NEW VALUE
	BRp PRINT_LOOP
	BRnz ENDEND
ENDEND
	
;	LD R0, BU_R0_PRINT
	LD R1, BU_R1_PRINT
	LD R3, BU_R3_PRINT
	LD R4, BU_R4_PRINT
	LD R6, BU_R6_PRINT
	LD R5, BU_R5_PRINT
	LD R2, BU_R2_PRINT
	LD R7, BU_R7_PRINT
RET
	intro_print .STRINGZ "VALUE: "
	
	BU_R1_PRINT .BLKW #1
	BU_R2_PRINT .BLKW #1
	BU_R3_PRINT .BLKW #1
	BU_R4_PRINT .BLKW #1
	BU_R6_PRINT .BLKW #1
	BU_R5_PRINT .BLKW #1
	BU_R7_PRINT .BLKW #1
	BU_R0_PRINT .BLKW #1

	PREV .BLKW #1
	MATH .FILL x6300
	NEG_S .FILL #45
	DEC_1 .FILL #1

;=======================================================================
; Subroutine: SUB_CHECK
; Parameter (R0): USER INPUT CHARACTER
; Postcondition: CHECK USER INPUT IF VALID INPUT
; Return Value: R6 INDICATES IF THERE IS A SIGN/ ERROR
.orig x3200
;=======================================================================

.ORIG x3400	;check ;DNT BU R3
	ST R0, BU_R0_CHECK
	ST R1, BU_R1_CHECK
	ST R2, BU_R2_CHECK
	ST R3, BU_R3_CHECK
	ST R4, BU_R4_CHECK
	ST R5, BU_R5_CHECK
	ST R7, BU_R7_CHECK

	LD R1, NEG
	LD R2, PLUS
	LD R3, ASCII_10

	LD R5, ENTER
	ADD R4, R0, R5	
	BRz EMPTY
	BRnp SKIP
EMPTY
	LD R4, BU_R5_CHECK
	ADD R5, R4, #0
	BRz ERROR
	BRnp SKIP
SKIP
	ADD R4, R0, R1
	BRz NEGATIVE
	BRnp done
NEGATIVE
	LDI R6, SIGN_FLAG
	ADD R6, R6, #1
	BRz ERROR

	LD R4, BU_R5_CHECK
	ADD R5, R4, #0
	BRp ERROR

	LD R6, nDEC_1
	STI R6, SIGN_FLAG
	STI R6, FLAG_NEG
	
	LD R0, BU_R0_CHECK
	LD R1, BU_R1_CHECK
	LD R2, BU_R2_CHECK
	LD R3, BU_R3_CHECK
	LD R4, BU_R4_CHECK
	LD R5, BU_R5_CHECK
	LD R7, BU_R7_CHECK

	RET
done
	ADD R4, R0, R2
	BRz positive
	BRnp done2
positive
	LDI R6, SIGN_FLAG
	ADD R6, R6, #1
	BRz ERROR

	LD R4, BU_R5_CHECK
	ADD R5, R4, #0
	BRp ERROR

	LD R6, nDEC_1
	STI R6, SIGN_FLAG

	LD R0, BU_R0_CHECK
	LD R1, BU_R1_CHECK
	LD R2, BU_R2_CHECK
	LD R3, BU_R3_CHECK
	LD R4, BU_R4_CHECK
	LD R5, BU_R5_CHECK
	LD R7, BU_R7_CHECK
	
	RET
done2
	ADD R4, R0, R3	;if between 0-9
	BRn NUMBER
	BRzp done3
NUMBER
	LD R0, BU_R0_CHECK
	LD R1, BU_R1_CHECK
	LD R2, BU_R2_CHECK
	LD R3, BU_R3_CHECK
	LD R4, BU_R4_CHECK
	LD R5, BU_R5_CHECK
	LD R7, BU_R7_CHECK

	RET
done3
	BRzp ERROR
	BRn done4
ERROR
	;Example of how to Output Error Message
	LD R0, errorMessage  ;Output Error Message
	PUTS

	LD R0, BU_R0_CHECK
	LD R1, BU_R1_CHECK
	LD R2, BU_R2_CHECK
	LD R3, BU_R3_CHECK
	LD R4, BU_R4_CHECK
	LD R5, BU_R5_CHECK
	LD R7, BU_R7_CHECK

	LD R6, RESET
	JMP R6
	RET
done4
	LD R0, BU_R0_CHECK
	LD R1, BU_R1_CHECK
	LD R2, BU_R2_CHECK
	LD R3, BU_R3_CHECK
	LD R4, BU_R4_CHECK
	LD R5, BU_R5_CHECK
	LD R7, BU_R7_CHECK
RET
	NEG .FILL #-45
	PLUS .FILL #-43
	ASCII_10 .FILL #-58
	nDEC_1 .FILL #-1
	ENTER .FILL #-10
	
	CONT .FILL x3200
errorMessage .FILL x6100
	RESET .FILL x3000
	FLAG_NEG .FILL x6200
	SIGN_FLAG .FILL x6201

	BU_R0_CHECK .BLKW #1
	BU_R1_CHECK .BLKW #1
	BU_R2_CHECK .BLKW #1
	BU_R3_CHECK .BLKW #1
	BU_R4_CHECK .BLKW #1
	BU_R5_CHECK .BLKW #1
	BU_R7_CHECK .BLKW #1
;-----------------------------------------------------------------

.END

