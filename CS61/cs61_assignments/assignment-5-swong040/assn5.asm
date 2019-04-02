;=================================================
; Name: Sabrina Wong
; Email: swong040@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: B21
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

RESET
	LD R1, MENU
	JSRR R1
;R1 : OPTION #
	LEA R0, NEWLINE
	PUTS

	ADD R3, R1, #-7
	BRz ENDpr

	LD R2, JUMP_TO
	LD R3, OFFSET
OPTION				;ADD R1 * x0200 TO x3200 TO GO TO SUBR
	ADD R2, R2, R3
	ADD R1, R1, #-1
	BRp OPTION

	JSRR R2
BR RESET
ENDpr
	LEA R0, Goodbye
	PUTS

HALT
;---------------	
;Data
;---------------
;Add address for subroutines
	MENU .FILL x3200
;Other data 
	JUMP_TO .FILL x3200
	OFFSET .FILL x0200

	NEWLINE .STRINGZ "\n"
;Strings for options
Goodbye .Stringz "Goodbye!\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, allowed the
;                          user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7
; no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.ORIG x3200	;MENU
	ST R7, BU_R7_MENU

	LD R2, ASCII_0
MENU_SUB
	LD R0, Menu_string_addr
	PUTS
	GETC
	OUT

	ADD R0, R0, R2		;IS OR LESS THAN 0
	BRnz INVALID
	ADD R3, R0, #-7		;MORE THAN 7
	BRp INVALID

	ADD R1, R0, #0		
	LD R7, BU_R7_MENU
RET
INVALID
	LEA R0, Error_message_1
	PUTS
	BR MENU_SUB	
;--------------------------------
;Data for subroutine MENU
;--------------------------------
	ASCII_0 .FILL #-48
	BU_R7_MENU .BLKW #1

Error_message_1 .STRINGZ "\nINVALID INPUT\n"
Menu_string_addr .FILL x6000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 0 if all machines are busy,    1 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.ORIG x3400	;ALL_BUSY OPTION 1
	ST R7, BU_R7_ABUSY
	ST R4, BU_R4_ABUSY

	LD R2, BUSYNESS_ADDR_ALL_MACHINES_BUSY
	LDR R1, R2, #0
	
	LD R2, DEC_15_3400
	LD R4, DEC_0_3400
	
CHECK_0
	ADD R1, R1, R4
	BRn NOT_BUSY
	ADD R4, R1, #0
	ADD R2, R2, #-1
	BRzp CHECK_0
END_CHECK_0

BUSY:
	LEA R0, ALLBUSY
	PUTS
	LD R4, BU_R4_ABUSY
	LD R7, BU_R7_ABUSY
	RET

NOT_BUSY:
	LEA R0, ALLNOTBUSY
	PUTS
	LD R4, BU_R4_ABUSY
	LD R7, BU_R7_ABUSY
	RET
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
	BU_R7_ABUSY .BLKW #1
	DEC_15_3400 .FILL #15
	BU_R4_ABUSY .BLKW #1
	DEC_0_3400 .FILL #0
ALLNOTBUSY .Stringz "Not all machines are busy\n"
ALLBUSY .Stringz "All machines are busy\n"
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xD000		;MACHINE

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free,    0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
.ORIG x3600	;ALL_FREE OPTION 2
	ST R7, BU_R7_AFREE

	LD R2, BUSYNESS_ADDR_ALL_MACHINES_FREE
	LDR R1, R2, #0
	
	LD R2, DEC_15_3600

CHECK_1
	ADD R1, R1, R1
	BRzp NOT_FREE
	ADD R2, R2, #-1
	BRp CHECK_1
END_CHECK_1

FREE:
	LEA R0, ALLFREE
	PUTS
	LD R7, BU_R7_AFREE
	RET

NOT_FREE:
	LEA R0, ALLNOTFREE
	PUTS
	LD R7, BU_R7_AFREE
	RET
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
	BU_R7_AFREE .BLKW #1
	DEC_15_3600 .FILL #15
ALLFREE .STRINGZ "All machines are free\n"
ALLNOTFREE .STRINGZ "Not all machines are free\n"
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xD000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R2): The number of machines that are busy
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.ORIG x3800	;NUM_BUSY OPTION
	ST R7, BU_R7_NBUSY
	
	LD R2, BUSYNESS_ADDR_NUM_BUSY_MACHINES
	LDR R1, R2, #0

	LD R2, DEC_15_3800
	LD R4, DEC_0_3800

COUNT_0
	ADD R1, R1, #0
	BRn SKIP_COUNT_BUSY
	COUNT_BUSY:
	    ADD R4, R4, #1

SKIP_COUNT_BUSY:
	ADD R1, R1, R1
	ADD R2, R2, #-1
	BRzp COUNT_0
END_COUNT_0

	LEA R0, BUSYMACHINE1
	PUTS

	ADD R3, R4, #0
	LD R0, PRINT_BUSY
	JSRR R0
    
	LEA R0, BUSYMACHINE2
	PUTS 

	LD R7, BU_R7_NBUSY
	RET

