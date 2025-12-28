
use ankit_bansal_udemy;


-------------------------------Friend's score-------------------------------
-------------------------------Friend's score-------------------------------

drop table friend;
drop table person;

Create table friend (pid int, fid int);
insert into friend (pid , fid ) values ('1','2');
insert into friend (pid , fid ) values ('1','3');
insert into friend (pid , fid ) values ('2','1');
insert into friend (pid , fid ) values ('2','3');
insert into friend (pid , fid ) values ('3','5');
insert into friend (pid , fid ) values ('4','2');
insert into friend (pid , fid ) values ('4','3');
insert into friend (pid , fid ) values ('4','5');

create table person (PersonID int,	Name varchar(50),	Score int);
insert into person(PersonID,Name ,Score) values('1','Alice','88');
insert into person(PersonID,Name ,Score) values('2','Bob','11');
insert into person(PersonID,Name ,Score) values('3','Devis','27');
insert into person(PersonID,Name ,Score) values('4','Tara','45');
insert into person(PersonID,Name ,Score) values('5','Johny','63');

select * from person;
select * from friend;



-- Write a query to find the personID, Name, number of friends, sum of marks
-- of the person who have friends with total score greater than 100


select 
	t1.PersonID_t1 as personid, 
	t1.Name_t1 as name, 
	count(*) as no_of_friends, 
	sum(t2.Score) as total_friendscore
from (
	select 
		p.PersonID as PersonID_t1, 
		p.Name as Name_t1, 
		p.Score as Score_t1, 
		f.fid as fid_t1 
	from person as p
	inner join friend as f
	on f.pid = p.PersonID) as t1
inner join person as t2
on t2.PersonID = t1.fid_t1
group by t1.PersonID_t1, t1.Name_t1
having sum(t2.Score) > 100
