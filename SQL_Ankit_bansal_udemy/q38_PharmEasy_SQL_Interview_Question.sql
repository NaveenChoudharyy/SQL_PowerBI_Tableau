
use ankit_bansal_udemy;

-------------------------------   PharmEasy SQL Interview Question -------------------------------
-------------------------------   PharmEasy SQL Interview Question -------------------------------

drop table movie;

create table movie(
seat varchar(50),occupancy int
);
insert into movie values('a1',1),('a2',1),('a3',0),('a4',0),('a5',0),('a6',0),('a7',1),('a8',1),('a9',0),('a10',0),
('b1',0),('b2',0),('b3',0),('b4',1),('b5',1),('b6',1),('b7',1),('b8',0),('b9',0),('b10',0),
('c1',0),('c2',1),('c3',0),('c4',1),('c5',1),('c6',0),('c7',1),('c8',0),('c9',0),('c10',1);




/*
There are 3 rows in a movie hall each with 10 seats in 10 rows
Write a sql to find 4 consecutive empty seats
*/


select * from movie;


--------------------------------------- My Solution-1 ---------------------------------------


with cte1 as (
	select *, 
	left(seat, 1) as row_name,
	cast(right(seat, len(seat)-1) as int) as seat_num
	from movie
), cte2 as (
	select *,
	row_number() over(partition by row_name order by seat_num) as rn_2
	from cte1
	where occupancy = 0
), cte3 as (
	select *,
	seat_num - rn_2 as gp
	from cte2
), cte4 as (
	select *,
	-- group by both row_name and gp
	-- ORDER BY inside a window aggregate like COUNT, it usually creates a Running Total
	-- DO NOT use 'ORDER BY' here. 
	-- 'ORDER BY' creates a running total (1,2,3,4) instead of a group total (4,4,4,4).
	-- We need the group total to filter ALL seats in the sequence.	
	count(*) over(partition by row_name, gp) as cnt
	from cte3
)
	select seat, occupancy 
	from cte4
	where cnt >= 4;
