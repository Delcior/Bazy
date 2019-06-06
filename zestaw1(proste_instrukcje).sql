--Z tabeli dept wy�wietli� wszystkie kolumny oraz wszystkie rekordy.
SELECT * FROM DEPT;

--Wy�wietli� wszystkie identyfikatory departament�w, nazwiska pracownik�w oraz identyfikatory manager�w ztabeli emp. 
SELECT dept_id "ID",last_name "Nazwisko",manager_id FROM EMP;

--Wy�wietli� roczne dochody wszystkich pracownik�w (wraz z nazwiskami tych pracownik�w). 
SELECT SALARY*12 "Roczne wynagrodzenie",last_name "Nazwisko" FROM EMP;

--Wy�wietli� dane osobowe pracownik�w, zarobki miesi�czne, zarobki roczne doliczaj�c premi� roczn� w wysoko�ci 1000. 
SELECT FIRST_NAME "Imi�",LAST_NAME "Nazwisko",SALARY "Zarobki miesi�czne", SALARY*12+1000 "Roczne z premi�" FROM EMP

--Wy�wietli� dane osobowe pracownik�w, zarobki miesi�czne, zarobki roczne �doliczaj�c premi� co miesi�cwwysoko�ci 8%.
SELECT FIRST_NAME ,LAST_NAME ,SAlARY,SALARY*1.08*12 "Roczne z premia" from EMP;

--Wy�wietli�nazwisko orazroczny doch�dwraz z dodatkiem 5% miesi�cznych zarobk�w�tak� kolumn� nazwa� ROCZNY DOCH�D(alias).
SELECT LAST_NAME,SALARY*12+SALARY*0.05 "ROCZNY DOCH�D" FROM EMP;

--Wy�wietli� skonkatenowane imi� inazwisko dla poszczeg�lnych pracownik�w (w jednej kolumnie np. MidoriNagayama). Kolumn� nazwa� Imi� i Nazwisko.
SELECT CONCAT(FIRST_NAME,LAST_NAME) as "Imi� i Nazwisko" FROM EMP;

--Wy�wietli� pe�ne dane osobowe opracownikach oraz ich stanowiskach (w jednej kolumnie,znag��wkiem Super Pracownicy).
SELECT FIRST_NAME || ' ' || LAST_NAME || ' - ' || TITLE as "Super Pracownicy" FROM EMP;

--Wy�wietli� nazwisko pracownika, pensj�, stanowisko i jego nagrod� 
SELECT LAST_NAME,SALARY,TITLE,SALARY*(COMMISSION_PCT/100) PROWIZJA from EMP;

--Zmodyfikowa� poprzednie zapytanie tak, aby zamiast (null)pojawi�osi� 0.
SELECT LAST_NAME,SALARY,TITLE,NVL(SALARY*(COMMISSION_PCT/100),0) PROWIZJA from EMP;

--Wy�wietli� nazwy dzia��w z tabeli dept. Zmodyfikowa� zapytanie tak, by nie pojawia�y si� wielokrotnie te same nazwy.
SELECT DISTINCT NAME FROM DEPT;

--Dla ka�dego pracownikawy�wietli� nazwisko, nr departamentu, wynagrodzenie oraz dat� zatrudnienia. Posortowa� wynik wzgl�dem numeru departamentu oraz malej�co wzgl�dem wynagrodzenia.
SELECT LAST_NAME,DEPT_ID,SALARY,START_DATE FROM EMP ORDER BY DEPT_ID,SALARY DESC;

--Wy�wietli� nazwiska pracownik�w, numery dzia��woraz datyzatrudnienia. Uporz�dkowa� wyniki rosn�co wzgl�dem daty zatrudnienia.
SELECT LAST_NAME,DEPT_ID,START_DATE FROM EMP ORDER BY START_DATE;

--Napisa� zapytanie, kt�re wy�wietlidane osobowe oraz stanowisko pracownik�w onazwisku Patel.
SELECT FIRST_NAME,LAST_NAME,TITLE FROM EMP WHERE LAST_NAME LIKE 'Patel';

--Wy�wietli� imi�, nazwisko oraz dat� zatrudnienia tych pracownik�w,kt�rzy zostali zatrudnieni pomi�dzy: 2 maja 1991 a15czerwca1991.
SELECT LAST_NAME,START_DATE FROM EMP WHERE START_DATE BETWEEN TO_DATE('02-05-1991','dd-mm-yyyy') and TO_DATE('15-06-1991','dd-mm-yyyy'); 

--Wy�wietli� identyfikatory departament�w, nazwy oraz identyfikatory dla region�w o ID r�wnym 1 lub 3 (tabela dept).
SELECT ID,NAME,REGION_ID FROM DEPT WHERE REGION_ID=3 or REGION_ID=1 ORDER BY ID;

--Wy�wietli� dane wszystkich pracownik�w, kt�rych nazwiska zaczynaj� si� na liter� M.
SELECT * FROM EMP WHERE LAST_NAME LIKE 'M%';

--Wy�wietli� wszystkie dane osobowe pracownik�w, kt�rych nazwiska nie zawieraj� litery �a�.
SELECT * FROM EMP WHERE LAST_NAME not like '%a%';

--Wy�wietli� nazwiska oraz dat� zatrudnienia pracownik�w, kt�rzy zacz�li prac� w 1991 roku.
SELECT LAST_NAME, START_DATE FROM EMP WHERE START_DATE LIKE '%91%';

--Wy�wietli� nazwiska pracownik�w, kt�rych drug� liter�nazwiska jest�a�.
SELECT LAST_NAME FROM EMP WHERE LAST_NAME LIKE '_a%';

--Wy�wietli� nazwy firm z tabeli customer, kt�rezawieraj�litery �s�i �o� oddzielone jednym znakiem.
SELECT NAME FROM CUSTOMER WHERE NAME LIKE '%s_o%';
