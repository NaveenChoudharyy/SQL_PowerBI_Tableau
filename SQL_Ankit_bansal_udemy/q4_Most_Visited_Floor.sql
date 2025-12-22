
use ankit_bansal_udemy;

----------------------------Most Visited Floor----------------------------
----------------------------Most Visited Floor----------------------------

create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')


select * from entries;






with cte1 as (
select e1.name, count(e1.name) as total_visits
from entries as e1
group by e1.name),
cte2 as (
select e1.name, e1.floor, count(e1.floor) as no_of_visits from entries as e1
group by e1.name, e1.floor),
cte3 as (
select cte2.name, cte2.floor,
row_number() over(partition by cte2.name order by cte2.no_of_visits desc) as rn
from cte2),
cte4 as (
select cte3.name, cte3.floor from cte3
where cte3.rn = 1),
cte5 as (
select distinct e1.name, e1.resources from entries as e1),
cte6 as (
select cte5.name, string_agg(cte5.resources, ', ') as resources_used from cte5
group by cte5.name)
select 
cte1.name, cte1.total_visits, cte4.floor as most_visited_floor, cte6.resources_used
from cte6
inner join cte1
on cte1.name = cte6.name
inner join cte4 on
cte1.name = cte4.name





