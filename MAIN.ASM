;----------------------------------------------------------------------------
; ++++ CHKPESEL v2.1 ++ MAIN Rev. 0 ++ MOD0523 ++ (c)1993 'marikaz' ++++
;----------------------------------------------------------------------------
; NOTES:
; Program sprawdza poprawnosc numeru PESEL na podstawie sensownosci zakodo-
; wanej w nim daty urodzenia oraz sumy kontrolnej.
;----------------------------------------------------------------------------

code SEGMENT PUBLIC 'code'
     ASSUME cs:code,ds:data

EXTRN GetCommandLine:proc
EXTRN GetBirthDate:proc
EXTRN GetPESELfromCon:proc
EXTRN CheckDay:proc
EXTRN LeapYear:proc
EXTRN CheckSum:proc
EXTRN GetAge:proc
EXTRN VeryficationNEG:proc,VeryficationPOZ:proc,ClearForm:proc

main         PROC
             call GetCommandLine        ;GCL.ASM
             mov ax,data
             mov ds,ax
             cmp statCL,1
             je  cmdLineMode
             cmp statCL,11b
             jne  waUsage
             lea dx,CMDErrTxt
             mov ah,9
             int 21h
    waUsage:
             lea dx,Interface
             mov ah,9
             int 21h

             ;pozycje i ksztalt kursora
             mov ah,3
             mov bx,0
             int 10h
             ;wypelnienie zmiennych pozycji i ksztaltu kursora
             mov CurPosRef,dx
             mov CurShapeRef,cx
             mov CurShapeCus,cx    ;mozna wlasny (tu standardowy)
             mov CurShapeHid,2020h ;niewidoczny

do:
             call ClearForm
             call GetPESELfromCon       ;GP.ASM
             cmp ax,-1
             je exitNow
cmdLineMode:
             call GetBirthDate          ;GBD.ASM
             cmp ax,-1
             je wrongPESEL
             call LeapYear              ;LY.ASM
             mov statLY,al
             call CheckDay              ;CD.ASM
             cmp ax,-1
             je  wrongPESEL
             call CheckSum              ;CS.ASM
             cmp ax,-1
             je wrongPESEL
             call GetAge                ;GA.ASM
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
main         ENDP

code ENDS

data SEGMENT PUBLIC 'data'
PUBLIC pesel,year,month,day
PUBLIC CurShapeRef,CurShapeHid,CurShapeCus,CurPosRef
PUBLIC statLY,statCL
PUBLIC dataRegionC,dataRegion,endRegion,errlvl
PUBLIC data1,data2,data3,data4

pesel         DB 11 DUP (?)
year          DW ?
month         DB ?
day           DB ?
CurPosRef     DW ?
CurShapeRef   DW ?
CurShapeHid   DW ?
CurShapeCus   DW ?
statLY        DB ?   ;LeapYear wpisuje bezposrednio 1:0
statCL        DB 0
errlvl        DB 0
INCLUDE iface.inc
data ENDS

_stk SEGMENT STACK 'stack'
dw 64 dup (?)
_stk ENDS
     END main