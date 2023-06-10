;----------------------------------------------------------------------------
; Part of CHKPESEL v. 2.2 ** GetDayOfWeek rev. 1 ** MOD0623 **
;----------------------------------------------------------------------------
; NOTES:
; Uproszczony algorytm Zellera, zrodlo Wikipedia (en.)
;----------------------------------------------------------------------------

code SEGMENT PUBLIC 'code'
     ASSUME cs:code,ds:data
     PUBLIC GetDayOfWeek

GetDayOfWeek      PROC
                  mov ax,year      ;trzeba zrobic kopie
                  mov Y,ax
                  mov al,month
                  mov m,al
                  mov al,day       ;dnia niekoniecznie
                  mov q,al

                  cmp m,2
                  ja do
                  add m,12
                  sub Y,1
do:
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

code ENDS

data SEGMENT PUBLIC 'data'
     EXTRN h:WORD,year:WORD,month:BYTE,day:BYTE

q    DB ?
m    DB ?
Y    DW ?

data ENDS
     END