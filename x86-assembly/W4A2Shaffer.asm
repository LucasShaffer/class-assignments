TITLE Week 4 Assignment 2 Shaffer

; W4A2Shaffer.asm - Week 4 Assignment 2 by Shaffer.
; This program creates 20 random strings that are 10 characters long.
; The strings consists of only capitol letters a nested loop of 2 PROCs is used.
; Reference/Resource https://media.pearsoncmg.com/ph/esm/ecs_irvine_x86_6/videos/ch5_6.html

INCLUDE Irvine32.inc

STR_COUNT	=	20	;Constant for number of strings to be displyed
STR_SIZE	=	10	;Constant for how long the string is

.data
string  BYTE  STR_SIZE DUP(0),0 ;Create a string full of "STR_SIZE" 0s

.code
main PROC
    mov   ecx,STR_COUNT		  ;Loop counter for the outside loop
							  ;that is for displaying the results
    L1:

    mov   esi,OFFSET string	  ;Move esi to the begining of the string
    mov	  eax,STR_SIZE		  ;Move "STR_SIZE" to eax for inner loop control

    call  CreateRandomString  ;Call PROC CreateRandomString
    
    mov	  edx,OFFSET string	  ;Move edx to the start of string to be displayed
    call  WriteString		  ;Call WriteString to dispayed string
    call  Crlf				  ;Display new line

    loop  L1				  ;Loop back to L1

    call  WaitMsg			  ;Wait for user input

    exit
main ENDP

CreateRandomString PROC
; Uses eax (string length) and puts it in ecx for loop control
; Uses esi which is already pointing to the string

    push  ecx		;Preserve ecx value from outer loop
    mov	  ecx,eax	;Set the inner loop control value
L1:
    
    mov	  eax,26	    ;Move 20 to eax for RandomRange: 0-25
    call  RandomRange	;Call RandomRange
    add	  al,'A'	    ;Add 'A' to the random value to get a random capitol letter
    mov	  [esi],al		;Move the random capitol letter to the string

    inc	  esi			;Increment esi to move up string
    loop  L1		    ;Loop back to L1

    pop	  ecx			;Restore the value of ecx for the outer loop control

    ret
CreateRandomString ENDP

END main
