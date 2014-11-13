TITLE Finite State Machine              (FSMforHexNumber.asm)

; This program implements a finite state machine that
; accepts an integer with an optional leading sign.

INCLUDE Irvine32.inc

ENTER_KEY = 13
.data
InvalidInputMsg BYTE "Invalid input",13,10,0

.code
main PROC
	call Clrscr

StateA:
	call	Getnext       		; read next char into AL
	call	IsDigit       		; ZF = 1 if AL contains a digit
	jz	StateB			; go to State B
	call	IsAF       	; ZF = 1 if AL contains a A--F
	jz	StateB			; go to State B
	call	DisplayErrorMsg  	; invalid input found
	jmp	Quit

StateB:
	call	Getnext       		; read next char into AL
	cmp al,'h'
	je Quit
	call	IsDigit       		; ZF = 1 if AL contains a digit
	jz	StateB
	call	IsAF       	; ZF = 1 if AL contains a A--F
	jz	StateB			; go to State B
	cmp	al,ENTER_KEY		; Enter key pressed?
	je	Quit				; yes: quit
	call	DisplayErrorMsg  	; invalid input found
	jmp	Quit


Quit:
	call	Crlf
	exit
main ENDP

;-----------------------------------------------
Getnext PROC
;
; Reads a character from standard input.
; Receives: nothing
; Returns: AL contains the character
;-----------------------------------------------
	 call ReadChar			; input from keyboard
	 call WriteChar		; echo on screen
	 ret
Getnext ENDP

;-----------------------------------------------
DisplayErrorMsg PROC
;
; Displays an error message indicating that
; the input stream contains illegal input.
; Receives: nothing. 
; Returns: nothing
;-----------------------------------------------
	 push  edx
	 call Crlf
	 mov	  edx,OFFSET InvalidInputMsg
	 call  WriteString
	 pop	  edx
	 ret
DisplayErrorMsg ENDP

;------------------------------------------------
IsAF PROC
;------------------------------------------------
	cmp al,'A'
	jb ID1
	cmp al,'F'
	ja ID1
	test ax,0
ID1: ret
IsAF ENDP
END main
