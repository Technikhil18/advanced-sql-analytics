# Advanced SQL Analytics & Business Intelligence

A hands-on SQL project using MySQL 8.0+ to solve business intelligence questions with CTEs, window functions, joins, subqueries, and aggregations.

## Project Highlights

- 20 documented analytical SQL queries
- CTEs using `WITH`
- `ROW_NUMBER()`, `RANK()`, and `DENSE_RANK()`
- `LAG()` and `LEAD()`
- Running totals and cumulative revenue
- Monthly sales analysis and month-over-month growth
- Customer spending and revenue contribution
- Department payroll analysis
- `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and a MySQL FULL OUTER JOIN alternative
- Subqueries and aggregate functions

## Repository Files

- `database.sql` — creates the database, tables, and sample data
- `queries.sql` — 20 documented analytical queries
- `expected_outputs.md` — expected outputs for key queries
- `README.md` — project overview and setup instructions
- `github_post_caption.txt` — caption to share the project

## Requirements

- MySQL 8.0 or later
- MySQL Command Line Client, MySQL Workbench, or a compatible SQL editor

## How to Run

1. Run `database.sql` first.
2. Run `queries.sql` after the setup finishes.
3. Compare selected results with `expected_outputs.md`.

In MySQL Command Line Client, use `SOURCE` followed by the actual full path, for example:

```sql
SOURCE C:/path/to/advanced-sql-analytics/database.sql;
SOURCE C:/path/to/advanced-sql-analytics/queries.sql;
```

Replace `C:/path/to/...` with the actual path on your computer.

## Dataset

The project uses illustrative employee, department, customer, and sales records. Sales amounts are sample units, not a stated currency.

## MySQL Note

MySQL does not directly support `FULL OUTER JOIN`. Query 13 uses `LEFT JOIN` and `RIGHT JOIN` combined with `UNION` to return matching and unmatched rows from both sides.

## Author

Nikhil Patel

## Tags

`SQL` `MySQL` `Data Analytics` `Business Intelligence` `Window Functions` `CTE`
