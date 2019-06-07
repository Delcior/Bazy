--Utworzyæ strukturê bazy danych
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
--2.1 Dodaædo tabeli klient kolumnê umo¿liwiaj¹c¹ przechowywanie adresu email. 
ALTER TABLE klient ADD (EMAIL VARCHAR(35) NULL);

--2.2 Zmodyfikowaæ kolumnê addr_zip w ten sposób, aby mia³a nazwê addr_postalcode i umo¿liwia³a przechowywanie 7 znaków 
ALTER TABLE klient RENAME COLUMN addr_zip TO addr_postalcode;
ALTER TABLE klient MODIFY(addr_postalcode CHAR(7));

--2.3 Zmodyfikowaæ tabelê zamowienia w taki sposób, aby mo¿na by³ przechowywaæ informacjê o tym, czy dane zg³oszenie jest zrealizowane. 
ALTER TABLE zamowienia ADD(realized CHAR(1) DEFAULT 'N' NOT NULL CHECK(realized IN ('N','Y')));

--2.4 Dodaæ kolumnê umo¿liwiaj¹c¹ przechowywanie informacji o dacie (i godzinie) zrealizowania zamówienia. 
ALTER TABLE zamowienia ADD(realizationTime TIMESTAMP NULL);

--2.5 Jakie zmiany nale¿y wprowadziæ do tabeli zamowienia, ¿eby mo¿na by³o przechowywaæ informacje ostatusie realizacji zamówienia 
--Nale¿y zmieniæ typ kolumny "realized" na VARCHAR(35),DEFAULT na "Nowe zamówienie" oraz CHECK na nastepujace statusy: "Nowe zamówienie","Realizowane","Przesyka wyslana","Realizacja zakonczona";

--2.6 Zmodyfikowaæ tabelê produktów w celu przechowywania informacji o cenie brutto. 
--Cena brutto powinna byæ wyliczana na podstawie stawki podatku VAT przypisanego towarowi.
ALTER TABLE produkt ADD(VAT FLOAT DEFAULT 0.23);
ALTER TABLE produkt drop column price_gross;
ALTER TABLE produkt ADD(price_gross  AS VAT*price_net+price_net));

--2.7 Dodaæ indeks do odpowiednich tabel,pozwalaj¹cy na szybsze wyszukiwanie klientów u¿ytkowników po nazwisku, loginie i adresie poczty elektronicznej. 
CREATE INDEX klient_index ON klient(surname,login,EMAIL);

--2.8 Jaki rodzaj indeksu (jakie ograniczenie) nale¿y zastosowaæ, aby unikalnoœæ loginu by³a gwarantowana na poziomie bazy danych. Napisaæ zapytanie realizuj¹ce tak¹ funkcjonalnoœæ.
--Nalezy dodac ograniczenie unique do kolumny EMAIL;
ALTER TABLE klient
ADD CONSTRAINT EMAIL_UNIQUE
UNIQUE (EMAIL);