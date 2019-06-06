--1 Wyœwietliæ listê pracowników, którzy zarabiaj¹ poni¿ej wartoœci 1300, posortowan¹ alfabetycznie wzglêdem nazwisk.
SELECT 
    FIRST_NAME,
    LAST_NAME,
    SALARY
FROM
    EMP
WHERE
    SALARY <1300
ORDER BY
    LAST_NAME;
--wyszukujê rekordy za pomoc¹ warunku 'salary <1300' i grupujê wzglêdem nazwiska
-- za pomoc¹ 'ORDER BY'

--2 Jak wyœwietliæ w jednej kolumnie (w osobnych wierszach) daty wszystkich zamówieñ i ich ³¹czne wartoœci?
SELECT 
    DATE_ORDERED||' '||TOTAL 
FROM
    ORD;
--u¿ywam operatora konkatenacji '||' by po³¹czyæ dwie kolumny w jedn¹

--3 Podaæimiona i nazwiska pracowników na stanowisku Stock Clerk, którzy zarabiaj¹ wiêcej, ni¿ œrednia zarobków na stanowisku Warehouse Manager
SELECT
    FIRST_NAME,
    LAST_NAME
FROM
    EMP
WHERE
    TITLE='Stock Clerk' AND
    SALARY > (SELECT AVG(SALARY) FROM EMP WHERE TITLE = 'Warehouse Manager');
--korzystam z podzapytania by przyrównaæ zarobki 'Stock Clerk' do œredniej zarobków
-- 'Warehouse Manager'

--4 Okreœliæ, ilu pracowników ma zarobki poni¿ej œredniej poborów wszystkich pracowników
SELECT 
    COUNT(*)
FROM 
    EMP
WHERE 
    SALARY < (SELECT AVG(SALARY) FROM EMP);
--u¿ywam podzapytania by przyrównaæ zarobki do œrednich zarobków i zliczam funkcj¹ COUNT

--5 Podaæ listê pracowników o sta¿u pracy ponad 28lat(wg stanu na dzieñ 1 marca 2019), sortuj¹c wzglêdem daty zatrudnienia
SELECT 
    FIRST_NAME,
    LAST_NAME
FROM
    EMP
WHERE
    MONTHS_BETWEEN(TO_DATE('19/03/01','RR/MM/DD'),TO_DATE(START_DATE,'RR/MM/DD'))/12 >28;
--liczê ró¿nicê miesiêcy miêdzy datami i mno¿ê *12 by sprawdziæ ile lat dany pracownik pracuje

--6 Wyœwietliæ numery przedstawicieli handlowych i sumy kwot wszystkich zamówieñ przez nich realizowanych.
SELECT
    E1.ID, SUM(O1.TOTAL)
FROM
    EMP E1,
    ORD O1
WHERE
    E1.ID=O1.SALES_REP_ID AND
    E1.TITLE = 'Sales Representative' 
GROUP BY 
    E1.ID;
--u¿ywam SUM by zsumowaæ kwoty i GROP BY by pogrupowaæ

--7 Podaæ numer identyfikacyjny przedstawiciela handlowego, któryobs³u¿y³ zamówienia o maksymalnej ³¹cznej wartoœci.
--Wypisaæ równie¿³¹czn¹ kwotê tych zamówieñ
SELECT 
    *
FROM
    (SELECT
        E1.ID, SUM(O1.TOTAL)
    FROM
        EMP E1,
        ORD O1
    WHERE
        E1.ID=O1.SALES_REP_ID AND
        E1.TITLE = 'Sales Representative'
    GROUP BY 
        E1.ID
    ORDER BY
        SUM(o1.total) DESC)
WHERE
    ROWNUM = 1;
--wykorzystujê zapytanie z zad.6 jako podzapytanie by wyœwietlic pierwszy rekord

--8 Okreœliænazwisko przedstawiciela handlowegoz poprzedniego zadania.
SELECT
    LAST_NAME
FROM
    EMP
WHERE
    ID =(SELECT 
            ID
        FROM
            (SELECT
                E1.ID, SUM(o1.total)
            FROM
                EMP E1,
                ORD O1
            WHERE
                E1.ID=O1.SALES_REP_ID AND
                E1.TITLE = 'Sales Representative'
            GROUP BY 
                E1.ID
            ORDER BY
                SUM(O1.TOTAL) DESC)
WHERE
    ROWNUM = 1);
--wybieram  id z zadania 7 i uzywam go jako warunku by wyœwietliæ nazwisko przedstawiciela handlowego
 
--9 Wypisaæ chronologicznie daty przyjêæ do pracy oraz liczbê osób zatrudnianychw danym dniu.
SELECT
    START_DATE, COUNT(*)
FROM
    EMP
GROUP BY
    START_DATE
ORDER BY 
    START_DATE;
--u¿ywam COUNT() by zliczyæ zgrupowane daty

--10 Sprawdziæ, których towarów brakuje na stanie inwentarza w którymkolwiek z magazynów oraz wyœwietliæ nazwy tylko tych, 
--które maj¹ komentarzuzasadniaj¹cy ich brak 
--(zabezpieczyæ siê przed przypadkiem, gdy nie bêdzie komentarza –wtedy nie nale¿y wyœwietlaæ nazwy produktu)
SELECT
    P.Name
FROM
    PRODUCT P,
    INVENTORY I 
WHERE
    P.ID = I.PRODUCT_ID
    AND I.AMOUNT_IN_STOCK LIKE 0
    AND I.OUT_OF_STOCK_EXPLANATION IS NOT NULL;
--sprawdzam których przedmiotów nie ma i wyœwietlam te które maja opis

--11 Okreœliæ nazwy produktów, których ³¹czna liczba na stanie we wszystkich magazynach jest mniejsza ni¿ 500. 
SELECT
    P.NAME, SUM(I.AMOUNT_IN_STOCK)
FROM
    INVENTORY I,
    PRODUCT P
WHERE 
    I.PRODUCT_ID = P.ID
GROUP BY
    P.NAME
HAVING 
    SUM(I.AMOUNT_IN_STOCK)<500;
--wyœwietlam nazwy produktów których iloœæ w magazynach  jest ich mniejsza ni¿ 500  

--12 Wyœwietliæ tylko 3-wyrazowe nazwy towarów
SELECT
    PRODUCT.NAME
FROM
    PRODUCT
WHERE
    ( LENGTH(PRODUCT.NAME) - LENGTH(REPLACE(PRODUCT.NAME, ' ', '')) + 1 ) = 3;
--sprawdzam które nazwy sa dluzsze o 3 po usunieciu spacji i je wyswietlam