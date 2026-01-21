
use ankit_bansal_udemy;

------------------------------- Microsoft SQL Interview Question -------------------------------
------------------------------- Microsoft SQL Interview Question -------------------------------

drop table candidates;

create table candidates (
emp_id int,
experience varchar(20),
salary int
);
delete from candidates;
insert into candidates values
(1,'Junior',10000),(2,'Junior',15000),(3,'Junior',40000),(4,'Senior',16000),(5,'Senior',20000),(6,'Senior',50000);


/*
A company wants to hire new employees. The budget of the company for the salaries is 70000. 
The company's criteria for hiring are :
Keep hiring the senior with the smallest salary until you cannot hire any more seniors.
Use the remaining budget to hire the junior with smallest salary.
Keep hiring the junior with smallest salary until you cannot hire any more juniors. 
Write an sql query to find the senior and juniors hired under the mentioned criteria.
*/

select * from candidates;


--------------------------------------- My Solution-1 ---------------------------------------

with cte1 as (
	select *,
	sum(salary) over(order by experience desc, salary asc) as salary_sum
	from candidates
	where experience = 'Senior'
), cte2 as (
	select * from cte1
	where salary_sum <= 70000
), cte3 as (
	select *,
	sum(salary) over(order by experience desc, salary asc) 
		+ (select  coalesce(max(salary_sum), 0)  as mx_sal_sum from cte2) as salary_sum
	from candidates
	where experience = 'Junior'
), cte4 as (
	select * 
	from cte3
	where salary_sum <= 70000
)
	select emp_id, experience, salary
	from cte2
	union 
	select emp_id, experience, salary 
	from cte4;
