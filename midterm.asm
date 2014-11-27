INCLUDE Irvine32.inc
.data

number1 SDWORD ?
number2 SDWORD ?
re SDWORD ?
char BYTE 'y'

prompt BYTE "請輸入第一個整數: ",0
prompt1 BYTE "請輸入下一個整數: ",0
prompt2 BYTE "最大公因數(GCD)為: ",0
prompt3 BYTE "是否繼續? 按y(YES), n(NO): ",0
prompt4 BYTE "最大公因數(GCD 程式執行結束)",0


.code
main PROC
	mov eax,black + (white * 16)
	call SetTextColor
	.WHILE char == 'y'
		mov edx,OFFSET prompt  
		call WriteString
		call ReadInt
		mov number1,eax
		mov edx,OFFSET prompt1  
		call WriteString
		call ReadInt
		mov number2,eax
		call GCD
		mov edx,OFFSET prompt2  
		call WriteString
		mov eax,number1
		call WriteDec
		call Crlf
		mov edx,OFFSET prompt3  
		call WriteString
		call ReadChar
		mov char,al
		call Crlf
		call Crlf
	.ENDW

	mov edx,OFFSET prompt4  
	call WriteString
	call Crlf
	exit
main ENDP


GCD PROC
	mov eax,number1
	.IF number1 < 0
		neg eax
	.ENDIF
	mov number1,eax
	mov ebx,number2

	.IF number2 < 0
		neg ebx
	.ENDIF
	mov number2,ebx

	.IF eax < ebx
		mov eax,number2
		.IF eax < 0
			neg eax
		.ENDIF
		mov re,eax
		mov ebx,number1
		.IF ebx < 0
			neg ebx
		.ENDIF
		mov number2,ebx
		mov eax,re
		mov number1,eax
	.ENDIF

	.WHILE number1 > 0
		mov eax,number1     ;x
		cdq
		mov ebx,number2     ;y
		cmp ebx,0
		je L3
		idiv ebx             ; x % y   reminder n in edx
		mov number1,ebx     ; x = y
		mov number2,edx     ; y = n
	.ENDW
		L3:
		ret
GCD ENDP


END main
