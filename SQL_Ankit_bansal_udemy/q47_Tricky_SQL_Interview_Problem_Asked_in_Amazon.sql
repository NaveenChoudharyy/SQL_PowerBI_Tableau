
use ankit_bansal_udemy;

------------------------------- Tricky SQL Interview Problem Asked in Amazon -------------------------------
------------------------------- Tricky SQL Interview Problem Asked in Amazon -------------------------------

drop table purchase_history;

create table purchase_history
(userid int
,productid int
,purchasedate date
);
SET DATEFORMAT dmy;
insert into purchase_history values
(1,1,'23-01-2012')
,(1,2,'23-01-2012')
,(1,3,'25-01-2012')
,(2,1,'23-01-2012')
,(2,2,'23-01-2012')
,(2,2,'25-01-2012')
,(2,4,'25-01-2012')
,(3,4,'23-01-2012')
,(3,1,'23-01-2012')
,(4,1,'23-01-2012')
,(4,2,'25-01-2012')
;

/*
Write a query to find the users who purchased different products on different dates.
ie: products purchased on any given day are not repeated on another day. 
*/

select * from purchase_history;

--------------------------------------- My Solution-1 ---------------------------------------

select userid
from purchase_history
group by userid
having count(distinct productid) = count(productid)
		and count(distinct purchasedate) > 1;
