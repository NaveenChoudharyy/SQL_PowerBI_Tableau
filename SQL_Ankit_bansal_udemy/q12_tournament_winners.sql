
use ankit_bansal_udemy;

-------------------------------Tournament Winners-------------------------------
-------------------------------Tournament Winners-------------------------------


--Write a sql query to to find the winner in each group.

--The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, 
--the lowest player_id wins.


drop table players;
drop table matches;

create table players
(player_id int,
group_id int)

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);


select * from matches;
select * from players;


-------------------------------Solution-------------------------------


with cte as(
select *, 
ROW_NUMBER() over(partition by group_id order by t2.sum_score desc, player_id asc) as rn 
from (
select t.player_id, p.group_id, sum(t.score) as sum_score from (
select m.first_player as player_id, m.first_score as score from matches as m
union all
select m.second_player, m.second_score from matches as m) as t
inner join players as p
on p.player_id = t.player_id
group by t.player_id, p.group_id) as t2)
select * from cte
where rn = 1;
