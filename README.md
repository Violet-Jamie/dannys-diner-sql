# Danny's Diner SQL Case Study

## Project Overview

This project is a SQL case study based on **Danny's Diner**, a Japanese restaurant selling sushi, curry, and ramen.

The goal is to use SQL to answer business questions about:

- Customer spending
- Restaurant visits
- Popular menu items
- Customer purchasing patterns
- Membership behaviour
- Loyalty points

## Business Questions

The SQL analysis answers 10 questions:

1. What is the total amount each customer spent?
2. How many days has each customer visited the restaurant?
3. What was the first item purchased by each customer?
4. What is the most purchased item overall?
5. Which item was most popular for each customer?
6. What was the first item purchased after becoming a member?
7. What was purchased just before becoming a member?
8. How many items and how much money did each member spend before joining?
9. How many loyalty points did each customer earn?
10. How many points did members A and B have at the end of January after applying the first-week bonus?

## Tools Used

- MySQL
- MySQL Workbench
- SQL

## SQL Concepts Practised

- `SELECT`
- `FROM`
- `WHERE`
- `JOIN`
- `GROUP BY`
- `ORDER BY`
- `LIMIT`
- `COUNT()`
- `SUM()`
- `MIN()`
- `MAX()`
- `DISTINCT`
- `CASE WHEN`
- Subqueries
- Common Table Expressions (CTEs)
- Date functions

## Key Findings

- Customer A spent **$76**.
- Customer B spent **$74**.
- Customer C spent **$36**.
- Ramen was the most purchased menu item overall, with **8 purchases**.
- Before membership, A spent **$25** across 2 items, while B spent **$40** across 3 items.
- Under the loyalty-points rules, A earned **860 points**, B earned **940 points**, and C earned **360 points**.
- After applying the first-week 2x bonus through the end of January, A had **1,370 points** and B had **1,020 points**.

## Repository Structure

```text
dannys-diner-sql/
│
├── dannys_diner_case_study.sql
└── README.md
```

## Source

Danny's Diner Case Study — 8 Week SQL Challenge.

This project was completed as part of a SQL/data analytics learning project.
