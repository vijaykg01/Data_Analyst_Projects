USE PROJECTS1;

SELECT * FROM EMPLOYEES;
SELECT * FROM SHOPS;
SELECT * FROM LOCATIONS;
SELECT * FROM SUPPLIERS;


/*=========================================================
SQL PROJECT: EMPLOYEE ANALYSIS
=========================================================*/

/* I.AGGREGATE FUNCTIONS */
/*---------------------------------------------------------
1. How many employees are there in the company?
---------------------------------------------------------*/
SELECT COUNT(*) AS total_employees 
FROM EMPLOYEES;

/*---------------------------------------------------------
2. What is the total salary paid to all employees?
---------------------------------------------------------*/
SELECT SUM(salary) AS total_salary 
FROM EMPLOYEES;

/*---------------------------------------------------------
3. What is the highest salary, lowest salary, and average salary?
---------------------------------------------------------*/
SELECT 
	MAX(salary) AS max_salary,
    MIN(salary) AS min_salary,
    AVG(salary) AS avg_salary
FROM EMPLOYEES;

/*---------------------------------------------------------
4. How many male and female employees are there?
---------------------------------------------------------*/
SELECT 
	gender,
    count(*) AS total_employees
FROM EMPLOYEES
GROUP BY gender;

/*---------------------------------------------------------
5. How many employees work in each coffee shop?
---------------------------------------------------------*/
SELECT 
	coffeeshop_id,
    count(*) AS total_employees
FROM EMPLOYEES
GROUP BY coffeeshop_id;

/*---------------------------------------------------------
6. Which coffee shop has the highest number of employees?
---------------------------------------------------------*/
SELECT 
	coffeeshop_id,
    COUNT(*) AS total_employees
FROM EMPLOYEES
GROUP BY coffeeshop_id
ORDER BY total_employees DESC 
LIMIT 1;

/*---------------------------------------------------------
7. What is the average salary in each coffee shop?
---------------------------------------------------------*/
SELECT 
	coffeeshop_id,
    AVG(salary) AS avg_salary
FROM EMPLOYEES
GROUP BY coffeeshop_id;

/*---------------------------------------------------------
8. Which coffee shop pays the highest total salary?
---------------------------------------------------------*/
SELECT 
	coffeeshop_id,
    SUM(salary) AS total_salary
FROM EMPLOYEES
GROUP BY coffeeshop_id
ORDER BY total_salary DESC
LIMIT 1;

/*---------------------------------------------------------
9. How many employees were hired each year?
---------------------------------------------------------*/
SELECT YEAR(hire_date) AS hire_year,
	   COUNT(*) AS total_employees
FROM EMPLOYEES
GROUP BY YEAR(hire_date)
ORDER BY YEAR(hire_date) ASC;

/*---------------------------------------------------------
10. Which year had the highest number of hires?
---------------------------------------------------------*/
SELECT YEAR(hire_date) AS hire_year,
	   COUNT(*) AS total_employees
FROM EMPLOYEES
GROUP BY YEAR(hire_date)
ORDER BY total_employees DESC
LIMIT 1;

/*---------------------------------------------------------
11. What is the highest salary in each coffee shop?
---------------------------------------------------------*/
SELECT 
	coffeeshop_id,
    MAX(salary) AS highest_salary
FROM EMPLOYEES
GROUP BY coffeeshop_id;

/*---------------------------------------------------------
12. What is the lowest salary in each coffee shop?
---------------------------------------------------------*/
SELECT 
	coffeeshop_id,
    MIN(salary) AS lowest_salary
FROM EMPLOYEES
GROUP BY coffeeshop_id;

/*---------------------------------------------------------
13. What is the total salary paid in each coffee shop?
---------------------------------------------------------*/
SELECT 
	coffeeshop_id,
    SUM(salary) AS total_salary
FROM EMPLOYEES
GROUP BY coffeeshop_id;

