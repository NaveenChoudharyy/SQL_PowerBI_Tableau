
use ankit_bansal_udemy;

------------------------------- Missing Quarter Using 3 Methods -------------------------------
------------------------------- Missing Quarter Using 3 Methods -------------------------------

drop table STORES;

CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);


/*
For each store find the missing quarter.
*/


select * from STORES;


---------------------------------------- My Solution ----------------------------------------

with cte1 as (
select distinct Store as store1, Quarter as qtr1 from STORES
), cte2 as (
select distinct Quarter as qtr2 from STORES
), cte3 as (
select distinct Store as store2 from STORES
), cte4 as (
select c3.store2 as store4, c2.qtr2 as qtr4 from cte2 as c2
cross join cte3 as c3)
select * from cte4
except
select * from cte1;


---------------------------------------- Better - MySolution-2 ----------------------------------------


with cte1 as (
		select distinct s1.Store, S2.Quarter 
		from STORES s1, STORES S2
), cte2 as (
		select distinct Store, Quarter 
		from STORES
) 
select Store as store, Quarter from cte1 
except 
select * from cte2;
