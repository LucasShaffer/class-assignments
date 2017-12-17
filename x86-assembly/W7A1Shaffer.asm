TITLE Week 7 Assignment 1 by Shaffer

; W7A1Shaffer.asm - Week 7 Assignment 1 by Shaffer.
; This program will find the largest value in 3 arrays and display those values.

INCLUDE Irvine32.inc

FindLargest PROTO array:SDWORD, len:BYTE

.data
arr1 SDWORD -200, -275, -80, 0, 180, 100, 200, -250, 250, 300
arr2 SDWORD 425, 8327, 8615, -46745, 6847, 6885
arr3 SDWORD -6412, -4658, -6415, -54, -6785, -68759, -6665, -4654, -4065
.code
main PROC
    
    invoke  FindLargest, ADDR arr1, LENGTHOF arr1	;Invoke FindLargest PROC and pass ADDR for arr1 and LENGTHOF arr1
    call	WriteInt								;Display the largest Int
    call	Crlf									;Write New Line

    invoke  FindLargest, ADDR arr2, LENGTHOF arr2	;Invoke FindLargest PROC and pass ADDR for arr2 and LENGTHOF arr2
    call	WriteInt								;Display the largest Int
    call	Crlf									;Write New Line
  
    invoke  FindLargest, ADDR arr3, LENGTHOF arr3	;Invoke FindLargest PROC and pass ADDR for arr3 and LENGTHOF arr3
    call	WriteInt								;Display the largest Int
    call	Crlf									;Write New Line

    call	WaitMsg									;Write wait message

    exit						 
main ENDP

FindLargest PROC USES esi ecx,
    array:SDWORD, len:BYTE
    
    mov	  esi,array     ;Move the address value in array to esi
    mov	  eax,[esi]     ;Move the value at the esi address to eax
    movzx ecx,len	    ;Move len to ecx
    dec	  ecx	        ;Decriment ecx
L1:
    add	  esi,4	        ;Add 4 to esi to move to next value
    cmp	  [esi],eax     ;Compare the current value to eax
    jg	  L2		    ;Jump to L2 if the current value is greater than eax
    jmp	  L3		    ;Jump to L3 if its not greater
L2:
    mov   eax,[esi]	    ;Move the current value to eax as the newest largest value
L3:
    loop  L1		    ;Loop to L1
    ret
FindLargest ENDP

END main
