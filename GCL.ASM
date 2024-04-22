;----------------------------------------------------------------------------
; CHKPESEL v2.2 ** GetCommandLine rev. A ** MOD0523 **
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
                 je noGCL
                 inc si
         findSW:
                 lodsb
                 cmp ax,'/'
                 je foundSW
                 cmp al,20h
                 je findSW
                 cmp al,9
                 je findSW
                 cmp al,0dh
                 je noGCL
        foundSW:
                 lodsb
                 or al,100000b
                 cmp al,'p'
                 jne errorGCL
                 lodsb
                 cmp al,':'
                 je skpc
                 dec si
           skpc:
                 lea di,[pesel]
                 mov cx,11

         get11d:
                 lodsb
                 cmp al,30h
                 jb errorGCL
                 cmp al,39h
                 ja errorGCL
                 sub al,30h
                 stosb
                 loop get11d
         skipBS:                    ;pomin 'sp' 'tab' po numerze
                 lodsb
                 cmp al,20h
                 je skipBS
                 cmp al,9
                 je skipBS
                 cmp al,0dh
                 je setGCL

errorGCL:
                 add BYTE PTR [statCL],10b
setGCL:
                 add BYTE PTR [statCL],1
noGCL:
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