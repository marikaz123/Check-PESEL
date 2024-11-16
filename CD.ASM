;----------------------------------------------------------------------------
; CHKPESEL v2.3 ** MOD2305 **
;----------------------------------------------------------------------------

_TEXT SEGMENT WORD PUBLIC 'CODE'
      DGROUP GROUP _DATA,_BSS
      ASSUME cs:_TEXT,ds:DGROUP
      PUBLIC CheckDay

CheckDay           PROC
                   cmp day,1
                   jb errCD
                   cmp day,31
                   ja errCD

                   cmp day,28    ;do 28 prawidlowe sa wszystkie miesiace
                   jbe retCD

                   cmp day,29
                   ja check30
                   cmp month,2    ;29 ma tylko luty
                   jne check30
                   cmp statLY,1   ;i tylko przestepny
                   jne errCD
                   jmp retCD
         check30:
                   cmp day,30
                   ja check31
                   cmp month,2    ;tylko luty nie moze miec 30 dni
                   je errCD
                   jmp retCD
         check31:
                   cmp month,2    ;tradycyjnie luty
                   je  errCD
                   cmp month,4
                   je  errCD
                   cmp month,6
                   je  errCD
                   cmp month,9
                   je  errCD
                   cmp month,11
                   je  errCD
retCD:
                   ret
errCD:
                   mov ax,-1
                   ret
CheckDay           ENDP

_TEXT ENDS

_BSS  SEGMENT WORD PUBLIC 'BSS'
      EXTRN month:BYTE,day:BYTE,statLY:BYTE
_BSS  ENDS

_DATA SEGMENT WORD PUBLIC 'DATA'
_DATA ENDS
      END