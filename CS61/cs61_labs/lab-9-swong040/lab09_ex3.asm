;=================================================
; Name: Sabrina Wong
; Email:  swong040@ucr.edu
; 
; Lab: lab 9
; Lab section: B21
; TA: Jason Goulding
; 
;=================================================

.ORIG x3000
	LD R6, BASE		;SET T0S, R6, TO BASE
	LD R5, MAX
	LD R4, BASE
	
	LEA R0, INTRO1		; FIRST DIGIT
	PUTS
	GETC
	OUT

	LD R7, PUSH		; PUSH FIRST
	JSRR R7

	LEA R0, NEWLINE
	PUTS

	LEA R0, INTRO2		;SECOND DIGIT
	PUTS
	GETC
	OUT

	LD R7, PUSH		;PUSH SECOND
	JSRR R7

	LEA R0, NEWLINE
	PUTS

	LEA R0, INTRO3		; OPERATIONS
	PUTS
	GETC
	OUT

	LD R7, PUSH		;PUSH OPERATION
	JSRR R7

	LEA R0, NEWLINE
	PUTS

	LD R7, MULTI
	JSRR R7

HALT
	PUSH .FILL x3200
	MULTI .FILL x3600
	MAX .FILL xA005
	BASE .FILL xA000

	INTRO1 .STRINGZ "INPUT FIRST VALUE\n"
	INTRO2 .STRINGZ "INPUT SECOND VALUE\n"
	INTRO3 .STRINGZ "INPUT OPERATION (*)\n"

	NEWLINE .STRINGZ "\n"

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (​one less than​ the lowest available
; address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the ​current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1).
; If the stack was already full (TOS = MAX), the subroutine has printed an
; overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------

.ORIG x3200	;PUSH		R0->ADDR_R6
	ST R7, BU_R7_PUSH

	LD R5, MAX_PUSH
	NOT R5, R5
 	ADD R5, R5, #1
	ADD R2, R6, R5			; TOS - MAX = (-)
	BRp OVERFLOW

	ADD R6, R6, #1			;TOS++
	STR R0, R6, #0			;R0 --> TOS

	LD R7, BU_R7_PUSH
	RET

OVERFLOW
	LEA R0, OVER
	PUTS
	LD R7, BU_R7_PUSH
	HALT
END_PUSH
	LEA R0, INVALID
	PUTS
	LD R7, BU_R7_PUSH
	HALT
;---------------
;DATA
;---------------
	ASCII_0 .FILL #-48
	STAR .FILL #-42
	MAX_PUSH .FILL xA005
	BU_R7_PUSH .BLKW #1

	INVALID .STRINGZ "\nINVALID INPUT, ENDED\n"
	OVER .STRINGZ "\nOVERFLOW\n"
	NEWLINE_PUSH .STRINGZ "\n"


;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (​one less than​ the lowest available
; address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the ​current top of the stack
; Postcondition: The subroutine has popped MEM[top] off of the stack.
; If the stack was already empty (TOS = BASE), the subroutine has printed
; an underflow error message and terminated.
; Return Value: R0 ← value popped off of the stack
; R6 ← updated TOS
;------------------------------------------------------------------------------------------
.ORIG x3400	;POP		R0 <-- MEM[ADDR_R6]
	ST R7, BU_R7_POP

	LEA R0, POPPED
	PUTS

	LD R4, BASE_POP
	NOT R4, R4
	ADD R4, R4, #1
	ADD R2, R6, R4		; CHECK TOS > BASE
	BRnz UNDERFLOW

	LDR R0, R6, #0		; TOS -> R0
	ADD R6, R6, #-1
	LD R7, BU_R7_POP
	RET

UNDERFLOW
	LEA R0, UNDER
	PUTS
	LD R7, BU_R7_POP
	HALT
;---------------
;DATA
;---------------
	BU_R7_POP .BLKW #1
	BASE_POP .FILL xA000
	UNDER .STRINGZ "UNDERFLOW\n"
	POPPED .STRINGZ "POPPED\n"

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (​one less than​ the lowest available
; address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the ​current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
; multiplied them together, and pushed the resulting value back
; onto the stack.
; Return Value: R6 ← updated top value
;------------------------------------------------------------------------------------------
.ORIG x3600	; RPN MULTIPLY
	ST R7, BU_R7_RPN
	
	LD R7, POP_RPN
	JSRR R7			;POP SIGN

	LD R7, POP_RPN
	JSRR R7			;POP FIRST DIGIT
	ADD R1, R0, #0		;R1 <-- VALUE POPPED
	ADD R1, R1, #-15
	ADD R1, R1, #-15
	ADD R1, R1, #-15
	ADD R1, R1, #-3
	ST R1, FIRST

	LD R7, POP_RPN
	JSRR R7			;POP SECOND
	ADD R1, R0, #0		;R1 <-- VALUE POPPED
	ADD R1, R1, #-15
	ADD R1, R1, #-15
	ADD R1, R1, #-15
	ADD R1, R1, #-3
	ST R1, SECOND

	LD R3, FIRST

	LD R7, MULTIPLY		;MULTIPLY ->R0
	JSRR R7 

	LD R7, PUSH_RPN		;PUSH RESULT
	JSRR R7

	LD R7, PRINT_VALUE	;PRINT 
	JSRR R7
	
	LD R7, BU_R7_RPN
RET
	FIRST .BLKW #1
	SECOND .BLKW #1
	POP_RPN .FILL x3400
	PUSH_RPN .FILL x3200

	MULTIPLY .FILL x3800
	PRINT_VALUE .FILL x7400
	BU_R7_RPN .BLKW #1

;-------------------------------------
; SUB : MULTIPLY
; INPUT: R1, R3 - VALUES OF FIRST AND SECOND DIGIT
; POST
; RETURN: R0 - RESULT OF FIRST * SECOND
;-------------------------------------

.ORIG x3800	;MULTIPLY
	ST R7, BU_R7_MULTIPLY
	AND R0, R0, #0
MULTIPLY_M
	ADD R0, R3, R0
	ADD R1, R1, #-1
	BRp MULTIPLY_M

	LD R7, BU_R7_MULTIPLY
RET
	BU_R7_MULTIPLY .BLKW #1


;-----------------------------------------------------------------------------------------------------------------
; Subroutine: print number
; Inputs: 
; Postcondition: 
; The subroutine prints the number that is in 
; Return Value : 
; NOTE: This subroutine should print the number to the user WITHOUT 
;		leading 0's and DOES NOT output the '+' for positive numbers.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x7400		;PRINT CONTENTS IN R3
	ST R7, BU_R7_PRINT
	
	LDR R3, R6, #0
	LD R4, NDEC_1
	
GET_10
	ADD R4, R4, #1
	ADD R3, R3, #-10
	BRzp GET_10
END_GET_10
	
	ADD R4, R4, #0
	BRnz NO_FIRST_DIGIT
	BRp PRINT_FIRST_DIGIT
	
PRINT_FIRST_DIGIT:
	ADD R0, R4, #15
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #3
	OUT
		
NO_FIRST_DIGIT:
	ADD R3, R3, #10
	LD R4, NDEC_1
	
GET_1
	ADD R4, R4, #1
	ADD R3, R3, #-1
	BRzp GET_1
END_GET_1
	
	ADD R0, R4, #15
	ADD R0, R0, #15
	ADD R0, R0, #15
	ADD R0, R0, #3
	OUT
;end print

	LD R7, BU_R7_PRINT
	RET
;--------------------------------
;Data for subroutine print number
;--------------------------------
	NDEC_1 .FILL #-1
	BU_R7_PRINT .BLKW #1
.END
