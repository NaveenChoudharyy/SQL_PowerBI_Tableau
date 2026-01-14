
use ankit_bansal_udemy;

------------------------------- Scenario Based SQL Question -------------------------------
------------------------------- Scenario Based SQL Question -------------------------------

drop table billings;
drop table HoursWorked;

create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
delete from billings;
insert into billings values
('Sachin','01-JAN-1990',25)
,('Sehwag' ,'01-JAN-1989', 15)
,('Dhoni' ,'01-JAN-1989', 20)
,('Sachin' ,'05-Feb-1991', 30)
;

create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values
('Sachin', '01-JUL-1990' ,3)
,('Sachin', '01-AUG-1990', 5)
,('Sehwag','01-JUL-1990', 2)
,('Sachin','01-JUL-1991', 4);


/*
Total charges as per billing rate
*/


--------------------------------------- Solution ---------------------------------------

select * from billings;
select * from HoursWorked;




with cte1 as (
select *, 
coalesce(lead(bill_date, 1) over(partition by emp_name order by bill_date), '2027-01-31') as last_bill_date 
from billings as b
)
select c.emp_name, sum(h.bill_hrs * c.bill_rate) as totalcharges from cte1 as c
inner join HoursWorked as h
on h.emp_name = c.emp_name and h.work_date between c.bill_date and c.last_bill_date
group by c.emp_name;
