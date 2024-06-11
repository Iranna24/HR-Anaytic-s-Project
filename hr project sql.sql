create database HRproject;

use HRproject;

SELECT * FROM hr_1 ;
SELECT * FROM hr_2 ;

# Average Attrition rate for all Departments (KPI 1)
SELECT 
department,
concat(round((AVG(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END)*100),2),'%') AS avg_attrition_rate
FROM hr_1
GROUP BY 
department;

# Average Hourly rate of Male Research Scientist (KPI 2)
SELECT 
round(AVG(HourlyRate),2) AS avg_hourly_rate
FROM hr_1
WHERE Gender = 'Male' AND JobRole = 'Research Scientist';

# Attrition rate Vs Monthly income stats (KPI 3)
SELECT
Department,
MonthlyIncome,
concat(round((AVG(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END)*100),2),'%') AS avg_attrition_rate
FROM hr_1 INNER JOIN hr_2 ON hr_1.EmployeeNumber = hr_2.'Employee ID'
GROUP BY 
department;

# Average working years for each Department (KPI 4)
SELECT 
hr_1.Department,
ROUND(AVG(hr_2.TotalWorkingYears),2) AS avg_working_years
FROM hr_1 INNER JOIN hr_2 ON hr_1.EmployeeNumber = hr_2.`Employee ID`
GROUP BY hr_1.Department;

# Job Role Vs Work life balance (KPI 5)
SELECT 
hr_1.JobRole AS job_role,
SUM(CASE WHEN hr_2.WorkLifeBalance = 4 THEN 1 ELSE 0 END) AS excellent_count,
SUM(CASE WHEN hr_2.WorkLifeBalance = 3 THEN 1 ELSE 0 END) AS good_count,
SUM(CASE WHEN hr_2.WorkLifeBalance = 2 THEN 1 ELSE 0 END) AS average_count,
SUM(CASE WHEN hr_2.WorkLifeBalance = 1 THEN 1 ELSE 0 END) AS poor_count
FROM hr_1 INNER JOIN hr_2 ON hr_1.EmployeeNumber = hr_2.`Employee ID`
GROUP BY hr_1.JobRole;