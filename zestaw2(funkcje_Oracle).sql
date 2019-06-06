--1 Wyœwietliæ imiê i nazwisko (tylko ma³ymiliterami), identyfikatoru¿ytkownika (pierwsza litera wielka, pozosta³e ma³e) oraz stanowisko (wielkie litery) dla wszystkich zastêpców prezesa
SELECT 
        LOWER(FIRST_NAME),
	LOWER(LAST_NAME),
	INITCAP(USERID),
	UPPER(TITLE)
FROM 
        EMP
WHERE
        TITLE LIKE 'VP%';
        
--2 Wyœwietliæ imiê i nazwisko wszystkich pracowników,którzy nosz¹ nazwisko Patel.
SELECT 
        FIRST_NAME,LAST_NAME
FROM 
        EMP
WHERE
        UPPER(LAST_NAME) LIKE 'PATEL';
        
--3 Wyœwietliæ nazwê oraz pañstwo dla wszystkich klientów (tabela customer), którzy maj¹ zdolnoœæ kredytow¹ (credit_rating) na poziomie dobrym(GOOD). Skonkatenowaæze sob¹ nazwê oraz pañstwo.
SELECT 
        NAME || ' - ' || COUNTRY  
FROM 
        CUSTOMER
WHERE
        CREDIT_RATING LIKE 'GOOD';
--4 Wyœwietliæ nazwê i jej d³ugoœæ dla wszystkich produktów, których pierwsze trzy litery nazwy s¹ równe ‘Ace’ 
SELECT 
        NAME,LENGTH(NAME)
FROM 
        PRODUCT
WHERE
        NAME LIKE 'Ace%';
--5 Wyœwietliæ wartoœæ 41.5843 zaokr¹glon¹ do setnych czêœci u³amkowych, do wartoœci ca³kowitych oraz do ca³ych dziesi¹tek.
SELECT 
        ROUND(41.5843,2),
	ROUND(41.5843),
	ROUND(41.5843,-1)
FROM 
        DUAL;
--6 Wyœwietliæ wartoœæ 41.5843 obciêt¹ do czêœcisetnych, wartoœci ca³kowitych orazdo ca³ych dziesi¹tek. 
SELECT 
        TRUNC(41.5843,2),
	TRUNC(41.5843),
	TRUNC(41.5843,-1)
FROM 
        DUAL;
--7 Obliczyæ resztê z dzielenia pensji przez prowizjê (commission_pct) dlawszystkich pracowników, których poborys¹ wiêkszeni¿ 1380. Podaæ nazwiska tych pracowników
SELECT 
        LAST_NAME,MOD(SALARY,(COMMISSION_PCT))
FROM 
        EMP
WHERE 
        SALARY > 1380 AND MOD(SALARY,(COMMISSION_PCT)) IS NOT NULL;
--8 Wyœwietliæ aktualn¹datê
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
