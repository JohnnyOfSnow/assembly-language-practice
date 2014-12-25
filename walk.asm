TITLE Drunkard's Walk 					(Walk.asm)

; Drunkard's walk program. The professors starts at 
; coordinates 25,25 and wanders around the immediate area.

INCLUDE Irvine32.inc
WalkMax = 50
StartX = 25
StartY = 25
RangeXBelow = 0;
RangeXUp = 79;
RangeYBelow = 0;
RangeYUp = 24;

DrunkardWalk STRUCT
	path COORD WalkMax DUP(<0,0>)
	pathsUsed WORD 0
DrunkardWalk ENDS

DisplayPosition PROTO currX:WORD, currY:WORD
.data
aWalk DrunkardWalk <>
message BYTE "酒鬼走路；酒鬼隨機搖晃走50步，最後印出所有步伐",0
message1 BYTE "開始輸入起始座標",0
message2 BYTE "請輸入X座標: ",0
message3 BYTE "請輸入Y座標: ",0
message4 BYTE "起始X 不在0~79的範圍，請重新輸入--->",0
message5 BYTE "起始Y 不在0~24的範圍，請重新輸入--->",0
StartX1 WORD ?
StartY1 WORD ?

.code
main PROC
	call Clrscr
	mov	 edx,OFFSET message
	call WriteString
	call Crlf
	mov	 edx,OFFSET message1
	call WriteString
	call Crlf
	L9:
	mov	 edx,OFFSET message2
	call WriteString
	call ReadInt
	.IF eax < 0 || eax > 79
		mov	 edx,OFFSET message4
		call WriteString
		jmp L9
		call Crlf
	.ENDIF
	mov StartX1,ax
	call Crlf

	L10:
	mov	 edx,OFFSET message3
	call WriteString
	call ReadInt
	.IF eax < 0 || eax > 24
		mov	 edx,OFFSET message5
		call WriteString
		jmp L10
		call Crlf
	.ENDIF
	mov StartY1,ax
	
	mov	esi,OFFSET aWalk
	call	TakeDrunkenWalk
	exit
main ENDP

;-------------------------------------------------------
TakeDrunkenWalk PROC
LOCAL currX:WORD, currY:WORD
;
; Take a walk in random directions (north, south, east,
; west).
; Receives: ESI points to a DrunkardWalk structure
; Returns:  the structure is initialized with random values
;-------------------------------------------------------
	pushad

; Use the OFFSET operator to obtain the address of
; path, the array of COORD objects, and copy it to EDI.
	mov	edi,esi
	add	edi,OFFSET DrunkardWalk.path
	mov	ecx,WalkMax		; loop counter
	mov ax,StartX1
	mov	currX,ax		; current X-location
	mov ax,StartY1
	mov	currY,ax		; current Y-location

.WHILE ecx > 0
	; Insert current location in array.
	mov	ax,currX
	mov	(COORD PTR [edi]).X,ax
	mov	ax,currY
	mov	(COORD PTR [edi]).Y,ax

	INVOKE DisplayPosition, currX, currY

	L24:
	mov	eax,8		; choose a direction (0-7)
	call	RandomRange

	.IF eax == 0		; North
	  dec currY
	  jmp Judge
	.ELSEIF eax == 1	; South
	  inc currY
	  jmp Judge
	.ELSEIF eax == 2	; West
	  dec currX
	  jmp Judge
	.ELSEIF eax == 3	; East (EAX = 3)
	  inc currX
	  jmp Judge
	.ELSEIF eax == 4	; North East
	  inc currX
	  inc currY
	  jmp Judge
	.ELSEIF eax == 5	; South East
	  inc currX
	  dec currY
	  jmp Judge
	.ELSEIF eax == 6	; South West
	  dec currX
	  dec currY
	  jmp Judge
	.ELSE				; North West
	  dec currX
	  inc currY
	  jmp Judge
	.ENDIF
	Judge:
	.IF eax == 0		; North
	  .IF currY < RangeYBelow || currY > RangeYUp
			inc currY
			jmp L24
	  .ENDIF
	  jmp OK
	.ELSEIF eax == 1	; South
	  .IF currY > RangeYUp
			dec currY
			jmp L24
	  .ENDIF
	  jmp OK
	.ELSEIF eax == 2	; West
	  .IF (currX < RangeXBelow) || (currX > RangeXUp)
			inc currX
			jmp L24
	  .ENDIF
	  jmp OK
	.ELSEIF eax == 3	; East (EAX = 3)
	  .IF currX > RangeXUp
			dec currX
			jmp L24
	  .ENDIF
	  jmp OK
	.ELSEIF eax == 4	; North East
	  .IF (currX > RangeXUp) || (currY > RangeYUp)
			dec currX
			dec currY
			jmp L24
	  .ENDIF
	  jmp OK
	.ELSEIF eax == 5	; South East
	   .IF (currX > RangeXUp) || (currY < RangeYBelow) || (currY > RangeYUp)
			dec currX
			inc currY
			jmp L24
	  .ENDIF
	  jmp OK
	.ELSEIF eax == 6	; South West
		.IF (currX > RangeXUp) || (currY > RangeYUp)
			inc currX
			inc currY
			jmp L24
	  .ENDIF
	  jmp OK
	.ELSE			;  North West
	  .IF (currX < RangeXBelow) || (currY > RangeYUp) || (currX > RangeXUp)
			inc currX
			dec currY
			jmp L24
	  .ENDIF
	  jmp OK
	.ENDIF

	OK:
	add	edi,TYPE COORD		; point to next COORD
	dec ecx
.ENDW


Finish:
	mov (DrunkardWalk PTR [esi]).pathsUsed, WalkMax
	popad
	ret
TakeDrunkenWalk ENDP

;-------------------------------------------------------
DisplayPosition PROC currX:WORD, currY:WORD
; Display the current X and Y positions.
;-------------------------------------------------------
.data
commaStr BYTE ",",0
.code
	pushad
	movzx eax,currX			; current X position
	call	 WriteDec
	mov	 edx,OFFSET commaStr	; "," string
	call	 WriteString
	movzx eax,currY			; current Y position
	call	 WriteDec
	call	 Crlf
	popad
	ret
DisplayPosition ENDP
END main
