TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
myMessage BYTE "Assembly language program example",0dh,0ah,0

.code
main PROC
	call Clrscr

	mov	 edx,OFFSET myMessage
	call WriteString

	mov al,35h
	add al,48h
	call DAAItself
	call WriteHex
	exit
main ENDP

DAAItself PROC
	push eax
	and al,00F0h
	.IF	al > 9h 
		pop eax
		add eax,6h
	.ELSE
		pop eax
	.ENDIF

	push eax
	and al,00F0h

	.IF	al > 9h && CARRY?
		pop eax
		add eax,60h
		stc    ; carry = 1
	.ELSE
		clc    ; carry = 0
		pop eax
	.ENDIF
	ret
DAAItself ENDP

END main
