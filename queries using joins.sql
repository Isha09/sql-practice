/*Consider the following tables

Employee     Location
EmpID     EmpName
13     Jason
8     Alex
3     Ram
17     Babu
25     Johnson
    
EmpID     EmpLoc
13     San Jose
8     Los Angeles
3     New York
17     Texas
39     New Jersey
*/

create table emp
(empid NUMBER
,ename VARCHAR2(20)
);

create table loc
(
empid NUMBER
,emploc VARCHAR2(20)
);

insert into emp values(13,'Jason');
insert into emp values(8,'Alex');
insert into emp values(3,'Ram');
insert into emp values(17,'Babu');
insert into emp values(25,'Johnson');



insert into loc values(13,'San Jose');
insert into loc values(8,'Los Angeles');
insert into loc values(3,'New York');
insert into loc values(17,'Texas');
insert into loc values(39,'New Jersey');


/*Qry 1:write sql to return common employees from both tables*/
select emp.empid,emp.ename,loc.emploc 
from emp
inner join 
loc
on emp.empid = loc.empid;

/*write sql to return employees in first table that are no there in 2nd table.*/
select empid,ename from emp minus select emp.empid,emp.ename,loc.emploc
from emp
left  join 
loc
on emp.empid = loc.empid ;
--OR
select emp.empid,emp.ename,loc.emploc
from emp
left  join 
loc
on emp.empid = loc.empid where loc.emploc is null;

/*write sql to return employees in second table that are no there in 1st table.*/
select loc.empid,loc.emploc
from emp
right join 
loc
on emp.empid = loc.empid where emp.ename is null;


/*write sql to return employees from both tables*/
select emp.*,loc.* 
from emp 
full outer join 
loc 
on emp.empid = loc.empid



