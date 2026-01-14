
use ankit_bansal_udemy;

------------------------------- Spotify Case Study -------------------------------
------------------------------- Spotify Case Study -------------------------------

drop table activity;

CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');


/*
the activity table shows the app-installed and app purchase activities for spotify app along with country details.
*/

select * from activity;

/*
Question 1: Find total active users each day

event_date	total_active_users
2022-01-01	3
2022-01-02	1
2022-01-03	3
2022-01-04	1
*/
--------------------------------------- Solution ---------------------------------------


select a.event_date, count(distinct a.user_id) as total_active_users from activity as a
group by a.event_date;



/*
Question 2: Find total active users each week

week_number	total_active_users
1			3
2			5
*/
--------------------------------------- Solution ---------------------------------------


select datepart(week, a.event_date) as week_number, count(distinct a.user_id) as total_active_users from activity as a
group by datepart(week, a.event_date);



/*
Question 3: Date wise total number of users who made the purchase same day they installed the app

event_date	number_of_users_same_day_purchase
2022-01-01	0
2022-01-02	0
2022-01-03	2
2022-01-04	1
*/
--------------------------------------- Solution ---------------------------------------

with cte1 as (
select a.user_id, a.event_name,a.event_date, 
lead(a.event_date, 1) over(partition by a.user_id order by a.event_date ) as lead_event_date 
from activity as a
), cte2 as (
select * from cte1 
where event_date = lead_event_date 
) select a.event_date, count(cte2.user_id) as number_of_users_same_day_purchase from activity as a
left join cte2 
on cte2.user_id = a.user_id and cte2.event_name = a.event_name
group by  a.event_date;



/*
Question 4: Percentage of paid users in india, usa and any other country should be tagged as others

country		percentage_users
India		40
USA			20
Others		40
*/
--------------------------------------- Solution ---------------------------------------


with cte1 as (
select count(*) as cnt from activity as a
where a.event_name = 'app-purchase'
), cte2 as (
select 
case when a.country <> 'India' and a.country <> 'USA' then 'others' else a.country end as country from activity as a
where a.event_name = 'app-purchase'
)
select country, 
100.0*count(country)/(select cnt from cte1) as percentage_users 
from cte2
group by country;



/*
Question 5: Among all the users who installed the app on a given day, how many did in purchased on the very next day-day wise results 

event_date		count_users
2022-01-01		0
2022-01-02		1
2022-01-03		0
2022-01-04		0
*/
--------------------------------------- Solution ---------------------------------------
--------------------------------------- This solution might not be perfact -------------



with install as (
select a.user_id, a.event_date from activity as a
where event_name = 'app-installed'
), purchase as (
select a.user_id, a.event_date from activity as a
where event_name = 'app-purchase'
), joined_table as (
select coalesce(p.event_date, i.event_date) as event_date_p, 
i.event_date as event_date_i 
from install as i
left join purchase as p
on p.user_id = i.user_id
), final_table as(
select event_date_p as event_date, 
case when datediff(day, event_date_i, event_date_p) = 1 then 1 else 0 end as flag
from joined_table)
select event_date, sum(flag) as count_users from final_table
group by event_date
order by event_date;
