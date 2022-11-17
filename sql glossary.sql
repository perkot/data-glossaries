-- !preview conn=DBI::dbConnect(RSQLite::SQLite())

/* ------------------------------------------------- /*
NAME: Personal SQL Glossary
PURPOSE : Helpful code snippets
MAPPING REF : 
CHANGE REVISION : 
DATE : 28/10/2022
AUTHOR : TOM PERKINS
/* ------------------------------------------------- */

-- =================================================
-- CREATE VOLATILE TABLE 
-- =================================================

DROP TABLE TESTTABLE;
CREATE VOLATILE TABLE TESTTABLE AS
(
  SELECT DISTINCT
     M.ID
    ,M.ACTION
    ,sum(M.TIME) AS 'TIME'
  FROM DB.TABLE AS M
  INNER JOIN DB.TABLE2 AS S
    ON M.ID = S.ID
  GROUP BY 
     M.ID
    ,M.ACTION
  )
WITH DATA PRIMARY INDEX (ID)
ON COMMIT PRESERVE ROWS
;

-- =================================================
-- IDENTIFY MY ROLES 
-- =================================================

SELECT A.* FROM DBC.ROLEMEMBERS AS A WHERE GRANTEE = "USERNAME"

-- =================================================
-- CALCULATIONS
-- =================================================

-- Calculate percentage of a column as fraction of a second column 
  ,(cast(ONE_MONTH_TOTAL AS decimal(18,4)) / cast(BASELINE_TOTAL AS decimal(18,4)))*100 AS ONE_MONTH_PERCENT
-- Minutes to days conversion expressed as a % 
  nullif(sum(D.MINUTES/1440.0),0) / sum(D.MINUTES_SINCE_CREATION/1440.0) * 100 AS PERCENT_OF_DAY
-- Calculate % total case under a condition
  ,sum(CASE WHEN GENDER = 'MALE' THEN 1 ELSE 0 END) / count(*) AS percentage_male -- % with salary > 100k ... / by count(*)
  
-- mean
avg(TIME_DAYS) AS MEAN_TIME 

-- median 
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY TIME_DAYS) AS MEDIAN_TIME

-- standard deviation
stddev_pop(TIME_DAYS) AS SD_TIME
stddev(TIME_DAYS) AS SD_TIME
-- standard deviation (manual)
SELECT
  sqrt(sum(power(((cast(TIME_DAYS AS float) - B.TOTALAVG)),2) / B.TOTALCNT)) AS SD
FROM DB.TABLE
JOIN
  (
  SELECT
     avg(cast(TIME_DAYS AS float)) AS TOTALAVG
    ,count(*) AS TOTALCNT
  FROM DB.TABLE
  ) AS B ON 1=1
;
  
-- =================================================
-- DATES
-- =================================================

-- cast to date
cast(STARTDATE AS date) >= '2017-10-01'
-- add a single leading zero to a date
,substring('0' FROM 1 FOR 10 - length(STARTDATE)) || STARTDATE AS STARTDATE
-- filter date to current date minus one
STARTDATE <= (current_date - 1)
-- week-year
,STARTDATE - ((STARTDATE - date '0001-01-01') MOD 7) AS STARTDATE_WEEKYEAR
-- month-year
,concat(cast(extract(year FROM STARTDATE) AS varchar(4)),'-'.cast(extract(month FROM STARTDATE) AS FORMAT '9(2)')) AS STARTDATE_YEARMONTH
-- month

-- =================================================
-- SUBSTRING & DATES
-- =================================================

-- remove characters from the end of a string 
,LEFT('String.PDF', char_length('String.PDF')-4) AS 'String' -- remove 4 characters 

-- add leading zeroes
,lpad('1/11/2022',8,'0') AS '01/11/2022' -- 8 is the number of existing characters, 0 is the string to add

-- extract all of a string up to a character
,strtok('01/11/2022.xlsx','.',1) AS '01/11/2022' -- extract all of string up to the period

-- extract part of string after the final occurrence of a character
,substr('C/File/Folder/01112022', instr('C/File/Folder/01112022', '/', -1)+1) AS '01112022'

-- limit a string to only alpha numeric characters - very useful when you have funky characters polluting a dataset 
,WHERE LIKE '%[a-z0-9]%'


-- =================================================
-- WINDOW FUNCTIONS 
-- ================================================= 

-- Creates column with difference by row, from year to year
SELECT  
  car_make,
  cars_sold,
  year,
  cars_sold - LAG(cars_sold) OVER (PARTITION BY car_make ORDER BY year) AS sales_diff -- this is a window function to determine diff in cars_sold each year 
FROM cars_sale
;

