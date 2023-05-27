;----------------------------------------------------------------------------
; Part of CHKPESEL v. 2.1 ** Interface ** MOD0423 **
;----------------------------------------------------------------------------

CMDErrTxt db 13,10,' Uzycie: chkpesel /p:<PESEL>',13,10,'$'
Interface db 13,10," Check PESEL v2.1  ***  (c)1993 'marikaz'",13,10
db ' ----------------------------------------',13,10
db '             PESEL: ...........',13,10
DataRegion db 13,10
DataRegionC db ' Ocena wzg. wzorca: '
data1 db '---',13,10
db '    Data urodzenia: '
data2 db '0000/00/00',20h,20h,13,10
db '              Plec: '
data3 db '-',13,10
db '              Wiek: '
data4 db '-',20h,20h,20h,20h
EndRegion db 20h,13,10
db ' ----------------------------------------',13,10
db ' [ENTER] Sprawdz/Nastepny ** [ESC] Koniec',13,10
db 13,10,'$'