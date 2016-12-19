/*Say there is an outdated students table. It has student info. 
There is another table that has studentid as foreign key and says which all students have passed out from school. 
Delete the passed out students from students table.*/

delete from students where stu_id in(select stu_id from stu_old where passed_status =’Y’);

/*Say there is an outdated students table. It has student info.
There is another table that has studentid as foreign key and says which all students have passed out from school. 
update the students table for soft delete column*/

alter table stu_old add passed_status varchar(5);

update stu_old set passed_status ='Y' where stu_id in (select stu_id from stu_alumni);
