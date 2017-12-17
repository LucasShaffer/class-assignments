TITLE Week 5 Assignment 1 by Shaffer

; W5A1Shaffer.asm - Week 5 Assignment 1 by Shaffer.
; This program will create 2 random numbers, determine which is lower and
; put that in J and the larger in K. The program will then fill up an array
; of 10 random number with J being the first and K being the last and the middle
; 8 being numbers with in that range. The arrays will be displayed.

INCLUDE Irvine32.inc

N = 10  ;Array length

.data
j		DWORD	 ?			;Lower array limit
k		DWORD	 ?			;Upper array limit
array   DWORD	 N DUP(?)	;Empty array

.code
main PROC

    mov  ecx,2		    ;Move 2 to the loop counter
L1:
    push ecx		    ;Push ecx onto the stack
    mov  eax,500	    ;Move 500 to eax for RandomRange
    call RandomRange	;Call RandomRange
    mov  j, eax			;Move the Random number to J

    mov  eax,500	    ;Move 500 to eax for RandomRange
    call RandomRange    ;Call RandomRange
   
    cmp  eax,j			;Compare eax and J
    jb   Small_K		;If the second random number is smaller then jump to Small_K
    ja   Small_J		;If the first random number is smaller then Jump to Small_J

Small_K:
    mov  ebx,j			;Move J to ebx to hold
    mov  k,ebx			;Move ebx to K
    mov  j,eax			;Move eax to J
    jmp  CONT

Small_J:
    mov k,eax			;Move eax to K

;Now that J is < K
CONT:
    mov	  esi,OFFSET array	;Move the begining of the array to esi
    call  makeArray			;Call the MakeArray PROC

    mov	  ecx,N				;Move the array size to the loop counter
    mov	  esi,OFFSET array	;Move esi to the start of array
L2:
    mov	  eax,[esi]			;Move the array number to eax
    call  WriteDec			;Call WriteDec to display number

    cmp	  ecx,1				;Compare ecx to 1
    je	  No_Coma			;If ecx = 1 then skip displaying a coma

    mov	  al,","			;Mov a coma to al
    call  WriteChar			;Call WriteChar to display coma

No_Coma:
    add	  esi,4				;Add 4 to esi to move 1 space in the array
    loop  L2				  

    call  Crlf				;Add new line

    pop	  ecx				;Pop ecx off stack
    loop  L1

    call  WaitMsg			;Call WaitMsg

    exit
main ENDP

makeArray PROC
    mov	  ecx,N	    ;Move the array length to ecx for the loop counter
    sub	  ecx,2	    ;Subtract to from the loop for the 1st and last numbers j and k
    mov	  ebx,j	    ;Move J to ebx
    mov	  [esi],ebx	;Move ebx (J) to the first array number
    add	  esi,4	    ;Add 4 to esi to move one space in the array
    
    mov	  ebx,k	    ;Move k to ebx
    sub	  ebx,j	    ;Subtract J to find the difference for range

L1:
    mov	  eax,ebx	  ;Move ebx to eax for range
    call  RandomRange ;Call RandomRange
    add	  eax,j	      ;Add J to eax
    
    mov	  [esi],eax ;Move eax to the array

    add	  esi,4	    ;Add 4 to esi to move one space in the array
    
    loop  L1
    
    mov	  ebx,k	    ;Move k to ebx
    mov	  [esi],ebx ;Move ebx(k) to the end of the array
    
    ret
makeArray ENDP
END main
