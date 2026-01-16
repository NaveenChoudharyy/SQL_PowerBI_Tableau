
use ankit_bansal_udemy;

------------------------------- SQL ON OFF Problem -------------------------------
------------------------------- SQL ON OFF Problem -------------------------------

drop table event_status;

create table event_status
(
event_time varchar(10),
status varchar(10)
);
insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');




/*
we want below output

login		logout		cnt
10:01		10:04		3
10:07		10:09		2
10:11		10:02		1

*/

select * from event_status;


--------------------------------------- My Solution-1 ---------------------------------------


with cte1 as (
	select *, 
	case when status = 'on' then 0 else 1 end as flag 
	from event_status
), cte2 as (
	select 
	event_time, status
	, sum(flag) over(order by event_time) - flag as new_partition 
	from cte1
), cte3 as (
select * from cte2
), cte4 as (
	select 
	first_value(event_time) over(partition by new_partition order by event_time) as login 
	, event_time as logout 
	from cte3
)
select 
login, max(logout) as logout, 
count(1)-1 as cnt 
from cte4
group by login;




with cte1 as (
	select event_time
	, sum(case when status = 'on' then 0 else 1 end) over(order by event_time) 
	- (case when status = 'on' then 0 else 1 end) as gp
	from event_status
)
select
min(event_time) as login, max(event_time) as logout
, count(1) - 1 as cnt
from cte1
group by gp;
