TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
myMessage BYTE "現在要進行對字串出現的每一個字做記數。",0dh,0ah,0
myMessage1 BYTE "計數表為",0
myMessage2 BYTE "   ----->  ",0
myMessage3 BYTE "符號      次數",0

target1 BYTE "AAEBDCFBBC",0
freqTable1 DWORD 256 DUP(0)
Get_frequencies PROTO,
	target:PTR DWORD, 
	freqTable:PTR DWORD

.code
main PROC
	call Clrscr
	
	INVOKE Get_frequencies, ADDR target1, ADDR freqTable1
main ENDP
Get_frequencies PROC,
	target:PTR DWORD, 
	freqTable:PTR DWORD

	mov ecx, LENGTHOF target
	L1 :
     mov eax,0
	 lodsb
	 push esi
	 call WriteChar
	 push ecx
	 sub eax,1
	 mov ecx,eax
	 mov esi,freqTable
	 L2:
		add esi,4
	 loop L2
	
	 mov ebx,[esi]
	 add ebx,1
	 mov [esi],ebx
	 pop ecx
	 pop esi
	 call Crlf
	loop L1

	 mov esi,freqTable
	 mov ecx,64
	 L4:
		add esi,4
	 loop L4

	 mov ecx,58
	 mov al,'A'

	 call Crlf
	 mov edx, OFFSET myMessage3
	 call WriteString
	 call Crlf
	 L3:
		call WriteChar
		push eax
		mov edx, OFFSET myMessage2
		call WriteString
		mov eax,[esi]
		call WriteDec
		call Crlf
		pop eax
		add al,1
		add esi,4
	 loop L3
	 ret
Get_frequencies ENDP
		


	exit


END main
