TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
myMessage BYTE "Assembly language program example",0dh,0ah,0
display0 BYTE "2個16位進數相加  用BCD的方式，每次的結果請看最後2位",0
display1 BYTE "69h + 29h",0
display2 BYTE "35h + 48h",0
display3 BYTE "35h + 65h",0

.code
main PROC
	call Clrscr

	mov	 edx,OFFSET display0
	call WriteString
	call Crlf

	mov	 edx,OFFSET display1
	call WriteString
	call Crlf

	mov al,69h
	add al,29h
	call DAAItself
	call WriteHex
	call Crlf
	clc

	mov	 edx,OFFSET display2
	call WriteString
	call Crlf
	mov al,35h
	add al,48h
	call DAAItself
	call WriteHex
	clc
	call Crlf

	mov	 edx,OFFSET display3
	call WriteString
	call Crlf
	mov al,35h
	add al,65h
	call DAAItself
	call WriteHex

	call Crlf
	exit
main ENDP

DAAItself PROC
	
	push eax
	and al,000Fh
	LAHF                    ;旗標暫存器的 bit0~bit7 的內容存入 AH
	bt eax,20
	jc L1
	.IF	al > 9h             ;If (AL(lo) > 9) or (AuxCarry = 1)
		L1:
		pop eax				
		add eax,6h			;AL = AL + 6
		bts eax,20
		SAHF
		clc
	.ELSE
		pop eax
	.ENDIF
	
	push eax
	
	and al,00F0h
	jc L2
	.IF	al > 90h 	;If (AL(hi) > 9) or Carry = 1
		L2:
		pop eax
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
