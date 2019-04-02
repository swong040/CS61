;=================================================
; Name: Sabrina Wong
; Email: swong040@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: B21
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
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

;Example of how to Output Error Message
;LD R0, errorMessage  ;Output Error Message
;PUTS

HALT
;---------------	
;Data
;---------------

SUB_VALUE .FILL x3200

introMessage .FILL x6000
;errorMessage .FILL x6100

;------------
;Remote data
;------------

;------------------------------------------------------------------------------------

.ORIG x3200	;get value
	ST R1, BU_R1_VALUE
	ST R2, BU_R2_VALUE
	ST R4, BU_R4_VALUE
	ST R6, BU_R6_VALUE
	ST R7, BU_R7_VALUE

LD R1, ASCII_0_SUB
LD R2, ENTER_SUB
LD R5, DEC_0
LD R4, DEC_0
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

	LD R1, BU_R1_VALUE
	LD R2, BU_R2_VALUE
	LD R4, BU_R4_VALUE
	LD R6, BU_R6_VALUE
	LD R7, BU_R7_VALUE
RET
HALT
	ENTER_SUB .FILL #-10
	ASCII_0_SUB .FILL #-48
	NONE_SUB .FILL #-44
	DEC_1_SUB .FILL #1
	PLUS_SUB .FILL #-43
	DEC_0 .FILL #0

	FLAG .FILL x6200
	S_FLAG .FILL x6201
	SUB_CHECK .FILL x3400

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
	.BLKW #1

;----------------------------------------------------------------------------

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
;good
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

;good
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

;good
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
;---------------
;END of PROGRAM
;---------------
.END
;-------------------
;PURPOSE of PROGRAM
;-------------------
