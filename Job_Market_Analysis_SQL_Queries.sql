-- ============================================================
-- Project Name : Job Market Analysis Using SQL
-- Author       : Mohan Baliji
-- Database     : Job_Market_Analysis
-- Tool         : MySQL Workbench
-- ============================================================                   
                        
                        
                        
                     --------- Query 1: Database Creation & Data Import ------------

CREATE DATABASE Job_Market_Analysis;
USE Job_Market_Analysis;
SELECT * FROM Job_Market_Analysis;
---------------------------------------------------------------------------------
-- NOTE:
-- Import the CSV dataset into the Job_Market_Analysis table
-- using MySQL Workbench -> Table Data Import Wizard.

--------------------------------------------------------------------------------
----- CREATED DUPLICATE TABLE

CREATE TABLE Job_Market_Analysis_Clean AS
SELECT *
FROM Job_Market_Analysis;

---- Total rows ------
SELECT COUNT(*) AS Total_Rows
FROM Job_Market_Analysis_Clean;

DESCRIBE Job_Market_Analysis_Clean;

---- Checking Duplicate ------
SELECT
    ID,
    COUNT(*) AS Duplicate_Count
FROM Job_Market_Analysis
GROUP BY ID
HAVING COUNT(*) > 1;

----- Checking NULL values -----
SELECT
    SUM(Job_Title IS NULL) AS Job_Title_Null,
    SUM(Company_Name IS NULL) AS Company_Name_Null,
    SUM(Location IS NULL) AS Location_Null,
    SUM(Headquarters IS NULL) AS Headquarters_Null,
    SUM(Industry IS NULL) AS Industry_Null,
    SUM(Sector IS NULL) AS Sector_Null
FROM Job_Market_Analysis_Clean;


----- Check -1 Values -----
SELECT
    SUM(Founded = -1) AS Founded_Minus1,
    SUM(Rating = -1) AS Rating_Minus1,
    SUM(Industry = '-1') AS Industry_Minus1,
    SUM(Sector = '-1') AS Sector_Minus1,
    SUM(Competitors = '-1') AS Competitors_Minus1
FROM Job_Market_Analysis_Clean;


----- Data Cleaning ------- 

DESCRIBE Job_Market_Analysis_Clean;

----- Replace -1 in Rating, Industry, Sector, Founded, Competitors -----
UPDATE Job_Market_Analysis_Clean
SET Rating = NULL
WHERE Rating = -1;
UPDATE Job_Market_Analysis_Clean
SET Industry = NULL
WHERE Industry = '-1';
UPDATE Job_Market_Analysis_Clean
SET Sector = NULL
WHERE Sector = '-1';
UPDATE Job_Market_Analysis_Clean
SET Founded = NULL
WHERE Founded = -1;
UPDATE Job_Market_Analysis_Clean
SET Competitors = NULL
WHERE Competitors = '-1';

----- Verify the Updates ----
SELECT
    SUM(Founded = -1) AS Founded_Minus1,
    SUM(Rating = -1) AS Rating_Minus1,
    SUM(Industry = '-1') AS Industry_Minus1,
    SUM(Sector = '-1') AS Sector_Minus1,
    SUM(Competitors = '-1') AS Competitors_Minus1
FROM Job_Market_Analysis_Clean;
-- ============================================================================================
-- Exploratory Data Analysis (EDA)
-- Business Analysis Queries
-- ================================================================================================

---- Query 2: States with Most Number of Jobs ---
SELECT
    SUBSTRING_INDEX(Location, ',', -1) AS State,
    COUNT(*) AS Total_Jobs
FROM Job_Market_Analysis_Clean
GROUP BY State
ORDER BY Total_Jobs DESC;

---- Top 10 States ---
SELECT
    SUBSTRING_INDEX(Location, ',', -1) AS State,
    COUNT(*) AS Total_Jobs
FROM Job_Market_Analysis_Clean
GROUP BY State
ORDER BY Total_Jobs DESC
LIMIT 10;
-- ===================================================================================

---- Query 3: Average Minimal and Maximal Salaries in Different States.
SELECT
    SUBSTRING_INDEX(Location, ',', -1) AS State,
    ROUND(AVG(Lower_Salary),2) AS Avg_Min_Salary,
    ROUND(AVG(Upper_Salary),2) AS Avg_Max_Salary
FROM Job_Market_Analysis_Clean
GROUP BY State
ORDER BY Avg_Max_Salary DESC;
-- ===================================================================================================

---- Query 4: Average Salary in Different States.
SELECT
    Job_Location,
    ROUND(AVG(Avg_SalaryK), 2) AS Average_Salary_K
FROM Job_Market_Analysis_Clean
GROUP BY Job_Location
ORDER BY Average_Salary_K DESC;
-- =================================================================================================

--- Query 5: Top 5 Industries with Maximum Number of Data Science Related Job Postings.
SELECT
    Industry,
    COUNT(*) AS Total_Job_Postings
FROM Job_Market_Analysis_Clean
WHERE Industry IS NOT NULL
  AND Industry <> ''
GROUP BY Industry
ORDER BY Total_Job_Postings DESC
LIMIT 5;
-- =====================================================================================================================

---- Query 6: Companies with Maximum Number of Job Openings
SELECT
    Company_Name,
    COUNT(*) AS Total_Job_Postings
FROM Job_Market_Analysis_Clean
GROUP BY Company_Name
ORDER BY Total_Job_Postings DESC
LIMIT 10;
-- ====================================================================================================

--- Query 7: Job Titles with Most Number of Jobs.
SELECT
    Job_Title,
    COUNT(*) AS Total_Job_Postings
FROM Job_Market_Analysis_Clean
GROUP BY Job_Title
ORDER BY Total_Job_Postings DESC
LIMIT 10;
-- ===================================================================================================

---- Query 8: Salary of Job Titles with Most Number of Jobs.
SELECT
    Job_Title,
    ROUND(AVG(Avg_SalaryK), 2) AS Average_Salary_K,
    COUNT(*) AS Total_Job_Postings
FROM Job_Market_Analysis_Clean
GROUP BY Job_Title
ORDER BY Total_Job_Postings DESC;
-- ======================================================================================

----- Query 9: Skills Required by Companies for Each Job Title.
SELECT
    Job_Title,
    SUM(Python) AS Python_Jobs,
    SUM(SQL_) AS SQL_Jobs,
    SUM(Excel) AS Excel_Jobs,
    SUM(Tableau) AS Tableau_Jobs
FROM Job_Market_Analysis_Clean
GROUP BY Job_Title
ORDER BY COUNT(*) DESC;
-- ============================================================================================

---- Query 10: Relation between Average Salary and Education.
SELECT
    Degree,
    ROUND(AVG(Avg_SalaryK), 2) AS Average_Salary_K,
    COUNT(*) AS Total_Job_Postings
FROM Job_Market_Analysis_Clean
GROUP BY Degree
ORDER BY Average_Salary_K DESC;

-- ==========================================================================
-- End of Job Market Analysis SQL Project
-- ==========================================================================