;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
	BU_R7_NBUSY	.BLKW #1
	DEC_15_3800 .FILL #15
	DEC_0_3800 .FILL #0
	NDEC_1_3800 .FILL #-1
	PRINT_BUSY .FILL x7400

BUSYMACHINE1 .STRINGZ "There are "
BUSYMACHINE2 .STRINGZ " busy machines\n"
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xD000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R2): The number of machines that are free 
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.ORIG x3A00	;NUM_FREE OPTION 4
	ST R7, BU_R7_NFREE

	LD R2, BUSYNESS_ADDR_NUM_FREE_MACHINES
	LDR R1, R2, #0

	LD R2, DEC_15_3A00
	LD R3, DEC_0_3A00

COUNT_1
	ADD R1, R1, #0
	BRzp SKIP_COUNT_FREE
	COUNT_FREE:
	    ADD R3, R3, #1

SKIP_COUNT_FREE:
	ADD R1, R1, R1
	ADD R2, R2, #-1
	BRzp COUNT_1
END_COUNT_1

	LEA R0,	FREEMACHINE1
	PUTS

	LD R0, PRINT_FREE
	JSRR R0

	LEA R0, FREEMACHINE2
	PUTS 

	LD R7, BU_R7_NFREE
	RET
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES
;--------------------------------
	BU_R7_NFREE	.BLKW #1
	DEC_15_3A00 .FILL #15
	DEC_0_3A00 .FILL #0
	NDEC_1_3A00 .FILL #-1

	PRINT_FREE .FILL x7400

FREEMACHINE1 .STRINGZ "There are "
FREEMACHINE2 .STRINGZ " free machines\n"
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xD000

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS
; Input (R1): Which machine to check
; Postcondition: The subroutine has returned a value indicating whether the machine indicated
;                          by (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.ORIG x3C00	;STATUS OPTION 5
	ST R7, BU_R7_STATUS  

	LD R0, STATUS_INPUT
	JSRR R0

	ADD R5, R2, #0			;IS LESS THAN 0
	BRn INVALID1
	ADD R5, R2, #-15		;IS MORE THAN 15
	BRp INVALID1
		
	LEA R0, STATUS1
	PUTS

	ADD R3, R2, #0
	LD R0, PRINT_STATUS
	JSRR R0

LD R3, BUSYNESS_ADDR_MACHINE_STATUS
LDR R1, R3, #0

	NOT R2, R2
	ADD R2, R2, #15
	ADD R2, R2, #1

GO_TO
	ADD R2, R2, #0
	BRz RESULT

	ADD R1, R1, R1
	ADD R2, R2, #-1
	BRzp GO_TO
END_GO_TO

RESULT:
	ADD R1, R1, #0
	BRn IS_FREE
	BRzp IS_BUSY

IS_FREE:
	LEA R0, STATUS3
	PUTS
	LD R7, BU_R7_STATUS
	RET   

IS_BUSY:
	LEA R0, STATUS2
	PUTS
	LD R7, BU_R7_STATUS  
	RET

INVALID1
	LEA R0, error_mes
	PUTS
	LD R7, BU_R7_STATUS
	LD R0, BEGIN
	JMP R0
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
	BU_R7_STATUS   .BLKW #1
	NDEC_1_3C00 .FILL #-1
	PRINT_STATUS .FILL x7400
	STATUS_INPUT .FILL x7000
	BEGIN .FILL x3C00
	ASC9 .FILL #-57

error_mes .STRINGZ	"ERROR INVALID INPUT\n"
BUSYNESS_ADDR_MACHINE_STATUS .Fill xD000
STATUS1 .STRINGZ "Machine "
STATUS2  .STRINGZ " is busy\n"
STATUS3 .STRINGZ " is free\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE
; Inputs: None
; Postcondition: 
; The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R2): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.ORIG x3E00	;FIRST_FREE OPTION 6		;FIX CANT GET x0000 NONE FREE
	ST R7, BU_R7_FIRST

	LD R2, DEC_15_3E00	;start at pos15

	LD R3, BUSYNESS_ADDR_FIRST_FREE
	LDR R1, R3, #0

	ADD R1, R1, #0		; if R1 = x0000
	BRz NOTHING		; GO TO PRINT NONE
LOOK
	ADD R1, R1, #0		; if r1 = +/-
	BRzp NOT_FREE1		; if +(0), go to not free
	ADD R3, R2, #0		; else (1) put FREE(1) position in r3
				; continue to not_free
NOT_FREE1:
	ADD R1, R1, R1		; bit shift
	ADD R2, R2, #-1		; subtract position
	BRzp LOOK		; loop again to check
	BRn END_FREE
END_FREE


FOUND:
	LEA R0, FIRSTFREE1
	PUTS

	LD R0, PRINT_FIRST
	JSRR R0	

	LEA R0, FIRSTFREE2
	PUTS
	LD R7, BU_R7_FIRST
	RET 

NOTHING:
	LEA R0, FIRSTFREE3
	PUTS
	LD R7, BU_R7_FIRST
	RET    
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
	BU_R7_FIRST	.BLKW #1 
	DEC_15_3E00 .FILL #15
	DEC_10_3E00 .FILL #10
	NDEC_1_3E00 .FILL #-1
	PRINT_FIRST .FILL x7400

