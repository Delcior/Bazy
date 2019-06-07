--Utworzy� anonimowy blok PL/SQL, w kt�rymzadeklarowane zostan� 3 zmienne
--Zainicjowa� zmienne dowolnymi warto�ciami, za� jedn� z nich okre�li� jako CONSTANT. Wy�wietli� w konsoli zadeklarowane zmienne 
DECLARE
    liczba CONSTANT NUMBER(10):=5;
    nazwa VARCHAR2(25):='Janek';
    dat DATE:= TO_DATE('11-03-2013','dd-mm-yyyy');
BEGIN
    DBMS_OUTPUT.PUT_LINE(liczba||' '||nazwa||' '||dat);
END;
-- Stworzy� blok wy�wietlaj�cy liczb�dni, tygodni i miesi�cy, kt�re min�y od okre�lonej daty z przesz�o�ci
DECLARE
    data_urodzin CONSTANT DATE := TO_DATE('17-07-1998', 'dd-mm-yyyy');
BEGIN
    dbms_output.put_line('Liczba dni: ' || trunc(SYSDATE - data_urodzin));
    dbms_output.put_line('Liczba tygodni: ' || trunc((SYSDATE - data_urodzin) / 7));
    dbms_output.put_line('Liczba miesi�cy: ' || trunc(months_between(SYSDATE, data_urodzin)));
END;

-- Napisa� anonimowy blok PL/SQL, wy�wietlaj�cy dane osobowe z tabeli emp tych pracownik�w, kt�rzy zarabiaj� najmniej i najwi�cej 
DECLARE
    imie varchar(25);
    nazwisko varchar(25);
BEGIN
    select first_name, last_name into imie,nazwisko from emp where salary=(select min(salary) from emp);
    DBMS_OUTPUT.PUT_LINE('imie: '||imie||' Nazwisko: '||nazwisko);
    select first_name, last_name into imie,nazwisko from emp where salary=(select max(salary) from emp);
    DBMS_OUTPUT.PUT_LINE('imie: '||imie||' Nazwisko '||nazwisko);
END;
-- Wy�wietli� w bloku PL/SQL dane wszystkich pracownik�w. Zadanie wykona� przy u�yciu: 
--a) kursora jawnego z wykorzystaniem p�tli LOOP
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

--b) bez wykorzystania kursora, p�tla FOR
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


-- Napisa� blok PL/SQL, kt�ry zmodyfikuje zarobki pracownik�w 
create table emp_new as select * from emp;

BEGIN
--a) dla zarabiaj�cych poni�ej 1/2 �redniej wszystkich zarobk�w, wprowadzi podwy�k� o 20%
UPDATE emp_new SET salary = salary*1.2
WHERE salary<(select avg(salary)/2 from emp);
--b) dla zarabiaj�cych pomi�dzy1/2 a 5/6 �redniej, wprowadzi podwy�k� o 10%
UPDATE emp_new SET salary = salary*1.1
WHERE salary between (select avg(salary)/2 from emp) and (select avg(salary)*(5/6) from emp);
--c) dla pozosta�ych pracownik�w wprowadzi podwy�k� o 5%
UPDATE emp_new SET salary = salary*1.05
WHERE salary>(select avg(salary)*(5/6) from emp);
END;

