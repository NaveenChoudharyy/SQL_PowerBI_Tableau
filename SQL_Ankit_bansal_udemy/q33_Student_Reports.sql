
use ankit_bansal_udemy;

------------------------------- Student Reports -------------------------------
------------------------------- Student Reports -------------------------------

drop table players_location;

create table players_location
(
name varchar(20),
city varchar(20)
);
delete from players_location;
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');



/*
We want output as 

Banglore		Mumbai		Delhi
Mayank			Rohit		Virat
Rahul			Sachin		Null

*/

select * from players_location;


--------------------------------------- My Solution-1 ---------------------------------------


with cte as (
	select 
	row_number() over(partition by city order by name) as rn
	, case when city = 'Bangalore' then name else Null  end as Bangalore
	, case when city = 'Mumbai' then name else Null  end as Mumbai
	, case when city = 'Delhi' then name else Null  end as Delhi
	from players_location
)
select min(Bangalore) Bangalore, min(Mumbai) Mumbai, min(Delhi) Delhi
from cte
group by rn;


--------------------------------------- My Solution-2 ---------------------------------------

with cte as (
	select name, city, 
	row_number() over(partition by city order by name) as rn 
	from players_location
)
select Bangalore, Delhi, Mumbai from cte
pivot (
max(name) for city in ([Bangalore], [Delhi], [Mumbai])
) agg_col;
