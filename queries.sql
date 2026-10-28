-- =========================================================
-- Project: Advanced SQL Analytics & Business Intelligence
-- Database: MySQL 8.0+
-- File: queries.sql
-- Run database.sql before running this file.
-- =========================================================

USE AdvancedSQLAnalytics;

-- QUERY 1
-- Business question: How are employees ranked by salary in each department?
SELECT e.employee_name, d.department_name, e.salary,
       RANK() OVER (
           PARTITION BY e.department_id
           ORDER BY e.salary DESC
       ) AS salary_rank
FROM Employees e
INNER JOIN Departments d ON d.department_id = e.department_id
ORDER BY d.department_name, salary_rank, e.employee_name;

-- QUERY 2
-- Business question: Who belongs to the top three salary ranks?
WITH EmployeeRanking AS (
    SELECT employee_name, salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
    FROM Employees
)
SELECT employee_name, salary, salary_rank
FROM EmployeeRanking
WHERE salary_rank <= 3
ORDER BY salary_rank, employee_name;

-- QUERY 3
-- Business question: How does each employee's salary compare with the department average?
SELECT e.employee_name, d.department_name, e.salary,
       ROUND(AVG(e.salary) OVER (
           PARTITION BY e.department_id
       ), 2) AS department_avg_salary,
       ROUND(e.salary - AVG(e.salary) OVER (
           PARTITION BY e.department_id
       ), 2) AS difference_from_average
FROM Employees e
INNER JOIN Departments d ON d.department_id = e.department_id
ORDER BY d.department_name, e.salary DESC;

