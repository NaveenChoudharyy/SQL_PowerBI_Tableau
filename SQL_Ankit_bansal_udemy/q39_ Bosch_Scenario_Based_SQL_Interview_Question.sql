
use ankit_bansal_udemy;

-------------------------------    Bosch Scenario Based SQL Interview Question -------------------------------
-------------------------------    Bosch Scenario Based SQL Interview Question -------------------------------

drop table call_details;

create table call_details  (
call_type varchar(10),
call_number varchar(12),
call_duration int
);

insert into call_details
values ('OUT','181868',13),('OUT','2159010',8)
,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);



/*
Write a sql to determine phone numbers that satisfy below conditions:
1- the numbers have both incoming and outgoing calls
2- the sum of duration of outgoing calls should be greater than sum of duration of incoming calls.
*/

select * from call_details;

--------------------------------------- My Solution-1 ---------------------------------------






with cte1 as (
	select 
	call_type, call_number, 
	sum(call_duration) as call_duration 
	from call_details
	where call_type = 'OUT'
	group by call_type, call_number
), cte2 as (
	select 
	call_type, call_number, 
	sum(call_duration) as call_duration 
	from call_details
	where call_type = 'INC'
	group by call_type, call_number
)
	select c1.call_number 
	from cte1 as c1
	inner join cte2 as c2
	on c1.call_duration > c2.call_duration and 
		c1.call_type != c2.call_type and 
			c1.call_number = c2.call_number;
