TITLE Using WriteFile                  (WriteFile.asm)

; This program writes text to an output file.

INCLUDE Irvine32.inc

.data
buffer DWORD 500 DUP(?),0dh,0ah
;buffer BYTE "This text is written to an output file.",0dh,0ah
bufSize DWORD ($-buffer)
errMsg BYTE "Cannot create file",0dh,0ah,0
filename     BYTE 500 DUP(?)
prompt1		BYTE	"Enter the filename: ",0
prompt3		BYTE	"How many record do you want to input? ",0
prompt2		BYTE	"Enter the student identification number, last name, first name, and date of birth ",0
fileHandle   DWORD ?	; handle to output file
bytesWritten DWORD ?    	; number of bytes written
Amount DWORD ?

.code
main PROC
      ;讓使用者輸入欲新建檔案的檔名
	mov edx,OFFSET prompt1
	call WriteString

	mov edx,OFFSET filename
	mov ecx,SIZEOF filename
	call ReadString
	call Crlf

	;讓使用者輸入欲新建檔案的檔名
	mov edx,OFFSET prompt3
	call WriteString
	call ReadDec
	mov Amount,eax
	mov ebx, Amount

	;讓使用者輸入新建檔案的內容
	mov edx,OFFSET prompt2
	call WriteString
	call Crlf

	INVOKE CreateFile,
	  ADDR filename, GENERIC_WRITE, DO_NOT_SHARE, NULL,
	  CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0
	
	mov fileHandle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  QuitNow
	.ENDIF

	.WHILE ebx > 0
		mov edx,OFFSET buffer
		mov ecx,SIZEOF buffer
		call ReadString
		;add edx,eax
		
	

	mov eax,fileHandle
	mov edx,OFFSET buffer
	mov ecx,bufSize
	call WriteToFile
	mov bytesWritten,eax
	

	;INVOKE WriteFile,		; write text to file
	    ;fileHandle,		; file handle
	   ; ADDR buffer,		; buffer pointer
	   ; bufSize,			; number of bytes to write
	   ; ADDR bytesWritten,	; number of bytes written
	   ; 0				; overlapped execution flag

	;INVOKE CloseHandle, fileHandle

      ;讓使用者輸入新建檔案的內容
	;call CloseFile
	call Crlf
		sub ebx,1
	.ENDW
	call CloseFile
QuitNow:
	exit
main ENDP
END main
