--1 Usunac wszystkie tabele znajduj¹ce siê na koncie serwera Oracle (napisac w³asny skrypt).
DROP TABLE item cascade constraints;
DROP TABLE inventory cascade constraints;
DROP TABLE product cascade constraints;
DROP TABLE longtext cascade constraints;
DROP TABLE image cascade constraints;
DROP TABLE warehouse cascade constraints; 
DROP TABLE ord cascade constraints;
DROP TABLE customer cascade constraints;
DROP TABLE emp cascade constraints;
DROP TABLE title cascade constraints;
DROP TABLE dept cascade constraints;
DROP TABLE region cascade constraints;
DROP TABLE klient cascade constraints;
DROP TABLE pozycja cascade constraints;
DROP TABLE produkt cascade constraints;
DROP TABLE zamowienia cascade constraints;
DROP TABLE region_kopia cascade constraints;

DROP TABLE CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE ACCOUNTS CASCADE CONSTRAINTS;
DROP TABLE EMP CASCADE CONSTRAINTS;
DROP TABLE TRANSACTIONS CASCADE CONSTRAINTS;
--2 Utworzyc tabele za pomoca skryptu wygenerowanego w rozwiazaniu zestawu 9.
CREATE TABLE accounts (     
  balance          NUMBER(14, 2) NOT NULL,     
  debt             INTEGER,    
  account_number   NUMBER(26) NOT NULL,     
  customer_pin     NUMBER(11) NOT NULL 
); 
ALTER TABLE accounts ADD CONSTRAINT accounts_pk PRIMARY KEY ( account_number ); 
ALTER TABLE accounts ADD CONSTRAINT accounts_customer_fk FOREIGN KEY ( customer_pin )REFERENCES customer ( pin );

CREATE TABLE customer (     
  first_name   VARCHAR2(25 CHAR) NOT NULL,    
  last_name    VARCHAR2(25 CHAR) NOT NULL,    
  pin          NUMBER(11) NOT NULL, 
  login        VARCHAR2(25 CHAR) NOT NULL,   
  password     VARCHAR2(32 CHAR) NOT NULL,   
  address      VARCHAR2(50 CHAR) NOT NULL 
); 
ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( pin ); 
ALTER TABLE customer ADD CONSTRAINT proper_length CHECK (LENGTH(PIN)=11);
 
CREATE TABLE emp (     
  id           NUMBER(7) NOT NULL,    
  first_name   VARCHAR2(25 CHAR) NOT NULL,     
  last_name    VARCHAR2(25 CHAR) NOT NULL,   
  title        VARCHAR2(20 CHAR),    
  salary       NUMBER(8, 2) NOT NULL,  
  address      VARCHAR2(50 CHAR),    
  start_date   DATE NOT NULL 
); 
ALTER TABLE emp ADD CONSTRAINT emp_pk PRIMARY KEY ( id ); 

CREATE TABLE transactions (   
  id                        NUMBER(7) NOT NULL, 
  "DATE"                    DATE,  
  value                     NUMBER(14, 2),   
  src_account_number        NUMBER(26) NOT NULL,  
  dst_account_number        NUMBER(26) NOT NULL,
  emp_id                    NUMBER(7) 
--emp_id przyjmuje wartosc gdy transakcja byla przeprowadzana przez danego pracownika w banku, gdy transakcja byla wykonywana online jest wartoœæ NULL
 ); 
 
ALTER TABLE transactions ADD CONSTRAINT transactions_pk PRIMARY KEY ( id );  
ALTER TABLE transactions ADD CONSTRAINT transactions_accounts_fk FOREIGN KEY ( accounts_account_number ) REFERENCES accounts ( account_number ); 
ALTER TABLE transactions ADD CONSTRAINT emp_id_fk FOREIGN KEY ( emp_id)REFERENCES emp( id );

--3 Wylistowac nazwy wszystkich tabel.
SELECT TABLE_NAME FROM USER_TABLES;

--4 Pokazac, jakie kolumny znajduja sie w poszczegolnych tabelach, a takze ich parametry 
SELECT 
    table_name,
    data_type,
    data_length,
    data_precision,
    nullable
FROM
    user_tab_columns;
    
--5 Wyswietlic, jakie ograniczenia sa narzucone na poszczegolne kolumny kazdej tabeli w projekcie
SELECT 
    constraint_name,
    constraint_type,
    search_condition
FROM 
    user_constraints
WHERE
    table_name in (select table_name from user_tables);
    
--6 Dodaæ kolejna tabele do projektu i wprowadzic w niej klucz obcy do kolumny jednej z istniejacych tabel.
-- Zademonstrowac 3 sposoby tworzenia takiego ograniczenia
CREATE TABLE cards (
    card_number          NUMBER(16, 0) PRIMARY KEY,
    valid_thru               DATE NOT NULL,
    ccv                         NUMBER(3,0) NOT NULL,
    --kolumnowe
    account_number    VARCHAR(26) NOT NULL
        CONSTRAINT acc_num_fk
        REFERENCES accounts(account_number)
    --tablicowe
--    CONSTRAINT acc_num_fk
--    FOREIGN KEY (account_number)
--    REFERENCES accounts(account_number)
);
-- alter table
ALTER TABLE cards
ADD CONSTRAINT acc_num_fk
FOREIGN KEY (account_number)
REFERENCES accounts(account_number);

