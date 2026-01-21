
use ankit_bansal_udemy;

------------------------------- Walmart Labs SQL Interview Question -------------------------------
------------------------------- Walmart Labs SQL Interview Question -------------------------------

drop table phonelog;

create table phonelog(
    callerid int, 
    recipientid int,
    datecalled datetime
);

insert into phonelog(callerid, recipientid, datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');


/*
There is a phonelog table that has information about caller's call history.
Write a sql query to find out callers first and last call was to the same person on a given day.
*/

select * from phonelog;


--------------------------------------- My Solution-1 ---------------------------------------


with cte1 as (
    select callerid, recipientid,
    cast(datecalled as date) as dt, 
    cast(datecalled as time) as tm
    from phonelog
), cte2 as (
    select *,
    row_number() over(partition by callerid, dt order by dt, tm) as rn,
    count(*) over(partition by callerid, dt ) as cnt
    from cte1
), cte3 as (
    select *,
    lag(recipientid,1 ) over(partition by callerid, dt order by dt, tm) as lg
    from cte2
    where rn = cnt or rn = 1
)
    select callerid as Callerid,
    dt as called_date,
    recipientid as Recipientid
    from cte3
    where lg = recipientid



--------------------------------------- My Solution-2 (fastest) ---------------------------------------


with cte1 as (
    select callerid, recipientid,
    cast(datecalled as date) as dt, 
    cast(datecalled as time) as tm
    from phonelog
), cte2 as (
    select *,
    LAST_VALUE(recipientid) over(partition by callerid, dt order by dt, tm 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as lv,
    row_number() over(partition by callerid, dt order by dt, tm) as rn
    from cte1
)
    select callerid ,dt, recipientid
    from cte2
    where rn = 1 and lv = recipientid;


    
--------------------------------------- My Solution-3 ---------------------------------------


with cte1 as (
    select p1.callerid, cast(p1.datecalled as date) as dt,
    min(p1.datecalled) as min_dt,
    max(p1.datecalled) as max_dt
    from phonelog as p1
    group by p1.callerid, cast(p1.datecalled as date) 
), cte2 as (
    select c.callerid, c.dt, c.min_dt, c.max_dt,
    p1.recipientid as f_rec, p2.recipientid as s_rec
    from cte1 as c
    left join phonelog as p1 
    on p1.datecalled = c.max_dt and c.callerid = p1.callerid
    left join phonelog as p2
    on p2.datecalled = c.min_dt and c.callerid = p2.callerid
)
    select callerid, dt, f_rec as recipientid 
    from cte2
    where f_rec = s_rec;

