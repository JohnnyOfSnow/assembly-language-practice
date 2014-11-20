TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
arrayFlower BYTE "Spade","Heart","Club","Dimond"
array DWORD 5 DUP(?)


.code
main PROC
	call Clrscr
	call RandomInput
	exit
main ENDP

RandomInput PROC
	mov esi, OFFSET array
	mov ecx,5
	mov eax,53
	inc eax
	L1:
		call RandomRange
		call WriteDec
		mov array[esi],eax
		call Crlf
		add esi,TYPE DWORD
		loop L1 
		ret
RandomInput ENDP
END main
