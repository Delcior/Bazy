--1 Po³¹czyæ ze sob¹ 2 tabele–pracowników i departamentów,wyœwietlaj¹c nastêpuj¹ce informacje: dane osobowe pracownika, numer departamentu oraz jego nazwê.
SELECT 
            E.LAST_NAME,
            E.FIRST_NAME,
            D.ID,
            D.NAME
FROM 
            DEPT D,EMP E
WHERE 
            E.DEPT_ID=D.ID;
--2 Wyœwietliæ numer departamentu, numer regionu oraz nazwê regionu dla wszystkich departamentów.
SELECT 
            D.ID,
            D.REGION_ID,
            R.NAME
FROM 
            DEPT D,REGION R
WHERE 
            D.REGION_ID=R.ID;
--3 Wyœwietliæ dane pracownika o nazwisku Menchu, numer oraz nazwê jego departamentu
SELECT 
            E.LAST_NAME,
            E.FIRST_NAME,
            D.ID,
            D.NAME
FROM 
            DEPT D,EMP E
WHERE 
            E.DEPT_ID=D.ID AND 
            E.LAST_NAME LIKE 'Menchu';
--4 Wyœwietliæ nazwisko, nazwê regionu oraz prowizjêdla pracowników,którzy otrzymuj¹ premiê.
SELECT
            E.LAST_NAME,
            R.NAME,
            E.COMMISSION_PCT
FROM
            EMP E,REGION R,DEPT D
WHERE
            E.DEPT_ID=D.ID AND D.REGION_ID=R.ID AND 
            E.COMMISSION_PCT IS NOT NULL;
--5 Wyœwietliæ dane przedstawicieli handlowych, identyfikator pracownika (tabela emp) oraz nazwy klientów (wszystkich). Wyœwietliæ te¿ nazwytych klientów, którzy nie maj¹ przypisanego przedstawiciela handlowego.
SELECT
            NVL(TO_CHAR(E.LAST_NAME),'-'),
            NVL(TO_CHAR(E.ID),'-'),
            C.NAME
FROM
            EMP E,CUSTOMER C
WHERE 
            E.ID(+)=C.SALES_REP_ID;
--6 Wyœwietliæ nazwiska pracowników oraz odpowiedniego dla danego pracownika kierownika(tak¿e nazwisko, tabela emp).
SELECT
            E1.LAST_NAME||' pracuje dla '||E2.LAST_NAME
FROM
            EMP E1,EMP E2
WHERE
            E1.MANAGER_ID=E2.ID;
--7 Wyœwietliæ nazwê klienta sk³adaj¹cego zamówienie, nazwisko pracownika „opiekuj¹cego” siê danym zamówieniem, datê zamówienia, wielkoœæ zamówienia oraz nazwê produktu –dla wszystkich zamówieñ onumerze 101.
SELECT 
            C.NAME,
            E.LAST_NAME,
            O.DATE_ORDERED,
            I.QUANTITY,
            P.NAME
FROM 
            ORD O,EMP E,CUSTOMER C,ITEM I,PRODUCT P
WHERE           
            O.CUSTOMER_ID = C.ID AND 
            O.ID = I.ORD_ID AND 
            P.ID = I.PRODUCT_ID AND 
            E.ID = O.SALES_REP_ID AND
            O.ID = 101;
--8 Wyœwietliæ identyfikator klienta, jego nazwê oraz identyfikator zamówienia dla wszystkich klientów i ich zamówieñ. Wyœwietliætak¿e tych klientów, którzy nie z³o¿yli ¿adnego zamówienia
SELECT
            C.ID,
            C.NAME,
            NVL(TO_CHAR(O.ID),'-')
FROM 
            CUSTOMER C,ORD O
WHERE
            C.ID=O.CUSTOMER_ID(+);
--9 Wyœwietliæ minimalne, maksymalne oraz œrednie zarobki;podaætak¿e sumê wszystkich zarobków oraz liczbê pracowników.
SELECT
            MAX(SALARY),
            MIN(SALARY),
            AVG(SALARY),
            SUM(SALARY),
            COUNT(*)
FROM
            EMP;
--10 Wyœwietliæ nazwiska tych pracowników, którzy wed³ug listy alfabetycznej s¹ na pierwszym i ostatnim miejscu. 
SELECT
            MIN(LAST_NAME),
            MAX(LAST_NAME)
FROM
            EMP;
--11 Wyœwietliæ liczbê pracowników z dzia³u 31, którzy pobieraj¹ premiê
SELECT
            COUNT(*)
FROM 
            EMP
WHERE 
            COMMISSION_PCT IS NOT NULL AND
            DEPT_ID = 31;
