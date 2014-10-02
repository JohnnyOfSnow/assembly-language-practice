TITLE MASM Template						(main.asm)

; This program adds and subtracts 32-bit integers
; and stores the sum in a variable.

INCLUDE Irvine32.inc

.data
val1     dword  ?
val2     dword  ?
val3     dword  ?
finalVal dword  ?

.code
main PROC
	call ReadHex
	mov	val1,eax
	call ReadHex
	mov	val2,eax
	call ReadHex
	mov	val3,eax
	mov	eax,val1			
	add	eax,val2			
	sub	eax,val3			
	call WriteHex
	

	exit
main ENDP
END main
