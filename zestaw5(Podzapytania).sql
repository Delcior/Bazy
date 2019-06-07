--1 Okreslic numer zamowienia o maksymalnej lacznej wartosci (tabela ord)
SELECT
        ID,
        TOTAL
FROM 
        ORD
WHERE
        TOTAL=(SELECT MAX(TOTAL) FROM ORD);
--2 Wyswietlic dane zamowienia o najmniejszej wartosci, za które zaplacono gotowk¹.
SELECT 
        ID,
        DATE_ORDERED,
        DATE_SHIPPED,
        TOTAL
FROM
        ORD
WHERE
        PAYMENT_TYPE='CASH' AND
        TOTAL = (SELECT MIN(TOTAL) FROM ORD);
--3 Wyœwietlic dane zamowien, ktorych kwota przekracza srednia wartosc wszystkich zamowien.
SELECT 
        ID,
        DATE_ORDERED,
        DATE_SHIPPED,
        TOTAL
FROM
        ORD
WHERE
        TOTAL > (SELECT AVG(TOTAL) FROM ORD);
--4 Wyswietlic nazwy produktow, których sugerowana cena jest nizsza, ni¿ srednia cena produktow serii Prostar
SELECT
        NAME,
        SUGGESTED_WHLSL_PRICE
FROM
        PRODUCT
WHERE
        SUGGESTED_WHLSL_PRICE< (SELECT AVG(SUGGESTED_WHLSL_PRICE) FROM PRODUCT WHERE NAME like 'Prostar%');
--5 Okreœlic, ktorych towarow jest najwiecej w poszczegolnych magazynach (
SELECT
        WAREHOUSE_ID,
        PRODUCT_ID,
        AMOUNT_IN_STOCK
FROM
        INVENTORY
WHERE (WAREHOUSE_ID,AMOUNT_IN_STOCK) IN
        (SELECT WAREHOUSE_ID,MAX(AMOUNT_IN_STOCK) FROM INVENTORY GROUP BY WAREHOUSE_ID);

--6 Wykonac powyzsze zadanie korzystajac z podzapytan skorelowanych.
SELECT
        WAREHOUSE_ID,
        PRODUCT_ID,
        AMOUNT_IN_STOCK
FROM
        INVENTORY I1
WHERE 
        AMOUNT_IN_STOCK = (SELECT MAX(AMOUNT_IN_STOCK) FROM INVENTORY I2 WHERE I1.WAREHOUSE_ID = I2.WAREHOUSE_ID);

--7 Zmodyfikowac powyzsze zapytanie tak, zeby w wynikach podane byly nazwy produktow i miasta, w ktorych znajduja siê odpowiednie magazyny.
SELECT
        W.CITY,
        P.NAME,
        I1.AMOUNT_IN_STOCK
FROM
        INVENTORY I1,
        WAREHOUSE W,
        PRODUCT P
WHERE 
        I1.WAREHOUSE_ID=W.ID AND
        I1.PRODUCT_ID = P.ID AND
        AMOUNT_IN_STOCK = (SELECT MAX(AMOUNT_IN_STOCK) FROM INVENTORY I2 WHERE I1.WAREHOUSE_ID = I2.WAREHOUSE_ID);
--8 WySwietlic nazwy klientow (tabela customer), ktorzy nigdy nie zlozyli zamowienia.
SELECT
        NAME
FROM
        CUSTOMER C
WHERE NOT EXISTS
        (SELECT 1 FROM ORD O WHERE C.ID=O.CUSTOMER_ID);
--9 modyfikowac powyzsze zapytanie (zachowujac podzapytanie) w taki sposob, zeby wyswietlic klientow, ktorzy skladali zamowienia
SELECT
        C.ID,
        C.NAME,
        O.ID
FROM
        ORD O,
        CUSTOMER C
WHERE EXISTS
        (SELECT 1 FROM ORD O WHERE C.ID=O.CUSTOMER_ID) AND
        O.CUSTOMER_ID=C.ID;
--10 Sprawdzic powyzszy wynik za pomoc¹ pojedynczego zapytania odnoszacego sie tylko do tabeli ord, sortujac wzgledem numeru klienta
SELECT
        CUSTOMER_ID,
        ID
FROM
        ORD O
WHERE EXISTS
        (SELECT 1 FROM CUSTOMER C WHERE C.ID=O.CUSTOMER_ID)
ORDER BY
        CUSTOMER_ID ;
--11 Podac nazwiska pracownikow, ktorzy obslugiwali zamowienia o numerze mniejszym od 100
SELECT DISTINCT
        LAST_NAME
FROM
        EMP E,
        ORD O
WHERE 
        E.ID=O.SALES_REP_ID AND
        O.ID IN
       (SELECT O.ID FROM ORD O WHERE  O.ID < 100);
--12 Wykonaæ powyzsze zadanie bez podzapytania.
SELECT DISTINCT
        LAST_NAME
FROM    
        EMP E,
        ORD O
WHERE
        E.ID=O.SALES_REP_ID AND
        O.ID < 100;
--Aby uniknac sytuacji dwukrotnego wystapienia nazwiska nalezy uzyc DISTINCT po SELECT

--13 Podac imiona i nazwiska pracownikow, ktorzy obsluzyli co najmniej 4 zamowienia
SELECT 
        FIRST_NAME,
        LAST_NAME
FROM   
        EMP E
WHERE
        E.ID IN 
        (SELECT SALES_REP_ID FROM ORD O WHERE E.ID=O.SALES_REP_ID  GROUP BY SALES_REP_ID HAVING COUNT(*)>=4);
