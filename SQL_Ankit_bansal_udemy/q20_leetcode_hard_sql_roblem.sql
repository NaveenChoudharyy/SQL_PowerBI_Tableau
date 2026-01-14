
use ankit_bansal_udemy;

------------------------------- Leetcode Hard SQL Problem -------------------------------
------------------------------- Leetcode Hard SQL Problem -------------------------------

drop table UserActivity;

create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');


/*
Get the second most recent activity, if there is only one activity then return that one.
*/




-------------------------------------- Solution --------------------------------------


select * from UserActivity;



with cte1 as (
select *, ROW_NUMBER() over(partition by username order by endDate) as rn1 from UserActivity as u 
), cte2 as (
select * from cte1
where rn1 <= 2
), cte3 as (
select c.username, c.activity, c.startDate, c.endDate, 
ROW_NUMBER() over(partition by c.username order by rn1 desc) as rn2 from cte2 as c
)
select cte3.username, cte3.activity, cte3.startDate, cte3.endDate from cte3
where rn2 = 1 ;
