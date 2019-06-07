--Z tabeli dept wy�wietlic wszystkie kolumny oraz wszystkie rekordy.
SELECT * FROM DEPT;

--Wy�wietlic wszystkie identyfikatory departamentow, nazwiska pracownik�w oraz identyfikatory manager�w z tabeli emp. 
SELECT dept_id "ID",last_name "Nazwisko",manager_id FROM EMP;

--Wy�wietli� roczne dochody wszystkich pracownik�w (wraz z nazwiskami tych pracownik�w). 
SELECT SALARY*12 "Roczne wynagrodzenie",last_name "Nazwisko" FROM EMP;

--Wy�wietlic dane osobowe pracownik�w, zarobki miesi�czne, zarobki roczne doliczaj�c premi� roczn� w wysoko�ci 1000. 
SELECT FIRST_NAME "Imi�",LAST_NAME "Nazwisko",SALARY "Zarobki miesi�czne", SALARY*12+1000 "Roczne z premi�" FROM EMP

--Wy�wietlic dane osobowe pracownikow, zarobki miesieczne, zarobki roczne � doliczajac premie co miesiac w wysokosci 8%.
SELECT FIRST_NAME ,LAST_NAME ,SAlARY,SALARY*1.08*12 "Roczne z premia" from EMP;

--Wy�wietlic nazwisko oraz roczny dochod wraz z dodatkiem 5% miesi�cznych zarobk�w�tak� kolumn� nazwa� ROCZNY DOCHOD.
SELECT LAST_NAME,SALARY*12+SALARY*0.05 "ROCZNY DOCH�D" FROM EMP;

--Wy�wietlic skonkatenowane imie inazwisko dla poszczegolnych pracownikow (w jednej kolumnie np. MidoriNagayama). Kolumne nazwac Imie i Nazwisko.
SELECT CONCAT(FIRST_NAME,LAST_NAME) as "Imi� i Nazwisko" FROM EMP;

--Wy�wietlic pelne dane osobowe opracownikach oraz ich stanowiskach.
SELECT FIRST_NAME || ' ' || LAST_NAME || ' - ' || TITLE as "Super Pracownicy" FROM EMP;

--Wy�wietlic nazwisko pracownika, pensje, stanowisko i jego nagrode.
SELECT LAST_NAME,SALARY,TITLE,SALARY*(COMMISSION_PCT/100) PROWIZJA from EMP;

--Zmodyfikowac poprzednie zapytanie tak, aby zamiast (null)pojawi�o sie 0.
SELECT LAST_NAME,SALARY,TITLE,NVL(SALARY*(COMMISSION_PCT/100),0) PROWIZJA from EMP;

--Wy�wietlic nazwy dzialow z tabeli dept. Zmodyfikowac zapytanie tak, by nie pojawialy si� wielokrotnie te same nazwy.
SELECT DISTINCT NAME FROM DEPT;

--Dla ka�dego pracownika wyswietlic nazwisko, nr departamentu, wynagrodzenie oraz dat� zatrudnienia. Posortowac wynik wzgl�dem numeru departamentu oraz malejaco wzgledem wynagrodzenia.
SELECT LAST_NAME,DEPT_ID,SALARY,START_DATE FROM EMP ORDER BY DEPT_ID,SALARY DESC;

--Wyswietlic nazwiska pracownik�w, numery dzialow oraz daty zatrudnienia. Uporzadkowac wyniki rosnaco wzgledem daty zatrudnienia.
SELECT LAST_NAME,DEPT_ID,START_DATE FROM EMP ORDER BY START_DATE;

--Napisac zapytanie, ktore wyswietli dane osobowe oraz stanowisko pracownik�w o nazwisku Patel.
SELECT FIRST_NAME,LAST_NAME,TITLE FROM EMP WHERE LAST_NAME LIKE 'Patel';

--Wyswietlic imie, nazwisko oraz date zatrudnienia tych pracownikow,ktorzy zostali zatrudnieni pomi�dzy: 2 maja 1991 a 15 czerwca 1991.
SELECT LAST_NAME,START_DATE FROM EMP WHERE START_DATE BETWEEN TO_DATE('02-05-1991','dd-mm-yyyy') and TO_DATE('15-06-1991','dd-mm-yyyy'); 

--Wyswietlic identyfikatory departamentow, nazwy oraz identyfikatory dla regionow o ID rownym 1 lub 3 (tabela dept).
SELECT ID,NAME,REGION_ID FROM DEPT WHERE REGION_ID=3 or REGION_ID=1 ORDER BY ID;

--Wyswietlic dane wszystkich pracownikow, kt�rych nazwiska zaczynaja si� na litere M.
SELECT * FROM EMP WHERE LAST_NAME LIKE 'M%';

--Wy�wietlic wszystkie dane osobowe pracownikow, kt�rych nazwiska nie zawieraja litery �a�.
SELECT * FROM EMP WHERE LAST_NAME not like '%a%';

--Wy�wietlic nazwiska oraz date zatrudnienia pracownik�w, ktorzy zaczeli prace w 1991 roku.
SELECT LAST_NAME, START_DATE FROM EMP WHERE START_DATE LIKE '%91%';

--Wy�wietlic nazwiska pracownikow, kt�rych druga litera nazwiska jest �a�.
SELECT LAST_NAME FROM EMP WHERE LAST_NAME LIKE '_a%';

--Wy�wietlic nazwy firm z tabeli customer, kt�re zawieraja litery �s�i �o� oddzielone jednym znakiem.
SELECT NAME FROM CUSTOMER WHERE NAME LIKE '%s_o%';
