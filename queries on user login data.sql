/*Given the 2 tables below, User and UserHistory:
User
user_id
name
phone_num

UserHistory
user_id
date
action
Answer the following questions
*/



create table usertbl(
    user_id VARCHAR2(5)
    ,username VARCHAR2(20)
    ,phone NUMBER
    ,constraint pk_user_id primary key (user_id)
);

create table userhistory
(
    userid VARCHAR2(5)
    ,actiondate DATE
    ,action VARCHAR2(20)
    ,constraint fk_userid foreign key (userid) references usertbl (user_id)        
);

insert into usertbl values('11','Alan',7140212344);
insert into usertbl values('12','Mark',7140212129);
insert into usertbl values('13','John',7140212254);
insert into usertbl values('14','Mary',7140212201);
insert into usertbl values('15','Amy',7143555344);


insert into userhistory values('11',to_date('10-12-2016','dd-mm-yyyy'),'logged_on');
insert into userhistory values('14',to_date('29-11-2016','dd-mm-yyyy'),'logged_on');
insert into userhistory values('11',to_date('5-11-2016','dd-mm-yyyy'),'logged_on');
insert into userhistory values('12',to_date('18-10-2016','dd-mm-yyyy'),'logged_on');
insert into userhistory values('14',to_date('25-11-2016','dd-mm-yyyy'),'logged_on');
insert into userhistory values('15',to_date('11-12-2016','dd-mm-yyyy'),'logged_on');

/*Query 1: Write a SQL query that returns the name, phone number and most recent date for any user that has logged in over the last 30 days 
(you can tell a user has logged in if the action field in UserHistory is set to "logged_on").*/
select u.username,u.phone,max(uh.actiondate)
from usertbl u
inner join 
userhistory uh 
on u.user_id = uh.userid
where uh.actiondate >= sysdate - 30
group by (u.username,u.phone,u.user_id);


/*Query 2: Write a SQL query to determine which user_ids in the User table are not contained in the UserHistory table 
(assume the UserHistory table has a subset of the user_ids in User table). 
Do not use the SQL MINUS statement. Note: the UserHistory table can have multiple entries for each user_id.*/
select distinct u.user_id
from usertbl as u
left join userhistory as uh on u.user_id=uh.userid
where uh.userid is null;




