TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
myMessage BYTE "Assembly language program example",0dh,0ah,0

.code
main PROC
	call Clrscr

	mov	 edx,OFFSET myMessage
	call WriteString

	mov al,69h
	add al,29h
	call DAAItself
	call WriteHex
	call Crlf
	mov al,35h
	add al,48h
	call DAAItself
	call WriteHex

	call Crlf
	mov al,35h
	add al,65h
	call DAAItself
	call WriteHex
	exit
main ENDP

DAAItself PROC
	push eax
	and al,00F0h
	LAHF                    ;旗標暫存器的 bit0~bit7 的內容存入 AH
	bt eax,19
	jc L1
	.IF	al > 9h             ;If (AL(lo) > 9) or (AuxCarry = 1)
		L1:
		pop eax				
		add eax,6h			;AL = AL + 6
		bts eax,11
		SAHF
		clc
	.ELSE
		pop eax
	.ENDIF
	push eax
	
	and al,00F0h

	.IF	al > 90h || CARRY?	;If (AL(hi) > 9) or Carry = 1
		add eax,60h			;AL = AL + 60h
		push eax
		stc					; carry = 1
	.ELSE
		clc					; carry = 0
	.ENDIF
	pop eax
	ret
DAAItself ENDP

END main
