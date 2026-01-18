
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
	sum(case when no_of_people >= 100 then 1 else 0 end) over(order by visit_date) as sum_flag
	from stadium
), cte2 as (
	select *,
	row_number() over(partition by sum_flag order by visit_date) as rn
	from cte1
)
	select * 
	from cte2




















