;----------------------------------------------------------------------------
; ++++ CHKPESEL v2.3 ++ MOD2410 ++ (c)1993 'marikaz' ++++
;----------------------------------------------------------------------------
; Program sprawdza poprawnosc numeru PESEL na podstawie sensownosci
; zakodowanej w nim daty urodzenia oraz cyfry kontrolnej.
;----------------------------------------------------------------------------

_TEXT SEGMENT WORD PUBLIC 'CODE'
      DGROUP GROUP _DATA,_BSS
      ASSUME cs:_TEXT,ds:DGROUP,es:DGROUP

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
             mov ax,DGROUP
             mov ds,ax
             cmp statCL,1
             je  cmdLineMode
             cmp statCL,11b
             jne iMode
             lea dx,cmdErrTxt
             mov ah,9
             int 21h
             mov errlvl,-1
             jmp exitCL
      iMode:
             lea si,dataRegion ;kopiuj czysty interfejs
             lea di,buffer0    ;do bufora
             mov cx,BLEN
             rep movsb

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
             call @LeadChar      ;wlasny znak 'wiodacy' dla pola PESEL

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
             call @LeadChar
             mov ah,2
             mov bx,0
             mov dx,curPosRef
             int 10h
             mov ah,1
             mov cx,curShapeRef
             int 10h
exitCL:
             mov al,errlvl
             mov ah,4ch
             int 21h
Main         ENDP

@LeadChar    PROC
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
leadChar DB 0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0
@LeadChar    ENDP

_TEXT ENDS

_DATA SEGMENT WORD PUBLIC 'DATA'

PUBLIC dataRegion,endRegion,data0,data1,data2,data3,data4
PUBLIC statCL,errlvl
PUBLIC BLEN

statCL DB 0
errlvl DB 0

       INCLUDE iface.inc

_DATA ENDS

_BSS SEGMENT WORD PUBLIC 'BSS'

PUBLIC pesel,year,month,day,h
PUBLIC curShapeRef,curShapeHid,curShapeCus,curPosRef
PUBLIC statLY,buffer0

pesel       DB 11 DUP (?)
year        DW ?
month       DB ?
day         DB ?
h           DW ?
curPosRef   DW ?
curShapeRef DW ?
curShapeHid DW ?
curShapeCus DW ?
statLY      DB ?
buffer0     DB BLEN DUP (?)

_BSS ENDS

STACK SEGMENT STACK 'STACK'
DW 32h DUP (?)
STACK ENDS
      END Main
