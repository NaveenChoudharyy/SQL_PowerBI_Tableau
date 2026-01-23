
use ankit_bansal_udemy;

------------------------------- Fintech Startup SQL Interview Question -------------------------------
------------------------------- Fintech Startup SQL Interview Question -------------------------------

drop table Trade_tbl;

Create Table Trade_tbl(
TRADE_ID varchar(20),
Trade_Timestamp time,
Trade_Stock varchar(20),
Quantity int,
Price Float
)

Insert into Trade_tbl Values('TRADE1','10:01:05','ITJunction4All',100,20)
Insert into Trade_tbl Values('TRADE2','10:01:06','ITJunction4All',20,15)
Insert into Trade_tbl Values('TRADE3','10:01:08','ITJunction4All',150,30)
Insert into Trade_tbl Values('TRADE4','10:01:09','ITJunction4All',300,32)
Insert into Trade_tbl Values('TRADE5','10:10:00','ITJunction4All',-100,19)
Insert into Trade_tbl Values('TRADE6','10:10:01','ITJunction4All',-300,19);


/*
Write a sql to find all couples of trade for same stock that happended in the range of 10 seconds 
and having price difference by more then 10%.
Output result should also list the percentage of price difference between the 2 trades.
*/

select * from Trade_tbl;

--------------------------------------- My Solution-1 ---------------------------------------


select 
t1.TRADE_ID as TRADE_ID_t1, 
t2.TRADE_ID as TRADE_ID_t2,
t1.Price as Price_t1, 
t2.Price as Price_t2,
t1.Trade_Timestamp as Trade_Timestamp_t1, 
t2.Trade_Timestamp as Trade_Timestamp_t2,
t1.Trade_Stock as Trade_Stock_t1, 
t2.Trade_Stock as Trade_Stock_t2,
abs(t1.Price-t2.Price)*100.0/t1.Price as price_diff_perc
from Trade_tbl as t1
left join Trade_tbl as t2
on datediff(second, t1.Trade_Timestamp, t2.Trade_Timestamp) <= 10 
		and t2.Trade_Timestamp > t1.Trade_Timestamp
		and t1.Trade_Stock = t2.Trade_Stock
where abs(t1.Price-t2.Price)*1.0/t1.Price > 0.1;
