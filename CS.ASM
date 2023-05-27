;----------------------------------------------------------------------------
; Part of CHKPESEL v. 2.1 ** CheckSum Rev. 1 ** MOD0423 **
;----------------------------------------------------------------------------
; NOTES:
; Algorytm obliczania cyfry kontrolnej zostal swiadomie zmodyfikowany.
; Info w README: Zrodla.

code SEGMENT PUBLIC 'code'
     ASSUME cs:code,ds:data
     PUBLIC CheckSum

CheckSum           PROC
                   mov word ptr [sum],0  ;konieczne po kazdym przebiegu
                   mov bx,0
                   mov cx,10             ;licznik
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
EXTRN pesel:byte
mls   db 9,7,3,1,9,7,3,1,9,7
sum   dw 0
data  ENDS
      END