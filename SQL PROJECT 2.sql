CREATE TABLE Employees (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    City VARCHAR(50),
    Join_Date DATE);

SELECT * FROM employees;

-- 1. Display all employees

SELECT *
FROM Employees;
--OR--
SELECT employee_name 
FROM employees
WHERE employee_name is not null;

-- 2. Show employees with salary greater than 50000

SELECT * FROM employees
WHERE SALARY>50000;

-- 3. Find employees from Bangalore

SELECT * FROM employees
WHERE CITY='Bangalore';

-- 4. Show employees in IT department

SELECT * FROM employees
WHERE department='IT';

-- 5. Display employees ordered by salary (highest to lowest)

SELECT * FROM employees
order by SALARY DESC;

-- 6. Find total number of employees

select count(employee_name) from employees;
--OR--
SELECT COUNT(*) AS Total_Employees
FROM Employees;

-- 7. Find average salary

SELECT avg(salary) FROM employees;

-- 8. Find highest salary

SELECT * FROM employees
order by SALARY DESC 
limit 1;
--OR--
select max(salary) FROM employees;

-- 9. Find employees who joined after 2023-01-01

select * from employees
where join_date>'2023-01-01';

-- 10. Find second highest salary

SELECT * FROM employees
order by SALARY DESC 
limit 1 offset 1;
--OR--
SELECT MAX(Salary) AS Second_Highest_Salary
FROM Employees
WHERE Salary < (
    SELECT MAX(Salary)
    FROM Employees);

/* ADVANCE LEVEL QUESTION PRACTICE */

CREATE TABLE Departments (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE Employees1 (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100),
    Department_ID INT,
    Salary DECIMAL(10,2),
    Join_Date DATE,
    FOREIGN KEY (Department_ID)
    REFERENCES Departments(Department_ID)
);

CREATE TABLE Projects (
    Project_ID INT PRIMARY KEY,
    Employee_ID INT,
    Project_Name VARCHAR(100),
    Project_Hours INT,
    FOREIGN KEY (Employee_ID)
    REFERENCES Employees(Employee_ID)
);

SELECT * FROM departments;
SELECT * FROM employees1;
SELECT * FROM projects;

-- 1. Show all employees whose salary is greater than 50000

SELECT * FROM employees1
WHERE SALARY>50000;

-- 2. Find employees working in the IT department

SELECT e.*
FROM Employees1 e
JOIN Departments d
ON e.Department_ID = d.Department_ID
WHERE d.Department_Name='IT';

-- 3. Display employee names with department names

SELECT e.Employee_Name,d.Department_Name,
	concat(e.employee_name,'-',d.department_name) as employee_department 
from departments d
join employees1 e
on e.department_id=d.department_id;
--OR--
SELECT e.Employee_Name,
       d.Department_Name
FROM Employees1 e
JOIN Departments d
ON e.Department_ID=d.Department_ID;

-- 4. Find total number of employees in each department

SELECT d.department_name,count(e.employee_id) as employee_department 
from departments d
join employees1 e
on e.department_id=d.department_id
group by department_name;

-- 5. Find the highest paid employee

SELECT * FROM Employees1
ORDER BY Salary DESC
LIMIT 1;

-- 6. Find the second highest salary

SELECT * FROM Employees1
ORDER BY Salary DESC
LIMIT 1 offset 1;
--OR--
SELECT MAX(Salary) AS Second_Highest
FROM Employees
WHERE Salary <
(SELECT MAX(Salary)
FROM Employees);

-- 7. Show employees who joined after 2023-01-01

SELECT *
FROM Employees1
WHERE Join_Date > '2023-01-01';

-- 8. Find average salary of each department

SELECT d.department_name,avg(e.salary) AS avg_salary
from departments d
join employees1 e
on e.department_id=d.department_id
group by d.department_name;

-- 9. Display employees who are not assigned to any project

SELECT e.employee_name
from employees1 e
left join projects p
on e.employee_id=p.employee_id
where p.employee_id is null;

-- 10. Find total project hours for each employee

SELECT e.employee_name,sum(p.project_hours) as total_hrs
from employees1 e
join projects p
on e.employee_id=p.employee_id
group by e.employee_name;

SELECT * FROM departments;
SELECT * FROM employees1;
SELECT * FROM projects;

-- 11. Find employee with maximum project hours

SELECT e.Employee_Name,
       SUM(p.Project_Hours) AS Total_Hours
FROM Employees1 e
JOIN Projects p
ON e.Employee_ID=p.Employee_ID
GROUP BY e.Employee_Name
ORDER BY Total_Hours DESC
LIMIT 1;

-- 12. Show departments with more than 2 employees

select d.department_name,count(e.employee_id) as total
from employees1 e
join departments d
on e.department_id=d.department_id
group by d.department_name
having count(e.employee_id) > 2;

-- 13. Find the department generating the highest salary expense

select d.department_name,sum(e.salary) as total_salary
from employees1 e
join departments d
on e.department_id=d.department_id
group by d.department_name
order by total_salary DESC
LIMIT 1;

-- 14. Find employees earning above average salary

SELECT * FROM Employees1
WHERE Salary >
(SELECT AVG(Salary)
FROM Employees1);

-- 15. Show top 3 highest paid employees

SELECT * FROM Employees
ORDER BY Salary DESC
LIMIT 3;

-- 16. Find employees working on multiple projects

SELECT e.Employee_Name,
       count(p.Project_name) AS Total_Hours
FROM Employees1 e
JOIN Projects p
ON e.Employee_ID=p.Employee_ID
GROUP BY e.Employee_Name limit 1;
--OR--
SELECT e.Employee_Name,
       COUNT(p.Project_ID) AS Total_Projects
FROM Employees e
JOIN Projects p
ON e.Employee_ID=p.Employee_ID
GROUP BY e.Employee_Name
HAVING COUNT(p.Project_ID)>1;

-- 17. Rank employees by salary using RANK()

select employee_name,salary,
rank() over(order by salary DESC)
from employees1;

-- 18. Find the department with the highest average salary

select d.department_name,avg(salary) as Avg_salary
from departments d
join employees1 e
on d.department_id=e.department_id
group by d.department_name
order by avg_salary desc limit 1;

-- 19. Show total project hours by department

select d.department_name,sum(p.project_hours) as total_hrs
from departments d
join employees1 e
on d.department_id=e.department_id 
join projects p 
on e.employee_id=p.employee_id
group by d.department_name ;

-- 20. Find employees whose salary is lower than department average

SELECT e.Employee_Name,
       e.Salary
FROM Employees1 e
JOIN
(SELECT Department_id,
       AVG(Salary) AS AvgSalary
FROM Employees1
GROUP BY Department_ID
) a
ON e.Department_ID=a.Department_ID
WHERE e.Salary < a.AvgSalary;







