
use ankit_bansal_udemy;

-------------------------------Median Salary (2 methods)-------------------------------
-------------------------------Median Salary (2 methods)-------------------------------


create table emp(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp
values
(1, 'Ankit', 100,10000, 4, 39),
(2, 'Mohit', 100, 15000, 5, 48),
(3, 'Vikas', 100, 10000,4,37),
(4, 'Rohit', 100, 5000, 2, 16),
(5, 'Mudit', 200, 12000, 6,55),
(6, 'Agam', 200, 12000,2, 14),
(7, 'Sanjay', 200, 9000, 2,13),
(8, 'Ashish', 200,5000,2,12),
(9, 'Mukesh',300,6000,6,51),
(10, 'Rakesh',300,7000,6,50);



-- How to calculate median
select * from emp;

-- Method 1: Using row_number
select avg(salary*1.0) as median from (
select e.salary, 
row_number() over(order by e.salary asc) as rn_asc,
row_number() over(order by e.salary desc) as rn_desc
from emp as e) as t1
where abs(rn_asc - rn_desc) <= 1;

-- Method 2: Using percentile_cont
select *, PERCENTILE_CONT(0.5) within group (order by e.salary) over() as median from emp as e;

--Method 3: My method
with cte as(
select *, row_number() over(order by rn_asc desc) as rn_desc from (
select e.salary, 
row_number() over(order by e.salary asc) as rn_asc
from emp as e) as t)
select avg(1.0 * salary) as median_sal from cte
where abs(rn_desc - rn_asc) <= 1;