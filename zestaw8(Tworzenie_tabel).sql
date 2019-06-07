--Utworzy� struktur� bazy danych
CREATE TABLE klient(
    customerID INTEGER not null 
        constraint customerID_pk primary key,
    name varchar(25) null,
    surname varchar(25) null,
    addr_street varchar(45) null,
    addr_zip char(5) null,
    addr_city varchar(45) null,
    login varchar(14) not null,
    passwd varchar(12) not null
);
CREATE TABLE zamowienia(
    orderID INTEGER not null 
        constraint orderID_pk primary key,
    IDcustomer INTEGER NULL
        constraint rel_klient2zamowienia
        REFERENCES klient(customerID),
    crDATE DATE
);
CREATE TABLE produkt(
    productID INTEGER not null
        constraint productID_pk primary key,
    name VARCHAR(35) not null,
    price_net FLOAT null,
    price_gross FLOAT null,
    description CLOB null
);
CREATE TABLE pozycja(
    IDproduct INTEGER not null
        constraint rel_produkt2pozycja
        REFERENCES produkt(productID),
    IDorder INTEGER not null
        constraint rel_zamowienia2pozycja
        REFERENCES zamowienia(orderID),
    quantity INTEGER not null
);
--2.1 Doda�do tabeli klient kolumn� umo�liwiaj�c� przechowywanie adresu email. 
ALTER TABLE klient ADD (EMAIL VARCHAR(35) NULL);

--2.2 Zmodyfikowa� kolumn� addr_zip w ten spos�b, aby mia�a nazw� addr_postalcode i umo�liwia�a przechowywanie 7 znak�w 
ALTER TABLE klient RENAME COLUMN addr_zip TO addr_postalcode;
ALTER TABLE klient MODIFY(addr_postalcode CHAR(7));

--2.3 Zmodyfikowa� tabel� zamowienia w taki spos�b, aby mo�na by� przechowywa� informacj� o tym, czy dane zg�oszenie jest zrealizowane. 
ALTER TABLE zamowienia ADD(realized CHAR(1) DEFAULT 'N' NOT NULL CHECK(realized IN ('N','Y')));

--2.4 Doda� kolumn� umo�liwiaj�c� przechowywanie informacji o dacie (i godzinie) zrealizowania zam�wienia. 
ALTER TABLE zamowienia ADD(realizationTime TIMESTAMP NULL);

--2.5 Jakie zmiany nale�y wprowadzi� do tabeli zamowienia, �eby mo�na by�o przechowywa� informacje ostatusie realizacji zam�wienia 
--Nale�y zmieni� typ kolumny "realized" na VARCHAR(35),DEFAULT na "Nowe zam�wienie" oraz CHECK na nastepujace statusy: "Nowe zam�wienie","Realizowane","Przesyka wyslana","Realizacja zakonczona";

--2.6 Zmodyfikowa� tabel� produkt�w w celu przechowywania informacji o cenie brutto. 
--Cena brutto powinna by� wyliczana na podstawie stawki podatku VAT przypisanego towarowi.
ALTER TABLE produkt ADD(VAT FLOAT DEFAULT 0.23);
ALTER TABLE produkt drop column price_gross;
ALTER TABLE produkt ADD(price_gross  AS VAT*price_net+price_net));

--2.7 Doda� indeks do odpowiednich tabel,pozwalaj�cy na szybsze wyszukiwanie klient�w u�ytkownik�w po nazwisku, loginie i adresie poczty elektronicznej. 
CREATE INDEX klient_index ON klient(surname,login,EMAIL);

--2.8 Jaki rodzaj indeksu (jakie ograniczenie) nale�y zastosowa�, aby unikalno�� loginu by�a gwarantowana na poziomie bazy danych. Napisa� zapytanie realizuj�ce tak� funkcjonalno��.
--Nalezy dodac ograniczenie unique do kolumny EMAIL;
ALTER TABLE klient
ADD CONSTRAINT EMAIL_UNIQUE
UNIQUE (EMAIL);