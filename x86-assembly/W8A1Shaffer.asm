TITLE Week 8 Assignment 1 by Shaffer

; W8A1Shaffer.asm - Week 8 Assignment 1 by Shaffer.
; This program will add one string on the the end of another.

INCLUDE Irvine32.inc

;Procedure Prototype
String_Concat PROTO target:PTR BYTE, source: PTR BYTE

.data
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",0

.code
main PROC
   
   ;Call the String_Concat proc and pass the ADDR of targetStr, and SourceStr to it
   invoke String_Concat, ADDR targetStr, ADDR sourceStr

   mov     edx,OFFSET targetStr  ;Move the offset of the string to edx to be dispalyed
   call    WriteString           ;Display the string
   call    Crlf                  ;Write new line
   call    WaitMsg               ;Display wait message

   exit						 
main ENDP

String_Concat PROC USES edi esi ecx ebx,
    target:PTR BYTE,
    source:PTR BYTE

    mov    edi,source         ;Move the address fo source to edi
    mov    esi,target         ;Move the address of esi to target
    add    esi,5              ;Add 5 to esi to move to the end of the string
    mov    ecx,SIZEOF source  ;Move the size of source to ecx for loop control
L1:
    mov    ebx,[edi]  ;Move [edi] to ebx
    mov    [esi],ebx  ;Move ebx to [esi]
    inc    edi        ;Increment edi
    inc    esi        ;Increment esi
    Loop   L1          ;Loop to L1
    ret
String_Concat ENDP
END main