BUSYNESS_ADDR_FIRST_FREE .Fill xD000
FIRSTFREE1 .STRINGZ "The first available machine is number "
FIRSTFREE2 .STRINGZ "\n"
FIRSTFREE3 .STRINGZ "No machines are free\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: Get input
; Inputs: None
; Postcondition: 
; The subroutine get up to a 5 digit input from the user within the range [-32768,32767]
; Return Value (R1): The value of the contructed input
; NOTE: This subroutine should be the same as the one that you did in assignment 5
;	to get input from the user, except the prompt is different.
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x7000	;GET USERIPUT RETURN TO R2
	ST R7, BU_R7_INPUT
	ST R3, BU_R3_INPUT
	ST R4, BU_R4_INPUT
	ST R5, BU_R5_INPUT

	LEA R0, prompt
	PUTS

	LD R2, DEC_0

	GETC			;SINGLE DIGIT OR DASH
	ADD R3, R0, #-10
	BRz INVALID2
	OUT

	LD R3, DASH		;CHECK FOR DASH
	ADD R3, R0, R3
	BRn INVALID2
	BRp SIGNED		;NO SIGN CONTINUE

SIGN
	GETC
	;OUT

	ADD R3, R0, #-10	;IF (ENTER) AFTER -
	BRz INVALID2
	
	LD R4, ASC
	ADD R3, R0, R4		;GET ACTUAL VALUE
	BRn INVALID2		;IF NOT 0-9
	ADD R3, R3, #-9
	BRp INVALID2

	AND R4, R4, #0
	ADD R2, R2, #0		; R2 x 10
	
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4

	ADD R2, R2, R3		; SINGLE DIGIT
	ADD R4, R2, #0
	OUT

	GETC
	ADD R3, R0, #-10	;NEGATIVE SINGLE DIGIT
	BRz INVALID2		;(ENTER) GO TO CHECK, RET INVALID
	OUT			;ELSE
	LD R4, ASC
	ADD R3, R0, R4		;GET ACTUAL VALUE
	BRn INVALID2		;IF NOT 0-9
	ADD R3, R3, #-9
	BRp INVALID2

	AND R4, R4, #0
	ADD R2, R2, #0		; R2 x 10
	
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4

	ADD R2, R2, R3		; DOUBLE DIGIT
	ADD R4, R2, #0

	GETC
	BR INVALID2

SIGNED
	LD R4, ASC
	ADD R3, R0, R4		;GET ACTUAL VALUE
	BRn INVALID2		;IF NOT 0-9
	ADD R4, R3, #-9
	BRp INVALID2

	AND R4, R4, #0		; R4 CLEARED
	ADD R2, R2, #0		; R2 x 10
	
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4

	ADD R2, R2, R3		; SINGLE DIGIT
	ADD R4, R2, #0		; R4 = R2 SO NEXT TIME IT CAN (x 10)

	GETC
	ADD R3, R0, #-10	;CHECK (ENTER)
	BRz FINISH_ASK

	OUT			;ELSE
	LD R5, ASC
	ADD R3, R0, R5		;GET ACTUAL VALUE
	BRn INVALID2		;IF NOT 0-9
	ADD R5, R3, #-9
	BRp INVALID2

	ADD R2, R2, #0		; R2 x 10
	
	ADD R2, R2, R4		; R2 + R2
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
	ADD R2, R2, R4
				;ADD R3 AS ONES
	ADD R2, R2, R3		; DOUBLE DIGIT
	ADD R4, R2, #0		;return actual value

	GETC
	ADD R3, R0, #-10
	BRz FINISH_ASK
	BRnp INVALID2

FINISH_ASK
	LEA R0, NEW
	PUTS
	LD R3, BU_R3_INPUT
	LD R4, BU_R4_INPUT
	LD R5, BU_R5_INPUT
	LD R7, BU_R7_INPUT
	RET

INVALID2
	LEA R0, Error_message_2
	PUTS
	LD R3, BU_R3_INPUT
	LD R4, BU_R4_INPUT
	LD R5, BU_R5_INPUT
	LD R7, BU_R7_INPUT
	LD R0, BEGIN2
	JMP R0
;--------------------------------
;Data for subroutine Get input
;--------------------------------
	DASH .FILL  #-45
	BU_R3_INPUT .BLKW #1
	BU_R4_INPUT .BLKW #1
	BU_R5_INPUT .BLKW #1
	BU_R7_INPUT .BLKW #1
	DEC_0 .FILL #0
	NEW .STRINGZ "\n"
	BEGIN2 .FILL x7000
	ASC .FILL #-48

prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_message_2 .STRINGZ "\nERROR INVALID INPUT\n"

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
	BU_R7_PRINT

.ORIG x6000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xD000			; Remote data
BUSYNESS .FILL x8000		; <----!!!VALUE FOR BUSYNESS VECTOR!!!

;---------------	
;END of PROGRAM
;---------------	
.END

