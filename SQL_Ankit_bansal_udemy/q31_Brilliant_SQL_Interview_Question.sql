
use ankit_bansal_udemy;

------------------------------- Brilliant SQL Interview Question -------------------------------
------------------------------- Brilliant SQL Interview Question -------------------------------

drop table int_orders;

CREATE TABLE [dbo].[int_orders](
 [order_number] [int] NOT NULL,
 [order_date] [date] NOT NULL,
 [cust_id] [int] NOT NULL,
 [salesperson_id] [int] NOT NULL,
 [amount] [float] NOT NULL
) ON [PRIMARY];

INSERT INTO [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (30, CAST('1995-07-14' AS Date), 9, 1, 460);

INSERT into [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (10, CAST('1996-08-02' AS Date), 4, 2, 540);

INSERT INTO [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (40, CAST('1998-01-29' AS Date), 7, 2, 2400);

INSERT INTO [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (50, CAST('1998-02-03' AS Date), 6, 7, 600);

INSERT into [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (60, CAST('1998-03-02' AS Date), 6, 7, 720);

INSERT into [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (70, CAST('1998-05-06' AS Date), 9, 7, 150);

INSERT into [dbo].[int_orders] ([order_number], [order_date], [cust_id], [salesperson_id], [amount]) VALUES (20, CAST('1999-01-30' AS Date), 4, 8, 1800);



/*
Find the largest order by value for each salesperson and display order details
Get the result without any subquery, cte, window functions, temp tables
*/

select * from int_orders;


--------------------------------------- My Solution-1 ---------------------------------------


select 
min(order_number) as order_number
, min(order_date) as order_date, 
min(cust_id) as cust_id, 
salesperson_id
, max(amount) as amount 
from int_orders
group by salesperson_id;

--------------------------------------- My Solution-2 ---------------------------------------


select 
a1.order_number, a1.order_date, a1.cust_id, a1.salesperson_id, a1.amount
from int_orders as a1
left join int_orders as a2
on a1.salesperson_id = a2.salesperson_id
group by a1.order_number, a1.order_date, a1.cust_id, a1.salesperson_id, a1.amount
having a1.amount >= max(a2.amount);