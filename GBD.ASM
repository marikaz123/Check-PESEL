;----------------------------------------------------------------------------
; Part of CHKPESEL v. 2.1 ** GetBirthDate Rev. 1 ** MOD0423 **
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
               jmp GetBirthMonth
    month6072:
               cmp month,60
               jb  month4052
               cmp month,72
               ja  errorGBD
               add year,2200
               jmp GetBirthMonth
    month4052:
               cmp month,40
               jb  month2032
               cmp month,52
               ja  errorGBD
               add year,2100
               jmp GetBirthMonth
    month2032:
               cmp month,20
               jb  month0012
               cmp month,32
               ja  errorGBD
               add year,2000
               jmp GetBirthMonth
    month0012:
               cmp month,0
               jb  errorGBD
               cmp month,12
               ja  errorGBD
               add year,1900
               jmp GetBirthMonth
;-----------------------
       retGBD:
               ret
     errorGBD:
               mov ax,-1
               ret
;-----------------------
GetBirthMonth:
               cmp month,80
               jb  month60
               cmp month,92
               ja  errorGBD
               sub month,80
               jmp GetBirthDay
      month60:
               cmp month,60
               jb  month40
               cmp month,72
               ja  errorGBD
               sub month,60
               jmp GetBirthDay
      month40:
               cmp month,40
               jb  month20
               cmp month,52
               ja  errorGBD
               sub month,40
               jmp GetBirthDay
      month20:
               cmp month,20
               jb  month00
               cmp month,32
               ja  errorGBD
               sub month,20
               jmp GetBirthDay
      month00:
               cmp month,0
               jna errorGBD
               cmp month,12
               ja  errorGBD
GetBirthDay:
               xor ax,ax
               mov al,[pesel+4]
               mul multipler
               add al,[pesel+5]
               mov day,al
               jmp retGBD
GetBirthDate   ENDP
code           ENDS

data SEGMENT PUBLIC 'data'
     EXTRN pesel:byte,year:word,month:byte,day:byte
     multipler DB 10
data ENDS
     END