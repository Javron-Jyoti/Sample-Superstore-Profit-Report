#Sample Superstore Profit Report & CRM Analysis

This repository contains two major projects:

CRM Project (SQL) → Customer, Sales, Leads, and Rep Management with SQL-based analysis.

Sample Superstore Analysis → Business insights using SQL queries and interactive dashboards in PowerBI

Tech Stack

SQL (MySQL) → Schema design, data storage & analysis

Tableau → Interactive business dashboards

Excel → KPI dashboard with slicers & charts

Pandas (Python) → (Optional) for quick EDA

Project Structure
Sample-Superstore-Profit-Report-and-CRM-Analysis-using-SQL
 ┣ crm_project.sql              # CRM database schema & queries
 ┣ superstore_analysis.sql      # SQL queries on Sample Superstore
 ┣ Tableau_Dashboard.png        # Snapshot of Tableau Dashboard
 ┣ Excel_Dashboard.png          # Snapshot of Excel Interactive Dashboard
 ┗ README.md                    # Documentation

1. CRM Project (SQL)
Database: crm_project

The CRM project is designed to manage customers, sales reps, leads, and sales transactions.

Schema Overview

Customers → Customer profile (Name, Region, Industry, Signup Date)

SalesReps → Sales representatives and their regions

Leads → Lead source, status, and conversion tracking

Sales → Sales transactions with product and amount

RepAssignments → Mapping of reps to customers

Sample Queries

Top Customers by Spend

SELECT c.Name, SUM(s.Amount) AS TotalSpent
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.Name
ORDER BY TotalSpent DESC;


Customer Conversion Rate

SELECT 
    c.CustomerID,
    c.Name AS CustomerName,
    COUNT(l.LeadID) AS TotalLeads,
    SUM(CASE WHEN l.Status = 'Converted' THEN 1 ELSE 0 END) AS ConvertedLeads,
    ROUND(
        (SUM(CASE WHEN l.Status = 'Converted' THEN 1 ELSE 0 END) / COUNT(l.LeadID)) * 100, 2
    ) AS ConversionRate
FROM Customers c
LEFT JOIN Leads l ON c.CustomerID = l.CustomerID
GROUP BY c.CustomerID, c.Name;


Use Cases:

Customer profiling & segmentation

Lead conversion tracking

Sales rep performance analysis

Revenue contribution by customer

2. Sample Superstore Analysis

Dataset: Sample Superstore (Tableau / Kaggle dataset)

Key Analyses

Profitability Analysis → Top categories, regions, and segments

Customer Analysis → Order frequency & contribution

Sales Trends → Monthly/Yearly sales performance

Dashboards

Tableau Dashboard — Interactive visuals for profitability & trends

Excel Dashboard — KPI dashboard with slicers (Category, Segment, Region)
