--1 Wyœwietliæ ka¿d¹ dostêpna zdolnoœæ kredytow¹ oraz liczbêklientów przypisanych do konkretnej zdolnoœci kredytowej(tabela customer)
SELECT 
        credit_rating,
        count(*) 
FROM
        CUSTOMER
GROUP BY
        credit_rating;
--2 Wyœwietliæ stanowiska (pomin¹wszyvice dyrektorów)oraz ³¹cznezarobkimiesiêcznedla ka¿dego znich. Posortowaæwyniki wed³ug wartoœci rosn¹cych
SELECT
        TITLE,
        SUM(SALARY)
FROM
        EMP
GROUP BY
        TITLE
HAVING 
        TITLE  NOT LIKE 'VP%'
ORDER BY 
        2;
--3 Wyœwietliæ maksymalne zarobki dla ka¿dej grupy stanowisk.
SELECT
        TITLE,
        MAX(SALARY)
FROM
        EMP
GROUP BY
        TITLE;
--4 Wyœwietliæ nazwy departamentów, w którychœrednie wynagrodzenie jest wiêksze ni¿ 1499(z³¹czyæ tabele dept i emp).
SELECT 
        NAME,
        AVG(SALARY)
FROM
        DEPT D,EMP E
WHERE
        D.ID=E.DEPT_ID
GROUP BY
        NAME
HAVING 
        AVG(SALARY)>1499;
--5 Wyœwietliæ szczegó³y zamówieñ zap³aconych gotówk¹(CASH), z³o¿onych wewrzeœniu 1992 roku. Pokazaæ równie¿ dane klienta sk³adaj¹cego zamówienie, nazwê zamawianego produktu, cenê sprzeda¿y orazliczbêsprzedanych produktów ka¿dego rodzaju. 
--Posortowaæ wed³ug numeruzamówienia oraz nazwy produktu.
SELECT
        O.ID,
        C.NAME,
        P.NAME,
        O.PAYMENT_TYPE,
        O.DATE_ORDERED,
        I.PRICE,
        I.QUANTITY
FROM
        ORD O,CUSTOMER C,PRODUCT P,ITEM I
WHERE
        C.ID=O.CUSTOMER_ID AND 
        O.ID=I.ORD_ID AND
        I.PRODUCT_ID=P.ID AND
        PAYMENT_TYPE = 'CASH' AND
        TO_CHAR(TO_DATE(DATE_ORDERED,'YY/MM/DD')) LIKE '92/09%';
--6 Zmodyfikowaæ powy¿sze zapytanie tak,aby dla ka¿dego zamówienia otrzymaæ sumê zamówien
SELECT
        O.ID,
        C.NAME,
        O.PAYMENT_TYPE,
        O.DATE_ORDERED,
        SUM(I.QUANTITY*I.PRICE)
FROM
        ORD O,CUSTOMER C,ITEM I
WHERE
        C.ID=O.CUSTOMER_ID AND 
        O.ID=I.ORD_ID 
GROUP BY
        O.ID,
        C.NAME,
        O.PAYMENT_TYPE,
        O.DATE_ORDERED
HAVING 
        PAYMENT_TYPE = 'CASH' AND
        TO_CHAR(TO_DATE(DATE_ORDERED,'YY/MM/DD')) LIKE '92/09%';
--7 Wyœwietliæpowtarzaj¹ce siê nazwiska pracowników
SELECT
        LAST_NAME
FROM
        EMP
GROUP BY
        LAST_NAME
HAVING 
        COUNT(*) >1;
--8 Wyœwietliæ hierarchie stanowisk w firmie, wypisuj¹cdane pracowników: imiê, nazwisko, stanowisko, identyfikator menad¿era oraz „poziom”, na którym znajdujesiê dane stanowisko.
-- Posortowaæ wed³ug "poziomu"
SELECT 
        FIRST_NAME,
        LAST_NAME,
        TITLE,
        NVL(TO_CHAR(MANAGER_ID),' '),
        LEVEL 
FROM 
        EMP E
CONNECT BY PRIOR
        E.ID = E.MANAGER_ID
START WITH
        E.TITLE = 'President'
ORDER BY
        LEVEL;
--9 Zmodyfikowaæ powy¿sze zapytanie tak, aby wyœwietliæ tylko osoby podleg³estanowisku VP, Operations.
SELECT 
        FIRST_NAME,
        LAST_NAME,
        TITLE,
        MANAGER_ID,
        LEVEL 
FROM 
        EMP E
CONNECT BY PRIOR
        E.ID = E.MANAGER_ID
START WITH
        E.TITLE = 'VP, Operations'
ORDER BY
        LEVEL;    
--10 Z tabeli departamentów wybraæidentyfikator regionu oraz nazwê departamentu,zsumowaæwynik zidentyfikatorem regionu oraz nazw¹ regionu z tabeli regionów.
--Posortowaæwed³ug nazw.
SELECT 
        REGION_ID,
        NAME
FROM DEPT
UNION
SELECT 
        ID,
        NAME
FROM 
        REGION
ORDER BY 
        2;
--11 Zmodyfikowaæ powy¿sze zapytanie,wyœwietlaj¹ctylko nazwy z obutabel.
SELECT 
        NAME
FROM 
        DEPT
UNION
SELECT 
        NAME
FROM 
        REGION
ORDER BY 
        1;
--12 Wyœwietliæ wartoœci powtarzaj¹ce siê.
SELECT 
        NAME
FROM 
        DEPT
UNION ALL
SELECT 
        NAME
FROM 
        REGION;
--13 Wyœwietliæ identyfikator departamentu oraz nazwisko pracownika, zsumowaæwynik z identyfikatorem regionu oraz nazw¹ regionu. 
--Posortowaæ wed³ug nazwiska /nazwy regionu.
SELECT 
        D.ID,
        E.LAST_NAME
FROM 
        DEPT D,EMP E
WHERE
        E.DEPT_ID = D.ID
UNION
SELECT 
        ID,
        NAME
FROM 
        REGION
ORDER BY 
        2;
--14 Wyœwietliæz tabeli customer identyfikatory klientów, którzy z³o¿yli choæ jedno zamówienie widoczne wtabeli ord
SELECT 
        ID
FROM
        CUSTOMER
INTERSECT
SELECT
        CUSTOMER_ID
FROM 
        ORD;
--15 Wyœwietliæ identyfikatory klientów, którzy nie z³o¿yli ¿adnego zamówienia.
SELECT 
        ID
FROM
        CUSTOMER
MINUS
SELECT
        CUSTOMER_ID
FROM 
        ORD;
        
        
        
        
        
        
        
        
        
        
        