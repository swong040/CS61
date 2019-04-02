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
	ADD R2, R2, #5
	
DO_PUSH
	LD R1, PUSH		;PUSH?
	JSRR R1

	ADD R3, R3, #0
	BRz END
	BR DO_PUSH
END
	LEA R0, DONE
	PUTS

DO_POP
	LEA R0, POP_		;POP?
	PUTS
	GETC
	OUT

	ADD R3, R0, #-10
	BRz END_POP

	LEA R0, NEWLINE
	PUTS

	LD R1, POP
	JSRR R1
	BR DO_POP
END_POP

HALT
	MAX .FILL xA005
	BASE .FILL xA000
	PUSH .FILL x3200
	POP .FILL x3400
	DONE .STRINGZ "DONE\n"
	POP_ .STRINGZ "PRESS ANY KEY TO POP, (ENTER) TO QUIT\n"
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

.ORIG x3200	;PUSH
	ST R7, BU_R7_PUSH

	LEA R0, INTRO
	PUTS
	GETC
	OUT

	ADD R3, R0, #-10
	BRz END_PUSH

	LD R5, MAX_PUSH
	NOT R5, R5
 	ADD R5, R5, #1
	ADD R2, R6, R5			; TOS - MAX = (-)
	BRzp OVERFLOW

	ADD R6, R6, #1			;TOS++

	ADD R0, R0, #-15
	ADD R0, R0, #-15
	ADD R0, R0, #-15
	ADD R0, R0, #-3			;DIGIT

	STR R0, R6, #0			;R0 --> TOS

	LEA R0, NEWLINE_PUSH
	PUTS
	LD R7, BU_R7_PUSH
	RET

OVERFLOW
	LEA R0, OVER
	PUTS
	LD R7, BU_R7_PUSH
	HALT
END_PUSH
	LD R7, BU_R7_PUSH
	RET
;---------------
;DATA
;---------------

	MAX_PUSH .FILL xA005
	BU_R7_PUSH .BLKW #1
	INTRO .STRINGZ "INPUT VALUE, (ENTER) TO END\n"
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
.ORIG x3400	;POP
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



