;----------------------------------------------------------------------------
; ++++ CHKPESEL v2.2 ++ MAIN rev. 2 ++ MOD0623 ++ (c)1993 'marikaz' ++++
;----------------------------------------------------------------------------
; NOTES:
; Program sprawdza poprawnosc numeru PESEL na podstawie sensownosci zakodo-
; wanej w nim daty urodzenia oraz sumy kontrolnej.
;----------------------------------------------------------------------------

code SEGMENT PUBLIC 'code'
     ASSUME cs:code,ds:data

     EXTRN GetCommandLine:PROC
     EXTRN GetBirthDate:PROC
     EXTRN GetPESELfromCon:PROC
     EXTRN CheckDay:PROC
     EXTRN LeapYear:PROC
     EXTRN CheckSum:PROC
     EXTRN GetDayOfWeek:PROC
     EXTRN GetAge:PROC
     EXTRN VeryficationNEG:PROC,VeryficationPOZ:PROC,ClearForm:PROC

Main         PROC
             call GetCommandLine        ;GCL.ASM
             mov ax,data
             mov ds,ax
             cmp statCL,1
             je  cmdLineMode
             cmp statCL,11b
             jne waUsage
             lea dx,cmdErrTxt
             mov ah,9
             int 21h
             mov errlvl,-1
             jmp exitCL
    waUsage:
             lea dx,interface
             mov ah,9
             int 21h

             ;pozycje i ksztalt kursora
             mov ah,3
             mov bx,0
             int 10h
             mov curPosRef,dx
             mov curShapeRef,cx
             mov curShapeCus,cx    ;(wlasny)
             mov curShapeHid,2020h
             call SetLeadChar      ;wlasny znak 'wiodacy' dla pola PESEL

do:
             call ClearForm             ;CI.ASM
             call GetPESELfromCon       ;GP.ASM
             cmp ax,-1
             je exitNow
cmdLineMode:
             call GetBirthDate          ;GBD.ASM
             cmp ax,-1
             je wrongPESEL
             call LeapYear              ;LY.ASM (ALGS.LIB)
             mov statLY,al
             call CheckDay              ;CD.ASM
             cmp ax,-1
             je  wrongPESEL
             call CheckSum              ;CS.ASM (ALGS.LIB)
             cmp ax,-1
             je wrongPESEL
             call GetAge                ;GA.ASM
             call GetDayOfWeek          ;DOW.ASM (ALGS.LIB)
             call VeryficationPOZ       ;CI.ASM
             cmp statCL,1
             je exitCL
             jmp while_esc
wrongPESEL:
             call VeryficationNEG       ;CI.ASM
             cmp statCL,1
             je exitCL

while_esc:
             mov ah,0
             int 16h
             cmp al,0dh
             je do
             cmp al,1bh
             jne while_esc
exitNow:
             mov cs:[leadChar+6],0 ;przywroc znak 255
             call SetLeadChar
             mov ah,2
             mov bx,0
             mov dx,CurPosRef
             int 10h
             mov ah,1
             mov cx,CurShapeRef
             int 10h
             mov ax,4c00h
             int 21h
exitCL:
             mov al,errlvl
             mov ah,4ch
             int 21h
Main         ENDP

SetLeadChar  PROC
             push es
             push bp
             mov ax,cs
             mov es,ax
             mov bp,OFFSET leadChar
             mov dx,WORD PTR 0FFh
             mov cx,1
             mov bx,1000h
             mov ax,1100h
             int 10h
             pop bp
             pop es
             ret
SetLeadChar  ENDP
leadChar     DB 0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0
code ENDS

data SEGMENT PUBLIC 'data'

     PUBLIC pesel,year,month,day,h
     PUBLIC curShapeRef,curShapeHid,curShapeCus,curPosRef
     PUBLIC statLY,statCL
     PUBLIC dataRegion,endRegion,data0,data1,data2,data3,data4
     PUBLIC errlvl

pesel         DB 11 DUP (?)
year          DW ?
month         DB ?
day           DB ?
h             DW ?
curPosRef     DW ?
curShapeRef   DW ?
curShapeHid   DW ?
curShapeCus   DW ?
statLY        DB ?   ;LeapYear wpisuje 1:0
statCL        DB 0   ;status linii polecen
errlvl        DB 0

              INCLUDE iface.inc
data ENDS

_stk SEGMENT STACK 'stack'
DW 64 DUP (?)
_stk ENDS
     END Main