
use ankit_bansal_udemy;

------------------------------- Consecutive Empty Seats -------------------------------
------------------------------- Consecutive Empty Seats -------------------------------

drop table bms;

create table bms (seat_no int ,is_empty varchar(10));
insert into bms values
(1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y');

/*
3 or more conecutive empty seats
method 1 -- lag
method 2 -- advance aggregation
method 3 -- analytical row_number function
*/

---------------------------------------- Solution ----------------------------------------


select * from bms as b;

------------------------ method 1 -- lag ------------------------


with lead_lag as (
select *,
lead(is_empty, 1) over(order by seat_no) as prev_1,
lead(is_empty, 2) over(order by seat_no) as prev_2,
lag(is_empty, 1) over(order by seat_no) as next_1,
lag(is_empty, 2) over(order by seat_no) as next_2
from bms
), cte2 as (
select seat_no from lead_lag
where (prev_2 = 'Y' and prev_1 = 'Y' and is_empty = 'Y') or 
(prev_1 = 'Y' and is_empty = 'Y' and next_1 = 'Y') or 
(is_empty = 'Y' and next_1 = 'Y' and next_2 = 'Y'))
select * from cte2;


------------------------ method 2 -- advance aggregation ------------------------

with cte1 as (
select seat_no, 
case when is_empty = 'Y' then 1 else 0 end as flag 
from bms as b ),
cte2 as (
select *,
sum(flag) over(order by seat_no rows between 2 preceding  and current row) +
sum(flag) over(order by seat_no rows between 1 preceding and 1 following) +
sum(flag) over(order by seat_no rows between current row and 2 following) as sum_row
from cte1)
select seat_no from cte2
where sum_row >= 7;


------------------------ method 3 -- analytical row_number function ------------------------


with cte1 as (
select *,
row_number() over(order by seat_no) as rn,
seat_no - row_number() over(order by seat_no) as diff
from bms as b
where is_empty = 'Y'
), cte2 as (
select diff, count(*) as cnt from cte1
group by diff
having count(*) >= 3)
select seat_no from cte1 
where diff in (select diff from cte2);




