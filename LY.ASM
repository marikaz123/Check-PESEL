;---------------------------------------------------------------------------
; Part of CHKPESEL v. 2.2 ** LeapYear rev. 1 ** MOD0423 **
;---------------------------------------------------------------------------
; NOTES:
; AL=((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ? 1 : 0
;---------------------------------------------------------------------------

code SEGMENT PUBLIC 'code'
     ASSUME cs:code,ds:data
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
code            ENDS

data SEGMENT PUBLIC 'data'
     EXTRN year:WORD
data ENDS
     END