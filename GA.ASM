;----------------------------------------------------------------------------
; CHKPESEL v2.3 ** MOD2410 **
;----------------------------------------------------------------------------

_TEXT SEGMENT WORD PUBLIC 'CODE'
      DGROUP GROUP _DATA,_BSS
      ASSUME cs:_TEXT,ds:DGROUP
      PUBLIC GetAge

GetAge          PROC
                mov ah,2ah
                int 21h
                cmp year,cx
                jb caseB
                ja caseNB
                ;case 0
                cmp month,dh
                jb caseB1
                ja caseNB
                cmp day,dl
                jae caseNB
caseB1:
                mov WORD PTR [data4],' <'
                mov [data4+2],'1'
                jmp endGA
caseNB:
                mov [data2+11],'!'
                mov WORD PTR [data4],'DN'
                jmp endGA
caseB:
                sub cx,year
                cmp month,dh ;sprawdz czy ukonczone
                ja sub1
                jb wrAge
                cmp day,dl
                jb wrAge
          sub1:
                sub cx,1
                jz caseB1
wrAge:
                mov ax,cx    ;tu zawsze CX > 0
                mov bx,10
                mov cx,3     ;max. 3 cyfry.
                lea di,data4
           lp0:
                xor dx,dx
                div bx
                push dx
                loop lp0
                mov cx,3
           lp1:
                pop ax
                or ax,ax
                jnz no0
                loop lp1
           lp2:
                pop ax
           no0:
                add al,'0'
                mov [di],al
                inc di
                loop lp2
endGA:
                ret
GetAge          ENDP
_TEXT ENDS

_DATA SEGMENT WORD PUBLIC 'DATA'
      EXTRN data2:BYTE,data4:BYTE
_DATA ENDS

_BSS SEGMENT WORD PUBLIC 'BSS'
     EXTRN year:WORD,month:BYTE,day:BYTE
_BSS ENDS
     END