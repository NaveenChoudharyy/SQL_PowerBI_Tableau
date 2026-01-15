
use ankit_bansal_udemy;

------------------------------- Google SQL Interview Question -------------------------------
------------------------------- Google SQL Interview Question -------------------------------

drop table company_users;

create table company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');


/*
Find companies who have atleast 2 users who speak english and german both the languages
*/

select * from company_users;


--------------------------------------- My Solution ---------------------------------------

with cte as (
	select c.company_id, c.user_id from company_users as c
	where language in ('English', 'German')
	group  by c.company_id, c.user_id 
	having count(1) = 2
)
select company_id from cte
group by company_id 
having count(1) > 1;

--------------------------------------- Solution-2 ---------------------------------------


select company_id, count(1) from
(
select 
company_id, user_id
from company_users
where language in ('English', 'German')
group by company_id, user_id
having count(1) = 2)
a
group by company_id 
having count(1) >= 2;
