--Utworzyæ anonimowy blok PL/SQL, w którymzadeklarowane zostan¹ 3 zmienne
--Zainicjowaæ zmienne dowolnymi wartoœciami, zaœ jedn¹ z nich okreœliæ jako CONSTANT. Wyœwietliæ w konsoli zadeklarowane zmienne 
DECLARE
    liczba CONSTANT NUMBER(10):=5;
    nazwa VARCHAR2(25):='Janek';
    dat DATE:= TO_DATE('11-03-2013','dd-mm-yyyy');
BEGIN
    DBMS_OUTPUT.PUT_LINE(liczba||' '||nazwa||' '||dat);
END;
-- Stworzyæ blok wyœwietlaj¹cy liczbêdni, tygodni i miesiêcy, które minê³y od okreœlonej daty z przesz³oœci
DECLARE
    data_urodzin CONSTANT DATE := TO_DATE('17-07-1998', 'dd-mm-yyyy');
BEGIN
    dbms_output.put_line('Liczba dni: ' || trunc(SYSDATE - data_urodzin));
    dbms_output.put_line('Liczba tygodni: ' || trunc((SYSDATE - data_urodzin) / 7));
    dbms_output.put_line('Liczba miesiêcy: ' || trunc(months_between(SYSDATE, data_urodzin)));
END;

-- Napisaæ anonimowy blok PL/SQL, wyœwietlaj¹cy dane osobowe z tabeli emp tych pracowników, którzy zarabiaj¹ najmniej i najwiêcej 
DECLARE
    imie varchar(25);
    nazwisko varchar(25);
BEGIN
    select first_name, last_name into imie,nazwisko from emp where salary=(select min(salary) from emp);
    DBMS_OUTPUT.PUT_LINE('imie: '||imie||' Nazwisko: '||nazwisko);
    select first_name, last_name into imie,nazwisko from emp where salary=(select max(salary) from emp);
    DBMS_OUTPUT.PUT_LINE('imie: '||imie||' Nazwisko '||nazwisko);
END;
-- Wyœwietliæ w bloku PL/SQL dane wszystkich pracowników. Zadanie wykonaæ przy u¿yciu: 
--a) kursora jawnego z wykorzystaniem pêtli LOOP
DECLARE
    uv_nazwisko emp.last_name%TYPE;
    uv_imie emp.first_name%TYPE;
    CURSOR c_emp is select last_name, first_name from emp;
BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO uv_imie, uv_nazwisko;
        EXIT WHEN c_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(uv_imie||' '||uv_nazwisko);
    END LOOP;
    CLOSE c_emp;
END;

--b) bez wykorzystania kursora, pêtla FOR
DECLARE
    uv_nazwisko emp.last_name%TYPE;
    uv_imie emp.first_name%TYPE;
    licz number;
BEGIN
    select count(*) into licz from emp;
    FOR i in 1..licz LOOP
        select last_name, first_name
        into uv_nazwisko, uv_imie
        from emp
        where id=i;
        DBMS_OUTPUT.PUT_LINE(uv_nazwisko || ' ' || uv_imie);
    END LOOP;
END;


-- Napisaæ blok PL/SQL, który zmodyfikuje zarobki pracowników 
create table emp_new as select * from emp;

BEGIN
--a) dla zarabiaj¹cych poni¿ej 1/2 œredniej wszystkich zarobków, wprowadzi podwy¿kê o 20%
UPDATE emp_new SET salary = salary*1.2
WHERE salary<(select avg(salary)/2 from emp);
--b) dla zarabiaj¹cych pomiêdzy1/2 a 5/6 œredniej, wprowadzi podwy¿kê o 10%
UPDATE emp_new SET salary = salary*1.1
WHERE salary between (select avg(salary)/2 from emp) and (select avg(salary)*(5/6) from emp);
--c) dla pozosta³ych pracowników wprowadzi podwy¿kê o 5%
UPDATE emp_new SET salary = salary*1.05
WHERE salary>(select avg(salary)*(5/6) from emp);
END;

