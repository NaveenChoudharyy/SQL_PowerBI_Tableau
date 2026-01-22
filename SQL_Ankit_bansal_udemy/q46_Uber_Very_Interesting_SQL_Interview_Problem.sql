
use ankit_bansal_udemy;

------------------------------- SQL Pre-Screening Test -------------------------------
------------------------------- SQL Pre-Screening Test -------------------------------

drop table drivers;

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');


/*
Write a query to print total rides and profit rides for each driver.
Profit ride is when the end location of current ride is same as start location on next ride.
*/

select * from drivers;


--------------------------------------- My Solution-1 ---------------------------------------

with cte1 as (
	select id, count(*) over(partition by id) as total_rides,
	case when lead(start_loc) over(partition by id order by start_time, end_time) = end_loc then 1 else 0 end as profit_rides
	from drivers
)
	select id,total_rides, 
	sum(profit_rides) as profit_rides
	from cte1
	group by id,total_rides;


--------------------------------------- Solution-self join ---------------------------------------



with cte as (
	select *, row_number() over(partition by id order by start_time) as rn
	from drivers
)
	select c1.id, 
	count(*) as total_rides,
	count(c2.rn) as profit_rides
	from cte as c1
	left join cte as c2
	on c1.id = c2.id and c2.rn - c1.rn = 1 and  c1.end_loc = c2.start_loc
	group by c1.id;
