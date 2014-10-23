TITLE MASM Template						(main.asm)

TITLE Reversing a String          (RegesterStack.asm)

; This program reverses a string.

INCLUDE Irvine32.inc

.data
prompt BYTE "Start to enter number: EBX ECX EDX ESI EDIEAX",0
reVax BYTE ?
prompt1 BYTE "The pop result is: ",0

.code
main PROC
	mov edx,OFFSET prompt
	call WriteString
	call Crlf

	call ReadInt
	mov ebx,eax

	call ReadInt
	mov ecx,eax

	call ReadInt
	mov edx,eax	
	
	call ReadInt
	mov esi,eax
	call ReadInt
	mov edi,eax
	call ReadInt
	pushad

	mov ecx,8
	


	L1:
		pop eax
		call WriteInt
		call Crlf
	loop L1 
	
	exit
main ENDP
END main
