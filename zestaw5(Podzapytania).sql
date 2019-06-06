--1 Okre�li� numer zam�wienia o maksymalnej ��cznej warto�ci (tabela ord)
SELECT
        ID,
        TOTAL
FROM 
        ORD
WHERE
        TOTAL=(SELECT MAX(TOTAL) FROM ORD);
--2 Wy�wietli� dane zam�wienia o najmniejszej warto�ci, za kt�re zap�acono got�wk�.
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
--3 Wy�wietli� dane zam�wie�, kt�rych kwota przekracza �redni� warto�� wszystkich zam�wie�.
SELECT 
        ID,
        DATE_ORDERED,
        DATE_SHIPPED,
        TOTAL
FROM
        ORD
WHERE
        TOTAL > (SELECT AVG(TOTAL) FROM ORD);
--4 Wy�wietli� nazwy produkt�w, kt�rych sugerowana cena jest ni�sza, ni� �rednia cena produkt�w serii Prostar
SELECT
        NAME,
        SUGGESTED_WHLSL_PRICE
FROM
        PRODUCT
WHERE
        SUGGESTED_WHLSL_PRICE< (SELECT AVG(SUGGESTED_WHLSL_PRICE) FROM PRODUCT WHERE NAME like 'Prostar%');
--5 Okre�li�, kt�rych towar�w jest najwi�cej w poszczeg�lnych magazynach (
SELECT
        WAREHOUSE_ID,
        PRODUCT_ID,
        AMOUNT_IN_STOCK
FROM
        INVENTORY
WHERE (WAREHOUSE_ID,AMOUNT_IN_STOCK) IN
        (SELECT WAREHOUSE_ID,MAX(AMOUNT_IN_STOCK) FROM INVENTORY GROUP BY WAREHOUSE_ID);

--6 Wykona� powy�sze zadanie korzystaj�c z podzapyta� skorelowanych.
SELECT
        WAREHOUSE_ID,
        PRODUCT_ID,
        AMOUNT_IN_STOCK
FROM
        INVENTORY I1
WHERE 
        AMOUNT_IN_STOCK = (SELECT MAX(AMOUNT_IN_STOCK) FROM INVENTORY I2 WHERE I1.WAREHOUSE_ID = I2.WAREHOUSE_ID);

--7 Zmodyfikowa� powy�sze zapytanie tak, �eby w wynikach podane by�y nazwy produkt�w i miasta, wkt�rych znajduj� si� odpowiednie magazyny.
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
--8 Wy�wietli� nazwy klient�w (tabela customer), kt�rzy nigdy nie z�o�yli zam�wienia.
SELECT
        NAME
FROM
        CUSTOMER C
WHERE NOT EXISTS
        (SELECT 1 FROM ORD O WHERE C.ID=O.CUSTOMER_ID);
--9 modyfikowa� powy�sze zapytanie (zachowuj�c podzapytanie) w taki spos�b, �eby wy�wietli� klient�w, kt�rzy sk�adali zam�wienia
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
--10 Sprawdzi� powy�szy wynik za pomoc� pojedynczegozapytania odnosz�cego si� tylko do tabeli ord, sortuj�c wzgl�dem numeru klienta
SELECT
        CUSTOMER_ID,
        ID
FROM
        ORD O
WHERE EXISTS
        (SELECT 1 FROM CUSTOMER C WHERE C.ID=O.CUSTOMER_ID)
ORDER BY
        CUSTOMER_ID ;
--11 Poda� nazwiska pracownik�w, kt�rzy obs�ugiwali zam�wienia o numerze mniejszym od 100
SELECT DISTINCT
        LAST_NAME
FROM
        EMP E,
        ORD O
WHERE 
        E.ID=O.SALES_REP_ID AND
        O.ID IN
       (SELECT O.ID FROM ORD O WHERE  O.ID < 100);
--12 Wykona� powy�sze zadanie bez podzapytania.
SELECT DISTINCT
        LAST_NAME
FROM    
        EMP E,
        ORD O
WHERE
        E.ID=O.SALES_REP_ID AND
        O.ID < 100;
--Aby unikna� sytuacji dwukrotnego wystapienia nazwiska nale�y u�y� DISTINCT po SELECT

--13 Poda� imiona i nazwiska pracownik�w, kt�rzy obs�u�yli co najmniej 4zam�wienia
SELECT 
        FIRST_NAME,
        LAST_NAME
FROM   
        EMP E
WHERE
        E.ID IN 
        (SELECT SALES_REP_ID FROM ORD O WHERE E.ID=O.SALES_REP_ID  GROUP BY SALES_REP_ID HAVING COUNT(*)>=4);
