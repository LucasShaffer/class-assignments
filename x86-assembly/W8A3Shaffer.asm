TITLE Week 8 Assignment 3 by Shaffer

; W8A3Shaffer.asm - Week 8 Assignment 3 by Shaffer.
; This program will search for a specified char in a string
; and replace that with a null byte. EAX will then point to
; the next character in the string and the ZF will be set.
; The program will display the new string and the rest of the
; string.

INCLUDE Irvine32.inc

;Procedure prototype
Str_NextWord PROTO string:PTR BYTE, delimChar:PTR BYTE

.data
target BYTE "Lucas,Shaffer",0

.code
main PROC
    
    ;Invoce the Str_NextWord PROC and pass it the address for target and a "," char
    invoke  Str_NextWord, ADDR target, ","
    
    mov   edx,OFFSET target ;Move the offset of target to edx to be displayed
    call  WriteString       ;Display the string
    call  Crlf              ;Write a new line

    mov   edx,eax           ;Move eax to edx to display the rest of the string
    call  WriteString       ;Display the string
    call  Crlf              ;Write a new line
    call  WaitMsg           ;Display a wait message

   exit						 
main ENDP

Str_NextWord PROC USES esi ebx ecx edx,
    string:PTR BYTE,
    delimChar:PTR BYTE

    mov   esi,string        ;Move the string address to esi
    mov   edx,delimChar     ;Move the delimChar to edx
    mov   ecx,SIZEOF target ;Move the size of the target array to ecx for loop control
L1:
    mov   ebx,[esi]         ;Move [esi] to ebx
    cmp   bl,dl             ;Compare the 2 BYTEs
    je    L2                ;If equal jump out of the loop to L2
    inc   esi               ;If not equal increment esi
    mov   eax,0             ;Move 0 to eax
    Loop   L1               ;Loop back to L1
L2:
    mov   al,0h             ;Move a null byte to al
    mov   [esi],al          ;Move al to [esi]
    inc   esi               ;Increment esi
    mov   eax,esi           ;Move esi to eax
    mov   edx,1             ;Set edx to 1
    sub   edx,1             ;Subtrace 1 from edx to set ZF

    ret
Str_NextWord ENDP


END main