/*---------------------------------------------------------
14. How many employees earn more than 50,000?
---------------------------------------------------------*/
SELECT COUNT(*) AS number_salary_above_50000 
FROM EMPLOYEES
WHERE salary > 50000;

/*---------------------------------------------------------
15. What is the total salary of employees earning more than 50,000?
---------------------------------------------------------*/
SELECT SUM(salary) AS total_salary
FROM EMPLOYEES
WHERE salary > 50000;

/*---------------------------------------------------------
16. What is the average salary of employees earning more than 50,000?
---------------------------------------------------------*/
SELECT AVG(salary) AS avg_salary
FROM EMPLOYEES
WHERE salary > 50000;

/*---------------------------------------------------------
17. How many employees were hired after 2020?
---------------------------------------------------------*/
SELECT COUNT(*) AS total_employees
FROM EMPLOYEES 
WHERE YEAR(hire_date) > 2020;

/*---------------------------------------------------------
18. What is the total salary of employees hired after 2020?
---------------------------------------------------------*/
SELECT SUM(salary) AS total_salary
FROM EMPLOYEES 
WHERE YEAR(hire_date) > 2020;

/*---------------------------------------------------------
19. What is the average salary of employees hired after 2020?
---------------------------------------------------------*/
SELECT AVG(salary) AS avg_salary
FROM EMPLOYEES 
WHERE YEAR(hire_date) > 2020;

/*---------------------------------------------------------
20. What is the difference between the highest salary and the lowest salary?
---------------------------------------------------------*/
SELECT MAX(salary) - MIN(salary) as defference_salary
FROM employees;

/* II.GROUP BY AND HAVINGS */
/*---------------------------------------------------------
21. Which coffee shops have an average salary greater than 40,000?
---------------------------------------------------------*/
SELECT coffeeshop_id, 
	   AVG(salary) AS avg_salary
FROM EMPLOYEES
GROUP BY coffeeshop_id
HAVING AVG(salary) > 40000;

/*---------------------------------------------------------
22. Which hiring years have more than 75 employees?
---------------------------------------------------------*/
SELECT YEAR(hire_date) AS hire_year,
	   COUNT(*) AS total_employees
FROM EMPLOYEES
GROUP BY YEAR(hire_date)
HAVING total_employees > 75
ORDER BY hire_year DESC;

/*---------------------------------------------------------
23. Which gender has an average salary greater than 35,000?
---------------------------------------------------------*/
SELECT gender, AVG(salary) AS avg_salary
FROM EMPLOYEES
GROUP BY gender
HAVING AVG(salary) > 35000;

/* III.CASE FUNCTIONS */
/*---------------------------------------------------------
24. Categorize employees based on salary:
    - Salary >= 50,000 : High Salary
    - Salary between 20,000 and 49,999 : Medium Salary
    - Salary < 20,000 : Low Salary
---------------------------------------------------------*/
SELECT full_name, salary,
	CASE WHEN salary >= 50000 then 'High Salary'
		 WHEN salary BETWEEN 20000 AND 49999 THEN 'Medium Salary'
         ELSE 'Low Salary'
	END AS salary_category
FROM EMPLOYEES;

/*---------------------------------------------------------
25. Display the full name of each employee along with their gender as:
    - Male Employee
    - Female Employee
---------------------------------------------------------*/
SELECT CONCAT(gender, ' ', full_name) AS gender_full_name
FROM EMPLOYEES;

/*---------------------------------------------------------
26. Categorize employees based on hiring year:
    - Hired before 2020 : Experienced
    - Hired in or after 2020 : New Employee
---------------------------------------------------------*/
SELECT hire_date,
	CASE WHEN YEAR(hire_date) < 2020 THEN 'Experienced'
		 WHEN YEAR(hire_date) >= 2020 THEN 'New Employee'
	END AS date_category
FROM EMPLOYEES;

