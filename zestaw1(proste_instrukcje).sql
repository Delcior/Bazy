--Z tabeli dept wyœwietliæ wszystkie kolumny oraz wszystkie rekordy.
SELECT * FROM DEPT;

--Wyœwietliæ wszystkie identyfikatory departamentów, nazwiska pracowników oraz identyfikatory managerów ztabeli emp. 
SELECT dept_id "ID",last_name "Nazwisko",manager_id FROM EMP;

--Wyœwietliæ roczne dochody wszystkich pracowników (wraz z nazwiskami tych pracowników). 
SELECT SALARY*12 "Roczne wynagrodzenie",last_name "Nazwisko" FROM EMP;

--Wyœwietliæ dane osobowe pracowników, zarobki miesiêczne, zarobki roczne doliczaj¹c premiê roczn¹ w wysokoœci 1000. 
SELECT FIRST_NAME "Imiê",LAST_NAME "Nazwisko",SALARY "Zarobki miesiêczne", SALARY*12+1000 "Roczne z premi¹" FROM EMP

--Wyœwietliæ dane osobowe pracowników, zarobki miesiêczne, zarobki roczne –doliczaj¹c premiê co miesi¹cwwysokoœci 8%.
SELECT FIRST_NAME ,LAST_NAME ,SAlARY,SALARY*1.08*12 "Roczne z premia" from EMP;

--Wyœwietliænazwisko orazroczny dochódwraz z dodatkiem 5% miesiêcznych zarobków–tak¹ kolumnê nazwaæ ROCZNY DOCHÓD(alias).
SELECT LAST_NAME,SALARY*12+SALARY*0.05 "ROCZNY DOCHÓD" FROM EMP;

--Wyœwietliæ skonkatenowane imiê inazwisko dla poszczególnych pracowników (w jednej kolumnie np. MidoriNagayama). Kolumnê nazwaæ Imiê i Nazwisko.
SELECT CONCAT(FIRST_NAME,LAST_NAME) as "Imiê i Nazwisko" FROM EMP;

--Wyœwietliæ pe³ne dane osobowe opracownikach oraz ich stanowiskach (w jednej kolumnie,znag³ówkiem Super Pracownicy).
SELECT FIRST_NAME || ' ' || LAST_NAME || ' - ' || TITLE as "Super Pracownicy" FROM EMP;

--Wyœwietliæ nazwisko pracownika, pensjê, stanowisko i jego nagrodê 
SELECT LAST_NAME,SALARY,TITLE,SALARY*(COMMISSION_PCT/100) PROWIZJA from EMP;

--Zmodyfikowaæ poprzednie zapytanie tak, aby zamiast (null)pojawi³osiê 0.
SELECT LAST_NAME,SALARY,TITLE,NVL(SALARY*(COMMISSION_PCT/100),0) PROWIZJA from EMP;

--Wyœwietliæ nazwy dzia³ów z tabeli dept. Zmodyfikowaæ zapytanie tak, by nie pojawia³y siê wielokrotnie te same nazwy.
SELECT DISTINCT NAME FROM DEPT;

--Dla ka¿dego pracownikawyœwietliæ nazwisko, nr departamentu, wynagrodzenie oraz datê zatrudnienia. Posortowaæ wynik wzglêdem numeru departamentu oraz malej¹co wzglêdem wynagrodzenia.
SELECT LAST_NAME,DEPT_ID,SALARY,START_DATE FROM EMP ORDER BY DEPT_ID,SALARY DESC;

--Wyœwietliæ nazwiska pracowników, numery dzia³óworaz datyzatrudnienia. Uporz¹dkowaæ wyniki rosn¹co wzglêdem daty zatrudnienia.
SELECT LAST_NAME,DEPT_ID,START_DATE FROM EMP ORDER BY START_DATE;

--Napisaæ zapytanie, które wyœwietlidane osobowe oraz stanowisko pracowników onazwisku Patel.
SELECT FIRST_NAME,LAST_NAME,TITLE FROM EMP WHERE LAST_NAME LIKE 'Patel';

--Wyœwietliæ imiê, nazwisko oraz datê zatrudnienia tych pracowników,którzy zostali zatrudnieni pomiêdzy: 2 maja 1991 a15czerwca1991.
SELECT LAST_NAME,START_DATE FROM EMP WHERE START_DATE BETWEEN TO_DATE('02-05-1991','dd-mm-yyyy') and TO_DATE('15-06-1991','dd-mm-yyyy'); 

--Wyœwietliæ identyfikatory departamentów, nazwy oraz identyfikatory dla regionów o ID równym 1 lub 3 (tabela dept).
SELECT ID,NAME,REGION_ID FROM DEPT WHERE REGION_ID=3 or REGION_ID=1 ORDER BY ID;

--Wyœwietliæ dane wszystkich pracowników, których nazwiska zaczynaj¹ siê na literê M.
SELECT * FROM EMP WHERE LAST_NAME LIKE 'M%';

--Wyœwietliæ wszystkie dane osobowe pracowników, których nazwiska nie zawieraj¹ litery „a”.
SELECT * FROM EMP WHERE LAST_NAME not like '%a%';

--Wyœwietliæ nazwiska oraz datê zatrudnienia pracowników, którzy zaczêli pracê w 1991 roku.
SELECT LAST_NAME, START_DATE FROM EMP WHERE START_DATE LIKE '%91%';

--Wyœwietliæ nazwiska pracowników, których drug¹ liter¹nazwiska jest„a”.
SELECT LAST_NAME FROM EMP WHERE LAST_NAME LIKE '_a%';

--Wyœwietliæ nazwy firm z tabeli customer, którezawieraj¹litery „s”i „o” oddzielone jednym znakiem.
SELECT NAME FROM CUSTOMER WHERE NAME LIKE '%s_o%';
