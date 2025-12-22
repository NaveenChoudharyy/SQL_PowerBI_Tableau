
use ankit_bansal_udemy;


-----------------How to Make Most out of this course------------
-----------------ICC Points Table-------------------------------

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;


with cte as (
select t2.Team_1, t2.matches_played, i3.Winner from (
select t1.Team_1, 
count(t1.Team_1) as matches_played from (
select i1.Team_1, i1.Team_2, i1.Winner from icc_world_cup as i1
union all
select i1.Team_2, i1.Team_1, i1.Winner from icc_world_cup as i1) as t1
group by t1.Team_1) as t2
left join icc_world_cup as i3
on i3.Winner = t2.Team_1)
select 
cte.Team_1, cte.matches_played, count(cte.Winner) as no_of_wins,
cte.matches_played - count(cte.Winner) as no_of_losses
from cte
group by cte.Team_1, cte.matches_played