/*---------------------------------------------------------
27. Show each employee's salary along with a bonus:
    - 10% bonus if salary is greater than 30,000
    - 5% bonus otherwise
---------------------------------------------------------*/
SELECT full_name, salary,
	CASE WHEN salary > 30000 THEN salary*0.1
		 ELSE salary*0.05
	END AS bonus_with_salary
FROM EMPLOYEES;

/*---------------------------------------------------------
28. Display whether each employee's salary is Above Average
    or Below Average.
---------------------------------------------------------*/
SELECT salary,
	CASE WHEN salary > (SELECT AVG(salary) FROM EMPLOYEES) THEN 'Above Salary'
		 ELSE 'Below Salary'
	END AS salary_category
FROM EMPLOYEES;

/*---------------------------------------------------------
29. Assign salary grades:
    - A : Salary >= 60,000
    - B : Salary between 40,000 and 59,999
    - C : Salary between 20,000 and 39,999
    - D : Salary < 20,000
---------------------------------------------------------*/
SELECT full_name, salary,
	CASE WHEN salary >= 60000 then 'A'
		 WHEN salary BETWEEN 40000 AND 59999 THEN 'B'
         WHEN salary BETWEEN 20000 AND 39999 THEN 'C'
         ELSE 'D'
	END AS salary_category
FROM EMPLOYEES;

/*---------------------------------------------------------
30. Display whether an employee's email is available or not.
---------------------------------------------------------*/
SELECT * FROM EMPLOYEES;
SELECT email,
	CASE WHEN email like '%@%' THEN 'Email is Available' 
		 ELSE 'NO Email'
    END AS email_category
FROM EMPLOYEES;

/* IV.STRING FUNCTIONS */
/*---------------------------------------------------------
31. Display all employee names in uppercase.
---------------------------------------------------------*/
SELECT full_name, UPPER(full_name)
FROM EMPLOYEES;

/*---------------------------------------------------------
32. Display all employee names in lowercase.
---------------------------------------------------------*/
SELECT full_name, LOWER(full_name)
FROM EMPLOYEES;

/*---------------------------------------------------------
33. Find the length of each employee's full name.
---------------------------------------------------------*/
SELECT full_name, LENGTH(full_name)
FROM EMPLOYEES;

/*---------------------------------------------------------
34. Display the first three characters of each employee's
    first name.
---------------------------------------------------------*/
SELECT full_name, LEFT(full_name, 3)
FROM EMPLOYEES;

/*---------------------------------------------------------
35. Display the last three characters of each employee's
    full name.
---------------------------------------------------------*/
SELECT full_name, RIGHT(full_name, 3)
FROM EMPLOYEES;

/*---------------------------------------------------------
36. Display the initials of each employee.
    Example: John Smith → J.S
---------------------------------------------------------*/
SELECT employee_id,
       full_name,
       CONCAT(
           LEFT(full_name, 1),
           '.',
           LEFT(SUBSTRING_INDEX(full_name, ' ', -1), 1)
       ) AS initials
FROM employees;

/*---------------------------------------------------------
37. Replace '.com' with '.org' in all email addresses.
---------------------------------------------------------*/
SELECT email,
       REPLACE(email, '.com', '.org') AS updated_email
FROM employees;

/*---------------------------------------------------------
38. Display each employee's email username
    (before the '@' symbol).
---------------------------------------------------------*/
SELECT email,
       SUBSTRING_INDEX(email, '@', 1) AS email_username
FROM employees;

/*---------------------------------------------------------
39. Display each employee's email domain
    (after the '@' symbol).
---------------------------------------------------------*/
SELECT email,
       SUBSTRING_INDEX(email, '@', -1) AS email_username
FROM employees;

/*---------------------------------------------------------
40. Remove any leading or trailing spaces from full names.
---------------------------------------------------------*/
SELECT TRIM(full_name) 
FROM EMPLOYEES;

/* V.DATE FUNCTION */
/*---------------------------------------------------------
41. Display each employee's hire year.
---------------------------------------------------------*/
SELECT employee_id, full_name, hire_date,
	YEAR(hire_date) AS hire_year
