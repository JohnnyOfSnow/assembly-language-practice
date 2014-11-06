TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

myMessage BYTE "Start to random 50 integer.",0dh,0ah,0
myMessage1 BYTE "The amount of negative value is: ",0dh,0ah,0
array SWORD 50 DUP(?)
amount DWORD 0
.code
main PROC
	call Clrscr
	mov	 edx,OFFSET myMessage
	call WriteString

	mov esi, OFFSET array
	mov ecx, 50
	call RandomInput

	mov ecx, 50
	call CheckNegative

	mov	 edx,OFFSET myMessage1
	call WriteString

	call WriteDec
	call Crlf


	exit
main ENDP

	RandomInput PROC
	L1:
		call Random32
		call WriteInt
		call Crlf
		mov [esi],eax
		add esi,TYPE DWORD
		loop L1 
		ret
	RandomInput ENDP

	CheckNegative PROC
		mov eax,0
		L2:
			test WORD PTR [esi],8000h
			pushfd
			add esi,TYPE array
			popfd
			jz L3
			L4:
		loop L2
		ret
		L3:
			inc eax
			jmp L4
		
	CheckNegative ENDP

	
END main
