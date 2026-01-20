
use ankit_bansal_udemy;

-------------------------------  Human Traffic of Stadium -------------------------------
-------------------------------  Human Traffic of Stadium -------------------------------

drop table stadium;

create table stadium (
visit_date date,
no_of_people int
);

insert into stadium
values ('2017-07-01',10)
,('2017-07-02',109)
,('2017-07-03',150)
,('2017-07-04',99)
,('2017-07-05',145)
,('2017-07-06',1455)
,('2017-07-07',199)
,('2017-07-08',188);




/*
Write a sql query to display the records which have 3 or more consicutive rows
with the amount of people more than 100 (inclusive) each day.
*/

select * from stadium;


--------------------------------------- My Solution-1 ---------------------------------------

with cte1 as (
	select 
	visit_date, no_of_people, 
	row_number() over(order by visit_date) as rn_1
	from stadium
), cte2 as (
	select *,
	ROW_NUMBER() over(order by visit_date) as rn_2
	from cte1
	where no_of_people >= 100
), cte3 as (
	select *,
	rn_1-rn_2 as gp
	from cte2
), cte4 as (
	select *,
	count(*) over(partition by gp) as cnt
	from cte3
)
	select visit_date, no_of_people 
	from cte4
	where cnt >=3;

--------------------------------------- My Solution-2 ---------------------------------------


with cte1 as (
	select *,
	-- Magic Logic: Date - RowNumber = Constant Base Date for consecutive sequences
	dateadd(day, -row_number() over(order by visit_date), visit_date) as rn
	from stadium
	where no_of_people >= 100
), cte2 as (
	select visit_date, no_of_people,
	count(*) over(partition by rn) as cnt
	from cte1
)
	select visit_date, no_of_people 
	from cte2
	where cnt >= 3;