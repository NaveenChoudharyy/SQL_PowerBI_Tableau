
use ankit_bansal_udemy;

------------------------------- Customer Retention and Churn Analysis part-1 -------------------------------
------------------------------- Customer Retention and Churn Analysis part-1 -------------------------------


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

#Customer churn

Customer churn refers to the loss of customers when they stop using a product or service or switch to a competitor.
It indicates dissatisfaction with the product, service quality, or pricing.

     subscription cancellation (Netflix / Hotstar)
     users uninstalling or becoming inactive
     switching wallets (Paytm → GPay)    
*/




-------------------------------------- Solution --------------------------------------


select * from transactions;




with cte1 as (
select cust_id, order_date, 
row_number() over(partition by cust_id, month(order_date) order by order_date) as rn 
from transactions ),
cte2 as (
select * from cte1
where rn = 1 ),
cte3 as (
select year(c1.order_date) as this_yr, month(c1.order_date) as this_mn, 
year(c2.order_date) as next_yr, month(c2.order_date) as next_mn
from cte2 as c1
left join  cte2 as c2
on c1.cust_id = c2.cust_id and datediff(month, c2.order_date, c1.order_date) = 1),
cte4 as (
select this_yr, this_mn, count(*) - count(next_mn) as churn,
row_number() over(order by this_yr asc, this_mn asc) as rn2
from cte3
group by this_yr, this_mn )
select this_yr, this_mn, churn from cte4
where rn2 != 1;