--7 W wybranej tabeli zdefiniowaæ „wewnetrzne” ograniczenie klucza obcego 
alter table emp 
add constraint manager_id_fk
foreign key (manager_id)
references emp(id);

--8 We wszystkich tabelach wprowadzic przykladowe dane.Utworzyc odpowiedni skrypt laduj¹cy „sensowne” dane, tzn. przykladowe imiona, nazwiska, nazwy, daty itp. 

--wartosci do tabeli EMP
INSERT INTO emp VALUES (
    1,'Jan','Raczynski','President',120000,TO_DATE('01-04-2015','dd-mm-yyyy'),NULL);
INSERT INTO emp VALUES (
    2,'Tomasz','Gruczynski','VP',95000,TO_DATE('01-04-2015','dd-mm-yyyy'),1);
INSERT INTO emp VALUES (
    3,'Marcin','Gulasz','Bank Clerk',10000,TO_DATE('11-04-2015','dd-mm-yyyy'),2);
INSERT INTO emp VALUES (
    4,'Grzegorz','Marciniak','Credit Analyst',15000,TO_DATE('12-04-2015','dd-mm-yyyy'),2);
INSERT INTO emp VALUES (
    5,'Dominika','Pytalska','Credit Agent',11400,TO_DATE('14-04-2015','dd-mm-yyyy'),2);
INSERT INTO emp VALUES (
    6,'Robert','Czynik','Cleaning Staff',9500,TO_DATE('13-04-2015','dd-mm-yyyy'),1);
    INSERT INTO emp VALUES (
    7,'Janusz','Bojaniewski','Cleaning Staff',9500,TO_DATE('15-04-2015','dd-mm-yyyy'),1);


 --wartosci do tabeli CUSTOMER
 INSERT INTO customer values(
    'Andrzej','Niewiadomski',96022143567,'aniewiadomski','Qwerty123','Krolewska 15/33','Radom');
 INSERT INTO customer values(
    'Emilia','Janiczak',96121143879,'ejaniczak','venive!41Fe','Sobieskiego 11','Radom');
 INSERT INTO customer values(
    'Adrian','Pawlowski',96042146527,'apawlowski','Ira321','Janiszewska 1','Radom');
 INSERT INTO customer values(
    'Mateusz','Œwigoñ',96010441567,'mswigon','Perla321','Wiejska 3','Warszawa');

--wartosci do tabeli ACCOUNTS
INSERT INTO accounts VALUES(
    3400,0,22346500000000432156432587,96022143567);
INSERT INTO accounts VALUES(
    33400,0,22764500000000432156432117,96121143879);
INSERT INTO accounts VALUES(
    100,1000,22377500000000432156432112,96042146527);
INSERT INTO accounts VALUES(
    114323,100,22654500000000432156432769,96010441567);


--wartosci do tabeli TRANSACTIONS
INSERT INTO transactions VALUES(
    001,TO_DATE('12-03-2016','dd-mm-yyyy'),533,22346500000000432156432587,3,26432800000000432156432599);
    
--wartosci do tabeli CARDS
INSERT INTO cards VALUES(
    4356224576432976,TO_DATE('31-07-2020','dd-mm-yyyy'),144,22346500000000432156432587);
INSERT INTO cards VALUES(
    5411224576432991,TO_DATE('31-08-2020','dd-mm-yyyy'),444,22764500000000432156432117);
INSERT INTO cards VALUES(
    4612224576432999,TO_DATE('31-01-2021','dd-mm-yyyy'),221,22377500000000432156432112);
INSERT INTO cards VALUES(
    1126224457432976,TO_DATE('31-03-2021','dd-mm-yyyy'),412,22654500000000432156432769);
    
--9 Wyswietlic zawartosc wybranej tabeli.
select * from emp;

--10 Dokonaæ proby zmiany wybranych danych wed³ug opracowanego przez siebie schematu
update emp
  set first_name='Kacper'
    where ID=1;
--11 Ponownie wyswietlic zawartosc tabeli
select * from emp;

--12 Wykorzystujac skrypt SUMMIT.SQL utworzyc jedna ze zdefiniowanych w nim tabel oraz wypelnic j¹ odpowiednia trescia 
CREATE TABLE emp_another 
(id                         NUMBER(7) 
   CONSTRAINT emp_id_nn NOT NULL,
 last_name                  VARCHAR2(25) 
   CONSTRAINT emp_last_name_nn NOT NULL,
 first_name                 VARCHAR2(25),
 userid                     VARCHAR2(8),
 start_date                 DATE,
 comments                   VARCHAR2(255),
 manager_id                 NUMBER(7),
 title                      VARCHAR2(25),
 dept_id                    NUMBER(7),
 salary                     NUMBER(11, 2),
 commission_pct             NUMBER(4, 2),
     CONSTRAINT emp_id_pk PRIMARY KEY (id),
     CONSTRAINT emp_userid_uk UNIQUE (userid),
     CONSTRAINT emp_commission_pct_ck
        CHECK (commission_pct IN (10, 12.5, 15, 17.5, 20)));
        

