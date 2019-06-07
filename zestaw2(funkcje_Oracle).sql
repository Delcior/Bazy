--1 Wy�wietlic imi� i nazwisko (tylko malymi literami), identyfikator uzytkownika (pierwsza litera wielka, pozosta�e male) oraz stanowisko (wielkie litery) dla wszystkich zastepcow prezesa
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
        
--3 Wyswietlic nazw� oraz panstwo dla wszystkich klient�w (tabela customer), kt�rzy maja zdolnosc kredytowa (credit_rating) na poziomie dobrym(GOOD). Skonkatenowac ze soba nazwe oraz panstwo.
SELECT 
        NAME || ' - ' || COUNTRY  
FROM 
        CUSTOMER
WHERE
        CREDIT_RATING LIKE 'GOOD';
--4 Wyswietlic nazwe i jej dlugosc dla wszystkich produktow, ktorych pierwsze trzy litery nazwy s� r�wne �Ace� 
SELECT 
        NAME,LENGTH(NAME)
FROM 
        PRODUCT
WHERE
        NAME LIKE 'Ace%';
--5 Wyswietlic wartosc 41.5843 zaokr�glona do setnych czesci ulamkowych, do wartosci calkowitych oraz do calych dziesiatek.
SELECT 
        ROUND(41.5843,2),
	ROUND(41.5843),
	ROUND(41.5843,-1)
FROM 
        DUAL;
--6 Wyswietlic warto�� 41.5843 obcieta do czesci setnych, wartosci calkowitych oraz do calych dziesiatek. 
SELECT 
        TRUNC(41.5843,2),
	TRUNC(41.5843),
	TRUNC(41.5843,-1)
FROM 
        DUAL;
--7 Obliczy� reszte z dzielenia pensji przez prowizje (commission_pct) dla wszystkich pracownikow, ktorych pobory sa wieksze niz 1380. Podac nazwiska tych pracownikow
SELECT 
        LAST_NAME,MOD(SALARY,(COMMISSION_PCT))
FROM 
        EMP
WHERE 
        SALARY > 1380 AND MOD(SALARY,(COMMISSION_PCT)) IS NOT NULL;
--8 Wyswietlic aktualna date
SELECT TO_DATE(SYSDATE, 'DD-MM-YYYY') "AKTUALNA DATA"
     FROM DUAL;
--9 Dla pracownik�w z departamentu 43 wy�wietli� nazwisko oraz liczb� tygodni zatrudnienia w firmie
SELECT 
        LAST_NAME,
        TRUNC(MONTHS_BETWEEN(TO_DATE(SYSDATE,'DD-MM-YYYY'),TO_DATE(START_DATE,'DD-MM-YYYY'))*4.345)
FROM 
        EMP
WHERE
        DEPT_ID = 43;
--10 Dla pracownik�w zatrudnionych mniej ni� 332 miesi�ce wy�wietli� identyfikator pracownika, liczb� pe�nych miesi�cy pracy oraz dat� zako�czenia 3-miesi�cznego okresu pr�bnego
SELECT 
        ID,
        TRUNC(MONTHS_BETWEEN(TO_DATE(SYSDATE,'DD-MM-YYYY'),
        TO_DATE(START_DATE,'DD-MM-YYYY'))),ADD_MONTHS(TO_DATE(START_DATE,'DD-MM-YYYY'),3)
FROM 
        EMP 
WHERE
        TRUNC(MONTHS_BETWEEN(TO_DATE(SYSDATE,'DD-MM-YYYY'),TO_DATE(START_DATE,'DD-MM-YYYY'))) < 332;

--11 Na potrzeby inwentaryzacji dostaw wy�wietli� chronologicznie numery zamawianych ponownie produkt�w, dzie� dostawy, pierwszy po nim pi�tek oraz ostatni dzie� miesi�ca,w kt�rym dostawa zosta�a przyj�ta 
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
--12 Zestawi� daty zatrudnienia dla pracownik�w, kt�rzy zostali przyj�ci do pracyw 1991 roku.Pokaza�numer pracownika, dat� rozpocz�cia pracy oraz tylko miesi�c rozpocz�cia pracy.
SELECT 
        ID,
        START_DATE,
        EXTRACT(MONTH FROM START_DATE)
FROM
        EMP
WHERE
        TO_CHAR(START_DATE,'DD-MM-YYYY') LIKE '%91';
--13 Z tabeli ord wy�wietli�numer (id) orazdat� (date_ordered) wszystkichzam�wie� z�o�onych przez przedstawiciela (sales_rep_id)o numerze 11.Dat� przeformatowa� tak,�eby by�a wy�wietlana w postaci analogicznej do �08/92�.
SELECT 
        ID,
        TO_CHAR(DATE_ORDERED,'MM/RR')
FROM
    ORD
WHERE
    SALES_REP_ID =11;

--14 Wy�wietli� nazwiska i daty zatrudnienia pracownik�w,kt�rzy pracuj� od 1991 roku. Data powinna by� wy�wietlana w nast�puj�cy spos�b:17 Czerwiec 1991 roku
SELECT
        LAST_NAME,
        TO_CHAR(TO_DATE(START_DATE,'DD-MM-YYYY'),'DD MON YYYY ')||'roku'
FROM
        EMP
WHERE
        TO_CHAR(TO_DATE(START_DATE,'DD-MM-YYYY'),'YYYY') >1990;
