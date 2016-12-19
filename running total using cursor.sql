/*Find running total of salary from a table having 2 columns - Name and Salary*/

DECLARE
empid emp.id%type;
sal emp.salary%type;
sumsal integer:=0;
CURSOR running_salary is select id,salary from emp;
BEGIN
OPEN running_salary;
LOOP
   FETCH running_salary INTO empid,sal;
   sumsal := sal + sumsal;
   EXIT WHEN running_salary%notfound;
   dbms_output.put_line(empid || ' ' || sal || ' ' || sumsal);
END LOOP;
CLOSE running_salary;
END;