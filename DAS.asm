TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
myMessage BYTE "Assembly language program example",0dh,0ah,0
display0 BYTE "2個16位進數相減  用BCD的方式，每次的結果請看最後2位",0
display1 BYTE "85h - 48h",0
display2 BYTE "62h - 35h",0
display3 BYTE "32h - 29h",0

.code
main PROC
	call Clrscr

	mov	 edx,OFFSET display0
	call WriteString
	call Crlf

	mov	 edx,OFFSET display1
	call WriteString
	call Crlf

	mov al,85h
	sub al,48h
	call DASItself
	call WriteHex
	call Crlf

	mov	 edx,OFFSET display2
	call WriteString
	call Crlf

	mov al,62h
	sub al,35h
	call DASItself
	call WriteHex
	call Crlf

	mov	 edx,OFFSET display3
	call WriteString
	call Crlf

	mov al,32h
	sub al,29h
	call DASItself
	call WriteHex
	call Crlf
	exit
main ENDP

DASItself PROC
	push eax
	and al,000Fh
	LAHF                    ;旗標暫存器的 bit0~bit7 的內容存入 AH
	bt eax,20
	jc L1
	.IF	al > 9h             ;If (AL(lo) > 9) or (AuxCarry = 1)
		L1:
		pop eax				
		sub eax,6h			;AL = AL + 6
		bts eax,20
		SAHF
		clc
	.ELSE
		btr eax,20
		pop eax
	.ENDIF
	
	push eax
	
	and al,00F0h
	jc L2
	.IF	al > 9Fh 	;If (AL(hi) > 9) or Carry = 1
		L2:
		pop eax
		sub eax,60h			;AL = AL + 60h
		push eax
		stc					; carry = 1
	.ELSE
		clc					; carry = 0
	.ENDIF
	pop eax
	ret
DASItself ENDP

END main
