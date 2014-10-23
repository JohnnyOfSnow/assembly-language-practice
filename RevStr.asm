TITLE MASM Template						(main.asm)

TITLE Reversing a String          (RevStr.asm)

; This program reverses a string.

INCLUDE Irvine32.inc

.data
aName BYTE 50 DUP(?)
nameSize DWORD ?

.code
main PROC

	mov edx,OFFSET aName
	mov ecx,SIZEOF aName
	call ReadString
	mov nameSize,eax

; Push the name on the stack.

	mov	ecx,nameSize
	mov	esi,0

L1:	movzx eax,aName[esi]	; get character
	push	eax				; push on stack
	inc	esi
	loop L1

; Pop the name from the stack, in reverse,
; and store in the aName array.

	mov	ecx,nameSize
	mov	esi,0

L2:	pop eax				; get character
	mov	aName[esi],al		; store in string
	inc	esi
	loop L2

; Display the name.

	mov  edx,OFFSET aName
	call Writestring
	call Crlf

	exit
main ENDP
END main
