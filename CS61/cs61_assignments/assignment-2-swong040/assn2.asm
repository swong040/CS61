;=================================================
; Name: Sabrina Wong
; Email: swong040@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;outputs prompt
;----------------------------------------------	
LEA R0, intro			; 
PUTS				; Invokes BIOS routine to output string


GETC
OUT
ADD R1, R0, #0
LEA R0, NEWLINE
PUTS

GETC
OUT
ADD R2, R0, #0
LEA R0, NEWLINE
PUTS

NOT R3, R2
ADD R3, R3, #1

ADD R0, R1, #0
OUT

LEA R0, MINUS
PUTS

ADD R0, R2, #0
OUT

LEA R0, EQUAL
PUTS

ADD R4, R1, R3
BRzp PRINT_NEG

	LD R0, DASH
	OUT
	NOT R4, R4
	ADD R4, R4, #1

PRINT_NEG
	ADD R0, R4, #0
	LD R5, ASCII_0
	ADD R0, R0, R5
	OUT

	LEA R0, NEWLINE
	PUTS


HALT				; Stop execution of program
;------	
;Data
;------
; String to explain what to input 
intro .STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 
NEWLINE .STRINGZ "\n"	; String that holds the newline character
MINUS .STRINGZ " - "
EQUAL .STRINGZ " = "
DASH .FILL #45
ASCII_0 .FILL #48


;---------------	
;END of PROGRAM
;---------------	
.END