FROM EMPLOYEES
GROUP BY employee_id;

/*---------------------------------------------------------
42. Display each employee's hire month.
---------------------------------------------------------*/
SELECT employee_id, full_name, hire_date,
	MONTHNAME(hire_date) AS hire_month
FROM EMPLOYEES
GROUP BY employee_id;

/*---------------------------------------------------------
43. Display each employee's hire day.
---------------------------------------------------------*/
SELECT employee_id, full_name, hire_date,
	DAY(hire_date) AS hire_day
FROM EMPLOYEES
GROUP BY employee_id;

/*---------------------------------------------------------
44. Find all employees hired in the year 2020.
---------------------------------------------------------*/
SELECT employee_id, full_name, hire_date,
	YEAR(hire_date) AS hire_year
FROM EMPLOYEES
WHERE YEAR(hire_date) = 2020
GROUP BY employee_id;

/*---------------------------------------------------------
45. Find all employees hired in the month of January.
---------------------------------------------------------*/
SELECT employee_id, full_name, hire_date,
	MONTHNAME(hire_date) AS hire_month
FROM EMPLOYEES
WHERE MONTHNAME(hire_date) = 'January'
GROUP BY employee_id;

/*---------------------------------------------------------
46. Display the number of years each employee has worked in
    the company.
---------------------------------------------------------*/
SELECT employee_id,
       full_name,
       hire_date,
       TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years_of_experience
FROM employees;

/*---------------------------------------------------------
47. Display the number of months each employee has worked in
    the company.
---------------------------------------------------------*/
SELECT employee_id,
       full_name,
       hire_date,
       TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) AS months_of_experience
FROM employees;

/*---------------------------------------------------------
48. Display the number of days each employee has worked in
    the company.
---------------------------------------------------------*/
SELECT employee_id,
       full_name,
       hire_date,
       TIMESTAMPDIFF(DAY, hire_date, CURDATE()) AS days_of_experience
FROM employees;

/*---------------------------------------------------------
49. Find employees who have more than 5 years of experience.
---------------------------------------------------------*/
SELECT employee_id,
       full_name,
       hire_date,
       TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years_of_experience
FROM employees
WHERE TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 5;

/*---------------------------------------------------------
50. Find employees hired within the last 4 years.
---------------------------------------------------------*/
SELECT employee_id,
       full_name,
       hire_date,
       TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS years_of_experience
FROM employees
WHERE TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) < 4;

/*---------------------------------------------------------
51. Find the oldest employee based on hire_date.
---------------------------------------------------------*/
SELECT employee_id,
       full_name,
       hire_date,
       salary,
       TIMESTAMPDIFF(DAY, hire_date, CURDATE()) AS days_of_experience
FROM employees
ORDER BY days_of_experience DESC
LIMIT 1;

/*---------------------------------------------------------
52. Find the newest employee based on hire_date.
---------------------------------------------------------*/
SELECT employee_id,
       full_name,
       hire_date,
       salary,
       TIMESTAMPDIFF(DAY, hire_date, CURDATE()) AS days_of_experience
FROM employees
ORDER BY days_of_experience ASC
LIMIT 1;

/*---------------------------------------------------------
53. Display employees hired on weekends (Saturday or Sunday).
---------------------------------------------------------*/
SELECT employee_id,
       full_name,
       hire_date,
       DAYNAME(hire_date) AS days_of_experience
FROM employees
WHERE DAYNAME(hire_date) = 'Saturday' OR DAYNAME(hire_date) = 'Sunday'
ORDER BY  days_of_experience ;

/*---------------------------------------------------------
54. Display each employee's hire date in the format
    'DD-Mon-YYYY'.
---------------------------------------------------------*/
SELECT employee_id,
       full_name,
       DATE_FORMAT(hire_date, '%d-%b-%Y') AS formatted_hire_date
FROM employees;

SELECT * FROM EMPLOYEES;
SELECT * FROM SHOPS;
SELECT * FROM LOCATIONS;
SELECT * FROM SUPPLIERS;

