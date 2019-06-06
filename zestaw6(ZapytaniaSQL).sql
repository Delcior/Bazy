--1 Wy�wietli� list� pracownik�w, kt�rzy zarabiaj� poni�ej warto�ci 1300, posortowan� alfabetycznie wzgl�dem nazwisk.
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
--wyszukuj� rekordy za pomoc� warunku 'salary <1300' i grupuj� wzgl�dem nazwiska
-- za pomoc� 'ORDER BY'

--2 Jak wy�wietli� w jednej kolumnie (w osobnych wierszach) daty wszystkich zam�wie� i ich ��czne warto�ci?
SELECT 
    DATE_ORDERED||' '||TOTAL 
FROM
    ORD;
--u�ywam operatora konkatenacji '||' by po��czy� dwie kolumny w jedn�

--3 Poda�imiona i nazwiska pracownik�w na stanowisku Stock Clerk, kt�rzy zarabiaj� wi�cej, ni� �rednia zarobk�w na stanowisku Warehouse Manager
SELECT
    FIRST_NAME,
    LAST_NAME
FROM
    EMP
WHERE
    TITLE='Stock Clerk' AND
    SALARY > (SELECT AVG(SALARY) FROM EMP WHERE TITLE = 'Warehouse Manager');
--korzystam z podzapytania by przyr�wna� zarobki 'Stock Clerk' do �redniej zarobk�w
-- 'Warehouse Manager'

--4 Okre�li�, ilu pracownik�w ma zarobki poni�ej �redniej pobor�w wszystkich pracownik�w
SELECT 
    COUNT(*)
FROM 
    EMP
WHERE 
    SALARY < (SELECT AVG(SALARY) FROM EMP);
--u�ywam podzapytania by przyr�wna� zarobki do �rednich zarobk�w i zliczam funkcj� COUNT

--5 Poda� list� pracownik�w o sta�u pracy ponad 28lat(wg stanu na dzie� 1 marca 2019), sortuj�c wzgl�dem daty zatrudnienia
SELECT 
    FIRST_NAME,
    LAST_NAME
FROM
    EMP
WHERE
    MONTHS_BETWEEN(TO_DATE('19/03/01','RR/MM/DD'),TO_DATE(START_DATE,'RR/MM/DD'))/12 >28;
--licz� r�nic� miesi�cy mi�dzy datami i mno�� *12 by sprawdzi� ile lat dany pracownik pracuje

--6 Wy�wietli� numery przedstawicieli handlowych i sumy kwot wszystkich zam�wie� przez nich realizowanych.
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
--u�ywam SUM by zsumowa� kwoty i GROP BY by pogrupowa�

--7 Poda� numer identyfikacyjny przedstawiciela handlowego, kt�ryobs�u�y� zam�wienia o maksymalnej ��cznej warto�ci.
--Wypisa� r�wnie���czn� kwot� tych zam�wie�
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
--wykorzystuj� zapytanie z zad.6 jako podzapytanie by wy�wietlic pierwszy rekord

--8 Okre�li�nazwisko przedstawiciela handlowegoz poprzedniego zadania.
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
--wybieram  id z zadania 7 i uzywam go jako warunku by wy�wietli� nazwisko przedstawiciela handlowego
 
--9 Wypisa� chronologicznie daty przyj�� do pracy oraz liczb� os�b zatrudnianychw danym dniu.
SELECT
    START_DATE, COUNT(*)
FROM
    EMP
GROUP BY
    START_DATE
ORDER BY 
    START_DATE;
--u�ywam COUNT() by zliczy� zgrupowane daty

--10 Sprawdzi�, kt�rych towar�w brakuje na stanie inwentarza w kt�rymkolwiek z magazyn�w oraz wy�wietli� nazwy tylko tych, 
--kt�re maj� komentarzuzasadniaj�cy ich brak 
--(zabezpieczy� si� przed przypadkiem, gdy nie b�dzie komentarza �wtedy nie nale�y wy�wietla� nazwy produktu)
SELECT
    P.Name
FROM
    PRODUCT P,
    INVENTORY I 
WHERE
    P.ID = I.PRODUCT_ID
    AND I.AMOUNT_IN_STOCK LIKE 0
    AND I.OUT_OF_STOCK_EXPLANATION IS NOT NULL;
--sprawdzam kt�rych przedmiot�w nie ma i wy�wietlam te kt�re maja opis

--11 Okre�li� nazwy produkt�w, kt�rych ��czna liczba na stanie we wszystkich magazynach jest mniejsza ni� 500. 
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
--wy�wietlam nazwy produkt�w kt�rych ilo�� w magazynach  jest ich mniejsza ni� 500  

--12 Wy�wietli� tylko 3-wyrazowe nazwy towar�w
SELECT
    PRODUCT.NAME
FROM
    PRODUCT
WHERE
    ( LENGTH(PRODUCT.NAME) - LENGTH(REPLACE(PRODUCT.NAME, ' ', '')) + 1 ) = 3;
--sprawdzam kt�re nazwy sa dluzsze o 3 po usunieciu spacji i je wyswietlam