--1 Okreœliæ numer zamówienia o maksymalnej ³¹cznej wartoœci (tabela ord)
SELECT
        ID,
        TOTAL
FROM 
        ORD
WHERE
        TOTAL=(SELECT MAX(TOTAL) FROM ORD);
--2 Wyœwietliæ dane zamówienia o najmniejszej wartoœci, za które zap³acono gotówk¹.
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
--3 Wyœwietliæ dane zamówieñ, których kwota przekracza œredni¹ wartoœæ wszystkich zamówieñ.
SELECT 
        ID,
        DATE_ORDERED,
        DATE_SHIPPED,
        TOTAL
FROM
        ORD
WHERE
        TOTAL > (SELECT AVG(TOTAL) FROM ORD);
--4 Wyœwietliæ nazwy produktów, których sugerowana cena jest ni¿sza, ni¿ œrednia cena produktów serii Prostar
SELECT
        NAME,
        SUGGESTED_WHLSL_PRICE
FROM
        PRODUCT
WHERE
        SUGGESTED_WHLSL_PRICE< (SELECT AVG(SUGGESTED_WHLSL_PRICE) FROM PRODUCT WHERE NAME like 'Prostar%');
--5 Okreœliæ, których towarów jest najwiêcej w poszczególnych magazynach (
SELECT
        WAREHOUSE_ID,
        PRODUCT_ID,
        AMOUNT_IN_STOCK
FROM
        INVENTORY
WHERE (WAREHOUSE_ID,AMOUNT_IN_STOCK) IN
        (SELECT WAREHOUSE_ID,MAX(AMOUNT_IN_STOCK) FROM INVENTORY GROUP BY WAREHOUSE_ID);

--6 Wykonaæ powy¿sze zadanie korzystaj¹c z podzapytañ skorelowanych.
SELECT
        WAREHOUSE_ID,
        PRODUCT_ID,
        AMOUNT_IN_STOCK
FROM
        INVENTORY I1
WHERE 
        AMOUNT_IN_STOCK = (SELECT MAX(AMOUNT_IN_STOCK) FROM INVENTORY I2 WHERE I1.WAREHOUSE_ID = I2.WAREHOUSE_ID);

--7 Zmodyfikowaæ powy¿sze zapytanie tak, ¿eby w wynikach podane by³y nazwy produktów i miasta, wktórych znajduj¹ siê odpowiednie magazyny.
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
--8 Wyœwietliæ nazwy klientów (tabela customer), którzy nigdy nie z³o¿yli zamówienia.
SELECT
        NAME
FROM
        CUSTOMER C
WHERE NOT EXISTS
        (SELECT 1 FROM ORD O WHERE C.ID=O.CUSTOMER_ID);
--9 modyfikowaæ powy¿sze zapytanie (zachowuj¹c podzapytanie) w taki sposób, ¿eby wyœwietliæ klientów, którzy sk³adali zamówienia
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
--10 Sprawdziæ powy¿szy wynik za pomoc¹ pojedynczegozapytania odnosz¹cego siê tylko do tabeli ord, sortuj¹c wzglêdem numeru klienta
SELECT
        CUSTOMER_ID,
        ID
FROM
        ORD O
WHERE EXISTS
        (SELECT 1 FROM CUSTOMER C WHERE C.ID=O.CUSTOMER_ID)
ORDER BY
        CUSTOMER_ID ;
--11 Podaæ nazwiska pracowników, którzy obs³ugiwali zamówienia o numerze mniejszym od 100
SELECT DISTINCT
        LAST_NAME
FROM
        EMP E,
        ORD O
WHERE 
        E.ID=O.SALES_REP_ID AND
        O.ID IN
       (SELECT O.ID FROM ORD O WHERE  O.ID < 100);
--12 Wykonaæ powy¿sze zadanie bez podzapytania.
SELECT DISTINCT
        LAST_NAME
FROM    
        EMP E,
        ORD O
WHERE
        E.ID=O.SALES_REP_ID AND
        O.ID < 100;
--Aby uniknaæ sytuacji dwukrotnego wystapienia nazwiska nale¿y u¿yæ DISTINCT po SELECT

--13 Podaæ imiona i nazwiska pracowników, którzy obs³u¿yli co najmniej 4zamówienia
SELECT 
        FIRST_NAME,
        LAST_NAME
FROM   
        EMP E
WHERE
        E.ID IN 
        (SELECT SALES_REP_ID FROM ORD O WHERE E.ID=O.SALES_REP_ID  GROUP BY SALES_REP_ID HAVING COUNT(*)>=4);
