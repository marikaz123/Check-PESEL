; Gen. daty urodzenia dla PESEL ** 'marikaz'
;--------------------------------------------------------------
; Enter - koduj, F2 - wpisz kolejny numer, Esc - Wyjscie
;--------------------------------------------------------------
; 1800 <= year <= 2299, 0 <= month <= 19, 0 <= day <= 49
; wystaeczy aby zakodowac poprawna lub bledna date do testow


code     segment
         assume cs:code
         org 100h
start:
         jmp begin
info     db '+.....:y...m.d.$'
prompt   db 13,10,"      :$"
buffer   db 9,?,9 dup (0)
pDate    db '      $'
year     dw ?
month    db ?

JUMPS
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

         xor ax,ax
         mov cx,1000
         mov al,[buffer+2]
         cmp al,31h
         jb errd
         cmp al,32h
         ja errd
         sub al,30h
         mul cx
         mov year,ax
         ;
         xor ax,ax
         mov cx,100
         mov al,[buffer+3]
         cmp al,30h
         jb errd
         cmp al,39h
         ja errd
         sub al,30h
         mul cx
         add year,ax
         ;
         xor ax,ax
         mov cx,10
         mov al,[buffer+4]
         cmp al,30h
         jb errd
         cmp al,39h
         ja errd
         sub al,30h
         mul cx
         add year,ax
         ;
         xor ax,ax
         mov al,[buffer+5]
         cmp al,30h
         jb errd
         cmp al,39h
         ja errd
         sub al,30h
         add year,ax
         ;
         xor ax,ax
         mov cx,10
         mov al,[buffer+6]
         cmp al,30h
         jb errd
         cmp al,31h
         ja errd
         sub al,30h
         mul cx
         mov month,al
         mov al,[buffer+7]
         cmp al,30h
         jb errd
         cmp al,39h
         ja errd
         sub al,30h
         add month,al
         ;zakoduj
         cmp year,2299
         ja errd
         cmp year,2200
         jb chk2100
         add month,60
         jmp cDate
chk2100:
         cmp year,2100
         jb chk2000
         add month,40
         jmp cDate
chk2000:
         cmp year,2000
         jb chk1900
         add month,20
         jmp cDate
chk1900:
         cmp year,1900
         jb chk1800
         jmp cDate
chk1800:
         cmp year,1800
         jb errd
         add month,80

cDate:
         mov cx,10
         xor dx,dx
         xor ax,ax
         mov al,month
         div cx
         add dl,30h
         mov [pDate+3],dl
         add al,30h
         mov [pDate+2],al

         mov ax,year
         xor dx,dx
         div cx
         add dl,30h
         mov [pDate+1],dl
         xor dx,dx
         div cx
         add dl,30h
         mov [pDate],dl

         mov al,[buffer+8]
         cmp al,30h
         jb errd
         cmp al,34h
         ja errd
         mov [pDate+4],al
         mov al,[buffer+9]
         cmp al,30h
         jb errd
         cmp al,39h
         ja errd
         mov [pDate+5],al

         lea dx,pdate
         mov ah,9
         int 21h

whileK:
         mov ah,0
         int 16h
         cmp ax,3c00h
         je do
         cmp al,1bh
         jne whileK

         mov ax,4c00h
         int 21h
errd:
         mov cx,3
         lea di,pDate
         mov ax,2020h
         rep stosw
         mov byte ptr [di-6],'E'
         lea dx,pDate
         mov ah,9
         int 21h
         jmp whileK

code ends
     end start