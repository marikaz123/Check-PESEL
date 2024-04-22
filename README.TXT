 ----------------------------------------------------------------------------

        Check PESEL ver. 2.2
                                                      (c)1993-2023 'marikaz'
 ----------------------------------------------------------------------------

 Check PESEL pozwala sprawdzic podany numer PESEL pod wzgledem jego
 zgodnosci ze wzorcem nadawania tego numeru. Dziala z linii polecen
 DOS lub z prostym interfejsem.


        CECHY
        -----

 W PRZECIWIENSTWIE DO SPRAWDZAREK INTERNETOWYCH:

 CHKPESEL w polu wprowadzania numeru nie pozwoli podac zbyt krotkiego
 lub zbyt dlugiego numeru, nie pozwoli na wprowadzenie innego znaku niz
 cyfra. Wiec na dzien dobry pozbywamy sie polowy potencjalnych bledow.

 CHKPESEL nie opowiada bzdur. Jezeli sprawdza numer z data urodzenia z
 przyszlosci to w polu wiek bedzie napis 'nd.' a nie minus 80 na przyklad.
 Dla dzieci, ktore nie ukonczyly jeszcze 1 roku program podaje wiek "< 1"
 a nie "0".

 CHKPESEL podaje tylko poprawne informacje i nie wypisuje daty urodzenia oraz
 plci w przypadku gdy numer PESEL dostaje ocene NEG. Nie wiadomo przeciez
 na ktorej pozycji wystapil blad.

 CHKPESEL nie pisze ze "PESEL Prawidlowy". Pisze, ze jest zgodny (POZ), albo
 niezgodny (NEG) ze wzorcem. Bo PESEL z data urodzenia w 2155 r. nie jest
 de facto prawidlowy.

 CHKPESEL podaje wiek w latach UKONCZONYCH, wiec jezeli ktos urodzil sie
 10.04.2006 r. to w polu wiek zobaczy 18 dopiero 11.04.2024.


         DZIALANIE
         ---------

 CHKPESEL sprawdza poprawnosc wprowadzonego numeru PESEL na podstawie:
 - Sensownosci zakodowanej w PESEL-u daty urodzenia.
   Daty z przyszlosci sa sensowne, jesli beda w kaledarzu, ale przy
   takiej dacie pojawi sie '!'
 - Cyfry kontrolnej.

 Program mozna uruchomic w 2 trybach:

 1. Z PESEL-em podanym jako parametr w linii polecen.

    CHKPESEL.EXE /p[:]<PESEL>

    W tym trybie sprawdzany jest PESEL podany w linii polecen i wyswietlane
    jest info o statusie:

               wariant:  dobry        zly          data z przyszlosci
     ----------------------------------------------------------------
     Ocena wzg. wzorca:  POZ          NEG          POZ
        Data urodzenia:  03-12-1985   00-00-0000   05-11-2153 !
                  Plec:  M lub K      -            M lub K
                  Wiek:  38           -            nd.

    Program w wersji 2.1+ podaje rowniez nazwe dnia tygodnia dla daty
    urodzenia.
    W tym trybie program zwraca do systemu informacje o zgodnosci numeru
    ze wzorcem. W przypadku POZ: errorlevel=0; NEG: errorlevel=1
    Po wyswietleniu informacji program konczy dzialanie.

 2. Z interfejsem uzytkownika

    CHKPESEL.EXE (bez parametrow).

    W tym trybie mozna przeprowadzic dowolna ilosc sprawdzen wpisujac
    numer PESEL w polu:

       PESEL: ...........

    Po wprowadzeniu numeru i zatwierdzeniu [ENTER] wypelniany jest
    formularz z informacjami. Patrz screenshot: /PIC/chkpesel.png (*)
    Kolejne wcisniecie [ENTER] czysci formularz i pozwala na wpisanie
    kolejnego numeru.
    Klawisz [ESC] wychodzi do DOS.


        KOMPATYBILNOSC
        --------------

 - DOSBox 0.74+ - CHKPESEL zostal przebudowany i ponownie skomplilowany
                  na tym emulatorze.
 - FreeDOS 1.3  - CHKPESEL zostal przetestowany z tym systemem
                  na maszynie wirtualnej.
 - MS-DOS 5.0+  - wersja 1.0 pracowala na maszynie fizycznej.


        ZRODLA
        ------

https://romek.info/ut/pesel.html
https://pl.wikipedia.org/wiki/PESEL
http://www.algorytm.org/numery-identyfikacyjne/pesel.html

(*) NUMER PESEL NIE NALEZY DO ZADNEJ KONKRETNEJ OSOBY. ZOSTAL WYGENEROWANY
    GENERATOREM INTERNETOWYM.