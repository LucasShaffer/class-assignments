TITLE Week 4 Assignment 3 Shaffer

; W4A3Shaffer.asm - Week 4 Assignment 3 by Shaffer.
; This program will display all combonations of text
; and background colors (16*16=256) by using a nested loop.

INCLUDE Irvine32.inc

.data
text		DWORD ?     ;To hold text color
background	DWORD ?     ;To hold background color

.code
main PROC
    mov   background,0h ;Set background to 0(black)
    mov	  ecx,16        ;Move 16 to ecx for outer loop control
L1:
    
    push  ecx           ;Push ecx to the stack
    mov	  ecx,16        ;Move 16 to ecx for inner loop control
    mov	  text,0h       ;Set text to 0(black)
    shl	  background,4  ;Move the background value left 4 bits
L2:
    
    mov	  eax,text       ;Move text value to ex
    add	  eax,background ;Add the background value to eax
    call  SetTextColor   ;Call SetTextColor
    
    push  eax           ;Push eax onto the stack

    mov	  al,'X'        ;Move 'X' to al
    call  WriteChar     ;Call WriteChar

    pop	  eax           ;Pop eax off of the stack

    inc	  text          ;Increment text value
    loop  L2            ;Return to the top of the inner loop L2

    call  Crlf          ;Move to a new line
    pop	  ecx           ;Pop ecx off of the stack

    shr	  background,4  ;Move background value right 4 bits for inc
    inc	  background    ;Increment the background value
    loop  L1            ;Return to the top of the outer loop L1

    mov	  eax,7         ;Move 7 to eax for white on black text
    call  SetTextColor  ;Call SetTextColor

    call  WaitMsg       ;Display a wait message

    exit
main ENDP
END main
