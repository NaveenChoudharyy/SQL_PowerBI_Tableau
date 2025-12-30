
use ankit_bansal_udemy;


-------------------------------Trips and Users-------------------------------
-------------------------------Trips and Users-------------------------------


drop table Trips;
drop table Users;

Create table  Trips (id int, client_id int, driver_id int, city_id int, status varchar(50), request_at varchar(50));

Create table Users (users_id int, banned varchar(50), role varchar(50));

insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');


insert into Users (users_id, banned, role) values ('1', 'No', 'client');
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client');
insert into Users (users_id, banned, role) values ('3', 'No', 'client');
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver');


/*
Write a sql query to find the calculation rate of requests with unbanned users
(both client and driver must not be banned) each day between '2013-10-01' and '2013-10-03'
Round cancellation rate to two decimal points.

The cancellation rate is computed by dividing the number of the cancelled (by client or driver)
requests with unbanned users by the total number of requests with unbanned users on that day.
*/


select * from Trips;
select * from Users;


-- Solution 1
select tab2.request_at, 
sum(tab2.is_cancelled) as cancelled_trip_count,
count(tab2.is_cancelled) as total_trips,
100*sum(tab2.is_cancelled)/(1.0*count(tab2.is_cancelled)) as cancelled_percent
from 
(select tab1.request_at,
case when tab1.status = 'cancelled_by_driver' or tab1.status = 'cancelled_by_client' then 1 else 0 end as is_cancelled
from 
(select * from Trips as t
where t.request_at between '2013-10-01' and '2013-10-03' and
t.client_id not in (select u.users_id from Users as u where u.banned = 'Yes') and
t.driver_id not in (select u.users_id from Users as u where u.banned = 'Yes') )
as tab1) as tab2
group by tab2.request_at



-- Solution 2 (not including cancelled_trip_count and total_trips)
with cte as (
select t.request_at,
case when t.status = 'cancelled_by_client' or t.status = 'cancelled_by_driver' then 1 else 0 end as is_cancelled
from Trips as t
inner join Users as u1
on u1.users_id = t.client_id
inner join Users as u2
on u2.users_id = t.driver_id
where u1.banned = 'No' and u2.banned = 'No'
and t.request_at between '2013-10-01' and '2013-10-03')
select request_at, sum(is_cancelled)/(1.0*count(is_cancelled)) as cancelled_percent 
from cte
group by request_at
--order by cancelled_percent asc




