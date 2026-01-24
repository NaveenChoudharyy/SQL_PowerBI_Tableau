
use ankit_bansal_udemy;

------------------------------- Amazon Data Engineer SQL Interview Problem -------------------------------
------------------------------- Amazon Data Engineer SQL Interview Problem -------------------------------

drop table hall_events;


create table hall_events
(
hall_id integer,
start_date date,
end_date date
);
delete from hall_events
insert into hall_events values 
(1,'2023-01-13','2023-01-14')
,(1,'2023-01-14','2023-01-17')
,(1,'2023-01-15','2023-01-17')
,(1,'2023-01-18','2023-01-25')
,(2,'2022-12-09','2022-12-23')
,(2,'2022-12-13','2022-12-17')
,(3,'2022-12-01','2023-01-30');

/*
Leetcode hard: 2494: Merge overlapping events in the same hall
*/


select * from hall_events;

--------------------------------------- My Solution-1 ---------------------------------------

with cte as (
	select *,
	row_number() over(order by start_date, end_date) as rn
	from hall_events
),cte1 as (
	select *, 
	lead(start_date, 1, end_date) over(partition by hall_id order by start_date, end_date) as date_lg,
	lag(end_date, 1, end_date) over(partition by hall_id order by start_date, end_date) as date_ld
	from cte
--	order by start_date, end_date
)
select * from cte1
, cte2 as (
	select *,
	case when date_lg between start_date and end_date then 1 else 0 end as flag_lg,
	case when date_ld between start_date and end_date then 1 else 0 end as flag_ld
	from cte1
), cte3 as (
	select *,
	case when flag_lg = 1 and flag_ld = 0 then 0 else 1 end as flag
	from cte2
), cte4 as (
	select *,
	rn - rank() over(partition by hall_id, flag order by rn) as gp
	from cte3
)
--select * from cte4

	select hall_id, min(start_date) as start_date, max(end_date) as end_date
	from cte4
	group by hall_id, gp
	order by hall_id, start_date






















