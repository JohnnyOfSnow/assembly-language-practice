TITLE Win32 Console Example #1                (Console1.asm)

; This program calls the following Win32 Console functions:
; GetStdHandle, ExitProcess, WriteConsole

INCLUDE Irvine32.inc

.data
endl EQU <0dh,0ah>			; end of line sequence
xyPos COORD <10,2>
cellsWritten DWORD ?
message LABEL BYTE
	BYTE "This program is a simple demonstration of "
	BYTE "console mode output, using the GetStdHandle "
	BYTE "and WriteConsole functions.", endl
messageSize DWORD ($-message)

consoleHandle HANDLE 0     ; handle to standard output device
bytesWritten  DWORD ?      ; number of bytes written

.code
main PROC
  ; Get the console output handle:
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle,eax

  ; Write a string to the console:
	;INVOKE WriteConsole,
	  ;consoleHandle,		; console output handle
	  ;ADDR message,       	; string pointer
	  ;messageSize,			; string length
	  ;ADDR bytesWritten,	; returns num bytes written
	  ;0					; not used

INVOKE WriteConsoleOutputCharacter,
	consoleHandle,		; console output handle
	ADDR message,       	; string pointer
	messageSize,			; string length
	xyPos,
	ADDR cellsWritten

	INVOKE ExitProcess,0
main ENDP
END main
