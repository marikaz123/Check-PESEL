;---------------------------------------------------------------------------
; CHKPESEL v2.3 ** MOD2304 **
;---------------------------------------------------------------------------
; AL = ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ? 1 : 0
;---------------------------------------------------------------------------

_TEXT SEGMENT WORD PUBLIC 'CODE'
      DGROUP GROUP _DATA,_BSS
      ASSUME cs:_TEXT,ds:DGROUP
      PUBLIC LeapYear

LeapYear        PROC
                mov ax,year
                mov cx,ax
                xor dx,dx

                mov bx,400
                div bx
                cmp dx,0
                je  lyYes

                mov ax,cx
                xor dx,dx
                mov bx,4
                div bx
                cmp dx,0
                jne lyNo

                mov ax,cx
                xor dx,dx
                mov bx,100
                div bx
                cmp dx,0
                jne lyYes
lyNo:
                mov al,0
                ret
lyYes:
                mov al,1
                ret
LeapYear        ENDP
_TEXT           ENDS

_DATA SEGMENT WORD PUBLIC 'DATA'
_DATA ENDS

_BSS SEGMENT WORD PUBLIC 'BSS'
     EXTRN year:WORD
_BSS ENDS
     END