
use ankit_bansal_udemy;

-------------------------------Data science sql interview question-------------------------------
-------------------------------Data science sql interview question-------------------------------


drop table orders;
drop table products;

create table orders
(
order_id int,
customer_id int,
product_id int,
);

insert into orders VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');



-- Recommendation system based on  -  product pairs most commonly purchased togather.

select * from orders;
select * from products;

------------------------------------ Solution 1 ------------------------------------

with c1 as (
select o1.order_id,
o1.product_id as product_id_1, o2.product_id as product_id_2
from orders as o1
inner join orders o2
on o1.order_id = o2.order_id
where o1.product_id <> o2.product_id and o1.product_id > o2.product_id ),
c2 as (
select c1.order_id, p1.name + ' ' + p2.name as pair
from c1 left join products as p1
on p1.id = c1.product_id_1
left join products as p2
on p2.id = c1.product_id_2),
c3 as (
select c2.pair, count(*) as purchase_freq from c2
group by c2.pair)
select * from c3;


------------------------------------ Solution 2 ------------------------------------


select pr1.name + ' ' + pr2.name as pair, count(1) as purchase_freq 
from orders o1 
inner join orders o2 
on o1.order_id = o2.order_id 
inner join products pr1 
on pr1.id = o1.product_id 
inner join products pr2 
on pr2.id = o2.product_id 
where o1.product_id < o2.product_id 
group by pr1.name, pr2.name;

