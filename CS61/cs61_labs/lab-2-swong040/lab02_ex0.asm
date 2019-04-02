;=================================================
; Name: SABRINA WONG
; Email:  SWONG040@UCR.EDU
; 
; Lab: lab 2
; Lab section: B21
; TA: JASON GOULDING
; 
;=================================================

.ORIG x3000
;------------------
;INSTRUCTIONS
;------------------
	LEA R0, MSG_TO_PRINT
	PUTS

	HALT
;------------------
;LOCAL DATA
;------------------
	MSG_TO_PRINT .STRINGZ "Hello world!!!\n"


.END
