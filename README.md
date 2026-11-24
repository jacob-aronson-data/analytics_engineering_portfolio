# 📊 Analytics Engineering & SQL Portfolio

Welcome to my Analytics Engineering portfolio. This repository showcases hands-on work across the modern analytics lifecycle—ranging from **database schema design (DDL/DML)** and **complex SQL transformations** to **end-to-end data pipelines** culminating in BI visualizations.

![SQL](https://img.shields.io/badge/Language-SQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![Data Modeling](https://img.shields.io/badge/Focus-Analytics_Engineering-008080?style=flat-square)
![Tableau](https://img.shields.io/badge/BI-Tableau-E97627?style=flat-square&logo=tableau&logoColor=white)

---

## 🗂️ Repository Structure

| Folder | Category | Focus & Key Skills |
| :--- | :--- | :--- |
| **[`lego_project`](./lego_project)** | End-to-End Pipeline | Data ingestion, relational modeling, and Tableau dashboarding |
| **[`olympics_project`](./olympics_project)** | End-to-End Pipeline | Multi-table joins, historical trend modeling, and Tableau visualization |
| **[`preppindata`](./preppindata)** | Data Transformation | Rebuilding 2023 Tableau Prep ETL workflows entirely in SQL |
| **[`leetcodeSQL100`](./leetcodeSQL100)** | Query Optimization | Algorithmic SQL problem solving, window functions, and edge-case logic |
| **[`other`](./other)** | Database Engineering | Schema creation (`DDL`) and record manipulation (`DML`) exercises |

---

## 🚀 End-to-End Pipeline Projects

Full-lifecycle analytics projects practicing raw data ingestion, cleaning, analytical modeling, and visual storytelling.

### 🧱 Lego Analysis Challenge — [`./lego_project`](./lego_project)
* **Overview:** An end-to-end pipeline transforming raw Lego set, theme, and part data into analytics-ready tables and an interactive summary visualization.
* **Key Skills:** Schema design, multi-table relational modeling, aggregation logic, and BI dashboard design.
* **Credit & Prompt Source:** Adapted from Will Sutton's [Lego Analysis Challenge](https://github.com/wjsutton/lego_analysis_challenge/tree/main).

### 🏅 Olympics Historical Analysis — [`./olympics_project`](./olympics_project)
* **Overview:** A complete workflow ingesting historical Olympic athlete and event datasets, modeling performance metrics in SQL, and delivering final insights via Tableau.
* **Key Skills:** Data cleansing, dimensional structuring, cohort/country aggregations, and Tableau visualization.
* **Credit & Prompt Source:** Adapted from Will Sutton's [SQL Olympics](https://github.com/wjsutton/SQL_olympics).

---

## 🛠️ SQL Transformation & Problem Solving

### 🔄 2023 Preppin' Data Challenges — [`./preppindata`](./preppindata)
* **Overview:** Solutions to the 2023 weekly challenges from [Preppin' Data](https://preppindata.blogspot.com/). While originally designed as ETL exercises for Tableau Prep, I challenged myself to solve every workflow purely in SQL.
* **Key Skills:** Common Table Expressions (CTEs), window functions, pivoting/unpivoting, regex/string parsing, and date manipulation.

### 🧠 LeetCode SQL Top 100 — [`./leetcodeSQL100`](./leetcodeSQL100)
* **Overview:** Exported solutions covering the [LeetCode SQL Top 100](https://leetcode.com/problem-list/v39x71tg/) problem list, focused on writing clean, readable, and performant queries.
* **Key Skills:** Self-joins, correlated subqueries, ranking functions (`ROW_NUMBER`, `DENSE_RANK`), running totals, and `NULL` handling.

---

## 🗄️ Database Design & Schema Management

### ⚙️ DDL & DML Exercises — [`./other`](./other)
* **Overview:** Practical exercises (`ddl_and_dml_practice`) focused on foundational database administration—building tables from scratch, enforcing data integrity, and modifying records safely.
* **Key Skills:** `CREATE`, `ALTER`, `DROP`, primary/foreign key constraints, `INSERT`, `UPDATE`, and `DELETE` operations.
* **Credit & Prompt Source:** Exercises sourced from [dbos23's SQL DDL/DML Exercises](https://github.com/dbos23/sql_ddl_dml_exercises).

---

## 💡 Core Competencies Demonstrated

* **Data Modeling & Warehousing:** Translating raw, denormalized flat files into clean, query-efficient analytical models.
* **Advanced SQL:** Modular query design using CTEs, complex conditional logic, window functions, and set operations.
* **ETL / ELT Mindset:** Taking GUI-based data prep requirements and translating them into reproducible, version-controlled SQL scripts.
* **BI & Data Storytelling:** Bridging the gap between backend SQL transformations and stakeholder-ready Tableau visuals.
