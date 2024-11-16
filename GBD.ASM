;----------------------------------------------------------------------------
; CHKPESEL v2.3 ** MOD2304 **
;----------------------------------------------------------------------------

_TEXT   SEGMENT WORD PUBLIC 'CODE'
        DGROUP GROUP _DATA,_BSS
        ASSUME cs:_TEXT,ds:DGROUP
        PUBLIC GetBirthDate

GetBirthDate   PROC
               ;rok
               mov bx,10
               xor ax,ax
               xor dx,dx
               mov al,[pesel]
               mul bx
               add al,[pesel+1]
               mov year,ax
               ;miesiac
               xor ax,ax
               mov al,[pesel+2]
               mul bx
               add al,[pesel+3]
               mov month,al

               cmp month,80
               jb  month6072
               cmp month,92
               ja  errGBD
               add year,1800
               jmp getBirthMonth
    month6072:
               cmp month,60
               jb  month4052
               cmp month,72
               ja  errGBD
               add year,2200
               jmp getBirthMonth
    month4052:
               cmp month,40
               jb  month2032
               cmp month,52
               ja  errGBD
               add year,2100
               jmp getBirthMonth
    month2032:
               cmp month,20
               jb  month0012
               cmp month,32
               ja  errGBD
               add year,2000
               jmp getBirthMonth
    month0012:
               cmp month,0
               jb  errGBD
               cmp month,12
               ja  errGBD
               add year,1900
               jmp getBirthMonth
errGBD:
               mov ax,-1
               ret
getBirthMonth:
               cmp month,80
               jb  month60
               cmp month,92
               ja  errGBD
               sub month,80
               jmp getBirthDay
      month60:
               cmp month,60
               jb  month40
               cmp month,72
               ja  errGBD
               sub month,60
               jmp getBirthDay
      month40:
               cmp month,40
               jb  month20
               cmp month,52
               ja  errGBD
               sub month,40
               jmp getBirthDay
      month20:
               cmp month,20
               jb  month00
               cmp month,32
               ja  errGBD
               sub month,20
               jmp getBirthDay
      month00:
               cmp month,0
               jna errGBD
               cmp month,12
               ja  errGBD
getBirthDay:
               xor ax,ax
               mov al,[pesel+4]
               mul bx
               add al,[pesel+5]
               mov day,al
               ret
GetBirthDate   ENDP
_TEXT          ENDS

_DATA SEGMENT WORD PUBLIC 'DATA'
_DATA ENDS

_BSS SEGMENT WORD PUBLIC 'BSS'
     EXTRN pesel:BYTE
     EXTRN year:WORD,month:BYTE,day:BYTE
_BSS ENDS
     END