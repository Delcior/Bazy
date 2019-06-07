--1 Po��czy� ze sob� 2 tabele�pracownik�w i departament�w,wy�wietlaj�c nast�puj�ce informacje: dane osobowe pracownika, numer departamentu oraz jego nazw�.
SELECT 
            E.LAST_NAME,
            E.FIRST_NAME,
            D.ID,
            D.NAME
FROM 
            DEPT D,EMP E
WHERE 
            E.DEPT_ID=D.ID;
--2 Wy�wietli� numer departamentu, numer regionu oraz nazw� regionu dla wszystkich departament�w.
SELECT 
            D.ID,
            D.REGION_ID,
            R.NAME
FROM 
            DEPT D,REGION R
WHERE 
            D.REGION_ID=R.ID;
--3 Wy�wietli� dane pracownika o nazwisku Menchu, numer oraz nazw� jego departamentu
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
--4 Wy�wietli� nazwisko, nazw� regionu oraz prowizj�dla pracownik�w,kt�rzy otrzymuj� premi�.
SELECT
            E.LAST_NAME,
            R.NAME,
            E.COMMISSION_PCT
FROM
            EMP E,REGION R,DEPT D
WHERE
            E.DEPT_ID=D.ID AND D.REGION_ID=R.ID AND 
            E.COMMISSION_PCT IS NOT NULL;
--5 Wy�wietli� dane przedstawicieli handlowych, identyfikator pracownika (tabela emp) oraz nazwy klient�w (wszystkich). Wy�wietli� te� nazwytych klient�w, kt�rzy nie maj� przypisanego przedstawiciela handlowego.
SELECT
            NVL(TO_CHAR(E.LAST_NAME),'-'),
            NVL(TO_CHAR(E.ID),'-'),
            C.NAME
FROM
            EMP E,CUSTOMER C
WHERE 
            E.ID(+)=C.SALES_REP_ID;
--6 Wy�wietli� nazwiska pracownik�w oraz odpowiedniego dla danego pracownika kierownika(tak�e nazwisko, tabela emp).
SELECT
            E1.LAST_NAME||' pracuje dla '||E2.LAST_NAME
FROM
            EMP E1,EMP E2
WHERE
            E1.MANAGER_ID=E2.ID;
--7 Wy�wietli� nazw� klienta sk�adaj�cego zam�wienie, nazwisko pracownika �opiekuj�cego� si� danym zam�wieniem, dat� zam�wienia, wielko�� zam�wienia oraz nazw� produktu �dla wszystkich zam�wie� onumerze 101.
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
--8 Wy�wietli� identyfikator klienta, jego nazw� oraz identyfikator zam�wienia dla wszystkich klient�w i ich zam�wie�. Wy�wietli�tak�e tych klient�w, kt�rzy nie z�o�yli �adnego zam�wienia
SELECT
            C.ID,
            C.NAME,
            NVL(TO_CHAR(O.ID),'-')
FROM 
            CUSTOMER C,ORD O
WHERE
            C.ID=O.CUSTOMER_ID(+);
--9 Wy�wietli� minimalne, maksymalne oraz �rednie zarobki;poda�tak�e sum� wszystkich zarobk�w oraz liczb� pracownik�w.
SELECT
            MAX(SALARY),
            MIN(SALARY),
            AVG(SALARY),
            SUM(SALARY),
            COUNT(*)
FROM
            EMP;
--10 Wy�wietli� nazwiska tych pracownik�w, kt�rzy wed�ug listy alfabetycznej s� na pierwszym i ostatnim miejscu. 
SELECT
            MIN(LAST_NAME),
            MAX(LAST_NAME)
FROM
            EMP;
--11 Wy�wietli� liczb� pracownik�w z dzia�u 31, kt�rzy pobieraj� premi�
SELECT
            COUNT(*)
FROM 
            EMP
WHERE 
            COMMISSION_PCT IS NOT NULL AND
            DEPT_ID = 31;