/* VI.MySQL JOINS */
/*---------------------------------------------------------
55. Display each employee along with the shop they work in.
---------------------------------------------------------*/
SELECT e.full_name, s.coffeeshop_name
FROM employees e
INNER JOIN shops s
ON e.coffeeshop_id = s.coffeeshop_id;

/*---------------------------------------------------------
56. Display each employee along with the shop name and
    location.
---------------------------------------------------------*/
SELECT e.full_name, s.coffeeshop_name, l.city, l.country
FROM employees e
INNER JOIN shops s
ON e.coffeeshop_id = s.coffeeshop_id
INNER JOIN locations l
ON s.city_id = l.city_id;

/*---------------------------------------------------------
57. Display each employee along with the supplier of their
    shop.
---------------------------------------------------------*/
SELECT e.full_name, s1.coffeeshop_name, s2.supplier_name
FROM employees e
INNER JOIN shops s1
ON e.coffeeshop_id = s1.coffeeshop_id
INNER JOIN suppliers s2
ON s1.coffeeshop_id = s2.coffeeshop_id ;

/*---------------------------------------------------------
58. Display the total number of employees working in each
shop.
---------------------------------------------------------*/
SELECT e.coffeeshop_id, s.coffeeshop_name,
	   COUNT(*) AS total_employees
FROM employees e 
INNER JOIN shops s
ON e.coffeeshop_id = s.coffeeshop_id
GROUP BY e.coffeeshop_id,s.coffeeshop_name;

/*---------------------------------------------------------
59. Display the total salary paid by each shop.
---------------------------------------------------------*/
SELECT e.coffeeshop_id, s.coffeeshop_name,
	   SUM(salary) AS total_salary
FROM employees e 
INNER JOIN shops s
ON e.coffeeshop_id = s.coffeeshop_id
GROUP BY e.coffeeshop_id,s.coffeeshop_name;

/*---------------------------------------------------------
60. Display the average salary of employees in each location.
---------------------------------------------------------*/
SELECT l.city, l.country,
	   AVG(salary) AS avg_salary
FROM employees e 
INNER JOIN shops s
ON e.coffeeshop_id = s.coffeeshop_id
INNER JOIN locations l
ON s.city_id = l.city_id
GROUP BY l.city, l.country;

/*---------------------------------------------------------
61. Find the location with the highest number of employees.
---------------------------------------------------------*/
SELECT l.city, l.country,
	   COUNT(*) AS total_employees
FROM employees e 
INNER JOIN shops s
ON e.coffeeshop_id = s.coffeeshop_id
INNER JOIN locations l
ON s.city_id = l.city_id
GROUP BY l.city, l.country
ORDER BY total_employees DESC
LIMIT 1;

/*---------------------------------------------------------
62. Find the supplier that supplies the highest number of
    shops.
---------------------------------------------------------*/
SELECT s2.supplier_name,
       COUNT(s1.coffeeshop_id) AS total_shops
FROM shops s1
INNER JOIN suppliers s2
ON s1.coffeeshop_id = s2.coffeeshop_id
GROUP BY s2.supplier_name
ORDER BY total_shops DESC
LIMIT 1;

/*---------------------------------------------------------
63. Display all shops along with the number of employees
    working in each shop.
---------------------------------------------------------*/
SELECT s.coffeeshop_id,
       s.coffeeshop_name,
       COUNT(e.employee_id) AS total_employees
FROM shops s
LEFT JOIN employees e
ON s.coffeeshop_id = e.coffeeshop_id
GROUP BY s.coffeeshop_id,
         s.coffeeshop_name;
         
/*---------------------------------------------------------
64. Find shops that do not have any employees.
---------------------------------------------------------*/
SELECT s.coffeeshop_id,
       s.coffeeshop_name
FROM shops s
LEFT JOIN employees e
ON s.coffeeshop_id = e.coffeeshop_id
WHERE e.employee_id IS NULL;

