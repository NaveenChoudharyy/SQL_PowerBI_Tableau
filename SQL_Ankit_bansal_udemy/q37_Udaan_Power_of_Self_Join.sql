
use ankit_bansal_udemy;

-------------------------------   Udaan Power of Self Join -------------------------------
-------------------------------   Udaan Power of Self Join -------------------------------

drop table business_city;

create table business_city (
business_date date,
city_id int
);
delete from business_city;
insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);




/*
business_city table has data from the day udaan has started operation
Write a sql query to identify yearwise count of new cities where udaan started their operation.
*/

select * from business_city;


--------------------------------------- My Solution-1 ---------------------------------------

with cte1 as (
	select year(business_date) as [year],
	row_number() over(partition by city_id order by business_date) as rn,
	city_id
	from business_city
)
	select [year], count(*) as #_new_cities
	from cte1
	where rn = 1
	group by [year];


--------------------------------------- My Solution-2 ---------------------------------------

select 
year(b1.business_date) as [year], 
count(b1.business_date) - count(b2.business_date) as #_new_cities
from business_city as  b1
left join business_city as b2
on b1.city_id = b2.city_id and year(b1.business_date) > YEAR(b2.business_date)
group by year(b1.business_date);
