
use ankit_bansal_udemy;

------------------------------- Data Analyst Case Study -------------------------------
------------------------------- Data Analyst Case Study -------------------------------

drop table booking_table;
drop table user_table;


CREATE TABLE booking_table(
   Booking_id       VARCHAR(3) NOT NULL 
  ,Booking_date     date NOT NULL
  ,User_id          VARCHAR(2) NOT NULL
  ,Line_of_business VARCHAR(6) NOT NULL
);
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b1','2022-03-23','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b2','2022-03-27','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b3','2022-03-28','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b4','2022-03-31','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b5','2022-04-02','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b6','2022-04-02','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b7','2022-04-06','u5','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b8','2022-04-06','u6','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b9','2022-04-06','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b10','2022-04-10','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b11','2022-04-12','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b12','2022-04-16','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b13','2022-04-19','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b14','2022-04-20','u5','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b15','2022-04-22','u6','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b16','2022-04-26','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b17','2022-04-28','u2','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b18','2022-04-30','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b19','2022-05-04','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b20','2022-05-06','u1','Flight');
;
CREATE TABLE user_table(
   User_id VARCHAR(3) NOT NULL
  ,Segment VARCHAR(2) NOT NULL
);
INSERT INTO user_table(User_id,Segment) VALUES ('u1','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u2','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u3','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u4','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u5','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u6','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u7','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u8','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u9','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u10','s3');

/*
Q1> Write an sql query that gives the below output Output: Summary at segment level
	Segment		Total_user_count	User_who_booked_flight_in_apr2022
	s1			3					2
	s2			2					2
	s3			5					1


Q2> Write a query to identify users whose first booking was a hotel booking

Q3> write a query to calculate the days between first and last booking of each user

Q4> write a query to count the number of flight and hotel bookings in each of the user segments 
for the year 2022 segment no_of_flights booking no_of_hotel_booking 2022.

*/


select * from booking_table;
select * from user_table;

--------------------------------------- My Solution-1 ---------------------------------------

--Q1> Write an sql query that gives the below output Output: Summary at segment level
--	Segment		Total_user_count	User_who_booked_flight_in_apr2022
--	s1			3					2
--	s2			2					2
--	s3			5					1

with cte1 as(
select 
u.Segment, count(distinct u.User_id) as Total_user_count
from user_table as u
left join booking_table as b
on u.User_id = b.User_id 
group by u.Segment
), cte2 as (
select 
u.Segment, count(distinct b.User_id) as User_who_booked_flight_in_apr2022
from user_table as u
left join booking_table as b
on u.User_id = b.User_id 
where b.Line_of_business = 'Flight'
group by u.Segment
)
select 
cte1.Segment, cte1.Total_user_count, cte2.User_who_booked_flight_in_apr2022 
from cte2
inner join cte1 
on cte1.Segment = cte2.Segment;


--------------------------------------- My Solution-2 ---------------------------------------

-- Q2> Write a query to identify users whose first booking was a hotel booking

with cte as (
select *,
row_number() over(partition by user_id order by booking_date) as rn
from booking_table)
select * from cte where rn = 1 and Line_of_business = 'Hotel';


--------------------------------------- My Solution-3 ---------------------------------------

-- Q3> write a query to calculate the days between first and last booking of each user


select user_id, datediff(day, min(Booking_date) , max(Booking_date)) as max_day
from booking_table as b
group by user_id;


--------------------------------------- My Solution-4 ---------------------------------------

-- Q4> write a query to count the number of flight and hotel bookings in each of the user segments 
-- for the year 2022 segment no_of_flights booking no_of_hotel_booking 2022.

with cte as (
	select 
	u.Segment, 
	case when b.Line_of_business = 'Flight' then 1 else 0 end as flag_1,
	case when b.Line_of_business = 'Hotel' then 1 else 0 end as flag_2
	from booking_table as b
	right join user_table as u
	on u.User_id = b.User_id and year(b.Booking_date) =  2022
)
select Segment, sum(flag_1) as no_of_flights, sum(flag_2) as no_of_hotel_booking
from cte
group by Segment;

