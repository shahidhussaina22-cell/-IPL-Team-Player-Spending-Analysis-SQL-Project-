# 🏏 IPL Team & Player Spending Analysis (SQL Project)

![SQL Language](https://img.shields.io/badge/Language-T--SQL-blue)
![Database Platform](https://img.shields.io/badge/Platform-SQL%20Server-orange)
![Project Status](https://img.shields.io/badge/Status-Completed-success)

## 📌 About This Project
In this project, I analyzed an IPL player dataset using SQL to understand how teams spend their money, which players get paid the most, and how budgets are distributed across different roles and player types. 

I wrote **11 practical, real-world SQL queries** to answer advanced sports analytics and business intelligence questions, showcasing data aggregation, window functions, pivoting, and CTEs.

---

## 🔍 What I Analyzed (Key Highlights)

* **Team Budgets:** Evaluated the total amount each IPL team spent on their squad and ranked them from highest to lowest spenders.
* **Top Performers & All-Rounders:** Identified the top 3 highest-paid All-Rounders across the entire league as well as partitioned within each individual team.
* **Star Players Comparison:** Pulled the #1 and #2 most expensive players from every franchise side-by-side using conditional aggregation to see who carries the biggest price tags.
* **Budget Share:** Calculated the exact percentage contribution of each player's price to their team's total budget.
* **Player Price Categories:** Grouped players into **High** (> ₹15 Cr), **Medium** (₹5–15 Cr), and **Low** (< ₹5 Cr) price brackets to examine how teams balance star investments with budget picks.
* **Indian vs. Overseas Pay:** Compared the average auction price of Indian players against Overseas players.
* **Above-Average Earners:** Filtered out players who earn more than their team's average salary to isolate key financial assets.

---

## 🛠️ SQL Skills & Concepts Used

* **Basic & Aggregate Queries:** `SUM`, `AVG`, `COUNT`, `GROUP BY`, `ORDER BY`
* **Advanced Window Functions:** `ROW_NUMBER()`, `OVER (PARTITION BY)` for ranking players inside teams and computing running/partition totals.
* **Common Table Expressions (CTEs):** Used `WITH` clauses to keep complex multi-step queries clean, modular, and readable.
* **Conditional Logic & Pivoting:** `CASE WHEN` statements to categorize price brackets and transform row-level ranks into horizontal views.
* **Subqueries:** Implemented standard and correlated subqueries for comparative filtering and dynamic maximum-price matching.

---

## 📂 Repository Files
* `IPL_Player_Analysis.sql` — Contains all 11 clean, optimized, and documented SQL queries.

---
*Feel free to star ⭐ this repository if you find it helpful!*
