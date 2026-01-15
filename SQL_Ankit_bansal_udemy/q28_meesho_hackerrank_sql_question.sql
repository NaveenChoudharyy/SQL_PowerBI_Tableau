
use ankit_bansal_udemy;

------------------------------- Meesho HackerRank SQL Question -------------------------------
------------------------------- Meesho HackerRank SQL Question -------------------------------

drop table products;
drop table customer_budget

create table products
(
product_id varchar(20) ,
cost int
);
insert into products values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget
(
customer_id int,
budget int
);

insert into customer_budget values (100,400),(200,800),(300,1500);


/*
Find how many products falls into customer budget along with list of products
In case of clash choose the lest cosly product
*/

select * from products;
select * from customer_budget;


--------------------------------------- My Solution ---------------------------------------


with cte1 as (
select * from customer_budget as c
left join products as p
on p.cost <= budget
), cte2 as (
select *,
sum(cost) over(partition by customer_id order by customer_id, cost) as running_total
from cte1)
, cte3 as (
select * from cte2
where running_total <= budget
)
select customer_id, budget, count(1) as no_of_products,  
STRING_AGG(product_id, ', ') WITHIN GROUP (order by customer_id, cost) as list_of_products
from cte3
group by customer_id, budget







