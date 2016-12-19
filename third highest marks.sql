/*1.	In a sql table about students and their marks how will you find out the students who have got third highest marks? */

create table student 
(
    stu_id VARCHAR2(5) ,
    name VARCHAR2(10) NOT NULL, 
    marks NUMBER,
    constraint pk_stuid primary key (stu_id) 
);


/*inserting values in a table*/
insert into student values('101','John',98);
insert into student values('102','Bob',99);
insert into student values('103','Mary',98);
insert into student values('104','Andrea',97);
insert into student values('105','Mark',97);
insert into student values('106','Harry',95);


/*Solution query*/
select stu_id,name,marks from
    (select 
     stu_id,name, marks,dense_rank() over (order by marks desc) as stu_rank  
     from 
     student ) 
where stu_rank = 3;
