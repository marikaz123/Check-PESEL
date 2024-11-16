;----------------------------------------------------------------------------
; CHKPESEL v2.3 ** MOD2306 **
;----------------------------------------------------------------------------
; NOTES:
; Uproszczony algorytm Zellera, zrodlo Wikipedia (en.)
;----------------------------------------------------------------------------

_TEXT SEGMENT WORD PUBLIC 'CODE'
      DGROUP GROUP _DATA,_BSS
      ASSUME cs:_TEXT,ds:DGROUP
      PUBLIC GetDayOfWeek

GetDayOfWeek      PROC
                  LOCALS
                  mov ax,year
                  mov Y,ax
                  mov al,month
                  mov m,al
                  mov al,day
                  mov q,al

                  cmp m,2
                  ja @@do
                  add m,12
                  sub Y,1
@@do:
                  xor dx,dx
                  mov al,q
                  cbw
                  mov h,ax

                  mov al,m
                  cbw
                  inc ax
                  mov bx,13
                  mul bx
                  mov bx,5
                  div bx
                  add h,ax

                  mov ax,Y
                  add h,ax

                  xor dx,dx
                  mov bx,4
                  div bx
                  add h,ax

                  xor dx,dx
                  mov ax,Y
                  mov bx,100
                  div bx
                  sub h,ax

                  xor dx,dx
                  mov ax,Y
                  mov bx,400
                  div bx
                  add h,ax

                  xor dx,dx
                  mov ax,h
                  mov bx,7
                  div bx

                  mov h,dx ;h=dzien tygodnia (0=sobota itd.)
                  ret
GetDayOfWeek      ENDP

_TEXT ENDS

_DATA SEGMENT WORD PUBLIC 'DATA'
_DATA ENDS

_BSS SEGMENT WORD PUBLIC 'BSS'
     EXTRN h:WORD,year:WORD,month:BYTE,day:BYTE

q    DB ?
m    DB ?
Y    DW ?

_BSS ENDS
     END