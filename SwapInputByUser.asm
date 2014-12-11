TITLE Swap Procedure Example                 (Swap.asm)

; This program demonstrates a procedure that exchanges
; two integers using their pointers. Shows how to use
; PROTO, PROC, and INVOKE.

INCLUDE Irvine32.inc

Swap PROTO,			; procedure prototype
	pValX:PTR DWORD,
	pValY:PTR DWORD

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

	INVOKE Swap,ADDR Array, ADDR [Array+4]

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

;-------------------------------------------------------
Swap PROC USES eax esi edi,
	pValX:PTR DWORD,	; pointer to first integer
	pValY:PTR DWORD	; pointer to second integer
;
; Exchange the values of two 32-bit integers
; Returns: nothing
;-------------------------------------------------------
	mov esi,pValX		; get pointers
	mov edi,pValY
	mov eax,[esi]		; get first integer
	xchg eax,[edi]		; exchange with second
	mov [esi],eax		; replace first integer
	ret
Swap ENDP

END main
