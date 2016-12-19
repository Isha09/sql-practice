/*write queries for 
1.You are given salaries deppt wise in some emplyee table. You have to determine what percentage of salaries in deptt. A contribute to overall salaries
2.Give the list of all emplyees whose salary is above average for their deptts. Use correlated query.
3.Two tables are given - Employee (salary + emp info) and Employee bonuses (note that same employee can receieve bonus more than once). 
  You want to find sum of salaries of all employees in deptt 10 along with sum of their bonuses.
4.You have two tables - Deptt and Employees. There are some employees without a deptt. and some deptts. without any employee. 
Find these rows using a single query. 
*/

create table emp
(  
      empno    number(4,0),  
      ename    varchar2(10),  
      job      varchar2(9),  
      mgr      number(4,0),  
      hiredate date,  
      sal      number(7,2),  
      comm     number(7,2),  
      deptno   number(2,0),  
      constraint pk_emp primary key (empno)
      --constraint fk_deptno foreign key (deptno) references dept (deptno)        
);

create table empbonus
(
       empno number(4,0)
       ,bonusamt number(7,2)
);


create table dept(  
      deptno     number(2,0),  
      dname      varchar2(14),  
      loc        varchar2(13),  
      constraint pk_dept primary key (deptno)  
    )

/*inserting values in a table*/
insert into emp values(  
     7839, 'KING', 'PRESIDENT', null,  
     to_date('17-11-1981','dd-mm-yyyy'),  
     5000, null, 10  
    );

insert into emp values(  
     7698, 'BLAKE', 'MANAGER', 7839,  
     to_date('1-5-1981','dd-mm-yyyy'),  
     2850, null, 30  
    );

insert into emp values(  
     7782, 'CLARK', 'MANAGER', 7839,  
     to_date('9-6-1981','dd-mm-yyyy'),  
     2450, null, 10  
    );

insert into emp values(  
     7566, 'JONES', 'MANAGER', 7839,  
     to_date('2-4-1981','dd-mm-yyyy'),  
     2975, null, 20  
    );

insert into emp  values(  
     7788, 'SCOTT', 'ANALYST', 7566,  
     to_date('13-JUL-87','dd-mm-rr') - 85,  
     3000, null, 20  
    );


insert into emp values(  
     7902, 'FORD', 'ANALYST', 7566,  
     to_date('3-12-1981','dd-mm-yyyy'),  
     3000, null, 20  
    );

insert into emp values(  
     7369, 'SMITH', 'CLERK', 7902,  
     to_date('17-12-1980','dd-mm-yyyy'),  
     800, null, 20  
    );

insert into emp values(  
     7499, 'ALLEN', 'SALESMAN', 7698,  
     to_date('20-2-1981','dd-mm-yyyy'),  
     1600, 300, 30  
    );

insert into emp values(  
     7521, 'WARD', 'SALESMAN', 7698,  
     to_date('22-2-1981','dd-mm-yyyy'),  
     1250, 500, 30  
    );

insert into emp values(  
     7654, 'MARTIN', 'SALESMAN', 7698,  
     to_date('28-9-1981','dd-mm-yyyy'),  
     1250, 1400, 30  
    );

insert into emp values(  
     7844, 'TURNER', 'SALESMAN', 7698,  
     to_date('8-9-1981','dd-mm-yyyy'),  
     1500, 0, 30  
    );

insert into emp values(  
     7876, 'ADAMS', 'CLERK', 7788,  
     to_date('13-JUL-87', 'dd-mm-rr') - 51,  
     1100, null, 20  
    );

insert into emp values(  
     7900, 'JAMES', 'CLERK', 7698,  
     to_date('3-12-1981','dd-mm-yyyy'),  
     950, null, 30  
    );

insert into emp values(  
     7934, 'MILLER', 'CLERK', 7782,  
     to_date('23-1-1982','dd-mm-yyyy'),  
     1300, null, 10  
    );
    

--inserting values in employee bonus table    
insert into empbonus values(7839,200);
insert into empbonus values(7839,300);
insert into empbonus values(7698,100);
insert into empbonus values(7782,200);
insert into empbonus values(7566,400);
insert into empbonus values(7566,150);


--inserting values in dept table
insert into dept values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept values(20, 'RESEARCH', 'DALLAS');
insert into dept values(30, 'SALES', 'CHICAGO');
insert into dept values(40, 'OPERATIONS', 'BOSTON');
    
    
/*Qry Sol 1*/   
select deptno,
round((sum(sal)*100/(select sum(sal) as totalsal from emp)),2)  as deptcntbtn
from emp group by deptno;  


/*Qry Sol 2*/
Select ename, deptno, sal
FROM emp e
WHERE sal > (select avg(sal) from emp e2 where e2.deptno = e.deptno);

/*Qry Sol 3*/
select sum(q1.totalsal),sum(q2.totalbonus) 
from
(select empno , sal as totalsal from emp where deptno =10)q1 
left join
(select empno, sum(bonusamt) as totalbonus from empbonus group by empno)q2 
on q1.empno = q2.empno;

/*Qry Sol 4*/
select * from emp 
full join dept 
on emp.deptno = dept.deptno 
where emp.empno is null or dept.deptno is null;
