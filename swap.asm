TITLE Swap Procedure Example                 (Swap.asm)

INCLUDE swap.inc
.code
;-------------------------------------------------------
Swap PROC USES eax esi edi,
	pValX:PTR DWORD,	; pointer to first integer
	pValY:PTR DWORD	; pointer to second integer
;
; Exchange the values of two 32-bit integers
; Returns: nothing
;-------------------------------------------------------
	mov esi,pValX		; get pointers
	mov edi,pValY
	mov eax,[esi]		; get first integer
	xchg eax,[edi]		; exchange with second
	mov [esi],eax		; replace first integer
	ret
Swap ENDP
END
