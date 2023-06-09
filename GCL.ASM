;----------------------------------------------------------------------------
; Part of CHKPESEL v. 2.2 ** GetCommandLine rev. 1 ** MOD0523 **
;----------------------------------------------------------------------------

code SEGMENT PUBLIC 'code'
     ASSUME cs:code,es:data
     PUBLIC GetCommandLine

GetCommandLine   PROC
                 mov ax,data
                 mov es,ax
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
                 lodsw
                 or al,0100000b
                 cmp ax,':p'
                 jne errorGCL
                 lea di,es:[pesel]
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
                 add BYTE PTR es:[statCL],10b
setGCL:
                 add BYTE PTR es:[statCL],1
noGCL:
                 ret
GetCommandLine   ENDP
code ENDS

data  SEGMENT PUBLIC 'data'
      EXTRN pesel:BYTE,statCL:BYTE
data  ENDS
      END