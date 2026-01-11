
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
Customer Retention and Churn matrics

# Customer retrntion
Customer retrntion refers to a company's ability to turn customers into repeat buyers and prevent them from
switiching to a competitor.
It indicates weather your product and the quality of your service please your existing customers
		reward programs (cc companies)
		wallet cashback (paytm/gpay)
		zomato pro/swiggy super

# retention period
*/




-------------------------------------- Solution --------------------------------------






select * from transactions as t;

























