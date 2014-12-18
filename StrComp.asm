TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
myMessage BYTE "現在要進行2個字串的比較。",0dh,0ah,0
myMessage1 BYTE "請輸入第1個字串",0
myMessage2 BYTE "請輸入第2個字串",0
myMessage3 BYTE "第1個字串比第2個字串大",0
myMessage4 BYTE "第1個字串沒有比第2個字串大",0
buffer BYTE 100 DUP(?)
buffer1 BYTE 100 DUP(?)
source DWORD ?
target DWORD ?


.code
main PROC
	call Clrscr
	mov	 edx,OFFSET myMessage
	call WriteString
	call Crlf
	mov	 edx,OFFSET myMessage1
	call WriteString
	call Crlf
	mov edx, OFFSET buffer
	mov ecx, SIZEOF buffer
	call ReadString
	mov source,eax
	call Crlf
	mov	 edx,OFFSET myMessage2
	call WriteString
	call Crlf
	mov edx, OFFSET buffer1
	mov ecx, SIZEOF buffer1
	call ReadString
	mov target,eax
	
	; start to compare
	mov esi, OFFSET source
	mov edi, OFFSET target
	cmpsd
	ja L1
	jmp L2

	L1:
	  mov edx, OFFSET myMessage3
	  jmp Quit
	L2:
	  mov edx, OFFSET myMessage4
	   jmp Quit

	Quit:
		call Crlf
		call WriteString
		call Crlf
	exit
main ENDP

END main
