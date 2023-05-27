; Generator cyfry kontrolnej dla numeru PESEL                ** 'marikaz'
; Enter - oblicz  F2 - wpisz kolejny numer, Esc - Wyjscie
;---------------------------------------------------------------------------

code     segment
         assume cs:code
         org 100h
start:
         jmp begin
info     db '+:..cyfry...$'
prompt   db 13,10," :$"
buffer   db 11,?,11 dup (0)
chkdig   db ' $'
mls      db ?,?,9,7,3,1,9,7,3,1,9,7
sum      dw 0

begin:
         mov dx,OFFSET info
         mov ah,9
         int 21h
do:
         mov dx,OFFSET prompt
         mov ah,9
         int 21h
         mov dx,OFFSET buffer
         mov ah,0ah
         int 21h
         mov word ptr [sum],0
         mov bx,2
         mov cx,10
         xor dx,dx
calcSum:
         xor ax,ax
         mov al,[buffer+bx]
         cmp al,30h
         jb errC
         cmp al,39h
         ja errC
         sub al,30h
         mul [mls+bx]
         add sum,ax
         inc bx
         loop calcSum

         sub bx,2
         mov ax,sum
         div bx
         add dl,30h
         mov chkdig,dl
         mov ah,9
         mov dx,OFFSET chkdig
         int 21h
whileKey:
         mov ah,0
         int 16h
         cmp ax,3c00h
         je do
         cmp al,1bh
         jne whileKey
         mov ah,4ch
         int 21h
errC:
         mov [chkdig],'E'
         lea dx,chkdig
         mov ah,9
         int 21h
         jmp whileKey
code     ends
end      start