TITLE Week 7 Assignment 2 by Shaffer

; W7A2Shaffer.asm - Week 7 Assignment 2 by Shaffer.
; This program will print a chess board using white and
; gray squares.
; Reference:https://media.pearsoncmg.com/ph/esm/ecs_irvine_x86_6/videos/Chapt8_Exercise9/index.html

INCLUDE Irvine32.inc

SetColor PROTO textColor:BYTE, backColor:BYTE
WriteColorChar PROTO char:BYTE, textColor:BYTE, backColor:BYTE
PrintOddRow PROTO color:BYTE
PrintEvenRow PROTO color:BYTE

.data
rows = 8
columns = 8
horizCharsPerSquare = 2

.code
main PROC

    mov	  ecx,rows/horizCharsPerSquare  ;Set loop counter for rows to be printed

L1:
    invoke  PrintOddRow, gray	;Invoke PrintOddRows PROC and pass gray to it
    call	Crlf				;Write new line
    invoke  PrintEvenRow, gray	;Invoke PrintEvenRows PROC and pass gray to it
    call	Crlf				;Write new line
    Loop	L1					;Loop to L1

    invoke  SetColor, lightGray, black	;Invoke SetColor Proc and pass lightGray and black to it
    call	Crlf					    ;Write new line

    call	WaitMsg						;Write wait message

    exit						 
main ENDP

PrintOddRow PROC USES ecx,
    color:BYTE

    mov		ecx,columns / horizCharsPerSquare   ;Set the loop counter for how many columns will be dispalyed

L1: invoke  WriteColorChar, ' ', color, color   ;Invoke WriteColorChar PROC and pass it ' ' and the color passed to this PROC
    invoke  WriteColorChar, ' ', color, color   ;Invoke WriteColorChar PROC and pass it ' ' and the color passed to this PROC
    invoke  WriteColorChar, ' ', white, white   ;Invoke WriteColorChar PROC and pass it ' ' and white
    invoke  WriteColorChar, ' ', white, white   ;Invoke WriteColorChar PROC and pass it ' ' and white
    Loop	L1									;Loop to L1

    ret
PrintOddRow ENDP

PrintEvenRow PROC USES ecx,
    color:BYTE

    mov		ecx,columns / horizCharsPerSquare	;Set the loop counter for how many columns will be dispalyed

L1: invoke  WriteColorChar, ' ', white, white   ;Invoke WriteColorChar PROC and pass it ' ' and white
    invoke  WriteColorChar, ' ', white, white   ;Invoke WriteColorChar PROC and pass it ' ' and white
    invoke  WriteColorChar, ' ', color, color   ;Invoke WriteColorChar PROC and pass it ' ' and the color passed to this PROC
    invoke  WriteColorChar, ' ', color, color   ;Invoke WriteColorChar PROC and pass it ' ' and the color passed to this PROC
    Loop	L1									;Loop to L1

    ret
PrintEvenRow ENDP

WriteColorChar PROC USES eax,
    char:BYTE, textColor:BYTE, backColor:byte

    invoke  SetColor, textColor,backColor  ;Invoke SetColor PROC and pass the textColor and backColor passed to this PROC
    mov		al,char						   ;Move char(' ') to al
    call	WriteChar					   ;Display the char(white or gray space)

    ret
WriteColorChar	 ENDP

SetColor PROC,
    textColor:BYTE, backColor:BYTE

    movzx	eax,backColor	;Move backColor to eax
    shl		eax,4			;Shift wax to the left 4 to set the background color
    or		al,textColor	;Sets al for the text color
    call	SetTextColor	;Calls SetTextColor to set the color

    ret
SetColor ENDP
END main
