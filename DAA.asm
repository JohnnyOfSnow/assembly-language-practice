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
	call WriteHex
	exit
main ENDP

DAAItself PROC
	push al
	and al,11110000b
	.IF	al > 9h && 
		add al,6h
	.ELSE
		pop al
	.ENDIF

	push al
	and al,00001111b

	.IF	al > 9h && 
		add al,60h
	.ELSE
		pop al
	.ENDIF

DAAItself ENDP

END main
