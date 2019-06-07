--1 Przedstawi� rozumienie polece� COMMIT,ROLLBACK, SAVEPOINT(kr�tko opisa� ich znaczenie).
COMMIT - zatwierdza wszystkie zmiany dokonane podczas transakcji,usuwa wszystkie savepointy.
ROLLBACK - cofa zmiany dokonane podczas transakcji.
SAVEPOINT - slu�y jako punkt kontrolny do kt�rego mo�emy wr�ci� przy pomocy "ROLLBACK TO SAVEPOINT 'nazwa' " 

--2 Zalogowa� si� na swoje kontoi wy��czy� AUTOCOMMIT(poleceniem SET AUTOCOMMIT OFF).
SET_AUTOCOMMIT OFF;

--3 Wstawi� do tabeli empnowego pracownika (wpisuj�cimi� i nazwisko). Wykona�polecenie COMMIT.
INSERT INTO emp (id,last_name,first_name) values (26,'Smith','John');
COMMIT;

--4 Wstawi� do tabeli emp kolejnego pracownika (jako dane poda�w�asne imi� i nazwisko, okre�li� dat� zatrudnienia oraz wynagrodzenie). 
--Sprawdzi� poleceniem SELECT,czy dane zosta�y wprowadzone, 
--nast�pnie wykona� polecenie ROLLBACKi jeszcze raz sprawdzi� tabel�emp.
INSERT INTO emp (id,last_name,first_name,start_date,salary)VALUES(27,'Derlatka','Kacper',TO_DATE('95/03/15','YY/MM/DD'),3000);
SELECT * FROM emp;
ROLLBACK;
SELECT * FROM emp;

--5 Ponownie wstawi� do tabeli emp nowego pracownika (dane podobne jak w poprzednim zadaniu). Zatwierdzi� zmiany. 
INSERT INTO emp (id,last_name,first_name,start_date,salary)VALUES(27,'Derlatka','Kacper',TO_DATE('95/03/15','YY/MM/DD'),3000);
COMMIT;

--6 Wykona� nast�puj�ce czynno�ci (tabela item):
--podnie�� cen� wszystkich produkt�w o 15% a) 
UPDATE item SET price=price*1.15;
--stworzy� pierwszy punkt kontrolny nazywaj�cgo S1 b) 
SAVEPOINT S1;
--wy�wietli� sum� cen wszystkich produkt�w c) 
SELECT SUM(price) FROM item;
--podnie��cen� o 10 % d) 
UPDATE item SET price=price*1.1;
--stworzy� drugi punkt kontrolny S2 e) 
SAVEPOINT S2;
--wy�wietli� sum� cen wszystkich produkt�w f) 
SELECT SUM(price) FROM item;
-- podnie��cen�o 60 % g)
UPDATE item SET price=price*1.6;
--wy�wietli� sum� cen wszystkich produkt�w h) 
SELECT SUM(price) FROM item;
--wycofa� zmiany do drugiego punktu kontrolnego i) 
ROLLBACK TO S2;
--wy�wietli� sum� cen wszystkich produkt�w j) 
SELECT SUM(price) FROM item;
--wycofa�zmiany do pierwszego punktu kontrolnego; k) 
ROLLBACK TO S1;
--wy�wietli�sum� cen wszystkich produkt�w l) 
SELECT SUM(price) FROM item;
-- wykona�polecenie COMMIT. m) 
COMMIT;

--7 W��czy� AUTOCOMMIT w konsoli SQL
SET AUTOCOMMIT ON;

--8 Stworzy� tabel� region_kopia(takie same kolumny jak w oryginalnej tabeli region),a nast�pnie przekopiowa� wszystkie dane z tabeli regiondo tabeli region_kopia.
CREATE TABLE region_kopia (
    id NUMBER(7),
    name VARCHAR(50)
);
INSERT INTO region_kopia (id,name)
    Select id,name FROM region;
    
--9 Wstawi�do tabeli deptkopie wszystkich istniej�cych danych z tej tabeli.Zaproponowa� spos�b,aby nie by�o konfliktu identyfikator�w(numer�w ID).
-- Jako nazw� departamentuw kopiach wstawi� pierwsze 4 litery oryginalnej nazwy departamentu. 
INSERT INTO dept (id,name,region_id)
SELECT (ID*100),SUBSTR(NAME,1,4)||NAME,REGION_ID FROM DEPT;

--10 Uzupe�ni�w tabeli region_kopiakolumn� namenazwami tych klient�w (z tabelicustomer), kt�rych maksymalne zam�wienie by�o wy�sze ni� 1000.
INSERT INTO  REGION_KOPIA (NAME)
      (select c.name from customer c,ord o where c.id=o.customer_id and o.total>1000);
--11 Podnie�� w�asn� pensj�o300%, a dat� zatrudnienia ustawi�na 31grudnia 2001 roku. 
UPDATE EMP 
SET
    salary=salary*4,
    start_date = TO_DATE('01/12/31','YY/MM/DD')
WHERE
    last_name like 'Derlatka';

--12 Zmodyfikowa�tabel� product
-- zmniejszy� ceny o 10% dla tych produkt�w, kt�rych sprzedano poni�ej 30sztuk a)
UPDATE product
SET
    suggested_whlsl_price=0.9*suggested_whlsl_price
where
    ID IN 
        (SELECT 
            P.ID
        FROM
            PRODUCT P,
            ITEM I 
        WHERE 
            P.ID=I.PRODUCT_ID AND I.QUANTITY_SHIPPED<30);
-- zwi�kszy� ceny o 8% dla pi�ciu najlepiej sprzedaj�cych si� produkt�w. b)
UPDATE product
SET
    suggested_whlsl_price=1.08*suggested_whlsl_price
where
    ID IN
        (SELECT ID FROM (SELECT 
            			ID
        		FROM
            			PRODUCT P,
            			ITEM I 
        		WHERE 
            			P.ID=I.PRODUCT_ID 
        		ORDER BY I.QUANTITY_SHIPPED desc) WHERE ROWNUM<=5
	);
    
--13 Podnie�� zarobki wszystkim vice-dyrektorom o 30%. 
UPDATE emp
SET
    salary=salary*1.3
WHERE
    title like 'VP%';

--14 Usun�� z tabeli emp wstawionych w tej sesji pracownik�w.
DELETE FROM emp 
WHERE
    id in (26);

--15 Skasowa� tabel� region_kopia
DROP TABLE region_kopia;