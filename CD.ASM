;----------------------------------------------------------------------------
; Part of CHKPESEL v. 2.2 ** CheckDay rev. 1 ** MOD0523 **
;----------------------------------------------------------------------------

code SEGMENT PUBLIC 'code'
     ASSUME cs:code,ds:data
     PUBLIC CheckDay

CheckDay           PROC
                   cmp day,1
                   jb errorCD
                   cmp day,31
                   ja errorCD

                   ;do 28 prawidlowe sa wszystjie miesiace
                   cmp day,28
                   jbe retCD

                   cmp day,29
                   ja check30
                   cmp month,2    ;29 ma tylko luty
                   jne check30
                   cmp statLY,1   ;i tylko przestepny
                   jne errorCD
                   jmp retCD

         check30:
                   cmp day,30
                   ja check31
                   cmp month,2    ;tylko luty nie moze miec 30 dni
                   je errorCD
                   jmp retCD

         check31:
                   cmp month,2    ;tradycyjnie luty
                   je  errorCD
                   cmp month,4
                   je  errorCD
                   cmp month,6
                   je  errorCD
                   cmp month,9
                   je  errorCD
                   cmp month,11
                   je  errorCD

            retCD:
                   ret
          errorCD:
                   mov ax,-1
                   ret
CheckDay           ENDP
code ENDS

data  SEGMENT PUBLIC 'data'
      EXTRN month:BYTE,day:BYTE,statLY:BYTE
data  ENDS
      END