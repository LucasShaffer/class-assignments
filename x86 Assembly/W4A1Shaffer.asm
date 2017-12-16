TITLE Week 4 Assignment 1 Shaffer

; W4A1Shaffer.asm - Week 4 Assignment 1 by Shaffer.
; This program move the cursor to about the center of the screen(from previous assignment in book)
; then asks the user to input 2 numbers. The program will add the 2
; numbers and display the total. This will happen 3 times.

INCLUDE Irvine32.inc

.data
    prompt	BYTE	"Enter 2 numbers to be added:",0	 ;String to prompt user
    num1	BYTE	"Number 1: ",0					 ;String for first number input
    num2	BYTE	"Number 2: ",0					 ;String for second number input
    total	BYTE	"Total: ",0					 ;String for total
    val		SDWORD	?							 ;SDWORD for value calculations and total
    y		BYTE	?							 ;For cursor y-val
    x		BYTE	?							 ;For cursor x-val

.code
main PROC
    mov   ecx,3				;Move 3 to ecx for it to loop 3 times

TOP:

    call  Clrscr			;Clears screen54
    
    mov	  y,9				;Specify y cursor location 1 above where you want it
    mov	  x,25				;Specify x cursor location

    call  newline			;Call newline PROC, this will add a new line and keep specified cursor location

    mov	  edx,OFFSET prompt	;Change edx to the offset of promt to display it
    call  WriteString		;Display string
    call  Crlf				;Display new line
				

    call  newline			;Call newline PROC, this will add a new line and keep specified cursor location

    mov	  edx,OFFSET num1	;Change edx to the offset of num1 to display it
    call  WriteString		;Display string

    call  ReadInt			;Reads an int from user input
    mov	  val,eax			;Moves the input to val

    call  newline			;Call newline PROC, this will add a new line and keep specified cursor location

    mov	  edx,OFFSET num2	;Change edx to the offset of num2 to display it
    call  WriteString		;Display string

    call  ReadInt			;Reads an int from user input
    add	  val,eax			;Adds the user input to val
    mov	  eax,val			;Moves val to eax for dispaly

    call  newline			;Call newline PROC, this will add a new line and keep specified cursor location

    mov	  edx,OFFSET total	;Change edx to the offset of total to display it
    call  WriteString		;Display string
    call  WriteInt			;Display total

    call  newline			;Call newline PROC, this will add a new line and keep specified cursor location

    call  WaitMsg			;Display a wait message
    loop  TOP				;Loop back to the top label

    exit
main ENDP

newline PROC
    
    inc   y					;Increase y by 1 for new line
    mov	  dh,y				;Move y to dh for Gotoxy
    mov	  dl,x				;Move x to dl for Gotoxy
    call  Gotoxy		;Call GotoXY to move cursor
    
    ret
newline ENDP
END main