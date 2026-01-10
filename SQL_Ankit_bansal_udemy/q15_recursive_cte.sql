
use ankit_bansal_udemy;

-------------------------------Recursive cte-------------------------------

-- Example of recursive cte for sql server

WITH nums AS (
    -- Anchor member
    SELECT 1 AS n

    UNION ALL

    -- Recursive member
    SELECT n + 1
    FROM nums
    WHERE n < 5
)
SELECT n
FROM nums;


-- Example of recursive cte for mysql
/*
WITH RECURSIVE nums AS (
    -- Anchor member
    SELECT 1 AS n

    UNION ALL

    -- Recursive member
    SELECT n + 1
    FROM nums
    WHERE n < 5
)
SELECT *
FROM nums;
*/

-------------------------------Recursive cte-------------------------------

drop table sales;
create table sales ( product_id int, period_start date, period_end date, average_daily_sales int ); 
insert into sales values
(1,'2019-01-25','2019-02-28',100),
(2,'2018-12-01','2020-01-01',10),
(3,'2019-12-01','2020-01-31',1);


-------------------------------------- Solution --------------------------------------

select * from sales;



with r_cte as (
select min(s.period_start) as min_dte, max(s.period_end) as max_dte from sales as s

union all

select dateadd(day, 1, min_dte) , max_dte from r_cte as s
where dateadd(day, 1, min_dte) <= max_dte )

select s.product_id as product_id, 
year(min_dte) as report_year, 
sum(s.average_daily_sales) as total_amount 
from r_cte
left join sales as s
on r_cte.min_dte between s.period_start and s.period_end
group by s.product_id, year(min_dte)
order by s.product_id, year(min_dte)

option (maxrecursion 1000);