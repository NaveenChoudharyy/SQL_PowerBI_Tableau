
use ankit_bansal_udemy;

-------------------------------  Human Traffic of Stadium -------------------------------
-------------------------------  Human Traffic of Stadium -------------------------------

drop table stadium;

create table stadium (
id int,
visit_date date,
no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);




/*
Write a sql query to display the records which have 3 or more consicutive rows
with the amount of people more than 100 (inclusive) each day.
*/

select * from stadium;


--------------------------------------- My Solution-1 ---------------------------------------


with cte1 as (
	select id, visit_date, no_of_people, 
	case when no_of_people >= 100 then 0 else 1 end as flag
	from stadium
), cte2 as (
	select *, 
	count(*) over(order by visit_date) as x
	from cte1
)
	select * 
	from cte2;





with cte1 as (
	select id, visit_date, no_of_people, 
	case when no_of_people >= 100 then 0 else 1 end as flag
	from stadium
), cte2 as (
	select *, 
	row_number() over(order by visit_date) as rn_1 ,
	row_number() over(partition by flag order by visit_date) as rn_2 
	from cte1
), cte3 as (
	select *,
	rn_1-rn_2 as new_grp
	from cte2
), cte4 as (
	select visit_date, no_of_people, count(1) over(partition by new_grp) as cnt
	from cte3
) 
	select *
	from cte4
	where cnt >= 3



with cte_1 as (
	select *,
	lag(visit_date, 1,visit_date) over(order by visit_date) as visit_date_lag
	from stadium
	where no_of_people >= 100
), cte_2 as (
	select *,
	case when datediff(day, visit_date_lag, visit_date) = 1 then 0 else 1 end as flag
	from cte_1
), cte_3 as (
	select *, sum(flag) over(order by visit_date) sum_flag
	from cte_2
), cte_4 as (
	select *, count(*) over(partition by sum_flag) as cnt
	from cte_3
)
	select visit_date, no_of_people
	from cte_4
	where cnt >= 3;













with cte_1 as (
	select *,
	lag(visit_date, 1,visit_date) over(order by visit_date) as visit_date_lag
	from stadium
	where no_of_people >= 100
), cte_2 as (
	select *,
	case when datediff(day, visit_date_lag, visit_date) = 1 then 0 else 1 end as flag
	from cte_1
), cte_3 as (
	select *, count(*) over(order by visit_date) as cnt
	from cte_2
), cte_4 as (
	select *
	from cte_3
)
	select *
	from cte_4;
	




select *, sum(no_of_people) 
over(order by visit_date) as sum_no_of_people from stadium
where no_of_people >= 100



