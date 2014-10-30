TITLE MASM Template						(main.asm)

TITLE Integer Summation Program		     (Sum2.asm)


INCLUDE Irvine32.inc



.data

array DWORD 0,1
prompt BYTE "How many fibonacci number do you want? ",0


.code 
main PROC
	mov edx, OFFSET prompt
	call WriteString
	call ReadDec
	mov ecx,eax
	mov esi,OFFSET array
	call fibonacci
	
exit
main ENDP
	
	fibonacci PROC
		L1:
			mov eax,[esi]
			add eax,[esi + 4]
			call WriteDec
			call Crlf
			mov ebx,[esi + 4]
			mov [esi],ebx
			mov [esi + 4],eax

		loop L1
		ret
	fibonacci ENDP

END main
