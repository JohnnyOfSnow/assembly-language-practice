TITLE Using WriteFile                  (WriteFile.asm)

; This program writes text to an output file.

INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
BUFFER_SIZE = 400
buffer BYTE 40 DUP(?)
;buffer BYTE "This text is written to an output file.",0dh,0ah
bufSize DWORD ($-buffer)
errMsg BYTE "Cannot create file",0dh,0ah,0
filename    BYTE "output.txt",0
prompt1		BYTE	"Enter the filename: ",0
prompt3		BYTE	"請問要輸入幾筆員工資料： ",0
prompt2		BYTE	"請輸入員工編號: ",0
prompt4		BYTE	"請輸入員工姓: ",0
prompt5		BYTE	"請輸入員工名: ",0
prompt6		BYTE	"請輸入員工薪水: ",0
prompt7		BYTE	"現在時間為: ",0
prompt8		BYTE	":",0
fileHandle   DWORD ?	; handle to output file
fileHandle1  HANDLE ?	; handle to input file
bytesWritten DWORD ?    	; number of bytes written
Amount DWORD ?
LocationX BYTE 10
LocationY BYTE 1
filename2    BYTE 80 DUP(0)
sysTime SYSTEMTIME <>

buffer1 BYTE BUFFER_SIZE DUP(?),0dh,0ah
filename3    BYTE 80 DUP(0)
fileHandle3  HANDLE ?

.code
main PROC
      
mov eax,yellow + (black * 16)
call SetTextColor

	
	mGotoxy 60,0
	mov edx,OFFSET prompt7
	call WriteString
	

	INVOKE GetLocalTime, ADDR sysTime
	movzx eax,sysTime.wHour
	call WriteDec
	mov edx,OFFSET prompt8
	call WriteString
	movzx eax,sysTime.wMinute
	call WriteDec
	mov edx,OFFSET prompt8
	call WriteString
	movzx eax,sysTime.wSecond
	call WriteDec
	

	;讓使用者輸入要多少筆
	mGotoxy 0,0
	mov edx,OFFSET prompt3
	call WriteString
	call ReadDec
	mov Amount,eax
	mov ebx, Amount

	INVOKE CreateFile,
	  ADDR filename, GENERIC_WRITE, DO_NOT_SHARE, NULL,
	  CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
	
	mov fileHandle,eax			; save file handle
	.IF eax == INVALID_HANDLE_VALUE
	  mov  edx,OFFSET errMsg		; Display error message
	  call WriteString
	  jmp  QuitNow
	.ENDIF

	.WHILE ebx > 0
		;讓使用者輸入新建檔案的內容
		mGotoxy LocationX,LocationY
		mov edx,OFFSET prompt2
		call WriteString
		

		mov edx,OFFSET buffer
		mov ecx,SIZEOF buffer
		call ReadString
		;add edx,eax

		mov eax,fileHandle
		mov edx,OFFSET buffer
		mov ecx,bufSize
		call WriteToFile
		mov bytesWritten,eax

		mov al,LocationX
		add al,10
		mov LocationX,al
		mov al,LocationY
		add al,1
		mov LocationY,al

		;讓使用者輸入新建檔案的內容
		mGotoxy LocationX,LocationY
		mov edx,OFFSET prompt4
		call WriteString
		

		mov edx,OFFSET buffer
		mov ecx,SIZEOF buffer
		call ReadString
		;add edx,eax

		mov eax,fileHandle
		mov edx,OFFSET buffer
		mov ecx,bufSize
		call WriteToFile
		mov bytesWritten,eax

		
		mov al,LocationY
		add al,1
		mov LocationY,al
	
		;讓使用者輸入新建檔案的內容
		mGotoxy LocationX,LocationY
		mov edx,OFFSET prompt5
		call WriteString
		

		mov edx,OFFSET buffer
		mov ecx,SIZEOF buffer
		call ReadString
		;add edx,eax

		mov eax,fileHandle
		mov edx,OFFSET buffer
		mov ecx,bufSize
		call WriteToFile
		mov bytesWritten,eax

		mov al,LocationY
		add al,1
		mov LocationY,al

		;讓使用者輸入新建檔案的內容
		mGotoxy LocationX,LocationY
		mov edx,OFFSET prompt6
		call WriteString
		

		mov edx,OFFSET buffer
		mov ecx,SIZEOF buffer
		call ReadString
		;add edx,eax

		mov eax,fileHandle
		mov edx,OFFSET buffer
		mov ecx,bufSize
		call WriteToFile
		mov bytesWritten,eax

		mov al,LocationX
		sub al,10
		mov LocationX,al
		mov al,LocationY
		add al,1
		mov LocationY,al

		sub ebx,1
	.ENDW
call CloseFile

INVOKE CloseHandle,fileHandle



; Let user input a filename.
	mWrite "Enter an input filename: "
	mov	edx,OFFSET filename3
	mov	ecx,SIZEOF filename3
	call	ReadString


; Open the file for input.
	mov	edx,OFFSET filename3
	call	OpenInputFile
	mov	fileHandle3,eax

; Check for errors.
	cmp	eax,INVALID_HANDLE_VALUE		; error opening file?
	jne	file_ok					; no: skip
	mWrite <"Cannot open file",0dh,0ah>
	jmp	quit						; and quit
file_ok:

; Read the file into a buffer.
	mov	edx,OFFSET buffer1
	mov	ecx,BUFFER_SIZE
	call	ReadFromFile
	jnc	check_buffer_size			; error reading?
	mWrite "Error reading file. "		; yes: show error message
	call	WriteWindowsMsg
	jmp	close_file
	
check_buffer_size:
	cmp	eax,BUFFER_SIZE			; buffer large enough?
	jb	buf_size_ok				; yes
	mWrite <"Error: Buffer too small for the file",0dh,0ah>
	jmp	quit						; and quit
	
buf_size_ok:	
	mov	buffer1[eax],0		; insert null terminator
	mWrite "File size: "
	call	WriteDec			; display file size
	call	Crlf

; Display the buffer.
	mWrite <"您輸入的資料為",0dh,0ah,0dh,0ah>
	mov	edx,OFFSET buffer1	; display the buffer
	.WHILE eax > 0
	call	WriteString
	add edx,1
	sub eax,1
	.ENDW
	call	Crlf

close_file:
	mov	eax,fileHandle3
	call	CloseFile


quit:
	exit

QuitNow:
	exit

main ENDP

END main
