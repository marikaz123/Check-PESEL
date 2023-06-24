;----------------------------------------------------------------------------
; Part of CHKPESEL v. 2.2 ** Interface ** MOD0623 **
;----------------------------------------------------------------------------

cmdErrTxt  DB 13,10," Check PESEL v2.2 :: (c)1993 'marikaz'",13,10
           DB 13,10,' Uzycie:',13,10
           DB '         chkpesel.exe [/p:<PESEL>]',13,10
           DB '         PESEL = 11 cyfr Numeru ewidencyjnego,',13,10,13,10
           DB ' Brak parametrow w linii komend powoduje',13,10
           DB ' uruchomienie interfejsu uzytkownika.',13,10,'$'

interface  DB 13,10," Check PESEL ver. 2.2  ***  (c)1993 'marikaz'",13,10
           DB ' --------------------------------------------',13,10
           DB '             PESEL: ...........',13,10
dataRegion DB 13,10,' Ocena wzg. wzorca: '
     data1 DB '-  ',13,10
           DB '    Data urodzenia: '
     data2 DB '00-00-0000',20h,20h
     data0 DB 12 dup (20h),13,10
           DB '              Plec: '
     data3 DB '-',13,10
           DB '              Wiek: '
     data4 DB '-',20h,20h,20h,20h
endRegion  DB 20h,13,10
           DB ' --------------------------------------------',13,10
           DB ' [ENTER] Sprawdz / Nastepny  **  [ESC] Koniec',13,10
           DB 13,10,'$'