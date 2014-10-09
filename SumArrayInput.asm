TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc

.data
intarray DWORD 4 DUP(?)

.code
main PROC

	mov  edi,OFFSET intarray			; 1: EDI = address of intarray
	mov  ecx,LENGTHOF intarray		; 2: initialize loop counter
	mov  eax,0					; 3: sum = 0
	call ReadHex
	mov	[edi],eax
	call ReadHex
	mov	[edi + 4],eax
	call ReadHex
	mov	[edi + 8],eax
	call ReadHex
	mov	[edi + 12],eax

L1:								; 4: mark beginning of loop
	add  eax,[edi]					; 5: add an integer
	add  edi,TYPE intarray   		; 6: point to next element
	
	loop L1						; 7: repeat until ECX = 0

	call WriteHex

	

	exit
main ENDP
END main
