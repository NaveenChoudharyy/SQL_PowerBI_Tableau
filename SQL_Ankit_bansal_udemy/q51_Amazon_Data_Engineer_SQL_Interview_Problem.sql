
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


with cte1 as (
	select *,
	lag(end_date) over(partition by hall_id order by start_date, end_date) as end_date_lg
	from hall_events
), cte2 as (
	select *,
	case when end_date_lg is null or start_date > end_date_lg then 1 else 0 end as flag
	from cte1
), cte3 as (
	select *,
	sum(flag) over(partition by hall_id order by start_date, end_date) as flag_sum
	from cte2
)
	select hall_id, min(start_date) as start_date, max(end_date) as end_date from cte3
	group by hall_id, flag_sum
	order by hall_id;