INSERT INTO emp_another VALUES (
  1, 'Velasquez', 'Carmen', 'cvelasqu',
   to_date('03-MAR-2016 ', 'dd-mon-yyyy'), NULL, NULL, 'President',
   50, 2500, NULL);
INSERT INTO emp_another VALUES (
   2, 'Ngao', 'LaDoris', 'lngao',
  to_date('13-MAR-2016 ', 'dd-mon-yyyy'), NULL, 1, 'VP, Operations',
   41, 1450, NULL);
INSERT INTO emp_another VALUES (
   3, 'Nagayama', 'Midori', 'mnagayam',
   to_date('23-KWI-2016 ', 'dd-mon-yyyy'), NULL, 1, 'VP, Sales',
   31, 1400, NULL);
INSERT INTO emp_another VALUES (
   4, 'Quick-To-See', 'Mark', 'mquickto', 
   to_date('03-KWI-2016 ', 'dd-mon-yyyy'), NULL, 1, 'VP, Finance', 
   10, 1450, NULL);
INSERT INTO emp_another VALUES (
   5, 'Ropeburn', 'Audry', 'aropebur',
   '04-MAR-1990', NULL, 1, 'VP, Administration',
   50, 1550, NULL);
INSERT INTO emp_another VALUES (
   6, 'Urguhart', 'Molly', 'murguhar',
   '18-JAN-1991', NULL, 2, 'Warehouse Manager',
   41, 1200, NULL);
INSERT INTO emp_another VALUES (
   7, 'Menchu', 'Roberta', 'rmenchu',
   '14-MAY-1990', NULL, 2, 'Warehouse Manager',
   42, 1250, NULL);
INSERT INTO emp_another VALUES (
   8, 'Biri', 'Ben', 'bbiri',
   '07-APR-1990', NULL, 2, 'Warehouse Manager',
   43, 1100, NULL);
INSERT INTO emp_another VALUES (
   9, 'Catchpole', 'Antoinette', 'acatchpo',
   '09-FEB-1992', NULL, 2, 'Warehouse Manager',
   44, 1300, NULL);
INSERT INTO emp_another VALUES (
   10, 'Havel', 'Marta', 'mhavel',
   '27-FEB-1991', NULL, 2, 'Warehouse Manager',
   45, 1307, NULL);
INSERT INTO emp_another VALUES (
   11, 'Magee', 'Colin', 'cmagee',
   '14-MAY-1990', NULL, 3, 'Sales Representative',
   31, 1400, 10);
INSERT INTO emp_another VALUES (
   12, 'Giljum', 'Henry', 'hgiljum',
   '18-JAN-1992', NULL, 3, 'Sales Representative',
   32, 1490, 12.5);
INSERT INTO emp_another VALUES (
   13, 'Sedeghi', 'Yasmin', 'ysedeghi',
   '18-FEB-1991', NULL, 3, 'Sales Representative',
   33, 1515, 10);
INSERT INTO emp_another VALUES (
   14, 'Nguyen', 'Mai', 'mnguyen',
   '22-JAN-1992', NULL, 3, 'Sales Representative',
   34, 1525, 15);
INSERT INTO emp_another VALUES (
   15, 'Dumas', 'Andre', 'adumas',
   '09-OCT-1991', NULL, 3, 'Sales Representative',
   35, 1450, 17.5);
INSERT INTO emp_another VALUES (
   16, 'Maduro', 'Elena', 'emaduro',
  to_date('27-CZE-2015', 'dd-mon-yyyy'), NULL, 6, 'Stock Clerk',
   41, 1400, NULL);
INSERT INTO emp_another VALUES (
   17, 'Smith', 'George', 'gsmith',
   to_date('25-MAJ-2015', 'dd-mon-yyyy'), NULL, 6, 'Stock Clerk',
   41, 940, NULL);
INSERT INTO emp_another VALUES (
   18, 'Nozaki', 'Akira', 'anozaki',
  to_date('02-MAJ-2015', 'dd-mon-yyyy'), NULL, 7, 'Stock Clerk',
   42, 1200, NULL);
INSERT INTO emp_another VALUES (
   19, 'Patel', 'Vikram', 'vpatel',
   to_date('22-MAJ-2015', 'dd-mon-yyyy'), NULL, 7, 'Stock Clerk',
   42, 795, NULL);

--13 Napisac polecenie, które umozliwi przekopiowanie wybranych danych z tabeli pochodz¹cej ze skryptu SUMMIT do jednej z wlasnych tabel.
INSERT INTO emp select id,first_name,last_name,title,salary,start_date,manager_id from emp_another where title like 'Stock Clerk';
update  emp 
set title ='Cleaner' where title like 'Stock Clerk';

--13 Sprawdzic zawartosc tak zmodyfikowanej tabeli wlasnej
select* from emp;