/*---------------------------------------------------------
65. Find suppliers that are not supplying any shop.
---------------------------------------------------------*/
SELECT S2.supplier_name
FROM  suppliers s2
LEFT JOIN shops s1
ON s1.coffeeshop_id = s2.coffeeshop_id 
WHERE s1.coffeeshop_id IS NULL;

/*---------------------------------------------------------
66. Find the highest-paid employee in each shop.
---------------------------------------------------------*/
SELECT e.full_name,
       s.coffeeshop_name,
       e.salary
FROM employees e
INNER JOIN shops s
ON e.coffeeshop_id = s.coffeeshop_id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE coffeeshop_id = e.coffeeshop_id);
    
/*---------------------------------------------------------
67. Find the highest-paid employee in each location.
---------------------------------------------------------*/
SELECT e.employee_id,
       e.full_name,
       e.salary,
       l.city,
       l.country
FROM employees e
INNER JOIN shops s
ON e.coffeeshop_id = s.coffeeshop_id
INNER JOIN locations l
ON s.city_id = l.city_id
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    INNER JOIN shops s2
    ON e2.coffeeshop_id = s2.coffeeshop_id
    WHERE s2.city_id = s.city_id);

/*---------------------------------------------------------
68. Display the total salary paid by each supplier.
---------------------------------------------------------*/
SELECT s.supplier_name,
       SUM(e.salary) AS total_salary
FROM suppliers s
LEFT JOIN employees e
ON s.coffeeshop_id = e.coffeeshop_id
GROUP BY s.supplier_name;

/*---------------------------------------------------------
69. Find suppliers whose shops have more than 600 employees.
---------------------------------------------------------*/
SELECT s.supplier_name,
       COUNT(e.employee_id) AS total_employees
FROM suppliers s
INNER JOIN employees e
ON s.coffeeshop_id = e.coffeeshop_id
GROUP BY s.supplier_name
HAVING COUNT(e.employee_id) > 600 ;

/*---------------------------------------------------------
70. Display each employee's name, shop name, location name,
    and supplier name in a single result.
---------------------------------------------------------*/
SELECT e.full_name,
       s.coffeeshop_name,
       l.city,
       r.supplier_name
FROM employees e
INNER JOIN shops s
ON e.coffeeshop_id = s.coffeeshop_id
INNER JOIN locations l
ON s.city_id = l.city_id
INNER JOIN suppliers r
ON s.coffeeshop_id = r.coffeeshop_id;

SELECT * FROM EMPLOYEES;
SELECT * FROM SHOPS;
SELECT * FROM LOCATIONS;
SELECT * FROM SUPPLIERS;

/* VII.MySQL SUBQUERIES */
/*---------------------------------------------------------
71. Display employees whose salary is greater than the
    average salary.
---------------------------------------------------------*/
SELECT * FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(salary) AS avg_salary 
				FROM EMPLOYEES);

/*---------------------------------------------------------
72. Display employees whose salary is less than the average
    salary.
---------------------------------------------------------*/
SELECT * FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(salary) AS avg_salary 
				FROM EMPLOYEES);

/*---------------------------------------------------------
73. Find the employee(s) with the highest salary.
---------------------------------------------------------*/
SELECT * FROM EMPLOYEES
WHERE SALARY = (SELECT MAX(salary) AS highest_salary 
				FROM EMPLOYEES);

/*---------------------------------------------------------
74. Find the employee(s) with the lowest salary.
---------------------------------------------------------*/
SELECT * FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(salary) AS lowest_salary 
				FROM EMPLOYEES);

/*---------------------------------------------------------
75. Find the employee(s) with the second highest salary.
---------------------------------------------------------*/
SELECT * FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (
        SELECT MAX(salary)
        FROM employees)
);


/*---------------------------------------------------------
76. Find the employee(s) with the second lowest salary.
---------------------------------------------------------*/
SELECT * FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
    WHERE salary > (
        SELECT MIN(salary)
        FROM employees)
);

