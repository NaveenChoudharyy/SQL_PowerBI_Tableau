
use ankit_bansal_udemy;

--------------New and Repeat Customers--------------
--------------New and Repeat Customers--------------



create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

select * from customer_orders;


with cte as (
select *,
row_number() over(partition by c1.customer_id order by c1.order_date ) as rn
from customer_orders as c1)
select cte.order_date, 
sum(case when cte.rn = 1 then 1 else 0 end) as new_cust_count,
count(rn) - sum(case when cte.rn = 1 then 1 else 0 end) as repeat_cust_count,
sum(case when cte.rn = 1 then cte.order_amount else 0 end) as new_cust_count_amt,
sum(case when cte.rn <> 1 then cte.order_amount else 0 end) as repeat_cust_count_amt
from cte
group by cte.order_date;


