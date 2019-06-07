--1 Przedstawiæ rozumienie poleceñ COMMIT,ROLLBACK, SAVEPOINT(krótko opisaæ ich znaczenie).
COMMIT - zatwierdza wszystkie zmiany dokonane podczas transakcji,usuwa wszystkie savepointy.
ROLLBACK - cofa zmiany dokonane podczas transakcji.
SAVEPOINT - slu¿y jako punkt kontrolny do którego mo¿emy wróciæ przy pomocy "ROLLBACK TO SAVEPOINT 'nazwa' " 

--2 Zalogowaæ siê na swoje kontoi wy³¹czyæ AUTOCOMMIT(poleceniem SET AUTOCOMMIT OFF).
SET_AUTOCOMMIT OFF;

--3 Wstawiæ do tabeli empnowego pracownika (wpisuj¹cimiê i nazwisko). Wykonaæpolecenie COMMIT.
INSERT INTO emp (id,last_name,first_name) values (26,'Smith','John');
COMMIT;

--4 Wstawiæ do tabeli emp kolejnego pracownika (jako dane podaæw³asne imiê i nazwisko, okreœliæ datê zatrudnienia oraz wynagrodzenie). 
--Sprawdziæ poleceniem SELECT,czy dane zosta³y wprowadzone, 
--nastêpnie wykonaæ polecenie ROLLBACKi jeszcze raz sprawdziæ tabelêemp.
INSERT INTO emp (id,last_name,first_name,start_date,salary)VALUES(27,'Derlatka','Kacper',TO_DATE('95/03/15','YY/MM/DD'),3000);
SELECT * FROM emp;
ROLLBACK;
SELECT * FROM emp;

--5 Ponownie wstawiæ do tabeli emp nowego pracownika (dane podobne jak w poprzednim zadaniu). Zatwierdziæ zmiany. 
INSERT INTO emp (id,last_name,first_name,start_date,salary)VALUES(27,'Derlatka','Kacper',TO_DATE('95/03/15','YY/MM/DD'),3000);
COMMIT;

--6 Wykonaæ nastêpuj¹ce czynnoœci (tabela item):
--podnieœæ cenê wszystkich produktów o 15% a) 
UPDATE item SET price=price*1.15;
--stworzyæ pierwszy punkt kontrolny nazywaj¹cgo S1 b) 
SAVEPOINT S1;
--wyœwietliæ sumê cen wszystkich produktów c) 
SELECT SUM(price) FROM item;
--podnieœæcenê o 10 % d) 
UPDATE item SET price=price*1.1;
--stworzyæ drugi punkt kontrolny S2 e) 
SAVEPOINT S2;
--wyœwietliæ sumê cen wszystkich produktów f) 
SELECT SUM(price) FROM item;
-- podnieœæcenêo 60 % g)
UPDATE item SET price=price*1.6;
--wyœwietliæ sumê cen wszystkich produktów h) 
SELECT SUM(price) FROM item;
--wycofaæ zmiany do drugiego punktu kontrolnego i) 
ROLLBACK TO S2;
--wyœwietliæ sumê cen wszystkich produktów j) 
SELECT SUM(price) FROM item;
--wycofaæzmiany do pierwszego punktu kontrolnego; k) 
ROLLBACK TO S1;
--wyœwietliæsumê cen wszystkich produktów l) 
SELECT SUM(price) FROM item;
-- wykonaæpolecenie COMMIT. m) 
COMMIT;

--7 W³¹czyæ AUTOCOMMIT w konsoli SQL
SET AUTOCOMMIT ON;

--8 Stworzyæ tabelê region_kopia(takie same kolumny jak w oryginalnej tabeli region),a nastêpnie przekopiowaæ wszystkie dane z tabeli regiondo tabeli region_kopia.
CREATE TABLE region_kopia (
    id NUMBER(7),
    name VARCHAR(50)
);
INSERT INTO region_kopia (id,name)
    Select id,name FROM region;
    
--9 Wstawiædo tabeli deptkopie wszystkich istniej¹cych danych z tej tabeli.Zaproponowaæ sposób,aby nie by³o konfliktu identyfikatorów(numerów ID).
-- Jako nazwê departamentuw kopiach wstawiæ pierwsze 4 litery oryginalnej nazwy departamentu. 
INSERT INTO dept (id,name,region_id)
SELECT (ID*100),SUBSTR(NAME,1,4)||NAME,REGION_ID FROM DEPT;

--10 Uzupe³niæw tabeli region_kopiakolumnê namenazwami tych klientów (z tabelicustomer), których maksymalne zamówienie by³o wy¿sze ni¿ 1000.
INSERT INTO  REGION_KOPIA (NAME)
      (select c.name from customer c,ord o where c.id=o.customer_id and o.total>1000);
--11 Podnieœæ w³asn¹ pensjêo300%, a datê zatrudnienia ustawiæna 31grudnia 2001 roku. 
UPDATE EMP 
SET
    salary=salary*4,
    start_date = TO_DATE('01/12/31','YY/MM/DD')
WHERE
    last_name like 'Derlatka';

--12 Zmodyfikowaætabelê product
-- zmniejszyæ ceny o 10% dla tych produktów, których sprzedano poni¿ej 30sztuk a)
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
-- zwiêkszyæ ceny o 8% dla piêciu najlepiej sprzedaj¹cych siê produktów. b)
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
    
--13 Podnieœæ zarobki wszystkim vice-dyrektorom o 30%. 
UPDATE emp
SET
    salary=salary*1.3
WHERE
    title like 'VP%';

--14 Usun¹æ z tabeli emp wstawionych w tej sesji pracowników.
DELETE FROM emp 
WHERE
    id in (26);

--15 Skasowaæ tabelê region_kopia
DROP TABLE region_kopia;