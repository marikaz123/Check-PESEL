# Check PESEL dla DOS (FreeDOS, MS-DOS, DOSBox)
<sup>MOD. 06/2023</sup>

Check PESEL pozwala sprawdzić podany numer PESEL pod wzgledem jego zgodności ze wzorcem nadawania tego numeru. Działa z linii polecen DOS lub z prostym interfejsem.    
> __W odróżnieniu od internetowych "walidatorów", program CHKPESEL został przetestowany z najprzeróżniejszymi numerami (dobrymi i zlymi) tak, aby mieć pewność co do poprawności jego działania i zwracanych wyników.__   

## CECHY
W przeciwieństwie do sprawdzarek internetowych:

- CHKPESEL w polu wprowadzania numeru nie pozwoli podać zbyt krótkiego lub zbyt dlugiego numeru, nie pozwoli na wprowadzenie innego znaku niż cyfra. Więc na dzień dobry odpada połowa potencjalnych blędów.
- CHKPESEL nie pisze "PESEL Prawidlowy". Pisze, że ocena zgodności ze wzorcem jest: POZ-ytywna lub NEG-atywna. Bo PESEL z data urodzenia w 2155 r. nie jest de facto prawidłowy.
- CHKPESEL nie opowiada bzdur. Jeżeli sprawdza numer z przyszłą datą urodzenia, to w polu wiek będzie napis 'ND.' a nie minus 80 na przykład.
- CHKPESEL nie zmyśla i nie podaje daty urodzenia oraz płci w przypadku, gdy numer PESEL dostaje ocenę NEG. Nie wiadomo przecież na której pozycji wystapił błąd.
- CHKPESEL podaje wiek w latach UKOŃCZONYCH, wiec jeżeli ktoś urodził się 10.04.2006 r., to w polu wiek zobaczy 18 dopiero 11.04.2024.
- CHKPESEL działa w pełnym zakresie dat urodzenia jaki został przewidziany dla systemu PESEL.

## DZIAŁANIE
CHKPESEL sprawdza zgodnoość wprowadzonego numeru PESEL na podstawie:
- Sensowności zakodowanej w PESEL-u daty urodzenia.   
(Daty z przyszłości są sensowne, jeśli będą w kaledarzu, ale przy takiej dacie pojawi się `!`).   
- Cyfry kontrolnej.   

## URUCHAMIANIE
#### Z PESEL-em podanym jako parametr linii poleceń.   
```
chkpesel /p:<PESEL>
```
W tym trybie sprawdzany jest PESEL podany w linii poleceń i wyświetlane jest info o statusie:

|wariant: |dobry |zły |z przyszłości |
|---:|:---|:---|:---|
|Ocena wzg. wzorca:|POZ |NEG |POZ |
|Data urodzenia: |1985/12/03 |0000/00/00 |2153/11/05 ! |
|Plec: |M lub K |- |M lub K |
|Wiek: |38 |- |ND.|   

Po wyświetleniu informacji program kończy działanie.   
W przypadku błędów w linii komend wyświetlane jest info o poprawnej składni.
   
Screenshot:<sup>*</sup>   
![chkpesel cl](/IMG/chkp_cl.jpg)

#### Z interfejsem użytkownika.   
```
chkpesel (bez parametrów)
```
W tym trybie można przeprowadzić dowolna ilość sprawdzeń wpisujac numer PESEL w polu:   

`PESEL: ........... `   

Po wprowadzeniu numeru i zatwierdzeniu `ENTER` wypełniany jest formularz z informacjami (jak w trybie z linii poleceń).   
Kolejne wciśnięcie `ENTER` czyści poprzednie dane i pozwala na wpisanie następnego numeru.   

Screenshot:<sup>*</sup>   
![chkpesel ui](/IMG/chkp_ui.jpg)


__Klawisze:__     
`ENTER` - Sprawdź numer po jego wprowadzeniu / wprowadź następny numer.   
`ESC` - Wyjdz do DOS.   

## KOMPATYBILNOŚĆ
 - __DOSBox 0.74+__ - CHKPESEL został przebudowany i ponownie skomplilowany pod tym emulatorem.   
 - __FreeDOS 1.3__ - CHKPESEL został przetestowany pod tym systemem na maszynie wirtualnej.   
 - __MS-DOS 5.0+__ - wersja 1.0 poprawnie działała rownież na maszynie fizycznej.   

## ŹRÓDŁA
1. http://www.algorytm.org/numery-identyfikacyjne/pesel.html   
Implementacja jest co prawda w C, ale była źródłem 'inspiracji'.
2. https://romek.info/ut/pesel.html   
Najbardziej wyczerpujące żródło informacji o numerach seryjnych jakie można znaleźć na polskim internecie.
3. https://pl.wikipedia.org/wiki/PESEL   


## HISTORIA WERSJI
Odgrzanie tego starocia spowodowaly sprawdzarki internetowe wypisujace totalne bzdury oraz konieczność skorzystania z niezawodnego narzedzia. No i jest... w wersji dla DOS w XXI wieku. :)

__ver. 2.2 (06/2023)__   
`+` Dodano dzień tygodnia dla dat urodzenia, oczywiście tylko dla tych, które już w kalendarzu wystąpiły.   
`~` Błąd w linii komend nie uruchamia już automatycznie interfejsu.   
`~` Poprawiono trochę interfejs: wyświetlanie daty, "customowy" znak wiodący w polu PESEL.  

__ver. 2.1 (05/2023)__    
`+` Dodano informację o wieku.   
`~` Poprawiono drobne błędy.   
`~` Zmieniono algorytm liczenia cyfry kontrolnej (patrz: zrodło poz. 2)   
Poprzednie wersje niedostępne w repozytorium.


###### <sup>*</sup> PESEL __nie należy__ do żadnej konkretnej osoby. Został wygenerowany narzędziami z /TOOLS na podstawie przypadkowych danych.

##### CHKPESEL <sub>ver. 2.2</sub> 1993 'marikaz'
