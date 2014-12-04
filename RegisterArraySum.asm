TITLE Integer Summation Program		     (Sum2.asm)

; This program prompts the user for three integers, 
; stores them in an array, calculates the sum of the
; array, and displays the sum.

INCLUDE Irvine32.inc

INTEGER_COUNT = 3

.data
str1  BYTE  "Enter a signed integer: ",0
str2  BYTE  "The sum of the integers is: ",0
array DWORD  INTEGER_COUNT DUP(?)
sum DWORD ?
.code 
main PROC
	call	Clrscr
	push OFFSET array
	push INTEGER_COUNT
	call	PromptForIntegers
	push OFFSET array
	push INTEGER_COUNT
	call	ArraySum
	call	DisplaySum
	exit
main ENDP

;-----------------------------------------------------
PromptForIntegers PROC 
;
; Prompts the user for an arbitrary number of integers 
; and inserts the integers into an array.
; Receives: ESI points to the array, ECX = array size
; Returns:  nothing
;-----------------------------------------------------
	push ebp
	mov ebp,esp
	pushad
	mov esi,[ebp + 12]
	mov ecx,[ebp + 8]
	mov	edx,OFFSET str1		; "Enter a signed integer"
L1:	call	WriteString		; display string
	call	ReadInt			; read integer into EAX
	call	Crlf				; go to next output line
	mov	[esi],eax			; store in array
	add	esi,TYPE DWORD		; next integer
	loop	L1
	popad
	pop ebp
	ret 8
PromptForIntegers ENDP

;-----------------------------------------------------
ArraySum PROC 
;
; Calculates the sum of an array of 32-bit integers.
; Receives: ESI points to the array, ECX = number 
;   of array elements
; Returns:  EAX = sum of the array elements
;-----------------------------------------------------
	push ebp
	mov ebp,esp
	pushad
	mov esi,[ebp + 12]
	mov ecx,[ebp + 8]
	mov	eax,0		; set the sum to zero
L1:	add	eax,[esi]		; add each integer to sum
	add	esi,TYPE DWORD	; point to next integer
	loop	L1			; repeat for array size
	mov sum,eax
	popad
	pop ebp
	ret 8
ArraySum ENDP

;-----------------------------------------------------
DisplaySum PROC 
;
; Displays the sum on the screen
; Receives: EAX = the sum
; Returns:  nothing
;-----------------------------------------------------
	mov	edx,OFFSET str2	; "The sum of the..."
	call	WriteString
	mov eax,sum
	call	WriteInt			; display EAX
	call	Crlf
	ret
DisplaySum ENDP
END main
