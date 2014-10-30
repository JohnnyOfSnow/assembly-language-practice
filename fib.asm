TITLE MASM Template						(main.asm)

TITLE Integer Summation Program		     (Sum2.asm)


INCLUDE Irvine32.inc



.data
check1 DWORD ?
zero DWORD 0
first DWORD 1
re DWORD ?

prompt BYTE "How many fibonacci number do you want? ",0


.code 
main PROC
	mov edx, OFFSET prompt
	call WriteString
	call ReadDec
	mov ecx,eax
	

	mov eax,zero
	push eax
	mov eax,first
	push eax
	call fibonacci
exit
main ENDP
	
	fibonacci PROC
		L1:
			pop re		
			pop eax
			add eax,re
			call WriteInt
			call Crlf
			push re
			push eax

		loop L1
		ret
	fibonacci ENDP

END main
