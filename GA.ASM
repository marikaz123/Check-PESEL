;----------------------------------------------------------------------------
; CHKPESEL v2.2 ** GetAge rev. A ** MOD0623 **
;----------------------------------------------------------------------------

_TEXT SEGMENT WORD PUBLIC 'CODE'
      DGROUP GROUP _DATA,_BSS
      ASSUME cs:_TEXT,ds:DGROUP
      PUBLIC GetAge

GetAge          PROC
                mov ah,2ah
                int 21h
                cmp year,cx
                ja  inFut
                sub cx,year
                jz checkM0     ;biezacy rok
                mov tmpAge,cx  ;przynajmniej 1
                cmp month,dh
                jb correctA
                ja sub1year

                ;miesiac ten sam
                cmp day,dl
                jb correctA
                jmp sub1year   ;wiek kalend. zmienia sie po urodzinach
       checkM0:
                cmp month,dh   ;dla wieku 0 lat
                jb correctA
                ja inFut
                cmp day,dl
                jb correctA    ;nawet 1 dzien niech bedzie ok
inFut:
                mov [data4],'N'     ;data z przyszlosci
                mov [data4+1],'D'
                mov [data4+2],'.'
                mov [data2+11],'!'
                ret
sub1year:
                sub tmpAge,1   ;tylko lata ukonczone
correctA:
                cmp tmpAge,0
                je age0
                mov cx,0       ;wazne
                lea bx,data4
                xor dx,dx
                mov ax,tmpAge
                cmp ax,100
                jb below100
                mov cx,100
                div cx
                add al,30h
                mov [bx],al
                mov ax,dx    ;reszta do ax
                inc bx
below100:
                cmp ax,10
                jb  below10
                xor dx,dx
                mov cx,10
                div cx
                add al,30h
                mov [bx],al
                add dl,30h
                mov [bx+1],dl
                ret
below10:
                ;czy przyszlo z dzielenia 100 < wiek < 110?
                xor dx,dx
                cmp cx,100
                je  first0
                add al,30h
                mov [bx],al
                ret
first0:
                mov ah,'0'
                mov [bx],ah
                add al,30h
                mov [bx+1],al
                ret
age0:
                mov [data4],'<'
                mov [data4+1],' '
                mov [data4+2],'1'
                ret
GetAge          ENDP
_TEXT ENDS

_DATA SEGMENT WORD PUBLIC 'DATA'
       EXTRN data2:BYTE,data4:BYTE
tmpAge DW 0
_DATA ENDS

_BSS SEGMENT WORD PUBLIC 'BSS'
     EXTRN year:WORD,month:BYTE,day:BYTE
_BSS ENDS
     END