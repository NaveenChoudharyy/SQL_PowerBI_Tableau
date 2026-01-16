
use ankit_bansal_udemy;

------------------------------- Horizontal Sorting in SQL -------------------------------
------------------------------- Horizontal Sorting in SQL -------------------------------

drop table subscriber;

CREATE TABLE subscriber (
 sms_date date ,
 sender varchar(20) ,
 receiver varchar(20) ,
 sms_no int
);
-- insert some values
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Vibhor',10);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Avinash', 'Pawan',30);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Avinash',20);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Pawan',5);
INSERT INTO subscriber VALUES ('2020-4-1', 'Pawan', 'Vibhor',8);
INSERT INTO subscriber VALUES ('2020-4-1', 'Vibhor', 'Deepak',50);

/*
Amazon sql intervew question for BIE position
Find total number of messages exchanged between each person per day
*/

select * from subscriber;


--------------------------------------- My Solution ---------------------------------------

with cte as (
	select sms_date,
	case when sender > receiver then sender else receiver end p1,
	case when sender < receiver then sender else receiver end p2,
	sms_no
	from subscriber
)
select sms_date, p1, p2, sum(sms_no) as total_sms
from cte
group by sms_date, p1, p2;
