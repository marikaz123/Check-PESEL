;----------------------------------------------------------------------------
; CHKPESEL v2.2 ** CheckSum rev. A ** MOD0423 **
;----------------------------------------------------------------------------
; Sposob obliczania cyfry kontrolnej zostal swiadomie zmodyfikowany.
; https://romek.info/ut/pesel.html
;----------------------------------------------------------------------------

_TEXT SEGMENT WORD PUBLIC 'CODE'
      DGROUP GROUP _DATA,_BSS
      ASSUME cs:_TEXT,ds:DGROUP
      PUBLIC CheckSum

CheckSum           PROC
                   LOCALS
                   mov [sum],0
                   mov bx,0
                   mov cx,10
                   xor dx,dx
             @@do:
                   xor ax,ax
                   mov al,[pesel+bx]
                   mul [mls+bx]
                   add sum,ax
                   inc bx
                   loop @@do
                   mov ax,sum   ;w bx jest 10
                   div bx
                   cmp dl,[pesel+10]
                   jne errorCS
                   ret
errorCS:
                   mov ax,-1
                   ret
CheckSum           ENDP
_TEXT ENDS

_DATA SEGMENT PUBLIC 'DATA'
mls   DB 9,7,3,1,9,7,3,1,9,7
sum   DW 0
_DATA ENDS

_BSS SEGMENT WORD PUBLIC 'BSS'
     EXTRN pesel:BYTE
_BSS ENDS
     END