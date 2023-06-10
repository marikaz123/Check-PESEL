;----------------------------------------------------------------------------
; Part of CHKPESEL v. 2.2 ** CheckSum rev. 1 ** MOD0423 **
;----------------------------------------------------------------------------
; Algorytm obliczania cyfry kontrolnej zostal swiadomie zmodyfikowany.
; README: Zrodla, poz. 2
;----------------------------------------------------------------------------

code SEGMENT PUBLIC 'code'
     ASSUME cs:code,ds:data
     PUBLIC CheckSum

CheckSum           PROC
                   mov WORD PTR [sum],0  ;konieczne po kazdym przebiegu
                   mov bx,0
                   mov cx,10
                   xor dx,dx
            doSum:
                   xor ax,ax
                   mov al,[pesel+bx]
                   mul [mls+bx]
                   add sum,ax
                   inc bx
                   loop doSum
                   ;w bx jest 10 i bardzo dobrze...
                   mov ax,sum
                   div bx
                   cmp dl,[pesel+10]
                   jne errorCS
                   ret
errorCS:
                   mov ax,-1
                   ret
CheckSum           ENDP
code ENDS

data  SEGMENT PUBLIC 'data'
      EXTRN pesel:BYTE
mls   DB 9,7,3,1,9,7,3,1,9,7
sum   DW 0
data  ENDS
      END