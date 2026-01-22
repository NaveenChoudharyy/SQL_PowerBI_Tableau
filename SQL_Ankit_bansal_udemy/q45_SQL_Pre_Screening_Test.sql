
use ankit_bansal_udemy;

------------------------------- SQL Pre-Screening Test -------------------------------
------------------------------- SQL Pre-Screening Test -------------------------------

drop table tbl_orders;
drop table tbl_orders_copy;


create table tbl_orders (
order_id integer,
order_date date
);
insert into tbl_orders
values (1,'2022-10-21'),(2,'2022-10-22'),
(3,'2022-10-25'),(4,'2022-10-25');

select * into tbl_orders_copy from  tbl_orders;

--select * from tbl_orders;
insert into tbl_orders
values (5,'2022-10-26'),(6,'2022-10-26');
delete from tbl_orders where order_id=1;


/*
Scenario: You have a live table ORDER and a snapshot table ORDER_COPY. Both use ORDER_ID as the Primary Key.

Requirement: Write an efficient SQL query to identify the "deltas" between the two tables:

Inserts: Records present in ORDER but missing from ORDER_COPY (Flag as 'I').

Deletes: Records present in ORDER_COPY but missing from ORDER (Flag as 'D').

Output Columns: ORDER_ID, INSERT_OR_DELETE_FLAG

Constraints:

Forbidden: You cannot use UNION, UNION ALL, MINUS, or MERGE.

Allowed: You can use EXISTS, NOT EXISTS, or standard Joins.
*/


select * from tbl_orders;
select * from tbl_orders_copy;


--------------------------------------- My Solution-1 ---------------------------------------


with cte1 as (
	select order_id,  
	'I' as flag
	from tbl_orders o1
	where not exists (select 1 from tbl_orders_copy o2 where o1.order_id = o2.order_id)
), cte2 as (
	select order_id, 
	'D' as flag
	from tbl_orders_copy o1
	where not exists (select 1 from tbl_orders o2 where o1.order_id = o2.order_id)
)
	select 
	coalesce(cte1.order_id, cte2.order_id) as order_id, 
	coalesce(cte1.flag, cte2.flag) as flag
	from cte1
	full outer join cte2 
	on cte2.order_id = cte1.order_id;

