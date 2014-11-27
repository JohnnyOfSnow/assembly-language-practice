INCLUDE Irvine32.inc
.data

array DWORD 5 DUP(0)


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
		
		inc eax
		push ecx
		push esi
		mov esi, OFFSET array
		mov ecx,5
		.WHILE ecx > 0
			mov ebx,[esi]
			add esi,TYPE array
			.IF eax == ebx
				mov eax,52
				inc eax
				call RandomRange
				inc eax
				mov ecx,5
				mov esi, OFFSET array
			.ENDIF
			sub ecx,1	
		.ENDW
		pop esi
		pop ecx
		call WriteDec
		mov [esi],eax
		call Crlf
		add esi,TYPE array
		mov eax,52
		inc eax
		loop L1 
		ret
RandomInput ENDP
END main
