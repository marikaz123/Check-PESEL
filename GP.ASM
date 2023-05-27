;----------------------------------------------------------------------------
; Part of CHKPESEL v. 2.1 ** GetPESELfromCon Rev. 1 ** MOD0423 **
;----------------------------------------------------------------------------

code SEGMENT PUBLIC 'code'
PUBLIC GetPESELfromCon
ASSUME cs:code, ds:data

GetPESELfromCon    PROC
                   mov ah,2
                   mov bh,0
                   mov dx,CurPosRef
                   sub dh,9
                   add dl,20        ;od pozycji ref.
                   mov CurPosTMP,dl
                   int 10h
                   mov ah,1
                   mov cx,[curShapeCus]
                   int 10h
                   mov ah,9
                   mov bx,0fh   ;kolor
                   mov al,'.'
                   mov cx,11
                   int 10h
                   lea bx,pesel
                   mov cx,0
         GetDigit:
                   cmp cx,11
                   je wait13h
                   mov ah,0
                   int 16h
                   cmp al,1bh
                   je brk
                   cmp al,8       ;backspace
                   je decCurPos
                   cmp al,30h
                   jb GetDigit
                   cmp al,39h
                   ja GetDigit
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
                   cmp dl, byte ptr [CurPosTMP]
                   je GetDigit
                   dec dl
                   mov ah,2
                   int 10h
                   mov ah,0ah
                   mov al,'.'
                   push cx
                   mov cx,1
                   int 10h
                   pop cx
                   dec cx
                   dec bx
                   jmp GetDigit
incCurPos:
                   mov ah,9
                   push bx
                   push cx
                   mov cx,1
                   mov bx,0fh  ;kolor
                   int 10h
                   pop cx
                   pop bx
                   inc dl
                   mov ah,2
                   int 10h
                   sub al,30h
                   mov byte ptr [bx],al
                   inc bx
                   inc cx
                   jmp GetDigit
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
CurPosTMP db ?
EXTRN pesel:byte
EXTRN CurShapeHid:word,CurShapeCus:word,CurPosRef:word
data ENDS
     END