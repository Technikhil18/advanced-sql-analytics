# Expected Outputs — Advanced SQL Analytics

Database: MySQL 8.0+

These are selected expected results calculated from the sample data in `database.sql`.

## Dataset checks

| Check | Expected |
|---|---:|
| Employees | 10 |
| Departments | 4 |
| Customers | 5 |
| Sales transactions | 10 |
| Total sales revenue | 59000 |

## Query 2 — Top three salary ranks

| Employee | Salary | Dense rank |
|---|---:|---:|
| Anjali | 95000 | 1 |
| Priya | 95000 | 1 |
| Neha | 90000 | 2 |
| Amit | 80000 | 3 |

Because `DENSE_RANK()` preserves ties, four employees are returned.

## Query 7 — Monthly sales

| Month | Total sales |
|---|---:|
| 2026-01 | 12000 |
| 2026-02 | 10000 |
| 2026-03 | 20000 |
| 2026-04 | 17000 |

## Query 8 — Month-over-month sales growth

| Month | Sales | Previous month | Change | Growth % |
|---|---:|---:|---:|---:|
| 2026-01 | 12000 | NULL | NULL | NULL |
| 2026-02 | 10000 | 12000 | -2000 | -16.67 |
| 2026-03 | 20000 | 10000 | 10000 | 100.00 |
| 2026-04 | 17000 | 20000 | -3000 | -15.00 |

## Query 9 / 14 — Customer spending and rank

| Customer | Total spending | Dense rank |
|---|---:|---:|
| Customer C | 14000 | 1 |
| Customer D | 14000 | 1 |
| Customer A | 13000 | 2 |
| Customer B | 10000 | 3 |
| Customer E | 8000 | 4 |

## Query 10 — Employees above company average

Company-wide average salary: **71500**

| Employee | Salary |
|---|---:|
| Priya | 95000 |
| Anjali | 95000 |
| Neha | 90000 |
| Amit | 80000 |
| Vikas | 75000 |

## Query 12 — Departments with average salary greater than 70000

| Department | Employee count | Total salary | Average salary |
|---|---:|---:|---:|
| IT | 3 | 270000 | 90000 |
| Finance | 2 | 165000 | 82500 |

## Query 15 — Cumulative revenue

| Month | Monthly revenue | Cumulative revenue |
|---|---:|---:|
| 2026-01 | 12000 | 12000 |
| 2026-02 | 10000 | 22000 |
| 2026-03 | 20000 | 42000 |
| 2026-04 | 17000 | 59000 |

## Notes

- Amounts are illustrative units and are not tied to a specific currency.
- MySQL does not support native `FULL OUTER JOIN` syntax. Query 13 demonstrates an equivalent pattern using `LEFT JOIN`, `RIGHT JOIN`, and `UNION`.
- Execute the SQL files in MySQL 8.0+ to validate all query results in your environment.
