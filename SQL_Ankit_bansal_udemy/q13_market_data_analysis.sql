
use ankit_bansal_udemy;

-------------------------------Market Data Analysis-------------------------------
-------------------------------Market Data Analysis-------------------------------


drop table users;
drop table items;
drop table orders;


create table users (
user_id         int     ,
join_date       date    ,
favorite_brand  varchar(50));

create table orders (
order_id       int     ,
order_date     date    ,
item_id        int     ,
buyer_id       int     ,
seller_id      int 
);

create table items
(
item_id        int     ,
item_brand     varchar(50)
);


insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);




/*
MARKET ANALYSIS: Write an sql query to find for each seller, weather the brand of the second item (by date) they sold is their 
favorite brand. If a seller sold less then two items, report the answer for that seller as no. o/p

seller_id		2nd_item_fav_brand
1				yes/no
2				yes/no

*/

-------------------------------Solution-------------------------------

Select * from users;
Select * from items;
Select * from orders;


---- My solution : 1
with cte1 as (
	Select o.seller_id,
	case when i.item_brand = u.favorite_brand then 'YES' else 'NO' end as item_fav_brand,
	row_number() over(partition by o.seller_id order by o.order_date) as rn
	from orders as o
	left join items as i
	on i.item_id = o.item_id
	left join users as u
	on u.user_id = o.seller_id ),
cte2 as (
	select seller_id, item_fav_brand from cte1 
	where rn = 2),
cte3 as (
	select user_id, 'no' as item_fav_brand from users ),
cte4 as (
	select * from cte2
	union all
	select * from cte3 ),
cte5 as (
	select top (select count(*) from users) * from cte4 )
select * from cte5
order by seller_id;


---- My solution : 2
with cte1 as (
	select *, 
	row_number() over(partition by o.seller_id order by o.order_date) as rn
	from orders as o ),
cte2 as (
	select u.user_id, coalesce(rn, 2) as rn,
	case when i.item_brand = u.favorite_brand then 'YES' else 'NO' end as item_fav_brand
	from cte1
	left join items as i
	on i.item_id = cte1.item_id
	right join users as u
	on u.user_id = cte1.seller_id )
select user_id, item_fav_brand from cte2
where rn = 2


---- My solution : 3
with cte1 as (
	select *, 
	row_number() over(partition by o.seller_id order by o.order_date) as rn
	from orders as o )
select u.user_id,
case when i.item_brand = u.favorite_brand then 'YES' else 'NO' end as item_fav_brand
from cte1
left join items as i
on i.item_id = cte1.item_id
right join users as u
on u.user_id = cte1.seller_id and rn=2


---- My solution : 4
with cte1 as (
	select *, 
	row_number() over(partition by o.seller_id order by o.order_date) as rn
	from orders as o )
select u.user_id,
case when i.item_brand = u.favorite_brand then 'YES' else 'NO' end as item_fav_brand
from cte1
left join items as i
on i.item_id = cte1.item_id
right join users as u
on u.user_id = cte1.seller_id
where rn = 2 or rn is null
