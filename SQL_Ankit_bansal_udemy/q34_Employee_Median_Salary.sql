
use ankit_bansal_udemy;

------------------------------- Employee Median Salary -------------------------------
------------------------------- Employee Median Salary -------------------------------

drop table employee;

create table employee 
(
emp_id int,
company varchar(10),
salary int
);

insert into employee values (1,'A',2341)
insert into employee values (2,'A',341)
insert into employee values (3,'A',15)
insert into employee values (4,'A',15314)
insert into employee values (5,'A',451)
insert into employee values (6,'A',513)
insert into employee values (7,'B',15)
insert into employee values (8,'B',13)
insert into employee values (9,'B',1154)
insert into employee values (10,'B',1345)
insert into employee values (11,'B',1221)
insert into employee values (12,'B',234)
insert into employee values (13,'C',2345)
insert into employee values (14,'C',2645)
insert into employee values (15,'C',2645)
insert into employee values (16,'C',2652)
insert into employee values (17,'C',65);



/*
Write a sql query to find the median salary of each company
-- Bonus point if you can solve it without using any build-in sql functions.
*/

select * from employee;


--------------------------------------- My Solution-1 ---------------------------------------


with cte as (
	select company,
	PERCENTILE_CONT(0.5) within group (order by salary) over(partition by company) as median_salary
	from employee
)
	select company, 
	avg(median_salary)*1.0 as median_salary
	from cte
	group by company;


--------------------------------------- My Solution-2 ---------------------------------------


with cte1 as (
	select company, salary,
	row_number() over(partition by company order by salary) as rn,
	count(*) over(partition by company) as cnt
	from employee
), cte2 as (
	select company, salary,
	case when (cnt*0.5 = rn) or (cnt*0.5+1 = rn) or (ceiling(cnt*0.5) = rn) then rn else null end as req_rn
	from cte1
)
	select company, avg(salary*1.0) as median_salary
	from cte2
	where req_rn is not null
	group by company;
