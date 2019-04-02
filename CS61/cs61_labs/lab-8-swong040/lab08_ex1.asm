;=================================================
; Name: Sabrina Wong
; Email:  swong040@ucr.edu
; 
; Lab: lab 8
; Lab section: B21
; TA: Jason Goulding
;=================================================

.ORIG x3000
	LD R1, SUB_GET_STRING
	JSRR R1

HALT
	SUB_GET_STRING .FILL x3200

;----------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R0): The address of where to start storing the string
; Postcondition: The subroutine has allowed the user to input a string,
; terminated by the [ENTER] key, and has stored it in an array
; that starts at (R0) and is NULL-terminated.
; Return Value: R5 The number of non-sentinel characters read from the user
;-----------------------------------------------------------------------------------------------------------------
.ORIG x3200	;SUB_GET_STRING
	ST R7, BU_R7_STRING
	ST R1, BU_R1_STRING

	AND R0, R0, #0
	ST R0, string

	AND R5, R5, #0
	LD R1, string

	LEA R0, get_string
	PUTS
USERINPUT
	GETC
	OUT
	ADD R3, R0, #-10
	BRz END	

	STR R0, R1, #0
	ADD R1, R1, #1
	ADD R5, R5, #1

	ADD R3, R0, #-10
	BRnp USERINPUT
END
	LD R0, string		;OUTPUT STRING
	PUTS
	LEA R0, NEWLINE
	PUTS

; NEED TO OUTPUT DECIMAL ?

	LD R1, BU_R1_STRING
	LD R7, BU_R7_STRING
RET
	get_string .STRINGZ "ENTER STRING OF TEXT FOLLOWED BY 'ENTER'.\n"

	string 
	BU_R1_STRING .BLKW #1
	BU_R7_STRING .BLKW #1

	ASCII .FILL #48
	NEWLINE .STRINGZ "\n"
;--------------------------------------------------------------------

.END
