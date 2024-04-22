;----------------------------------------------------------------------------
; CHKPESEL v. 2.2 ** MOD0623 **
;----------------------------------------------------------------------------
; VeryficationNEG:PROC  rev. A
; VeryficationPOZ:PROC  rev. B
; ClearForm      :PROC  rev. A
; GetSex         :PROC  rev. A
;


_TEXT SEGMENT WORD PUBLIC 'CODE'
      DGROUP GROUP _DATA,_BSS
      ASSUME cs:_TEXT,ds:DGROUP
      PUBLIC VeryficationNEG,VeryficationPOZ,ClearForm

ClearForm           PROC
                    lea bx,data1
                    mov BYTE PTR [bx],'-'
                    mov WORD PTR [bx+1],2020h
                    lea bx,data2
                    mov WORD PTR [bx+10],2020h
                    lea bx,data0
                    mov cx,12
             clrD0:
                    mov BYTE PTR [bx],20h
                    inc bx
                    loop clrD0
                    lea bx,data2
                    mov WORD PTR [bx],3030h
                    mov WORD PTR [bx+3],3030h
                    mov WORD PTR [bx+6],3030h
                    mov WORD PTR [bx+8],3030h
                    lea bx,data3
                    mov BYTE PTR [bx],'-'
                    lea bx,data4
                    mov BYTE PTR [bx],'-'
                    mov WORD PTR [bx+1],2020h
                    lea bx,endRegion
                    mov BYTE PTR [bx],'$'
                    call printDR
                    ret
ClearForm           ENDP

VeryficationNEG     PROC
                    lea bx,data1
                    mov BYTE PTR [bx],'N'
                    mov BYTE PTR [bx+1],'E'
                    mov BYTE PTR [bx+2],'G'
                    lea bx,endRegion
                    mov BYTE PTR [bx],'$'
                    call printDR
                    mov errlvl,1
                    ret
VeryficationNEG     ENDP

VeryficationPOZ     PROC
                    lea bx,data1
                    mov BYTE PTR [bx],'P'
                    mov BYTE PTR [bx+1],'O'
                    mov BYTE PTR [bx+2],'Z'

                    ;ROK
                    lea bx,data2
                    xor dx,dx
                    mov ax,year
                    div dm
                    add dx,30h
                    mov [bx+9],dl
                    xor dx,dx
                    div dm
                    add dx,30h
                    mov [bx+8],dl
                    xor dx,dx
                    div dm
                    add dl,30h
                    mov [bx+7],dl
                    add al,30h
                    mov [bx+6],al

                    ;MIESIAC
                    mov al,month
                    cmp al,9
                    ja twoDig
                    mov BYTE PTR [bx+3],'0'
                    add al,30h
                    mov BYTE PTR [bx+4],al
                    jmp complDay
            twoDig:
                    mov BYTE PTR [bx+3],'1'
                    sub al,10
                    add al,30h
                    mov [bx+4],al

                    ;DZIEN
          complDay:
                    mov ah,0
                    mov al,day
                    xor dx,dx
                    div dm
                    add al,30h
                    mov [bx],al
                    add dl,30h
                    mov [bx+1],dl
                    call GetSex
                    lea bx,EndRegion
                    mov BYTE PTR [bx],'$'

                    ;DZIEN TYG.
                    cmp BYTE PTR [data2+11],'!' ;wyk. jako marker
                    je skipDoW

                    mov BYTE PTR [data2+10],','
                    xor dx,dx
                    mov ax,h
                    mov bx,12
                    mul bx
                    mov bx,ax
                    lea si,[dowName+bx]
                    lea bx,data0
                    mov cx,12
            cpyDoW:
                    lodsb
                    mov [bx],al
                    inc bx
                    loop cpyDoW
           skipDoW:
                    call printDR
                    mov errlvl,0
                    ret
VeryficationPOZ     ENDP

PrintDR             PROC
                    cmp statCL,1
                    je prnCL
                    mov ah,2
                    mov bx,0
                    mov dx,curPosRef
                    sub dh,8
                    int 10h
                    lea dx,dataRegion
                    mov ah,9
                    int 21h
                    ret
             prnCL:
                    mov ax,0a0dh
                    mov WORD PTR [endRegion-2],ax
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

_TEXT ENDS

_DATA SEGMENT WORD PUBLIC 'DATA'

      EXTRN data0:BYTE,data1:BYTE,data2:BYTE,data3:BYTE,data4:BYTE
      EXTRN dataRegion,endRegion
      EXTRN statCL:BYTE,errlvl:BYTE,dm:WORD

dowName  DB 'SOBOTA      '
         DB 'NIEDZIELA   '
         DB 'PONIEDZIALEK'
         DB 'WTOREK      '
         DB 'SRODA       '
         DB 'CZWARTEK    '
         DB 'PIATEK      '

_DATA ENDS

_BSS  SEGMENT WORD PUBLIC 'BSS'
      EXTRN curPosRef:WORD
      EXTRN year:WORD,month:BYTE,day:BYTE,h:WORD
      EXTRN pesel:BYTE
_BSS  ENDS
      END