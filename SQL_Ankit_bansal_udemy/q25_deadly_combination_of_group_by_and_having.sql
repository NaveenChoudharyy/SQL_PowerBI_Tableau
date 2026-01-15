
use ankit_bansal_udemy;

------------------------------- Deadly Combination of Group By and Having -------------------------------
------------------------------- Deadly Combination of Group By and Having -------------------------------

drop table exams;

create table exams (student_id int, subject varchar(20), marks int);
delete from exams;
insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);

/*
Find students with same marks in physics and chemistry.
*/

select * from exams;

---------------------------------------- My Solution ----------------------------------------


select distinct e1.student_id
from exams as e1, exams e2
where e1.student_id = e2.student_id 
		and e1.subject <> e2.subject 
		and e2.marks = e1.marks
		and e1.subject in ('Chemistry', 'Physics');


---------------------------------------- My Solution-2 ----------------------------------------

select student_id
from exams
where subject in ('Chemistry', 'Physics')
group by student_id
having count(distinct subject) = 2 and count(distinct marks) = 1
