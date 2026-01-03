
use ankit_bansal_udemy;

-------------------------------User Purchase Platform-------------------------------
-------------------------------User Purchase Platform-------------------------------


drop table spending;
create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);


/*
User purchase platform
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop
and a mobile application.
-- Write a sql query to find the total number of users and the total amount spent using mobile only, desktop only
and both mobile and desktop togather for each date.
*/

select * from spending;






with cte1 as (
	select s.user_id, s.spend_date from spending as s
	group by s.user_id, s.spend_date
	having count(distinct s.platform) = 1 ),
cte2 as (
	select s.* from cte1
	left join spending as s
	on cte1.user_id = s.user_id and cte1.spend_date = s.spend_date),
cte3 as (
	select cte2.spend_date, cte2.platform,
	sum(cte2.amount) as total_amount,
	count( distinct cte2.user_id) as total_users from cte2
	group by cte2.spend_date, cte2.platform),
cte4 as (
	select s.* from cte1
	outer join spending as s
	on cte1.user_id = s.user_id and cte1.spend_date = s.spend_date)
select * from cte4




select s.spend_date, 'both' as [platform], 
sum(s.amount) as total_amount, 
count(distinct user_id) as total_users 
from spending as s
group by s.spend_date, [platform]
having count(distinct user_id) > 1



















