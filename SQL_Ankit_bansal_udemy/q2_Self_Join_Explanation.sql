
use ankit_bansal_udemy;


----------------------Self Join Simplified and Interview question-----------------
----------------------Self Join Explanation---------------------------------------
----------------------Find employees with salary more then managers salary--------


create table emp_manager(emp_id int,emp_name varchar(50),salary int,manager_id int);
insert into emp_manager values(	1	,'Ankit',	10000	,4	);
insert into emp_manager values(	2	,'Mohit',	15000	,5	);
insert into emp_manager values(	3	,'Vikas',	10000	,4	);
insert into emp_manager values(	4	,'Rohit',	5000	,2	);
insert into emp_manager values(	5	,'Mudit',	12000	,6	);
insert into emp_manager values(	6	,'Agam',	12000	,2	);
insert into emp_manager values(	7	,'Sanjay',	9000	,2	);
insert into emp_manager values(	8	,'Ashish',	5000	,2	);



select * from emp_manager;


---- my solution

with cte as (
select e3.emp_id, e3.emp_name, e3.salary as emp_sal, t1.salary as manager_sal,
case when e3.salary > t1.salary then 1 else 0 end as is_emp_sal_more
from emp_manager as e3
inner join (
select distinct e2.manager_id, e1.salary from emp_manager as e1
inner join emp_manager as e2
on e1.emp_id = e2.manager_id) as t1
on t1.manager_id = e3.manager_id
)
select cte.emp_id, emp_name from cte
where cte.is_emp_sal_more = 1



---- easy solution




select e1.emp_id, e1.emp_name from emp_manager as e1
inner join emp_manager as e2
on e1.manager_id = e2.emp_id
where e1.salary > e2.salary