-- QUERY 4
-- Business question: What is the running salary total within each department?
SELECT employee_name, department_id, salary,
       SUM(salary) OVER (
           PARTITION BY department_id
           ORDER BY salary, employee_id
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS running_salary_total
FROM Employees
ORDER BY department_id, salary, employee_id;

-- QUERY 5
-- Business question: How does an employee's salary compare with the previous salary in their department?
SELECT employee_name, department_id, salary,
       LAG(salary) OVER (
           PARTITION BY department_id
           ORDER BY salary, employee_id
       ) AS previous_salary,
       salary - LAG(salary) OVER (
           PARTITION BY department_id
           ORDER BY salary, employee_id
       ) AS salary_difference
FROM Employees
ORDER BY department_id, salary, employee_id;

-- QUERY 6
-- Business question: What is the next employee salary within each department?
SELECT employee_name, department_id, salary,
       LEAD(salary) OVER (
           PARTITION BY department_id
           ORDER BY salary, employee_id
       ) AS next_salary
FROM Employees
ORDER BY department_id, salary, employee_id;

-- QUERY 7
-- Business question: What is the total sales revenue for each month?
WITH MonthlySales AS (
    SELECT DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
           SUM(amount) AS total_sales
    FROM Sales
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT sales_month, total_sales
FROM MonthlySales
ORDER BY sales_month;

-- QUERY 8
-- Business question: How did monthly sales change from the previous month?
WITH MonthlySales AS (
    SELECT DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
           SUM(amount) AS total_sales
    FROM Sales
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
),
SalesComparison AS (
    SELECT sales_month, total_sales,
           LAG(total_sales) OVER (ORDER BY sales_month) AS previous_month_sales
    FROM MonthlySales
)
SELECT sales_month, total_sales, previous_month_sales,
       total_sales - previous_month_sales AS sales_change,
       ROUND(
           100.0 * (total_sales - previous_month_sales)
           / NULLIF(previous_month_sales, 0), 2
       ) AS growth_percentage
FROM SalesComparison
ORDER BY sales_month;

-- QUERY 9
-- Business question: Which customers generate the most revenue, including customers with no sales?
SELECT c.customer_id, c.customer_name,
       COALESCE(SUM(s.amount), 0) AS total_spending
FROM Customers c
LEFT JOIN Sales s ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC, c.customer_name;

-- QUERY 10
-- Business question: Which employees earn more than the company-wide average salary?
SELECT employee_name, salary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees)
ORDER BY salary DESC, employee_name;

-- QUERY 11
-- Business question: How can each employee be given a unique number within their department?
SELECT employee_name, department_id, salary,
       ROW_NUMBER() OVER (
           PARTITION BY department_id
           ORDER BY salary DESC, employee_id
       ) AS employee_number
FROM Employees
ORDER BY department_id, employee_number;

-- QUERY 12
-- Business question: Which departments have an average salary greater than 70000?
SELECT d.department_name,
       COUNT(e.employee_id) AS employee_count,
       SUM(e.salary) AS total_salary,
       ROUND(AVG(e.salary), 2) AS average_salary
FROM Departments d
INNER JOIN Employees e ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING AVG(e.salary) > 70000
ORDER BY average_salary DESC;

-- QUERY 13
-- Business question: How can all matching and unmatched department/employee rows be returned?
-- MySQL does not directly support FULL OUTER JOIN.
SELECT d.department_id, d.department_name, e.employee_id, e.employee_name
FROM Departments d
LEFT JOIN Employees e ON e.department_id = d.department_id
UNION
SELECT d.department_id, d.department_name, e.employee_id, e.employee_name
FROM Departments d
RIGHT JOIN Employees e ON e.department_id = d.department_id;

-- QUERY 14
-- Business question: What is each customer's rank based on total spending?
WITH CustomerSpending AS (
    SELECT c.customer_id, c.customer_name,
           COALESCE(SUM(s.amount), 0) AS total_spending
    FROM Customers c
    LEFT JOIN Sales s ON s.customer_id = c.customer_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name, total_spending,
       DENSE_RANK() OVER (ORDER BY total_spending DESC) AS spending_rank
FROM CustomerSpending
ORDER BY spending_rank, customer_name;

-- QUERY 15
-- Business question: How does total revenue accumulate month by month?
WITH MonthlySales AS (
    SELECT DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
           SUM(amount) AS monthly_revenue
    FROM Sales
    GROUP BY DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT sales_month, monthly_revenue,
       SUM(monthly_revenue) OVER (
           ORDER BY sales_month
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumulative_revenue
FROM MonthlySales
ORDER BY sales_month;

-- QUERY 16
-- Business question: Which employees are in the top two salary positions per department?
WITH DepartmentSalaryRanks AS (
    SELECT employee_name, department_id, salary,
           DENSE_RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS department_salary_rank
    FROM Employees
)
SELECT employee_name, department_id, salary, department_salary_rank
FROM DepartmentSalaryRanks
WHERE department_salary_rank <= 2
ORDER BY department_id, department_salary_rank, employee_name;

-- QUERY 17
-- Business question: What is each department's payroll and share of company payroll?
WITH DepartmentPayroll AS (
    SELECT d.department_id, d.department_name, SUM(e.salary) AS payroll
    FROM Departments d
    INNER JOIN Employees e ON e.department_id = d.department_id
    GROUP BY d.department_id, d.department_name
)
SELECT department_name, payroll,
       ROUND(100.0 * payroll / SUM(payroll) OVER (), 2) AS payroll_share_pct
FROM DepartmentPayroll
ORDER BY payroll DESC;

-- QUERY 18
-- Business question: What is the highest sale amount for each customer?
SELECT c.customer_name, s.sale_date, s.amount,
       MAX(s.amount) OVER (PARTITION BY c.customer_id) AS customer_max_sale
FROM Customers c
INNER JOIN Sales s ON s.customer_id = c.customer_id
ORDER BY c.customer_name, s.sale_date;

-- QUERY 19
-- Business question: Which sales transactions are above the average transaction amount?
SELECT sale_id, customer_id, sale_date, amount
FROM Sales
WHERE amount > (SELECT AVG(amount) FROM Sales)
ORDER BY amount DESC;

-- QUERY 20
-- Business question: What percentage of total revenue does each customer contribute?
WITH CustomerRevenue AS (
    SELECT c.customer_id, c.customer_name,
           COALESCE(SUM(s.amount), 0) AS revenue
    FROM Customers c
    LEFT JOIN Sales s ON s.customer_id = c.customer_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name, revenue,
       ROUND(100.0 * revenue / NULLIF(SUM(revenue) OVER (), 0), 2) AS revenue_share_pct
FROM CustomerRevenue
ORDER BY revenue DESC, customer_name;
