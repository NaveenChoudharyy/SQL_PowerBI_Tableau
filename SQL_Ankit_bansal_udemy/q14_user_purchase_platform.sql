
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
	select distinct spend_date from spending),
cte2 as (
	select spend_date, user_id,
	sum(amount) as total_amount 
	from spending
	group by spend_date, user_id
	having count(platform) > 1),
cte3 as (
	select cte1.spend_date, cte2.total_amount, cte2.user_id 
	from cte1 left join cte2
	on cte1.spend_date = cte2.spend_date),
cte4 as (
	select cte3.spend_date, cte3.total_amount, cte3.user_id,
	'both' as [platform]
	from cte3
	left join spending as s1
	on s1.spend_date = cte3.spend_date and s1.user_id = cte3.user_id)
select * from cte3


