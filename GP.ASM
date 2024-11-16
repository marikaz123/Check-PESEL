;----------------------------------------------------------------------------
; CHKPESEL v2.3 ** MOD2410 **
;----------------------------------------------------------------------------

;Wyroznienie wpisywanego numeru PESEL:
;BG = kolor tla, FG = kolor znaku

BG = 0   ;czarny
FG = 15  ;bialy (jasny)

;Znak wiodacy w polu PESEL (domyslny FFh, podmieniany w matrycy znakow
;na osobno zdefiniowany, ale mozna oczywiscie wybrac dowolny)

LEADCHAR  = 0FFh     ;Alt. 20h

_TEXT SEGMENT WORD PUBLIC 'CODE'
      DGROUP GROUP _DATA,_BSS
      ASSUME cs:_TEXT,ds:DGROUP
      PUBLIC GetPESELfromCon

GetPESELfromCon    PROC
                   mov ah,2
                   mov bh,0
                   mov dx,curPosRef
                   sub dh,9
                   add dl,20        ;od pozycji ref.
                   mov curPosTMP,dl
                   int 10h
                   mov ah,1
                   mov cx,curShapeCus
                   int 10h
                   mov ah,9
                   mov bx,BG SHL 4 OR FG
                   mov al,LEADCHAR
                   mov cx,11
                   int 10h
                   lea di,pesel
                   mov cx,0
         getDigit:
                   cmp cx,11
                   je wait13h
                   mov ah,0
                   int 16h
                   cmp al,1bh
                   je brk
                   cmp al,8       ;backspace
                   je decCurPos
                   cmp al,30h
                   jb getDigit
                   cmp al,39h
                   ja getDigit
                   jmp incCurPos
          wait13h:
                   mov ah,0
                   int 16h
                   cmp al,0dh
                   je endPESEL
                   cmp al,8
                   je decCurPos
                   cmp al,1bh
                   je brk
                   jmp wait13h
decCurPos:
                   push cx
                   cmp dl,curPosTMP
                   je getDigit
                   dec dl
                   mov ah,2
                   mov bx,0
                   int 10h
                   mov ah,0ah
                   mov al,LEADCHAR
                   mov cx,1
                   int 10h
                   pop cx
                   dec cx
                   dec di
                   jmp getDigit
incCurPos:
                   push cx
                   mov ah,9
                   mov cx,1
                   mov bx,BG SHL 4 OR FG
                   int 10h
                   inc dl
                   mov ah,2
                   mov bx,0
                   int 10h
                   sub al,30h
                   mov BYTE PTR [di],al
                   inc di
                   pop cx
                   inc cx
                   jmp getDigit
brk:
                   mov ax,-1
                   ret
endPESEL:
                   mov ah,1
                   mov cx,curShapeHid
                   int 10h
                   ret
GetPESELfromCon    ENDP
_TEXT ENDS

_DATA SEGMENT WORD PUBLIC 'DATA'
_DATA ENDS

_BSS SEGMENT WORD PUBLIC 'BSS'
     EXTRN pesel:BYTE
     EXTRN CurShapeHid:WORD,CurShapeCus:WORD,CurPosRef:WORD

curPosTMP DB ?
_BSS ENDS
     END
