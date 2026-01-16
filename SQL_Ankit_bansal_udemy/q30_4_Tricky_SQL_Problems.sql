
use ankit_bansal_udemy;

------------------------------- 4 Tricky SQL Problems -------------------------------
------------------------------- 4 Tricky SQL Problems -------------------------------

drop table [students];

CREATE TABLE [students](
 [studentid] [int] NULL,
 [studentname] [nvarchar](255) NULL,
 [subject] [nvarchar](255) NULL,
 [marks] [int] NULL,
 [testid] [int] NULL,
 [testdate] [date] NULL
)
data:
insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');


/*
Sql set with 4 medium to high complexity problems
*/

select * from [students];


--Q1-- Write an sql query to get the list of students who scored above the average marks.

--------------------------------------- My Solution-1 ---------------------------------------


with cte as (
	select 
	subject, avg(1.0*marks) as avg_marks 
	from students
	group by subject
) 
select * from cte as c 
inner join students as s
on c.subject = s.subject
where c.avg_marks < s.marks;


--Q2-- Write an sql query to get the percentage of students who score more then 90 in any subject amongest the total students.

--------------------------------------- My Solution-2 ---------------------------------------


with cte as (
	select count(1) as cnt 
	from (
		select studentid 
		from students
		group by studentid
		having max(marks) > 90) as t1 
) 
select 
(select 100.0*cnt from cte)/count(distinct studentid) as perc
from students;

/*

Q3-- Write an sql query to get the second highest and second lowest marks for each subject.

subject		second_highest_marks		second_lowest_marks
subject1		91							63
subject2		71							60
subject3		29							98

*/
--------------------------------------- My Solution-3 ---------------------------------------

with cte as (
	select subject, marks
	, row_number() over(partition by subject order by marks) as marks_asc
	, row_number() over(partition by subject order by marks desc) as marks_desc
	from students
)
select 
subject
, sum(case when marks_desc = 2 then marks else 0 end) as second_highest_marks
, sum(case when marks_asc = 2 then marks else 0 end) as second_lowest_marks
from cte
group by subject;

--Q4-- For each student and test, identify if their marks increased or decreased from the previous test.

--------------------------------------- My Solution-4 ---------------------------------------


with cte as (
	select *
	, case when marks > lag(marks) over(partition by studentid order by studentid, testdate) then 1 else 0 end as lag_marks 
	, case when testdate > lag(testdate) over(partition by studentid order by studentid, testdate) then 1 else 0 end as lag_testdate 
	from students
)
select *
, case when (lag_marks = 0 and lag_testdate = 0) or (lag_marks = 1 and lag_testdate = 0) 
		then 'NA' else (case when lag_marks = 0 and lag_testdate = 1 then 'dec' else 'inc' end) end as status
from cte;
