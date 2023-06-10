;----------------------------------------------------------------------------
; Part of CHKPESEL v. 2.2 ** GetBirthDate rev. 1 ** MOD0423 **
;----------------------------------------------------------------------------

code    SEGMENT PUBLIC 'code'
        ASSUME cs:code,ds:data
        PUBLIC GetBirthDate

GetBirthDate   PROC
               ;rok
               xor ax,ax
               mov al,[pesel]
               mul multipler
               mov year,ax
               mov al,[pesel+1]
               add year,ax
               ;miesiac
               xor ax,ax
               mov al,[pesel+2]
               mul multipler
               mov month,al
               mov al,[pesel+3]
               add month,al

               cmp month,80
               jb  month6072
               cmp month,92
               ja  errorGBD
               add year,1800
               jmp getBirthMonth
    month6072:
               cmp month,60
               jb  month4052
               cmp month,72
               ja  errorGBD
               add year,2200
               jmp getBirthMonth
    month4052:
               cmp month,40
               jb  month2032
               cmp month,52
               ja  errorGBD
               add year,2100
               jmp getBirthMonth
    month2032:
               cmp month,20
               jb  month0012
               cmp month,32
               ja  errorGBD
               add year,2000
               jmp getBirthMonth
    month0012:
               cmp month,0
               jb  errorGBD
               cmp month,12
               ja  errorGBD
               add year,1900
               jmp getBirthMonth
;-----------------------
       retGBD:
               ret
     errorGBD:
               mov ax,-1
               ret
;-----------------------
getBirthMonth:
               cmp month,80
               jb  month60
               cmp month,92
               ja  errorGBD
               sub month,80
               jmp getBirthDay
      month60:
               cmp month,60
               jb  month40
               cmp month,72
               ja  errorGBD
               sub month,60
               jmp getBirthDay
      month40:
               cmp month,40
               jb  month20
               cmp month,52
               ja  errorGBD
               sub month,40
               jmp getBirthDay
      month20:
               cmp month,20
               jb  month00
               cmp month,32
               ja  errorGBD
               sub month,20
               jmp getBirthDay
      month00:
               cmp month,0
               jna errorGBD
               cmp month,12
               ja  errorGBD
getBirthDay:
               xor ax,ax
               mov al,[pesel+4]
               mul multipler
               add al,[pesel+5]
               mov day,al
               jmp retGBD
GetBirthDate   ENDP
code           ENDS

data SEGMENT PUBLIC 'data'
     EXTRN pesel:BYTE,year:WORD,month:BYTE,day:BYTE
     multipler DB 10
data ENDS
     END