-- Select only the highest FUM per app
WITH 
  TOP_RANK AS
  (
    SELECT
       PRODUCT_ID
      ,SALES
      ,ROW_NUMBER() OVER (PARTITION BY PRODUCT_ID ORDER BY SALES DESC) AS rn 
    FROM APPS
  )
SELECT
   PRODUCT_ID
  ,SALES
FROM TOP_RANK
WHERE rn = 1
;

-- Select only the highest FUM per app w// condition that equal values are ranked equally 
WITH 
  TOP_RANK AS
  (
    SELECT
       PRODUCT_ID
      ,SALES
      ,RANK() OVER (PARTITION BY PRODUCT_ID ORDER BY SALES DESC) AS rk 
    FROM APPS
  )
SELECT
   PRODUCT_ID
  ,SALES
FROM TOP_RANK
WHERE rk = 1
;

-- =================================================
-- TRIGGERS
-- ================================================= 

-- https://www.sqlshack.com/learn-sql-sql-triggers/
-- DML (data manipulation language) triggers – We’ve already mentioned them, and they react to DML commands. These are – INSERT, UPDATE, and DELETE
-- DDL (data definition language) triggers – As expected, triggers of this type shall react to DDL commands like – CREATE, ALTER, and DROP

 -- =================================================
-- STORED PROCEDURES
-- ================================================= 

-- Stored procedures are compiled once and stored in executable form, so procedure calls are quick and efficient. 
-- Executable code is automatically cached and shared among users. This lowers memory requirements and invocation overhead.

-- By grouping SQL statements, a stored procedure allows them to be executed with a single call. 
-- This minimizes the use of slow networks, reduces network traffic, and improves round-trip response time. OLTP applications,
-- in particular, benefit because result set processing eliminates network bottlenecks.

-- https://www.w3schools.com/sql/sql_stored_procedures.asp

CREATE PROCEDURE 
  SelectAllCustomers 
    @City nvarchar(30), 
    @PostalCode nvarchar(10)
AS
SELECT * 
FROM Customers 
WHERE City = @City 
  AND PostalCode = @PostalCode
GO
;

EXEC SelectAllCustomers @City = 'London', @PostalCode = 'WA1 1DP';


-- =================================================
-- INTERVIEW TESTS
-- ================================================= 

-- EXPLORE THE DATA!! 
  -- clarify the data
  -- vet your assumptions
-- COMMENT THE APPROACH
  -- psuedo code 
  -- verify the logic 
  -- look for unique values in columns of interest (i.e. SELECT DISTINCT x FROM y;)
-- CODE THE SOLUTION

WITH 
  FIRSTSESSION AS
  (
  SELECT
     user_id
    ,session_start
    ,row_number() over (partition by user_id order by session_start asc) as rn
  FROM TWITCH
  WHERE session_type = 'viewer'
  ),
  VIEWERS_ONLY AS
  (
  SELECT
     user_id
    ,session_start as first_viewer_session
  FROM FIRST_SESSION
  WHERE rn = 1
  )
SELECT
   user_id
  ,count (session_id) AS total_sessions
FROM TWITCH AS T
INNER JOIN FIRST_SESSION AS F
  ON T.user_id = F.user_id
WHERE session_type = 'streamer'
GROUP BY
  user_id
ORDER BY
  total_sessions desc user_id asc
;

-- =================================================
-- EXAMPLE QUERIES 
-- ================================================= 

SELECT
   d.name AS department_name
  ,count(*) AS number_of_employees
  ,sum(CASE WHEN salary>100000 THEN 1 ELSE 0 END) / count(*) AS percentage_over_100k -- % with salary > 100k ... / by count(*)
FROM departments AS d 
INNER JOIN employees AS e 
  ON d.id = e.department_id
GROUP BY department_name
HAVING count(*) >= 10 -- HAVING is simply a "WHERE" clause for aggregate functions 
ORDER BY 3 APPLICATION_START
;

WITH 
  CTE AS 
  (
    SELECT 
       department_id
      ,count(DISTINCT id) AS cnt1 
    FROM employees
    GROUP BY 
      department_id 
    HAVING cnt1 >= 10
  ),
  cte_100K AS 
  (
    SELECT 
       department_id
      ,count(DISTINCT id) cnt2 
    FROM employees
    WHERE salary > 100000
    GROUP BY 
      department_id
  )
SELECT 
  c.name as department_name,
  b.cnt1 as  number_of_employees,
  a.cnt2 / b.cnt1 as percentage_over_100k
FROM cte_100K AS a 
INNER JOIN cte b
  ON a.department_id = b.department_id
JOIN departments c
  ON a.department_id = c.id
ORDER BY 3
;