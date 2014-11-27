TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

array DWORD 5 DUP(?)


.code
main PROC
	call Clrscr
	mov esi, OFFSET array
	mov ecx,5
	mov eax,52
	inc eax
	call RandomInput
	exit
main ENDP

RandomInput PROC
	call Randomize
	L1:
		call RandomRange
		call WriteDec
		inc eax
		mov [esi],eax
		call Crlf
		add esi,TYPE array
		mov eax,52
		inc eax
		loop L1 
		ret
RandomInput ENDP
END main
