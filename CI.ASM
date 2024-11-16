;----------------------------------------------------------------------------
; CHKPESEL v. 2.3 ** MOD2410 **
;----------------------------------------------------------------------------

_TEXT SEGMENT WORD PUBLIC 'CODE'
      DGROUP GROUP _DATA,_BSS
      ASSUME cs:_TEXT,ds:DGROUP,es:DGROUP
      EXTRN  BLEN:ABS
      PUBLIC VeryficationNEG,VeryficationPOZ,ClearForm

ClearForm           PROC
                    lea si,buffer0
                    lea di,dataRegion
                    mov cx,BLEN
                    rep movsb
                    call printDR
                    ret
ClearForm           ENDP

VeryficationNEG     PROC
                    lea di,data1
                    mov [di],'EN'
                    mov [di+2],' G'
                    lea di,endRegion
                    mov BYTE PTR [di],'$'
                    call printDR
                    mov errlvl,1
                    ret
VeryficationNEG     ENDP

VeryficationPOZ     PROC
                    lea di,data1
                    mov [di],'OP'
                    mov [di+2],' Z'
                    ;DZIEN
                    lea di,data2
                    mov bx,10
                    xor dx,dx
                    xor ax,ax
                    mov al,day
                    div bl
                    add ax,'00'
                    stosb
                    xchg ah,al
                    stosb
                    inc di
                    ;MIESIAC
                    xor ax,ax
                    mov al,month
                    dec al    ;korekta
                    mov cx,3
                    mul cl
                    lea si,moName
                    add si,ax
                    rep movsb
                    inc di
                    ;ROK
                    mov ax,year
                    mov cx,4
                l1:
                    xor dx,dx
                    div bx
                    push dx
                    loop l1
                    mov cx,4
                l2:
                    pop dx
                    mov ax,dx
                    add al,'0'
                    stosb
                    loop l2
                    ;DZIEN TYG.
                    cmp BYTE PTR [di],'!' ;znacznik (wstawia GetAge)
                    je skipDoW
                    mov BYTE PTR [di],','
                    add di,2
                    lea si,dowName
                    xor dx,dx
                    mov ax,h
                    mov cx,12
                    mul cx
                    add si,ax
                    rep movsb
           skipDoW:
                    call GetSex
                    mov endRegion,'$'
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
             prnCL:
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

      EXTRN data0,data1,data2,data3,data4
      EXTRN dataRegion,endRegion
      EXTRN statCL:BYTE,errlvl:BYTE,dm:WORD

dowName DB 'SOBOTA      ','NIEDZIELA   ','PONIEDZIALEK'
        DB 'WTOREK      ','SRODA       ','CZWARTEK    ','PIATEK      '
moName  DB 'STY','LUT','MAR','KWI','MAJ','CZE','LIP','SIE'
        DB 'WRZ','PAZ','LIS','GRU'

_DATA ENDS

_BSS  SEGMENT WORD PUBLIC 'BSS'
      EXTRN curPosRef:WORD
      EXTRN year:WORD,month:BYTE,day:BYTE,h:WORD
      EXTRN pesel:BYTE
      EXTRN buffer0
_BSS  ENDS
      END
