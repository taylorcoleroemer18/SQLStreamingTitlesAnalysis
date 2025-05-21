# 🎬 Streaming Titles Analysis SQL Project

This project analyzes a database of movies and TV shows across multiple streaming platforms to explore content distribution, genre diversity, and original vs. licensed productions.

---

## 📊 Objectives

- Count total titles per streaming platform  
- Calculate percentage share of titles by platform  
- Analyze original vs. licensed content proportions  
- Compare domestic (U.S.) vs. international content  
- Measure genre diversity and find the most common genre per platform  

---

## 🧠 Key SQL Concepts Used

- Table creation and data insertion  
- Aggregate functions (`COUNT`, `SUM`)  
- Common Table Expressions (CTEs)  
- Window functions (`RANK() OVER`)  
- Conditional aggregation with `CASE WHEN`  
- Percentage calculations and rounding  
- Grouping and filtering data  

---

## 🧩 Files in This Repo

| File                   | Description                                   |
|------------------------|-----------------------------------------------|
| `streaming_titles.sql` | Creates & populates the `streaming_titles` table |
| `analysis_queries.sql`  | SQL queries analyzing content by platform, genre, and origin |
| `README.md`            | Project overview, goals, and technical details |

---

## 📷 Sample Output

Example snippet showing percentage of original content per platform:

| platform    | original_titles | total_titles | percent_original |
|-------------|-----------------|--------------|------------------|
| Netflix     | 7               | 8            | 87.50            |
| Disney+     | 7               | 7            | 100.00           |
| Hulu        | 4               | 5            | 80.00            |
| Amazon Prime| 5               | 6            | 83.33            |

---

## 🛠 Built With

- Microsoft SQL Server / T-SQL  
- SQL Server Management Studio (SSMS) or equivalent  
- Sample streaming titles dataset  

---

## 💼 Portfolio Description

Developed a robust SQL project to explore streaming platforms' content libraries. Used advanced SQL features like CTEs and window functions to extract insights on title distribution, genre variety, and content origination, valuable for business intelligence or market analysis.

---

## 📩 Contact

Questions or feedback? Feel free to reach out or fork and adapt this project for your own learning and analysis!

