/*
There are three tables :salesperson,customer,orders.Answer the following questions using the data given below:
Salesperson
ID     Name     Age     Salary
1     Abe     61     140000
2     Bob     34     44000
5     Chris     34     40000
7     Dan     41     52000
8     Ken     57     115000
11     Joe     38     38000

Customer
ID     Name     City     Industry Type
4     Samsonic     pleasant     J
6     Panasung     oaktown     J
7     Samony     jackson     B
9     Orange     Jackson     B

Orders
Number     order_date     cust_id     salesperson_id     Amount
10     8/2/96     4     2     540
20     1/30/99     4     8     1800
30     7/14/95     9     1     460
40     1/29/98     7     2     2400
50     2/3/98     6     7     600
60     3/2/98     6     7     720
70     5/6/98     9     7     150

*/

create table salesperson
(
    sid NUMBER, 
    sname VARCHAR2(20), 
    age NUMBER, 
    salary NUMBER,
    constraint pk_salesid primary key (sid)
);

create table customer 
(
    cid NUMBER,
    cname VARCHAR2(20),
    city VARCHAR2(20),
    ind_type VARCHAR2(10),
    constraint pk_custid primary key (cid)
);


create table orders 
(
    order_no NUMBER,
    order_dt date,
    c_id NUMBER,
    s_id NUMBER,
    amount NUMBER(7,2),
    constraint pk_orderno primary key (order_no) 
);


/*inserting values in table orders*/
insert into orders values(10,to_date('2-8-1996','dd-mm-yyyy'),4,2,540);
insert into orders values(20,to_date('30-1-1999','dd-mm-yyyy'),4,8,1800);
insert into orders values(30,to_date('14-7-1995','dd-mm-yyyy'),9,1,460);
insert into orders values(40,to_date('29-1-1998','dd-mm-yyyy'),7,2,2400);
insert into orders values(50,to_date('3-2-1998','dd-mm-yyyy'),6,7,600);
insert into orders values(60,to_date('2-3-1998','dd-mm-yyyy'),6,7,720);
insert into orders values(70,to_date('6-5-1998','dd-mm-yyyy'),9,7,150);


/*inserting values in table salesperson*/
insert into salesperson values(1,'Abe',61,140000);
insert into salesperson values(2,'Bob',34,44000);
insert into salesperson values(5,'Chris',34,40000);
insert into salesperson values(7,'Dan',41,52000);
insert into salesperson values(8,'Ken',57,115000);
insert into salesperson values(11,'Joe',38,38000);


/*inserting values in table customer*/
insert into customer values(4,'Samsonic','pleasant','J');
insert into customer values(6,'Panasung','oaktown','J');
insert into customer values(7,'Samony','jackson','B');
insert into customer values(9,'Orange','jackson','B');

/*Qry1:The names of all salespeople that have an order with Samsonic.*/
select 
s.sname 
from salesperson s, orders o
where s.sid = o.s_id and o.c_id in
(
  select cid from customer where cname = 'Samsonic'
);


/*Qry 2:The names of all salespeople that do not have any order with Samsonic.*/
select distinct s.sname 
from salesperson s, orders o 
where s.sid = o.s_id and o.s_id not in
(
select o.s_id from orders o,customer cu where cu.cid = o.c_id and cu.cname ='Samsonic'
);

/*Query 3: The names of salespeople that have 2 or more orders.*/
select s.sname 
from salesperson s,orders o 
where s.sid = o.s_id
group by s.sname 
having count(o.s_id) >1;


/*Query 4:Write a SQL statement to insert rows into a table called highAchiever(Name, Age), 
where a salesperson must have a salary of 100,000 or greater to be included in the table.*/
insert into highAchiever 
select name, salary 
from salesperson 
where salary >= 100000;


/*query 4:find the largest order amount for each salesperson and the associated order number, along with the customer to whom that order belongs to. */
select ord.sales_id,s.sname as salesname,ord.customer_id,ord.customer_name,ord.order_no, ord.maxamt  
from salesperson s, 
(
select o.order_no as order_no, o.c_id as customer_id,c.cname as customer_name,o.s_id as sales_id,o.amount as maxamt,
row_number()  over (partition by o.s_id order by o.amount desc) as max_amt_no
from orders o inner join customer c on o.c_id = c.cid
)ord
where s.sid=ord.sales_id and ord.max_amt_no = 1;



