/*In a table there are cols, employee name and employee location. Retrieve unique locations from this table without using group by or distinct*/



create table emp
(
    empno VARCHAR(5), 
    ename VARCHAR(20),
    location VARCHAR(20),
    constraint pk_emp primary key (empno)
);


/*inserting values in a table*/
insert into emp values('101','Jason','NY');
insert into emp values('102','Alex','NJ');
insert into emp values('103','Ram','TX');
insert into emp values('104','Mary','NY');
insert into emp values('105','Sally','TX');


/*Solution Query*/
select location from 
(
    select emp.*,row_number() over (partition by location order by ename) as loc_num 
    from emp 
) where loc_num=1;
