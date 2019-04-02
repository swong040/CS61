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
	BR END
YEE
	LEA R0, PALPAL
	PUTS
	BR END
END
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
	
	JSR SUB_TO_UPPER

	LD R1, STIRNG		;FRONT
	ADD R2, R1, R5		;END
	ADD R2, R2, #-1
	LD R4, DEC_0		;YES/NO

CHECK_CHAR
	LDR R3, R1, #0		;FRONT VAL
	LDR R5, R2, #0		;END VAL

	ADD R1, R1, #1
	ADD R2, R2, #-1
	
	NOT R6, R1
	ADD R6, R6, #1
	
	NOT R3, R3
	ADD R3, R3, #1

	ADD R0, R3, R5
	BRnp NOTPAL

	ADD R0, R2, R6
	BRzp CHECK_CHAR
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

	SPACE .FILL #-32
	DEC_0 .FILL #0

	STIRNG .FILL x0000
	SUB_TO_UPPER .FILL x3800

;------------------------------------------------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R0): Starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case in-place
;i.e. the upper-case string has replaced the original string
; No return value.
;------------------------------------------------------------------------------------------------------------------

.ORIG x3800	;TO UPPER
	ST R7, BU_R7_UPPER
	ST R1, BU_R1_UPPER
	ST R2, BU_R2_UPPER
	ST R3, BU_R3_UPPER
	ST R5, BU_R5_UPPER
	ST R6, BU_R6_UPPER

	LD R3, a_CAP		;IF BETWEEN x61 - x7A, a-z
	NOT R3, R3
	ADD R3, R3, #1
	LD R5, DIFF
	NOT R5, R5
	ADD R5, R5, #1
	LD R1, OG
	LDR R2, R1, #0
CHANGE
	ADD R6, R2, R3
	BRzp CHANGE_LETTER
	BRn NEXT
CHANGE_LETTER
	ADD R6, R2, R5
	STR R6, R1, #0
NEXT
	ADD R1, R1, #1
	LDR R2, R1, #0	
	BRnp CHANGE

;	ST R1, OG
	
	LD R7, BU_R7_UPPER
	LD R1, BU_R1_UPPER
	LD R2, BU_R2_UPPER
	LD R3, BU_R3_UPPER
	LD R5, BU_R5_UPPER
	LD R6, BU_R6_UPPER
RET
	a_CAP .FILL x61
;	U_LETTER .FILL #-26
	DIFF .FILL x20

	OG .FILL x0000
	
	BU_R7_UPPER .BLKW #1
	BU_R1_UPPER .BLKW #1
	BU_R2_UPPER .BLKW #1
	BU_R3_UPPER .BLKW #1
	BU_R5_UPPER .BLKW #1
	BU_R6_UPPER .BLKW #1
	
.END

