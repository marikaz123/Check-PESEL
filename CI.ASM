;----------------------------------------------------------------------------
; Part of CHKPESEL v. 2.1 ** CI Rev. 0 ** MOD0523 **
;----------------------------------------------------------------------------
; VeryficationNEG:PROC
; VeryficationPOZ:PROC
;       ClearForm:PROC
;          GetSex:PROC

code SEGMENT PUBLIC 'code'
     ASSUME cs:code,ds:data
     PUBLIC VeryficationNEG,VeryficationPOZ,ClearForm

ClearForm           PROC
                    lea bx,data1
                    mov byte ptr [bx],'-'
                    mov byte ptr [bx+1],' '
                    mov byte ptr [bx+2],' '
                    lea bx,data2
                    mov byte ptr [bx+10],20h
                    mov byte ptr [bx+11],20h
                    jmp clearF
VeryficationNEG:
                    lea bx,data1
                    mov byte ptr [bx],'N'
                    mov byte ptr [bx+1],'E'
                    mov byte ptr [bx+2],'G'
            clearF:
                    lea bx,data2
                    mov word ptr [bx],3030h
                    mov word ptr [bx+2],3030h
                    mov word ptr [bx+5],3030h
                    mov word ptr [bx+8],3030h
                    lea bx,data3
                    mov byte ptr [bx],'-'
                    lea bx,EndRegion
                    mov byte ptr [bx],'$'
                    lea bx,data4
                    mov byte ptr [bx],'-'
                    mov byte ptr [bx+1],20h
                    mov byte ptr [bx+2],20h
                    mov errlvl,1
                    call printDR
                    ret
ClearForm           ENDP

VeryficationPOZ     PROC
                    lea bx,data1
                    mov byte ptr [bx],'P'
                    mov byte ptr [bx+1],'O'
                    mov byte ptr [bx+2],'Z'

                    ;ROK
                    lea bx,data2
                    xor dx,dx
                    mov ax,year
                    div divisor
                    add dx,30h
                    mov [bx+3],dl
                    xor dx,dx
                    div divisor
                    add dx,30h
                    mov [bx+2],dl
                    xor dx,dx
                    div divisor
                    add dl,30h
                    mov [bx+1],dl
                    add al,30h
                    mov [bx],al

                    ;MIESIAC
                    mov al,month
                    cmp al,9
                    ja twoDig
                    mov byte ptr [bx+5],'0'
                    add al,30h
                    mov byte ptr [bx+6],al
                    jmp complDay
            twoDig:
                    mov byte ptr [bx+5],'1'
                    sub al,10
                    add al,30h
                    mov [bx+6],al

                    ;DZIEN
          complDay:
                    mov ah,0
                    mov al,day
                    xor dx,dx
                    div divisor
                    add al,30h
                    mov [bx+8],al
                    add dl,30h
                    mov [bx+9],dl
                    call GetSex
                    lea bx,EndRegion
                    mov byte ptr [bx],'$'
                    mov errlvl,0
                    call printDR
                    ret
                    ENDP

PrintDR             PROC
                    cmp statCL,1
                    je prnCL
                    mov ah,2
                    mov bx,0
                    mov dx,CurPosRef
                    sub dh,8
                    int 10h
                    lea dx,dataRegion
                    mov ah,9
                    int 21h
                    ret
             prnCL:
                    mov ax,0a0dh
                    mov word ptr [EndRegion-2],ax
                    lea dx,dataRegion
                    mov ah,9
                    int 21h
                    ret
PrintDR             ENDP

GetSex              PROC
                    mov al,[pesel+9]
                    shr al,1
                    jc male
                    mov data3,'K'
                    ret
              male:
                    mov data3,'M'
                    ret
GetSex              ENDP



code ENDS
data SEGMENT PUBLIC 'data'
     EXTRN data1:byte,data2:byte,data3:byte,data4:byte
     EXTRN dataRegionC,dataRegion,endRegion
     EXTRN CurPosRef:word
     EXTRN year:word,month:byte,day:byte
     EXTRN statCL:byte,errlvl:byte,pesel:byte
     divisor dw 10
data ENDS
     END