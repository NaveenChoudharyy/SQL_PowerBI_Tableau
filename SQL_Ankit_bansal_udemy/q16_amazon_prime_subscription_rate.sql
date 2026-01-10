
use ankit_bansal_udemy;

-------------------------------Amazon Prime Subscription Rate-------------------------------
-------------------------------Amazon Prime Subscription Rate-------------------------------

drop table users;
drop table events;

create table users
(
user_id integer,
name varchar(20),
join_date date
);
insert into users
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'P', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'P', CAST('3-16-20' AS date)), 
(3, 'P', CAST('3-22-20' AS date));



/*
Prime subscription rate by product action
Given the following two tables, return the fraction of users, rounded to two decimal places,
who accessed Amazon music and upgraded to prime membersip whithin the first 30 days of signing up.
*/

------------------------------------- Solution -------------------------------------

select * from users;
select * from events;






with music as (
select * from events
where type = 'Music' ),
prime as (
select * from events
where type = 'P' ),
cte3 as (
select prime.user_id, prime.type, prime.access_date 
from music inner join prime on prime.user_id = music.user_id),
cte4 as (
select count(*)*1.0 as cnt from cte3 as c inner join users as u 
on u.user_id = c.user_id 
where c.access_date  between u.join_date and dateadd(day, 30, u.join_date) ),
cte5 as (
select count(*)*1.0 as tot_cnt from events
where type = 'Music' )
select cte4.cnt/cte5.tot_cnt as frac from cte5
inner join cte4 on 1=1