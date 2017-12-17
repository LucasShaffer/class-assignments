TITLE Week 8 Assignment 2 by Shaffer

; W8A2Shaffer.asm - Week 8 Assignment 2 by Shaffer.
; This program will remove a number of BYTEs from a string
; based on a starting position and number of bytes to remove.

INCLUDE Irvine32.inc

;Procedure prototype
Str_Remove PROTO pos:PTR BYTE, num:PTR BYTE

.data
target BYTE "ABCXXXXDEFGHIJKLMNOP",0

.code
main PROC
    
    ;Call Str_Remove and pass the address for the start of the
    ;area that needs to be deleted and how many BYTES need to be deleted
    invoke  Str_Remove, ADDR [target+3], 4

    mov	  edx,OFFSET target	;Move the offset of target to edx to be displayed
    call  WriteString		;Display the string
    call  Crlf				;Write a new line
    call  WaitMsg			;Diaplay a wait message

   exit						 
main ENDP

Str_Remove PROC USES esi edi ecx ebx,
    pos:PTR BYTE,
    num:PTR BYTE

    mov	  esi,pos			;Move pos to esi
    mov	  edi,pos			;Move pos to edi aswell
    add	  edi,num			;Add num to edi
    mov	  ecx,SIZEOF target	;Set ecx to the size of the string
    sub	  ecx,num			;Subtract numb from ecx
L1:
    mov	  ebx,[edi]			;Move [edi] to ebx
    mov	  [esi],ebx			;Move ebx to [esi]
    inc	  edi				;Increment edi
    inc	  esi				;Increment esi
    Loop  L1				;Loop back to L1
							;Clears out the rest of the sting with null bytes
    ret
Str_Remove ENDP

END main
