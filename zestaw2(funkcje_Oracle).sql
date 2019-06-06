--1 Wy�wietli� imi� i nazwisko (tylko ma�ymiliterami), identyfikatoru�ytkownika (pierwsza litera wielka, pozosta�e ma�e) oraz stanowisko (wielkie litery) dla wszystkich zast�pc�w prezesa
SELECT 
        LOWER(FIRST_NAME),
	LOWER(LAST_NAME),
	INITCAP(USERID),
	UPPER(TITLE)
FROM 
        EMP
WHERE
        TITLE LIKE 'VP%';
        
--2 Wy�wietli� imi� i nazwisko wszystkich pracownik�w,kt�rzy nosz� nazwisko Patel.
SELECT 
        FIRST_NAME,LAST_NAME
FROM 
        EMP
WHERE
        UPPER(LAST_NAME) LIKE 'PATEL';
        
--3 Wy�wietli� nazw� oraz pa�stwo dla wszystkich klient�w (tabela customer), kt�rzy maj� zdolno�� kredytow� (credit_rating) na poziomie dobrym(GOOD). Skonkatenowa�ze sob� nazw� oraz pa�stwo.
SELECT 
        NAME || ' - ' || COUNTRY  
FROM 
        CUSTOMER
WHERE
        CREDIT_RATING LIKE 'GOOD';
--4 Wy�wietli� nazw� i jej d�ugo�� dla wszystkich produkt�w, kt�rych pierwsze trzy litery nazwy s� r�wne �Ace� 
SELECT 
        NAME,LENGTH(NAME)
FROM 
        PRODUCT
WHERE
        NAME LIKE 'Ace%';
--5 Wy�wietli� warto�� 41.5843 zaokr�glon� do setnych cz�ci u�amkowych, do warto�ci ca�kowitych oraz do ca�ych dziesi�tek.
SELECT 
        ROUND(41.5843,2),
	ROUND(41.5843),
	ROUND(41.5843,-1)
FROM 
        DUAL;
--6 Wy�wietli� warto�� 41.5843 obci�t� do cz�cisetnych, warto�ci ca�kowitych orazdo ca�ych dziesi�tek. 
SELECT 
        TRUNC(41.5843,2),
	TRUNC(41.5843),
	TRUNC(41.5843,-1)
FROM 
        DUAL;
--7 Obliczy� reszt� z dzielenia pensji przez prowizj� (commission_pct) dlawszystkich pracownik�w, kt�rych poborys� wi�kszeni� 1380. Poda� nazwiska tych pracownik�w
SELECT 
        LAST_NAME,MOD(SALARY,(COMMISSION_PCT))
FROM 
        EMP
WHERE 
        SALARY > 1380 AND MOD(SALARY,(COMMISSION_PCT)) IS NOT NULL;
--8 Wy�wietli� aktualn�dat�
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
