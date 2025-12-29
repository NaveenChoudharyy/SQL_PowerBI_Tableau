
use ankit_bansal_udemy;


-------------------------------Where vs Having-------------------------------
-------------------------------Where vs Having-------------------------------

-- Ques. -> Can we use where and having togather?
-- Ans. -> yes, below is example. (WHERE cannot use aggregate functions and HAVING can use aggregate functions)
--  	   WHERE works on individual rows before aggregation, and HAVING works on aggregated results after GROUP BY.

drop table emp;
create table emp(emp_id int,emp_name varchar(10),salary int ,manager_id int);

insert into emp values(1,'Ankit',10000,4);
insert into emp values(2,'Mohit',15000,5);
insert into emp values(3,'Vikas',10000,4);
insert into emp values(4,'Rohit',5000,2);
insert into emp values(5,'Mudit',12000,6);
insert into emp values(6,'Agam',12000,2);
insert into emp values(7,'Sanjay',9000,2);
insert into emp values(8,'Ashish',5000,2);

select * from emp;

select emp_id, avg(salary) as avg_sal from emp
where salary > 10000
group by emp_id
having avg(salary) > 10000;

-- WHERE filters the rows first and then HAVING works.