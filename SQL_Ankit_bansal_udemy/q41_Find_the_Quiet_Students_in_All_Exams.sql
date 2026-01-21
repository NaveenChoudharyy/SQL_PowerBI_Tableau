
use ankit_bansal_udemy;

------------------------------- Find the Quiet Students in All Exams -------------------------------
------------------------------- Find the Quiet Students in All Exams -------------------------------

drop table exams;
drop table students;

create table students
(
student_id int,
student_name varchar(20)
);
insert into students values
(1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

create table exams
(
exam_id int,
student_id int,
score int);

insert into exams values
(10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60)
,(40,2,70),(40,4,80);



/*
Write a sql quey to report the students (student_id, student_name) being "quiet" in all exams
A "quite" student is the one who took the least one exam and didn't score neither the high score 
	nor the low score in any of the exam.
Don't return the student who has never taken any exam. Return the result table orderd by student_id.
*/

select * from exams;
select * from students;

--------------------------------------- My Solution-1 ---------------------------------------

with cte1 as (
	select e.*, s.student_name,
	max(score) over(partition by e.exam_id) as score_max,
	min(score) over(partition by e.exam_id) as score_min
	from exams as e
	left join students as s
	on s.student_id = e.student_id
), cte2 as (
	select student_id, student_name,
	case when score_min < score and score < score_max then 0 else 1 end as flag 
	from cte1
)
	select student_id, student_name
	from cte2
	group by student_id, student_name
	having sum(flag) = 0;
