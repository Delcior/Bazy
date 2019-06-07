--1 Wyœwietlic imiê i nazwisko (tylko malymi literami), identyfikator uzytkownika (pierwsza litera wielka, pozosta³e male) oraz stanowisko (wielkie litery) dla wszystkich zastepcow prezesa
SELECT 
        LOWER(FIRST_NAME),
	LOWER(LAST_NAME),
	INITCAP(USERID),
	UPPER(TITLE)
FROM 
        EMP
WHERE
        TITLE LIKE 'VP%';
        
--2 Wyswietlic imie i nazwisko wszystkich pracownikow,ktorzy nosza nazwisko Patel.
SELECT 
        FIRST_NAME,LAST_NAME
FROM 
        EMP
WHERE
        UPPER(LAST_NAME) LIKE 'PATEL';
        
--3 Wyswietlic nazwê oraz panstwo dla wszystkich klientów (tabela customer), którzy maja zdolnosc kredytowa (credit_rating) na poziomie dobrym(GOOD). Skonkatenowac ze soba nazwe oraz panstwo.
SELECT 
        NAME || ' - ' || COUNTRY  
FROM 
        CUSTOMER
WHERE
        CREDIT_RATING LIKE 'GOOD';
--4 Wyswietlic nazwe i jej dlugosc dla wszystkich produktow, ktorych pierwsze trzy litery nazwy s¹ równe ‘Ace’ 
SELECT 
        NAME,LENGTH(NAME)
FROM 
        PRODUCT
WHERE
        NAME LIKE 'Ace%';
--5 Wyswietlic wartosc 41.5843 zaokr¹glona do setnych czesci ulamkowych, do wartosci calkowitych oraz do calych dziesiatek.
SELECT 
        ROUND(41.5843,2),
	ROUND(41.5843),
	ROUND(41.5843,-1)
FROM 
        DUAL;
--6 Wyswietlic wartoœæ 41.5843 obcieta do czesci setnych, wartosci calkowitych oraz do calych dziesiatek. 
SELECT 
        TRUNC(41.5843,2),
	TRUNC(41.5843),
	TRUNC(41.5843,-1)
FROM 
        DUAL;
--7 Obliczyæ reszte z dzielenia pensji przez prowizje (commission_pct) dla wszystkich pracownikow, ktorych pobory sa wieksze niz 1380. Podac nazwiska tych pracownikow
SELECT 
        LAST_NAME,MOD(SALARY,(COMMISSION_PCT))
FROM 
        EMP
WHERE 
        SALARY > 1380 AND MOD(SALARY,(COMMISSION_PCT)) IS NOT NULL;
--8 Wyswietlic aktualna date
SELECT TO_DATE(SYSDATE, 'DD-MM-YYYY') "AKTUALNA DATA"
     FROM DUAL;
--9 Dla pracowników z departamentu 43 wyœwietliæ nazwisko oraz liczbê tygodni zatrudnienia w firmie
SELECT 
        LAST_NAME,
        TRUNC(MONTHS_BETWEEN(TO_DATE(SYSDATE,'DD-MM-YYYY'),TO_DATE(START_DATE,'DD-MM-YYYY'))*4.345)
FROM 
        EMP
WHERE
        DEPT_ID = 43;
--10 Dla pracowników zatrudnionych mniej ni¿ 332 miesi¹ce wyœwietliæ identyfikator pracownika, liczbê pe³nych miesiêcy pracy oraz datê zakoñczenia 3-miesiêcznego okresu próbnego
SELECT 
        ID,
        TRUNC(MONTHS_BETWEEN(TO_DATE(SYSDATE,'DD-MM-YYYY'),
        TO_DATE(START_DATE,'DD-MM-YYYY'))),ADD_MONTHS(TO_DATE(START_DATE,'DD-MM-YYYY'),3)
FROM 
        EMP 
WHERE
        TRUNC(MONTHS_BETWEEN(TO_DATE(SYSDATE,'DD-MM-YYYY'),TO_DATE(START_DATE,'DD-MM-YYYY'))) < 332;

--11 Na potrzeby inwentaryzacji dostaw wyœwietliæ chronologicznie numery zamawianych ponownie produktów, dzieñ dostawy, pierwszy po nim pi¹tek oraz ostatni dzieñ miesi¹ca,w którym dostawa zosta³a przyjêta 
SELECT
        PRODUCT_ID,
        RESTOCK_DATE,NEXT_DAY(RESTOCK_DATE,'friday'),
        LAST_DAY(TO_DATE(RESTOCK_DATE,'DD-MM-YYYY'))
FROM
        INVENTORY
WHERE
        RESTOCK_DATE IS NOT NULL
ORDER BY
        RESTOCK_DATE;
--12 Zestawiæ daty zatrudnienia dla pracowników, którzy zostali przyjêci do pracyw 1991 roku.Pokazaænumer pracownika, datê rozpoczêcia pracy oraz tylko miesi¹c rozpoczêcia pracy.
SELECT 
        ID,
        START_DATE,
        EXTRACT(MONTH FROM START_DATE)
FROM
        EMP
WHERE
        TO_CHAR(START_DATE,'DD-MM-YYYY') LIKE '%91';
--13 Z tabeli ord wyœwietliænumer (id) orazdatê (date_ordered) wszystkichzamówieñ z³o¿onych przez przedstawiciela (sales_rep_id)o numerze 11.Datê przeformatowaæ tak,¿eby by³a wyœwietlana w postaci analogicznej do „08/92”.
SELECT 
        ID,
        TO_CHAR(DATE_ORDERED,'MM/RR')
FROM
    ORD
WHERE
    SALES_REP_ID =11;

--14 Wyœwietliæ nazwiska i daty zatrudnienia pracowników,którzy pracuj¹ od 1991 roku. Data powinna byæ wyœwietlana w nastêpuj¹cy sposób:17 Czerwiec 1991 roku
SELECT
        LAST_NAME,
        TO_CHAR(TO_DATE(START_DATE,'DD-MM-YYYY'),'DD MON YYYY ')||'roku'
FROM
        EMP
WHERE
        TO_CHAR(TO_DATE(START_DATE,'DD-MM-YYYY'),'YYYY') >1990;
