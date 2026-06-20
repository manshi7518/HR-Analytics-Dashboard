CREATE TABLE hr_analytics (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(20),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(50),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

select *from hr_analytics;


--1) total number of employees
select count(*) from hr_analytics;

--2) total number of employees who left the company
select count(attrition) from hr_analytics
where attrition='Yes';

--3) average age of employee
select avg(age) from hr_analytics;

--4) average monthly income
select avg(monthlyincome) from hr_analytics;

--5) count number of male and female employee
select  gender ,count(gender)
from hr_analytics
group by gender;

--6) employee count by department
select department,count(employeenumber)
from hr_analytics
group by department;

--7) attrition count my department
select department,count(attrition)
from hr_analytics
where attrition='Yes'
group by department;

--8)which job hai highest attritation
select jobrole,count(attrition) as highest_attrition
from hr_analytics
where attrition='Yes'
group by jobrole
order by highest_attrition desc
limit 1;

--9) attrition count by matrial status

select maritalstatus,count(attrition) as count_attrition
from hr_analytics
where attrition='Yes'
group by maritalstatus;

--10) count employee who work overtime

select overtime ,count(employeecount)
from hr_analytics
where overtime='Yes'
group by overtime;


--11)attrition count  among employee who work overtime

select count(*)
from hr_analytics
where attrition='Yes'
and attrition='Yes'

--12)average sallary by department
select department,avg(monthlyincome)
from hr_analytics
group by department;

--13)top 5 highest paid employee
select employeenumber,monthlyincome
from hr_analytics
order by monthlyincome desc
limit 5;

--14)top 5 lowest paid employee
select employeenumber,monthlyincome
from hr_analytics
order by monthlyincome asc
limit 5;

--15)Create age groups: and employeecount in each age group
18–25
26–35
36–45
46–55
55+ 


select 
case
when age between 18 and 25 then '18-25'
when age between 26 and 35 then '26-35'
when age between 36 and 45 then '36-45'
when age between 46 and 55 then '46-55'
else' 55+'
end as age_group,
count(employeecount) as employee_count
from hr_analytics
group by age_group
order by age_group asc;

--16) Create salary slabs:
--Less than 5K
--5K–10K
--10K–15K
--Greater than 15K

--Find the employee count in each salary slab
 select 
 case
 when monthlyincome <5000 then '5K-'
 when monthlyincome between 5000 and 100000 then '5K-10K'
 when monthlyincome between 10000 and 15000 then '10K-15K'
 else '15K+'
 end as salary_slabs,
 count(employeecount)
 from hr_analytics
 group by salary_slabs;

--17 attrition count by sallary slabs
select 
 case
 when monthlyincome <5000 then 'less than 5K'
 when monthlyincome between 5000 and 100000 then '5K-10K'
 when monthlyincome between 10000 and 15000 then '10K-15K'
 else '15K+'
 end as salary_slabs,
 count(*) as attrition_type
 from hr_analytics
 where attrition='Yes'
 group by salary_slabs
 order by attrition_type;

 --18)emplyoyess whose saalary is below the company average sallary
WITH avg_salary AS
(
    SELECT AVG(MonthlyIncome) AS avg_sal
    FROM hr_analytics
)
SELECT EmployeeNumber,
       JobRole,
       MonthlyIncome
FROM hr_analytics, avg_salary
WHERE MonthlyIncome < avg_sal;

--19)employee whose age is above company avergea age

with  avg_age as(
select avg(age) as avg_age
from hr_analytics
)
select employeenumber,age from hr_analytics ,avg_age
where age>avg_age;

--20)which department has highest average salary

WITH dept_salary AS
(
    SELECT Department,
           ROUND(AVG(MonthlyIncome),2) AS Avg_Salary
    FROM hr_analytics
    GROUP BY Department
)
SELECT *
FROM dept_salary
ORDER BY Avg_Salary DESC
LIMIT 1;