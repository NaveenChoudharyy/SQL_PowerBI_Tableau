
use ankit_bansal_udemy;

------------------------------- Customer Retention and Churn Analysis part-2 -------------------------------
------------------------------- Customer Retention and Churn Analysis part-2 -------------------------------


drop table transactions;

create table transactions(
order_id int,
cust_id int,
order_date date,
amount int
);
delete from transactions;
insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150);


/*
# Customer retrntion

Customer retrntion refers to a company's ability to turn customers into repeat buyers and prevent them from
switiching to a competitor. It indicates weather your product and the quality of your service please your existing customers.

     reward programs (cc companies)
     wallet cashback (paytm/gpay)
     zomato pro/swiggy super
*/




-------------------------------------- Solution --------------------------------------


select * from transactions;


--------1
with cte1 as (
select distinct cust_id, year(order_date) as this_year, month(order_date) as this_month, 
lag(year(order_date)) over(partition by cust_id order by year(order_date)) as next_year,
lag(month(order_date)) over(partition by cust_id order by month(order_date)) as next_month
from transactions as t ),
cte2 as (
select this_year, this_month,
sum(case when this_year = next_year and this_month=  next_month + 1 then 1 else 0 end) as cust_retained 
from cte1
group by this_year, this_month)
select * from cte2;





--------2
with cte as (
select distinct t.cust_id, t.order_date from transactions as t),
cte1 as (
select t.order_date, 
lag(t.order_date) over(partition by t.cust_id order by t.order_date asc) as next_month 
from cte as t ),
cte2 as (
select year(order_date) as this_year, month(order_date) as this_month,
case when datediff(month, next_month, order_date) = 1 then 1 else 0 end as flag
from cte1 ),
cte3 as (
select this_year, this_month, sum(flag) as cust_retained from cte2
group by this_year, this_month)
select * from cte3
order by this_year asc, this_month asc;
