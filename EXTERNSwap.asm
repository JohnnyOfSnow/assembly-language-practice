TITLE Swap Procedure   (_swap.asm)

INCLUDE Irvine32.inc
.code
;-------------------------------------------------------
Swap PROC 
	
;
; Exchange the values of two 32-bit integers
; Returns: nothing
;-------------------------------------------------------
	push ebp
	mov ebp,esp
	pushad
	mov esi,[ebp + 8]

	mov eax,[esi]		; get first integer
	xchg eax,[esi + 4]		; exchange with second
	mov [esi],eax
	leave
	ret 4
Swap ENDP

END
