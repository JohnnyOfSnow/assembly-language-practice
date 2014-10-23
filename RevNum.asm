TITLE MASM Template						(main.asm)

TITLE Reversing a String          (RevNum.asm)

; This program reverses a string.

INCLUDE Irvine32.inc

.data
prompt2 BYTE "How many number do you want to input: ",0
prompt BYTE "Enter a number: ",0
prompt1 BYTE "The reverse result is: ",0


amount DWORD ?


.code
main PROC
	mov edx,OFFSET prompt2
	call WriteString
	call ReadDec
	mov amount,eax
	mov ecx,amount

	L1: 	
		mov edx,OFFSET prompt
		call WriteString
		call ReadInt
		push eax
		loop L1

	mov ecx,amount
	mov edx,OFFSET prompt1
	call WriteString
	call Crlf

	L2:
		pop eax
		call WriteInt
		call Crlf
		loop L2
	
	exit
main ENDP
END main
