#CREATE DATABASE HR_Analytics;
use hr_analytics;


SHOW TABLES;
select * from hr_1;
/*
ALTER TABLE hr_1
CHANGE COLUMN `ï»¿Age` Age VARCHAR(20);
select * from hr_2;

ALTER TABLE hr_2
CHANGE COLUMN `ï»¿Employee ID` Employee_ID VARCHAR(20);
*/



#1
SELECT COUNT(*) AS TotalEmployees
FROM hr_1;

SELECT Attrition, COUNT(*) AS Total
FROM hr_1
GROUP BY Attrition;

SELECT AVG(MonthlyIncome) AS AvgSalary
FROM hr_2;

SELECT Department,
       COUNT(CASE WHEN Attrition='Yes' THEN 1 END) AS AttritionCount
FROM hr_1
GROUP BY Department;

SELECT COUNT(*) AS OvertimeEmployees
FROM hr_2
WHERE OverTime='Yes';

SELECT Employee_ID, MonthlyIncome
FROM hr_2
ORDER BY MonthlyIncome DESC
LIMIT 1;

SELECT *
FROM hr_1 h1
JOIN hr_2 h2
ON h1.EmployeeNumber = h2.Employee_ID;



#####_____1_____Attrition_Rate
SELECT 
(COUNT(CASE WHEN Attrition='Yes' THEN 1 END)*100.0/COUNT(*)) AS AttritionRate
FROM hr_1;

#2
SELECT h1.JobRole,
       AVG(h2.MonthlyIncome) AS AvgSalary
FROM hr_1 h1
JOIN hr_2 h2
ON h1.EmployeeNumber = h2.Employee_ID
GROUP BY h1.JobRole;


#####___2____Average Hourly rate of Male Research Scientist
SELECT AVG(HourlyRate) AS Avg_Hourly_Rate
FROM hr_1
WHERE Gender = 'Male'
AND JobRole = 'Research Scientist';


#3
SELECT 
    Attrition,
    AVG(MonthlyIncome) AS Avg_Monthly_Income,
    MIN(MonthlyIncome) AS Min_Income,
    MAX(MonthlyIncome) AS Max_Income,
    SUM(MonthlyIncome) AS Total_Income
FROM hr_2 h2
JOIN hr_1 h1
ON h1.EmployeeNumber = h2.Employee_ID
GROUP BY Attrition;


####_____3_____Attrition rate Vs Monthly income stats
SELECT 
    Attrition,
    COUNT(*) AS Total_Employees,
    
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hr_1),
        2
    ) AS Attrition_Percentage,
    
    ROUND(AVG(MonthlyIncome),2) AS Avg_Monthly_Income
FROM hr_1 h1
JOIN hr_2 h2
ON h1.EmployeeNumber = h2.Employee_ID
GROUP BY Attrition;

#####____4_____Average working years for each Department

SELECT 
    h1.Department,
    ROUND(AVG(h2.TotalWorkingYears),2) AS Avg_Working_Years
FROM hr_1 h1
JOIN hr_2 h2
ON h1.EmployeeNumber = h2.Employee_ID
GROUP BY h1.Department;


####____5_____Job Role Vs Work life balance

select * from hr_2;
SELECT 
    h1.JobRole,
    ROUND(AVG(h2.WorkLifeBalance),2) AS Avg_Work_Life_Balance
FROM hr_1 h1
JOIN hr_2 h2
ON h1.EmployeeNumber = h2.Employee_ID
GROUP BY h1.JobRole;

###______6___Attrition rate Vs Year since last promotion relation

SELECT 
    h2.YearsSinceLastPromotion,
    
    COUNT(CASE WHEN h1.Attrition = 'Yes' THEN 1 END) AS Attrition_Count,
    
    COUNT(*) AS Total_Employees,
    
    ROUND(
        COUNT(CASE WHEN h1.Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate_Percentage

FROM hr_1 h1
JOIN hr_2 h2
ON h1.EmployeeNumber = h2.Employee_ID

GROUP BY h2.YearsSinceLastPromotion
ORDER BY h2.YearsSinceLastPromotion;





