-- =========================================================
-- Project: Advanced SQL Analytics & Business Intelligence
-- Database: MySQL 8.0+
-- File: database.sql
-- =========================================================

CREATE DATABASE IF NOT EXISTS AdvancedSQLAnalytics;
USE AdvancedSQLAnalytics;

DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

INSERT INTO Departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    FOREIGN KEY (department_id)
        REFERENCES Departments(department_id)
);

INSERT INTO Employees VALUES
(101, 'Amit', 1, 80000, '2022-01-15'),
(102, 'Priya', 1, 95000, '2021-03-10'),
(103, 'Rahul', 2, 50000, '2023-06-20'),
(104, 'Sneha', 2, 55000, '2022-09-05'),
(105, 'Vikas', 3, 75000, '2020-11-12'),
(106, 'Neha', 3, 90000, '2021-07-18'),
(107, 'Karan', 4, 60000, '2023-02-01'),
(108, 'Anjali', 1, 95000, '2020-05-25'),
(109, 'Rohit', 4, 65000, '2022-12-15'),
(110, 'Pooja', 2, 50000, '2024-01-10');

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Customer A', 'Raipur'),
(2, 'Customer B', 'Bhilai'),
(3, 'Customer C', 'Durg'),
(4, 'Customer D', 'Bilaspur'),
(5, 'Customer E', 'Raipur');

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    sale_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);

INSERT INTO Sales VALUES
(1001, 1, '2026-01-05', 5000),
(1002, 2, '2026-01-10', 7000),
(1003, 3, '2026-02-02', 4000),
(1004, 1, '2026-02-15', 6000),
(1005, 4, '2026-03-01', 9000),
(1006, 2, '2026-03-12', 3000),
(1007, 5, '2026-03-20', 8000),
(1008, 3, '2026-04-05', 10000),
(1009, 1, '2026-04-18', 2000),
(1010, 4, '2026-04-25', 5000);

-- Basic validation
SHOW TABLES;
SELECT COUNT(*) AS employee_count FROM Employees;
SELECT COUNT(*) AS department_count FROM Departments;
SELECT COUNT(*) AS customer_count FROM Customers;
SELECT COUNT(*) AS sales_transaction_count FROM Sales;
SELECT SUM(amount) AS total_sales_revenue FROM Sales;
