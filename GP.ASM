;----------------------------------------------------------------------------
; Part of CHKPESEL v. 2.2 ** GetPESELfromCon rev. 2 ** MOD0623 **
;----------------------------------------------------------------------------

cHighlight = 0*16+15            ;highlight = kolor tla*16 + kolor znaku
cLeadChar  = '.'                ;znak wiodacy w polu

code SEGMENT PUBLIC 'code'
     PUBLIC GetPESELfromCon
     ASSUME cs:code,ds:data

GetPESELfromCon    PROC
                   mov ah,2
                   mov bh,0
                   mov dx,curPosRef
                   sub dh,9
                   add dl,20        ;od pozycji ref.
                   mov curPosTMP,dl
                   int 10h
                   mov ah,1
                   mov cx,[curShapeCus]
                   int 10h
                   mov ah,9
                   mov bx,cHighlight
                   mov al,cLeadChar
                   mov cx,11
                   int 10h
                   lea bx,pesel
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
                   cmp dl, BYTE PTR [curPosTMP]
                   je getDigit
                   dec dl
                   mov ah,2
                   int 10h
                   mov ah,0ah
                   mov al,cLeadChar
                   push cx
                   mov cx,1
                   int 10h
                   pop cx
                   dec cx
                   dec bx
                   jmp getDigit
incCurPos:
                   mov ah,9
                   push bx
                   push cx
                   mov cx,1
                   mov bx,cHighlight
                   int 10h
                   pop cx
                   pop bx
                   inc dl
                   mov ah,2
                   int 10h
                   sub al,30h
                   mov BYTE PTR [bx],al
                   inc bx
                   inc cx
                   jmp getDigit
brk:
                   mov ax,-1
                   ret
endPESEL:
                   mov ah,1
                   mov cx,[curShapeHid]
                   int 10h
                   ret
GetPESELfromCon    ENDP
code ENDS

data SEGMENT PUBLIC 'data'
     EXTRN pesel:BYTE
     EXTRN CurShapeHid:WORD,CurShapeCus:WORD,CurPosRef:WORD
curPosTMP DB ?
data ENDS
     END