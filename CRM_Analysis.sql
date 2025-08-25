CREATE DATABASE crm_project;
USE crm_project;
CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(255),
  Region VARCHAR(255),
  Industry VARCHAR(255),
  SignupDate DATE
);

CREATE TABLE SalesReps (
  RepID INT PRIMARY KEY,
  Name VARCHAR(255),
  Region VARCHAR(255)
);

CREATE TABLE Leads (
  LeadID INT PRIMARY KEY,
  CustomerID INT,
  LeadSource VARCHAR(255),
  Status VARCHAR(255),
  ConversionDate DATE,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Sales (
  SaleID INT PRIMARY KEY,
  CustomerID INT,
  SaleDate DATE,
  Product VARCHAR(255),
  Amount DECIMAL(10,2),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE RepAssignments (
  AssignmentID INT PRIMARY KEY,
  RepID INT,
  CustomerID INT,
  FOREIGN KEY (RepID) REFERENCES SalesReps(RepID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
USE crm_project;

SELECT * FROM Customers LIMIT 10;
SELECT * FROM Sales LIMIT 10;
SELECT * FROM Leads LIMIT 10;
SELECT * FROM SalesReps LIMIT 10;
SELECT * FROM RepAssignments LIMIT 10;

SELECT c.Name, SUM(s.Amount) AS TotalSpent
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.Name
ORDER BY TotalSpent DESC;

USE crm_project;
show tables;

SELECT 
    c.CustomerID,
    c.Name AS CustomerName,
    SUM(s.Amount) AS TotalSales,
    COUNT(s.SaleID) AS NumberOfPurchases
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.Name;

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

SELECT 
    c.CustomerID,
    c.Name AS CustomerName,
    MAX(i.InteractionDate) AS LastInteractionDate,
    MAX(i.InteractionType) AS LastInteractionType
FROM Customers c
LEFT JOIN Interactions i ON c.CustomerID = i.CustomerID
GROUP BY c.CustomerID, c.Name;