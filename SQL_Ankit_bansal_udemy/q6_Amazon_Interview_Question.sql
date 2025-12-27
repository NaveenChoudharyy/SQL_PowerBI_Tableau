
use ankit_bansal_udemy;


-----------------Amazon Interview Question-------------------------------
-----------------Amazon Interview Question-------------------------------

/*
Write a query to provide the date for nth occurrence of sunday in future from given date.
datepart
sunday-1
monday-2
friday-6
saturday-7
*/



select datename(weekday, getdate()) as dte;


SELECT DATEADD(
           day,
           ( (7 + 1 - DATEPART(weekday, '2025-01-10')) % 7 )
           + ((3 - 1) * 7),
           '2025-01-10'
       );

