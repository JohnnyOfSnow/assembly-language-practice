TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

array DWORD 5 DUP(?)
arrayCheck DWORD 53(0)
check DWORD 0
number DWORD ?


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
		push esi
		push ecx
			mov esi, OFFSET array
			mov ecx,check
			.WHILE ecx >= 1
				.IF eax == [esi]
					mov eax,52
					inc eax
					call RandomRange
					call WriteDec
					inc eax
					mov ecx,check
				.ENDIF
				add esi,TYPE array
				sub ecx,1
			.ENDW
		inc ecx
		mov check,ecx
		pop esi
		pop ecx
		mov [esi],eax
		call Crlf
		add esi,TYPE array
		mov eax,52
		inc eax
		loop L1 
		ret
RandomInput ENDP
END main
