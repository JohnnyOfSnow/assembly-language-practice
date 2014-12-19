TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
myMessage BYTE "現在要進行對字串出現的每一個字做記數。",0dh,0ah,0
myMessage4 BYTE "對這個字串AAEBDCFBBC，進行每一個字的計數。程式需稍待10~20秒",0
myMessage1 BYTE "計數表為",0
myMessage2 BYTE "   ----->  ",0
myMessage3 BYTE "符號      次數",0

target BYTE "AAEBDCFBBC",0
freqTable DWORD 256 DUP(0)
Get_frequencies PROTO,
	target:PTR DWORD, 
	freqTable:PTR DWORD

.code
main PROC
	 call Clrscr
	 mov edx, OFFSET myMessage
	 call WriteString
	 call Crlf
	 mov edx, OFFSET myMessage4
	 call WriteString
	 call Crlf
	INVOKE Get_frequencies, ADDR target, ADDR freqTable
main ENDP

Get_frequencies PROC,
	target1:PTR DWORD, 
	freqTable1:PTR DWORD

	mov ecx, LENGTHOF target
	mov esi,target1
	L1 :
     mov eax,0
	 lodsb
	 push esi
	
	 push ecx
	 sub eax,1
	 mov ecx,eax
	 mov esi,freqTable1
	 L2:
		add esi,4
	 loop L2
	
	 mov ebx,[esi]
	 add ebx,1
	 mov [esi],ebx
	 pop ecx
	 pop esi
	
	loop L1

	 mov esi,freqTable1
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
