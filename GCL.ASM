;----------------------------------------------------------------------------
; CHKPESEL v2.3 ** MOD2305 **
;----------------------------------------------------------------------------

_TEXT SEGMENT WORD PUBLIC 'CODE'
      DGROUP GROUP _DATA,_BSS
      ASSUME cs:_TEXT,es:DGROUP
      PUBLIC GetCommandLine

GetCommandLine   PROC
                 mov ax,DGROUP
                 mov es,ax
                 cld
                 mov si,80h
                 cmp BYTE PTR [si],0
                 je noCL
                 inc si
fSwitch:
                 lodsb
                 cmp al,'/'
                 je switch
                 cmp al,20h
                 je fSwitch
                 cmp al,9
                 je fSwitch
                 cmp al,0dh
                 je noCL
switch:
                 lodsb
                 or al,100000b
                 cmp al,'p'
                 jne errCL
                 cmp BYTE PTR [si],':'
                 jne skp
                 inc si
            skp:
                 lea di,[pesel]
                 mov cx,11
           g11d:
                 lodsb
                 cmp al,30h
                 jb errCL
                 cmp al,39h
                 ja errCL
                 sub al,30h
                 stosb
                 loop g11d
          skpBS:
                 lodsb
                 cmp al,20h
                 je skpBS
                 cmp al,9
                 je skpBS
                 cmp al,0dh
                 je setCL
errCL:
                 or BYTE PTR [statCL],10b
setCL:
                 or BYTE PTR [statCL],1   ;11b=blad
noCL:
                 ret
GetCommandLine   ENDP
_TEXT ENDS

_DATA SEGMENT WORD PUBLIC 'DATA'
      EXTRN statCL:BYTE
_DATA ENDS

_BSS SEGMENT WORD PUBLIC 'BSS'
     EXTRN pesel:BYTE
_BSS ENDS
     END