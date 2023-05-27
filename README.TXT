 ----------------------------------------------------------------------------

          Check PESEL ver. 2.1 ** 1993 'marikaz' **  mod. 05/2023

 ----------------------------------------------------------------------------

 Check PESEL pozwala sprawdzic podany numer PESEL pod wzgledem jego
 zgodnosci ze wzorcem nadawania tego numeru. Dziala z linii polecen
 DOS lub z prostym interfejsem.

        CECHY
        -----

 CHKPESEL w polu wprowadzania numeru nie pozwoli podac zbyt krotkiego
 lub zbyt dlugiego numeru, nie pozwoli na wprowadzenie innego znaku niz
 cyfra. Wiec na dzien dobry pozbywamy sie polowy potencjalnych bledow.

 CHKPESEL nie opowiada bzdur. Jezeli sprawdza numer z przyszla data
 urodzenia to w polu wiek bedzie napis 'nd.' a nie minus 80 na przyklad.

 CHKPESEL nie brnie w kolejne bzdury i nie podaje daty urodzenia oraz
 plci w przypadku gdy numer PESEL dostaje ocene NEG. Nie wiadomo przeciez
 na ktorej pozycji wystapil blad.

 CHKPESEL nie pisze ze "PESEL Prawidlowy". Pisze, ze jest zgodny, albo
 niezgodny ze wzorcem. POZ - NEG. Bo PESEL z data urodzenia w 2155 r.
 nie jest de facto prawidlowy.

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

    chkpesel /p:<PESEL>

    W tym trybie sprawdzany jest PESEL podany w linii polecen i wyswietlane
    jest info o statusie:

               wariant:  dobry        zly          data z przyszlosci
     ----------------------------------------------------------------
     Ocena wzg. wzorca:  POZ          NEG          POZ
        Data urodzenia:  1985/12/03   0000/00/00   2153/11/05 !
                  Plec:  M lub K      -            M lub K
                  Wiek:  38           -            nd.

    Po wyswietleniu informacji program konczy dzialanie.
    W przypadku bledu skladni program wyswietli info o poprawnej skladni
    i przejdzie do trybu z interfejsem uzytkownika.

    W tym trybie program zwraca rowniez do systemu informacje o zgodnosci
    numeru ze wzorcem. W przypadku POZ: errorlevel=0; NEG: errorlevel=1

 2. Z interfejsem uzytkownika

    chkpesel (bez parametrow).

    W tym trybie mozna przeprowadzic dowolna ilosc sprawdzen wpisujac
    numer PESEL w polu:

       PESEL: ...........

    Po wprowadzeniu numeru i zatwierdzeniu [ENTER] wypelniany jest
    formularz z informacjami (jak w trybie z linii polecen).
    Kolejne wcisniecie [ENTER] czysci formularz i pozwala na wpisanie
    kolejnego numeru.

    Klawisze:

    [ENTER] - Sprawdz numer po jego wprowadzeniu / wprowadz nastepny numer.
    [ESC]   - Wyjdz do DOS


        KOMPATYBILNOSC
        --------------

 - DOSBox 0.74+ - CHKPESEL zostal przebudowany i ponownie skomplilowany
                  pod tym emulatorem.
 - FreeDOS 1.3  - CHKPESEL zostal przetestowany pod tym systemem
                  na maszynie wirtualnej.
 - MS-DOS 5.0+  - wersja 1.0 poprawnie dzialala rowniez na maszynie
                  fizycznej.