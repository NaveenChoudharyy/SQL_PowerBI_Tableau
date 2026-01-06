
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


---------------------------------------- Solution ----------------------------------------


with cte as (
		select s.spend_date, 
		max(s.platform) as [platform], sum(s.amount) as amount,
		count(distinct s.user_id) as total_users
		from spending as s
		group by s.spend_date, s.user_id
		having count(distinct s.platform) = 1
	union all
		select s.spend_date, 
		'both' as [platform], sum(s.amount) as amount,
		count(distinct s.user_id) as total_users
		from spending as s
		group by s.spend_date, s.user_id
		having count(distinct s.platform) > 1
	union all
		select distinct s.spend_date, 'both' as [platform], 0 as amount, null as total_users 
		from spending as s)
select spend_date, [platform], sum(amount) as total_amount, count(distinct total_users) as total_users 
from cte 
group by spend_date, [platform] 
order by spend_date, [platform] desc