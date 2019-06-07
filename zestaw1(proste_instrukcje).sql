--Z tabeli dept wyœwietlic wszystkie kolumny oraz wszystkie rekordy.
SELECT * FROM DEPT;

--Wyœwietlic wszystkie identyfikatory departamentow, nazwiska pracowników oraz identyfikatory managerów z tabeli emp. 
SELECT dept_id "ID",last_name "Nazwisko",manager_id FROM EMP;

--Wyœwietliæ roczne dochody wszystkich pracowników (wraz z nazwiskami tych pracowników). 
SELECT SALARY*12 "Roczne wynagrodzenie",last_name "Nazwisko" FROM EMP;

--Wyœwietlic dane osobowe pracowników, zarobki miesiêczne, zarobki roczne doliczaj¹c premiê roczn¹ w wysokoœci 1000. 
SELECT FIRST_NAME "Imiê",LAST_NAME "Nazwisko",SALARY "Zarobki miesiêczne", SALARY*12+1000 "Roczne z premi¹" FROM EMP

--Wyœwietlic dane osobowe pracownikow, zarobki miesieczne, zarobki roczne – doliczajac premie co miesiac w wysokosci 8%.
SELECT FIRST_NAME ,LAST_NAME ,SAlARY,SALARY*1.08*12 "Roczne z premia" from EMP;

--Wyœwietlic nazwisko oraz roczny dochod wraz z dodatkiem 5% miesiêcznych zarobków–tak¹ kolumnê nazwaæ ROCZNY DOCHOD.
SELECT LAST_NAME,SALARY*12+SALARY*0.05 "ROCZNY DOCHÓD" FROM EMP;

--Wyœwietlic skonkatenowane imie inazwisko dla poszczegolnych pracownikow (w jednej kolumnie np. MidoriNagayama). Kolumne nazwac Imie i Nazwisko.
SELECT CONCAT(FIRST_NAME,LAST_NAME) as "Imiê i Nazwisko" FROM EMP;

--Wyœwietlic pelne dane osobowe opracownikach oraz ich stanowiskach.
SELECT FIRST_NAME || ' ' || LAST_NAME || ' - ' || TITLE as "Super Pracownicy" FROM EMP;

--Wyœwietlic nazwisko pracownika, pensje, stanowisko i jego nagrode.
SELECT LAST_NAME,SALARY,TITLE,SALARY*(COMMISSION_PCT/100) PROWIZJA from EMP;

--Zmodyfikowac poprzednie zapytanie tak, aby zamiast (null)pojawi³o sie 0.
SELECT LAST_NAME,SALARY,TITLE,NVL(SALARY*(COMMISSION_PCT/100),0) PROWIZJA from EMP;

--Wyœwietlic nazwy dzialow z tabeli dept. Zmodyfikowac zapytanie tak, by nie pojawialy siê wielokrotnie te same nazwy.
SELECT DISTINCT NAME FROM DEPT;

--Dla ka¿dego pracownika wyswietlic nazwisko, nr departamentu, wynagrodzenie oraz datê zatrudnienia. Posortowac wynik wzglêdem numeru departamentu oraz malejaco wzgledem wynagrodzenia.
SELECT LAST_NAME,DEPT_ID,SALARY,START_DATE FROM EMP ORDER BY DEPT_ID,SALARY DESC;

--Wyswietlic nazwiska pracowników, numery dzialow oraz daty zatrudnienia. Uporzadkowac wyniki rosnaco wzgledem daty zatrudnienia.
SELECT LAST_NAME,DEPT_ID,START_DATE FROM EMP ORDER BY START_DATE;

--Napisac zapytanie, ktore wyswietli dane osobowe oraz stanowisko pracowników o nazwisku Patel.
SELECT FIRST_NAME,LAST_NAME,TITLE FROM EMP WHERE LAST_NAME LIKE 'Patel';

--Wyswietlic imie, nazwisko oraz date zatrudnienia tych pracownikow,ktorzy zostali zatrudnieni pomiêdzy: 2 maja 1991 a 15 czerwca 1991.
SELECT LAST_NAME,START_DATE FROM EMP WHERE START_DATE BETWEEN TO_DATE('02-05-1991','dd-mm-yyyy') and TO_DATE('15-06-1991','dd-mm-yyyy'); 

--Wyswietlic identyfikatory departamentow, nazwy oraz identyfikatory dla regionow o ID rownym 1 lub 3 (tabela dept).
SELECT ID,NAME,REGION_ID FROM DEPT WHERE REGION_ID=3 or REGION_ID=1 ORDER BY ID;

--Wyswietlic dane wszystkich pracownikow, których nazwiska zaczynaja siê na litere M.
SELECT * FROM EMP WHERE LAST_NAME LIKE 'M%';

--Wyœwietlic wszystkie dane osobowe pracownikow, których nazwiska nie zawieraja litery „a”.
SELECT * FROM EMP WHERE LAST_NAME not like '%a%';

--Wyœwietlic nazwiska oraz date zatrudnienia pracowników, ktorzy zaczeli prace w 1991 roku.
SELECT LAST_NAME, START_DATE FROM EMP WHERE START_DATE LIKE '%91%';

--Wyœwietlic nazwiska pracownikow, których druga litera nazwiska jest „a”.
SELECT LAST_NAME FROM EMP WHERE LAST_NAME LIKE '_a%';

--Wyœwietlic nazwy firm z tabeli customer, które zawieraja litery „s”i „o” oddzielone jednym znakiem.
SELECT NAME FROM CUSTOMER WHERE NAME LIKE '%s_o%';
