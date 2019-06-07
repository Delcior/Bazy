--1 Opracowac model wlasnej bazy danych
--Stworzona przeze mnie baza w prosty sposób imituje baze danych banku

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
--emp_id przyjmuje wartosc gdy transakcja byla przeprowadzana przez danego pracownika w banku, gdy transakcja by³a wykonywana online jest wartosc NULL
 ); 
 
ALTER TABLE transactions ADD CONSTRAINT transactions_pk PRIMARY KEY ( id );  
ALTER TABLE transactions ADD CONSTRAINT transactions_accounts_fk FOREIGN KEY ( accounts_account_number ) REFERENCES accounts ( account_number ); 
ALTER TABLE transactions ADD CONSTRAINT emp_id_fk FOREIGN KEY ( emp_id)REFERENCES emp( id );
 
ALTER TABLE transactions     ADD CONSTRAINT transactions_emp_fk FOREIGN KEY ( emp_id )         REFERENCES emp ( id ); 