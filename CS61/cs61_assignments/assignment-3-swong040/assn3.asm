;=================================================
; Name: Sabrina Wong
; Email: swong040@ucr.edu
; 
; Assignment name: Assignment 3
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
LD R6, Convert_addr		; R6 <-- Address pointer for Convert
LDR R1, R6, #0			; R1 <-- VARIABLE Convert 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

LD R2, DEC_15
LD R3, DEC_4
LD R4, DEC_0

DO_WHILE
	ADD R1, R1, R4

	BRzp POS
	BRn END_POS
POS
	LD R0, ASCII_0
	OUT
END_POS

	BRn NEG
	BRzp END_NEG
NEG
	LD R0, ASCII_1
	OUT
END_NEG

	ADD R3, R3, #-1
	BRnp NO_SPACE

	LD R0, SPACE
	OUT
	LD R3, DEC_4
NO_SPACE

	ADD R4, R1, #0
	ADD R2, R2, #-1
	BRnp DO_WHILE

ADD R1, R1, R4
BRzp POST
BRn END_POST
POST
	LD R0, ASCII_0
	OUT
END_POST

BRn NEGA
BRzp END_NEGA
NEGA
	LD R0, ASCII_1
	OUT
END_NEGA

	LEA R0, NEWLINE
	PUTS
	
HALT
;---------------	
;Data
;---------------
Convert_addr .FILL xD000	; The address of where to find the data
DEC_15 .FILL #15
DEC_4 .FILL #4
DEC_0 .FILL #0
ASCII_0 .FILL #48
ASCII_1 .FILL #49
SPACE .FILL #32
NEWLINE .STRINGZ "\n"


.ORIG xD000			; Remote data
Convert .FILL xABCD		; <----!!!NUMBER TO BE CONVERTED TO BINARY!!!
;---------------	
;END of PROGRAM
;---------------	
.END
