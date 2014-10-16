TITLE MASM Template						(main.asm)

TITLE Copying a String                  (CopyStr.asm)

; This program copies a string.

INCLUDE Irvine32.inc

.data
source  BYTE 30 DUP(?)
target  BYTE  SIZEOF source DUP(0),0


.code
main PROC
	
	mov edx,OFFSET source
	mov ecx,SIZEOF source
	call ReadString

	mov  esi,0			; index register
	mov  ecx,SIZEOF source	; loop counter
L1:
	mov  al,source[esi]		; get a character from source
	mov  target[esi],al		; store it in the target
	inc  esi				; move to next character
	loop L1				; repeat for entire string

	mov edx,OFFSET target
	call WriteString

	exit
main ENDP
END main