/*---------------------------------------------------------
77. Display employees who work in the shop with the highest
    average salary.
---------------------------------------------------------*/
SELECT * FROM employees
WHERE coffeeshop_id = (
    SELECT coffeeshop_id
    FROM employees
    GROUP BY coffeeshop_id
    ORDER BY AVG(salary) DESC
    LIMIT 1
);

/*---------------------------------------------------------
78. Display employees who work in the shop with the highest
    number of employees.
---------------------------------------------------------*/
SELECT * FROM employees
WHERE coffeeshop_id = (
    SELECT coffeeshop_id
    FROM employees
    GROUP BY coffeeshop_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

/*---------------------------------------------------------
79. Find employees earning more than the average salary of
    their own shop.
---------------------------------------------------------*/
SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE coffeeshop_id = e.coffeeshop_id
);

/*---------------------------------------------------------
80. Find employees earning less than the average salary of
    their own shop.
---------------------------------------------------------*/
SELECT * FROM employees e
WHERE salary < (
    SELECT AVG(salary)
    FROM employees
    WHERE coffeeshop_id = e.coffeeshop_id
);

/*---------------------------------------------------------
81. Display the highest-paid employee in each shop using a
    subquery.
---------------------------------------------------------*/
SELECT * FROM employees e
WHERE salary = (
    SELECT max(salary)
    FROM employees
    WHERE coffeeshop_id = e.coffeeshop_id
);

/*---------------------------------------------------------
82. Display the lowest-paid employee in each shop using a
    subquery.
---------------------------------------------------------*/
SELECT * FROM employees e
WHERE salary = (
    SELECT min(salary)
    FROM employees
    WHERE coffeeshop_id = e.coffeeshop_id
);

/*---------------------------------------------------------
83. Find employees who were hired before the average hire
    date.
---------------------------------------------------------*/
SELECT *
FROM employees
WHERE hire_date < (
    SELECT FROM_DAYS(AVG(TO_DAYS(hire_date)))
    FROM employees
);

/*---------------------------------------------------------
84. Find employees who were hired after the average hire
    date.
---------------------------------------------------------*/
SELECT *
FROM employees
WHERE hire_date > (
    SELECT FROM_DAYS(AVG(TO_DAYS(hire_date)))
    FROM employees);

/*---------------------------------------------------------
85. Display employees working in shops located in the city
    with the highest number of employees.
---------------------------------------------------------*/
-- TOTAL EMPLOYEE NUMBERS
SELECT l.city, COUNT(*) as highest_employees
FROM employees e
INNER JOIN shops s
ON e.coffeeshop_id = s.coffeeshop_id
INNER JOIN locations l
ON s.city_id = l.city_id
group by l.city
ORDER BY highest_employees DESC 
LIMIT 1; 

