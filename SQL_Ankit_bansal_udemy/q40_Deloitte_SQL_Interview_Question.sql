
use ankit_bansal_udemy;

------------------------------- Deloitte SQL Interview Question -------------------------------
------------------------------- Deloitte SQL Interview Question -------------------------------

drop table brands;

create table brands 
(
category varchar(20),
brand_name varchar(20)
);
insert into brands values
('chocolates','5-star')
,(null,'dairy milk')
,(null,'perk')
,(null,'eclair')
,('Biscuits','britannia')
,(null,'good day')
,(null,'boost');



/*
Write the sql populate category value to the last not null value.
*/

select * from brands;

--------------------------------------- My Solution-1 ---------------------------------------


with cte1 as (
	select *,
	row_number() over(order by (select null)) as rn
	from brands
), cte2 as (
	select *,
	count(category) over (order by rn)  as cnt
	from cte1

)
	select 
	first_value(category) over(partition by cnt order by rn) as category,
	brand_name
	from cte2;
