--1 Wy�wietli� ka�d� dost�pna zdolno�� kredytow� oraz liczb�klient�w przypisanych do konkretnej zdolno�ci kredytowej(tabela customer)
SELECT 
        credit_rating,
        count(*) 
FROM
        CUSTOMER
GROUP BY
        credit_rating;
--2 Wy�wietli� stanowiska (pomin�wszyvice dyrektor�w)oraz ��cznezarobkimiesi�cznedla ka�dego znich. Posortowa�wyniki wed�ug warto�ci rosn�cych
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
--3 Wy�wietli� maksymalne zarobki dla ka�dej grupy stanowisk.
SELECT
        TITLE,
        MAX(SALARY)
FROM
        EMP
GROUP BY
        TITLE;
--4 Wy�wietli� nazwy departament�w, w kt�rych�rednie wynagrodzenie jest wi�ksze ni� 1499(z��czy� tabele dept i emp).
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
--5 Wy�wietli� szczeg�y zam�wie� zap�aconych got�wk�(CASH), z�o�onych wewrze�niu 1992 roku. Pokaza� r�wnie� dane klienta sk�adaj�cego zam�wienie, nazw� zamawianego produktu, cen� sprzeda�y orazliczb�sprzedanych produkt�w ka�dego rodzaju. 
--Posortowa� wed�ug numeruzam�wienia oraz nazwy produktu.
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
--6 Zmodyfikowa� powy�sze zapytanie tak,aby dla ka�dego zam�wienia otrzyma� sum� zam�wien
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
--7 Wy�wietli�powtarzaj�ce si� nazwiska pracownik�w
SELECT
        LAST_NAME
FROM
        EMP
GROUP BY
        LAST_NAME
HAVING 
        COUNT(*) >1;
--8 Wy�wietli� hierarchie stanowisk w firmie, wypisuj�cdane pracownik�w: imi�, nazwisko, stanowisko, identyfikator menad�era oraz �poziom�, na kt�rym znajdujesi� dane stanowisko.
-- Posortowa� wed�ug "poziomu"
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
--9 Zmodyfikowa� powy�sze zapytanie tak, aby wy�wietli� tylko osoby podleg�estanowisku VP, Operations.
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
--10 Z tabeli departament�w wybra�identyfikator regionu oraz nazw� departamentu,zsumowa�wynik zidentyfikatorem regionu oraz nazw� regionu z tabeli region�w.
--Posortowa�wed�ug nazw.
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
--11 Zmodyfikowa� powy�sze zapytanie,wy�wietlaj�ctylko nazwy z obutabel.
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
--12 Wy�wietli� warto�ci powtarzaj�ce si�.
SELECT 
        NAME
FROM 
        DEPT
UNION ALL
SELECT 
        NAME
FROM 
        REGION;
--13 Wy�wietli� identyfikator departamentu oraz nazwisko pracownika, zsumowa�wynik z identyfikatorem regionu oraz nazw� regionu. 
--Posortowa� wed�ug nazwiska /nazwy regionu.
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
--14 Wy�wietli�z tabeli customer identyfikatory klient�w, kt�rzy z�o�yli cho� jedno zam�wienie widoczne wtabeli ord
SELECT 
        ID
FROM
        CUSTOMER
INTERSECT
SELECT
        CUSTOMER_ID
FROM 
        ORD;
--15 Wy�wietli� identyfikatory klient�w, kt�rzy nie z�o�yli �adnego zam�wienia.
SELECT 
        ID
FROM
        CUSTOMER
MINUS
SELECT
        CUSTOMER_ID
FROM 
        ORD;
        
        
        
        
        
        
        
        
        
        
        