-- TOTAL EMPLOYEE DETAILES
SELECT * FROM employees
WHERE coffeeshop_id IN (
    SELECT s.coffeeshop_id
    FROM shops s
    INNER JOIN locations l
        ON s.city_id = l.city_id
    WHERE l.city = (
        SELECT l.city
        FROM employees e
        INNER JOIN shops s
            ON e.coffeeshop_id = s.coffeeshop_id
        INNER JOIN locations l
            ON s.city_id = l.city_id
        GROUP BY l.city
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
);

SELECT * FROM EMPLOYEES;
SELECT * FROM SHOPS;
SELECT * FROM LOCATIONS;
SELECT * FROM SUPPLIERS;

/* VIII.WINDOW FUNCTIONS */
/*---------------------------------------------------------
86. Assign a row number to each employee based on salary
    (highest to lowest).
---------------------------------------------------------*/
SELECT full_name, salary, 
ROW_NUMBER() OVER(ORDER BY salary DESC)
FROM EMPLOYEES;

/*---------------------------------------------------------
87. Rank employees based on salary using RANK().
---------------------------------------------------------*/
SELECT full_name, salary, 
RANK() OVER(ORDER BY salary DESC)
FROM EMPLOYEES;

/*---------------------------------------------------------
88. Rank employees based on salary using DENSE_RANK().
---------------------------------------------------------*/
SELECT full_name, salary, 
DENSE_RANK() OVER(ORDER BY salary DESC)
FROM EMPLOYEES;

/*---------------------------------------------------------
89. Display the top 3 highest-paid employees.
---------------------------------------------------------*/
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 3;
 
-- OR
SELECT employee_id,
       full_name,
       salary
FROM (
    SELECT employee_id,
           full_name,
           salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
    FROM employees
) AS ranked
WHERE salary_rank <= 3;

/*---------------------------------------------------------
90. Display the highest-paid employee from each shop.
---------------------------------------------------------*/
select coffeeshop_id, max(salary) 
from employees
group by coffeeshop_id;
 
/*---------------------------------------------------------
91. Display the second highest-paid employee from each shop.
---------------------------------------------------------*/
 SELECT employee_id,
       full_name,
       coffeeshop_id,
       salary
FROM (
    SELECT employee_id,
           full_name,
           coffeeshop_id,
           salary,
           DENSE_RANK() OVER (
               PARTITION BY coffeeshop_id
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employees
) AS ranked
WHERE salary_rank = 2;


/*---------------------------------------------------------
92. Display the running total of salaries ordered by
    employee ID.
---------------------------------------------------------*/
SELECT employee_id, salary,
SUM(salary) OVER(ORDER BY employee_id)
FROM EMPLOYEES;

/*---------------------------------------------------------
93. Display the cumulative average salary ordered by
    employee ID.
---------------------------------------------------------*/
SELECT employee_id,
       full_name,
       salary,
       AVG(salary) OVER (
           ORDER BY employee_id
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumulative_avg_salary
FROM employees;

/*---------------------------------------------------------
94. Display each employee's previous salary using LAG().
---------------------------------------------------------*/
SELECT full_name, salary,
LAG(salary) OVER(ORDER BY SALARY)
FROM EMPLOYEES;

/*---------------------------------------------------------
95. Display each employee's next salary using LEAD().
---------------------------------------------------------*/
SELECT full_name, salary,
LEAD(salary) OVER(ORDER BY SALARY)
FROM EMPLOYEES;

/*---------------------------------------------------------
96. Display the salary difference between an employee and
    the previous employee using LAG().
---------------------------------------------------------*/
SELECT employee_id,
       full_name,
       salary,
       salary - LAG(salary) OVER (ORDER BY employee_id) AS salary_difference
FROM employees;


/*---------------------------------------------------------
97. Divide employees into 4 salary groups using NTILE(4).
---------------------------------------------------------*/
SELECT full_name, salary,
NTILE(4) OVER(ORDER BY SALARY desc)
FROM EMPLOYEES;

/*---------------------------------------------------------
98. Display the first hired employee in each shop using
    FIRST_VALUE().
---------------------------------------------------------*/
SELECT full_name,hire_date, coffeeshop_id,
FIRST_VALUE(hire_date) OVER(PARTITION BY coffeeshop_id ORDER BY hire_date)
FROM EMPLOYEES;

/*---------------------------------------------------------
99. Display the last hired employee in each shop using
    LAST_VALUE().
---------------------------------------------------------*/
SELECT full_name,
       hire_date,
       coffeeshop_id,
       LAST_VALUE(hire_date) OVER (
           PARTITION BY coffeeshop_id
           ORDER BY hire_date
           ROWS BETWEEN UNBOUNDED PRECEDING
           AND UNBOUNDED FOLLOWING
       ) AS last_hire_date
FROM employees;

/*---------------------------------------------------------
100. Display each employee along with the average salary of
     their shop using a window function.
---------------------------------------------------------*/
SELECT employee_id, full_name, salary, coffeeshop_id,
avg(salary) OVER(PARTITION BY coffeeshop_id)
from employees;






