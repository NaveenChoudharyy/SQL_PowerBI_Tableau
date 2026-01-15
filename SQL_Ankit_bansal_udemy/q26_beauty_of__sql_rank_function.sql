
use ankit_bansal_udemy;

------------------------------- Beauty of SQL RANK Function -------------------------------
------------------------------- Beauty of SQL RANK Function -------------------------------

drop table covid;

create table covid(city varchar(50),days date,cases int);
delete from covid;
insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);

insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);

insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);

insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400);

/*
Find cities where the covid cases are increasing continously
*/

select * from covid;


--------------------------------------- My Solution ---------------------------------------


with cte1 as(
	select c.city, 
	c.cases -  coalesce(lag(c.cases) over(partition by c.city order by c.days), 0) as diff 
	from covid as c
)
select distinct city 
from covid 
where city not in (select city from cte1 where diff <= 0);


--------------------------------------- Solution-2 ---------------------------------------


with cte1 as (
	select * 
		, rank() over (partition by city order by days) - rank() over (partition by city order by cases) as diff
	from covid
) 
select city 
from cte1
group by city
having count(distinct diff) = 1 and avg(diff) = 0;
