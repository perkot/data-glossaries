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
-- BASIC
-- =================================================

-- Identify a role in a database 
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
-- WILDCARDS
-- =================================================

CASE WHEN 'LONG-STRING' LIKE 'LONG%' THEN 1 ELSE O END AS LONG_FLAG  -- String beginning with 'long' will be included 

-- =================================================
-- WINDOW FUNCTIONS 
-- ================================================= 
-- https://learnsql.com/blog/partition-by-with-over-sql/
-- PARTITION BY expression is a subclause of the OVER clause
    -- AVG(), 
    -- MAX(), 
    -- RANK(),
    -- ROW_NUMBER()

-- Can also do 
    -- GROUP BY
    -- ORDER BY

SELECT
    car_make,
    car_model,
    car_price,
    AVG(car_price) OVER() AS "overall average price", -- this returns the overall avg car price - the same for every row 
    AVG(car_price) OVER (PARTITION BY car_type) AS "car type average price" -- this returns the avg car price for each car type, differs by row depending upon the car type 
FROM car_list_prices

-- Create a row index as an ID
sum(1) over (ROWS unbounded preceding) AS ROW_ID 

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
      ,RANK() OVER (PARTITION BY PRODUCT_ID ORDER BY SALES DESC) AS rk -- rank orders 1,2,2,4,4,4,7
      ,DENSE_RANK() OVER (PARTITION BY PRODUCT_ID ORDER BY SALES DESC) AS rkd  -- dense rank orders 1,2,2,3,3,3,4
    FROM APPS
  )
SELECT
   PRODUCT_ID
  ,SALES
FROM TOP_RANK
WHERE rk = 1
;


-- Running sum / Rolling sum 
SELECT 
     StudentName
    ,StudentAge
    ,sum (StudentAge) OVER (ORDER BY Id) AS running_sum_age
FROM Students

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

