TITLE Week 7 Assignment 3 by Shaffer

; W7A3Shaffer.asm - Week 7 Assignment 3 by Shaffer.
; This program will evaluate 4 arrays and see if there are 3 3s in a row.
; If there are or are not then the program will display the proper string.

INCLUDE Irvine32.inc

FindThrees PROTO array:DWORD, len:BYTE

.data
threes  BYTE ?
arr1	BYTE 4, 6, 3, 7, 8, 3, 3, 1
arr2	BYTE 8, 9, 3, 3, 3, 0, 4, 7, 8
arr3	BYTE 3, 3, 3, 1, 8, 9, 7, 1, 5, 7, 6, 4 ,7 , 6, 7
arr4	BYTE 0, 3, 3, 1, 3, 9, 3, 1, 3, 7, 3, 4 ,3 , 6, 3
string1 BYTE "There are 3 3s in this array.",0
string2 BYTE "There are not 3 3s in this array.",0
.code
main PROC
    
    invoke  FindThrees, ADDR arr1, LENGTHOF arr1	  ;Invoke FindThrees and pass it the address and length of arr1

    cmp	  threes,1  ;Compare threes to 1
    je	  L1        ;If threes equals 1 then jump tp L1
    jmp	  L2        ;If threes is not equal to 1 then jump to L2
L1:
    mov	  edx,OFFSET string1   ;Move the offset of string1 to edx to be displayed
    call  WriteString          ;Call WriteString to display the string
    call  Crlf                 ;Write new line
    jmp	  L3                   ;Jump to L3
L2:
    mov	  edx,OFFSET string2   ;Move the offset of string2 to edx to be displayed
    call  WriteString          ;Call WriteString to display the string
    call  Crlf                 ;Write new line
L3:
    invoke  FindThrees, ADDR arr2, LENGTHOF arr2  ;Invoke FindThrees and pass it the address and length of arr2

    cmp	  threes,1             ;Compare threes to 1
    je	  L4                   ;If threes equals 1 then jump tp L4
    jmp	  L5                   ;If threes is not equal to 1 then jump to L5
L4:
    mov	  edx,OFFSET string1   ;Move the offset of string1 to edx to be displayed
    call  WriteString          ;Call WriteString to display the string
    call  Crlf                 ;Write new line
    jmp	  L6                   ;Jump to L6
L5:
    mov	  edx,OFFSET string2   ;Move the offset of string2 to edx to be displayed
    call  WriteString          ;Call WriteString to display the string
    call  Crlf                 ;Write new line
L6:
    invoke  FindThrees, ADDR arr3, LENGTHOF arr3  ;Invoke FindThrees and pass it the address and length of arr3

    cmp	  threes,1             ;Compare threes to 1
    je	  L7                   ;If threes equals 1 then jump tp L7
    jmp	  L8                   ;If threes is not equal to 1 then jump to L8
L7:
    mov	  edx,OFFSET string1   ;Move the offset of string1 to edx to be displayed
    call  WriteString          ;Call WriteString to display the string
    call  Crlf                 ;Write new line
    jmp	  L9                   ;Jump to L9
L8:
    mov	  edx,OFFSET string2   ;Move the offset of string2 to edx to be displayed
    call  WriteString          ;Call WriteString to display the string
    call  Crlf                 ;Write new line
L9:
    invoke  FindThrees, ADDR arr4, LENGTHOF arr4   ;Invoke FindThrees and pass it the address and length of arr4

    cmp	  threes,1             ;Compare threes to 1
    je	  L10                  ;If threes equals 1 then jump tp L10
    jmp	  L11                  ;If threes is not equal to 1 then jump to L11
L10:
    mov	  edx,OFFSET string1   ;Move the offset of string1 to edx to be displayed
    call  WriteString          ;Call WriteString to display the string
    call  Crlf                 ;Write new line
    jmp	  L12                  ;Jump to L12
L11:
    mov	  edx,OFFSET string2   ;Move the offset of string2 to edx to be displayed
    call  WriteString          ;Call WriteString to display the string
    call  Crlf                 ;Write new line
L12:

    call  WaitMsg              ;Write a wait message

    exit						 
main ENDP

FindThrees PROC USES esi ecx,
    array:DWORD, len:BYTE

    mov	  threes,0          ;Reset threes to 0
    mov	  eax,0             ;Reset eax to 0
    mov	  esi,array         ;Move the address fpr the array to esi
    movzx ecx,len           ;Move the length of the array to ecx
L1:
    cmp	  BYTE PTR [esi],3  ;Compare the current array number to 3
    je	  L2                ;If it is 3 then jump to L2
    jmp	  L4                ;If not jump to L4

L2:
    inc	  eax               ;If the number is 3 increment eax
    cmp	  eax,3             ;Compare eax to 3
    je	  L3                ;If it is equal to 3 jump to L3
    jmp	  L5                ;If not then jump to L5

L3:
    mov	  threes,1          ;If eax is 3 then set threes to 1
    jmp	  L6                ;Then jump to L6

L4:
    mov	  eax,0             ;If the number is not 3 then reset eax to 0
L5:
    inc	  esi               ;Increment esi
    loop  L1                ;Loop back to L1
L6:
    ret
FindThrees ENDP

END main
