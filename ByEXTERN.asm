TITLE Swap Procedure Example                 (main.asm)

; This program demonstrates a procedure that exchanges
; two integers using their pointers. Shows how to use
; PROTO, PROC, and INVOKE.

INCLUDE Irvine32.inc

EXTERN Swap@0:PROC

;redefine
Swap EQU Swap@0



.data
Array  SDWORD  2 DUP(?)
myMessage BYTE "Start to enter two number",0dh,0ah,0
myMessage1 BYTE "The first number: ",0dh,0ah,0
myMessage2 BYTE "The second number: ",0dh,0ah,0
myMessage3 BYTE "After exchange: ",0dh,0ah,0
.code
main PROC
	call Clrscr
	mov	 edx,OFFSET myMessage
	call WriteString
	call Crlf
	
	

	; Display the array before the exchange:
	
	mov  esi,OFFSET Array
	mov  ecx,2				; count = 2
	mov  ebx,TYPE Array
	
	mov	 edx,OFFSET myMessage1
	call WriteString
	call ReadInt
	mov [esi],eax
	mov	 edx,OFFSET myMessage2
	call WriteString
	call ReadInt

	mov[esi+4],eax
	push OFFSET Array
	call Swap

	; Display the array after the exchange:
	mov	 edx,OFFSET myMessage3
	call WriteString
	mov	 edx,OFFSET myMessage1
	call WriteString
	mov  esi,OFFSET Array
	mov eax,[esi]
	call WriteInt
	call Crlf
	mov	 edx,OFFSET myMessage2
	call WriteString
	mov eax,[esi + 4]
	call WriteInt
	call Crlf
	exit
main ENDP

END main
