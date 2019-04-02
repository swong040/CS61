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

	LD R2, SUB_IS_A_PALINDROME
	JSRR R2

	ADD R4, R4, #0
	BRz NOPE
	BRp YEE
NOPE
	LEA R0, NOPAL
	PUTS
	BR END2HALT
YEE
	LEA R0, PALPAL
	PUTS
	BR END2HALT
END2HALT
HALT
	SUB_IS_A_PALINDROME .FILL x3400
	SUB_GET_STRING .FILL x3200

	NOPAL .STRINGZ " IS NOT A PALINDROME\n"
	PALPAL .STRINGZ " IS A PALINDROME\n"

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
	BRz END_USERINPUT

	STR R0, R1, #0
	ADD R1, R1, #1
	ADD R5, R5, #1		;COUNT

	ADD R3, R0, #-10
	BRnp USERINPUT
END_USERINPUT
	LD R0, string		;OUTPUT STRING
	PUTS
;	LEA R0, NEWLINE
;	PUTS

; NEED TO OUTPUT DECIMAL ?

	LD R1, BU_R1_STRING
	LD R7, BU_R7_STRING
RET
	get_string .STRINGZ "ENTER STRING OF TEXT FOLLOWED BY 'ENTER'.\n"

	string 			;x0000
	BU_R1_STRING .BLKW #1
	BU_R7_STRING .BLKW #1

	ASCII .FILL #48
	NEWLINE .STRINGZ "\n"

;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_IS_A_PALINDROME
; Parameter (R0): The address of a string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R0) is
; a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;------------------------------------------------------------------------------------------------------------------
.ORIG x3400	;PALINDROME
	ST R2, BU_R2_PAL
	ST R5, BU_R5_PAL
	ST R7, BU_R7_PAL

	LD R1, STIRNG		;BEGINNING
	ADD R2, R1, R5		;END
	ADD R2, R2, #-1
	LD R4, DEC_0		;YES/NO
CHAR
	LDR R3, R1, #0
	LDR R5, R2, #0

	ADD R1, R1, #1
	ADD R2, R2, #-1
	
	NOT R6, R1
	ADD R6, R6, #1
	
	NOT R3, R3
	ADD R3, R3, #1

	ADD R0, R3, R5
	BRnp NOTPAL

	ADD R0, R2, R6
	BRzp CHAR
END_CHAR

ISPAL
	ADD R4, R4, #1
	LD R2, BU_R2_PAL
	LD R5, BU_R5_PAL
	LD R7, BU_R7_PAL
RET
NOTPAL
	LD R2, BU_R2_PAL
	LD R5, BU_R5_PAL
	LD R7, BU_R7_PAL
RET
	BU_R2_PAL .BLKW #1
	BU_R5_PAL .BLKW #1
	BU_R7_PAL .BLKW #1

	DEC_0 .FILL #0
	STIRNG .FILL x0000
	
.END

