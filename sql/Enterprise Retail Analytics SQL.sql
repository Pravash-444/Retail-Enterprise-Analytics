/*==============================================================
 Enterprise Retail Analytics
 SQL Analytics Script
 Warehouse : WH_Retail
 Author    : Pravash Paul
==============================================================*/

/*==============================================================
Query 1
View Customer Dimension
==============================================================*/

SELECT *
FROM dim.DimCustomer;

/*==============================================================
Query 2
View Product Dimension
==============================================================*/

SELECT *
FROM dim.DimProduct;


/*==============================================================
Query 3
View Sales Transactions
==============================================================*/

SELECT *
FROM fact.FactSales;


/*==============================================================
Query 4
Total Customers
==============================================================*/

SELECT COUNT(*) AS TotalCustomers
FROM dim.DimCustomer;


/*==============================================================
Query 5
Total Products
==============================================================*/

SELECT COUNT(*) AS TotalProducts
FROM dim.DimProduct;

/*==============================================================
Query 6
Total Stores
==============================================================*/

SELECT COUNT(*) AS TotalStores
FROM dim.DimStore;

/*==============================================================
Query 7
Total Sales Transactions
==============================================================*/

SELECT COUNT(*) AS TotalTransactions
FROM fact.FactSales;

/*==============================================================
Query 8
Total Revenue
==============================================================*/

SELECT
    SUM(NetSales) AS TotalRevenue
FROM fact.FactSales;

/*==============================================================
Query 9
Total Quantity Sold
==============================================================*/

SELECT
    SUM(Quantity) AS TotalQuantitySold
FROM fact.FactSales;

/*==============================================================
Query 10
Average Order Value
==============================================================*/

SELECT
    AVG(NetSales) AS AverageOrderValue
FROM fact.FactSales;

/*==============================================================
Query 11
Sales by Year
==============================================================*/

SELECT
    d.Year,
    SUM(f.NetSales) AS TotalRevenue
FROM fact.FactSales f
INNER JOIN dim.DimDate d
    ON f.SalesDateKey = d.DateKey
GROUP BY d.Year
ORDER BY d.Year;

/*==============================================================
Query 12
Monthly Sales
==============================================================*/

SELECT
    d.Year,
    d.MonthName,
    d.MonthNumber,
    SUM(f.NetSales) AS TotalRevenue
FROM fact.FactSales f
INNER JOIN dim.DimDate d
    ON f.SalesDateKey = d.DateKey
GROUP BY
    d.Year,
    d.MonthName,
    d.MonthNumber
ORDER BY
    d.Year,
    d.MonthNumber;

/*==============================================================
Query 13
Sales by Product Category
==============================================================*/

SELECT
    p.Category,
    SUM(f.NetSales) AS TotalRevenue
FROM fact.FactSales f
INNER JOIN dim.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY p.Category
ORDER BY TotalRevenue DESC;

/*==============================================================
Query 14
Top 10 Products
==============================================================*/

SELECT TOP (10)
    p.ProductName,
    SUM(f.NetSales) AS Revenue
FROM fact.FactSales f
INNER JOIN dim.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY
    p.ProductName
ORDER BY Revenue DESC;

/*==============================================================
Query 15
Top 10 Customers
==============================================================*/

SELECT TOP (10)
    c.CustomerName,
    SUM(f.NetSales) AS Revenue
FROM fact.FactSales f
INNER JOIN dim.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY
    c.CustomerName
ORDER BY Revenue DESC;


/*==============================================================
Query 16
Sales by Region
==============================================================*/

SELECT
    r.RegionName,
    SUM(f.NetSales) AS Revenue
FROM fact.FactSales f
INNER JOIN dim.DimStore s
    ON f.StoreKey = s.StoreKey
INNER JOIN dim.DimRegion r
    ON s.RegionKey = r.RegionKey
GROUP BY
    r.RegionName
ORDER BY
    Revenue DESC;


/*==============================================================
Query 17
Sales by Store
==============================================================*/

SELECT
    s.StoreName,
    SUM(f.NetSales) AS Revenue
FROM fact.FactSales f
INNER JOIN dim.DimStore s
    ON f.StoreKey = s.StoreKey
GROUP BY
    s.StoreName
ORDER BY Revenue DESC;

/*==============================================================
Query 18
Top 10 Customers by Orders
==============================================================*/

SELECT TOP (10)
    c.CustomerName,
    COUNT(f.SalesKey) AS TotalOrders
FROM fact.FactSales f
INNER JOIN dim.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY
    c.CustomerName
ORDER BY
    TotalOrders DESC;

/*==============================================================
Query 19
Top 10 Customers by Revenue
==============================================================*/

SELECT TOP (10)
    c.CustomerName,
    SUM(f.NetSales) AS Revenue
FROM fact.FactSales f
INNER JOIN dim.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY
    c.CustomerName
ORDER BY
    Revenue DESC;

/*==============================================================
Query 20
Average Revenue per Customer
==============================================================*/

SELECT
    AVG(CustomerRevenue) AS AverageRevenue
FROM
(
    SELECT
        CustomerKey,
        SUM(NetSales) AS CustomerRevenue
    FROM fact.FactSales
    GROUP BY CustomerKey
) AS CustomerSales;

/*==============================================================
Query 21
Revenue by Category
==============================================================*/

SELECT
    p.Category,
    SUM(f.NetSales) AS Revenue
FROM fact.FactSales f
INNER JOIN dim.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY
    p.Category
ORDER BY
    Revenue DESC;

/*==============================================================
Query 22
Best Selling Products
==============================================================*/

SELECT TOP (10)
    p.ProductName,
    SUM(f.Quantity) AS QuantitySold
FROM fact.FactSales f
INNER JOIN dim.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY
    p.ProductName
ORDER BY
    QuantitySold DESC;

/*==============================================================
Query 23
Highest Revenue Products
==============================================================*/

SELECT TOP (10)
    p.ProductName,
    SUM(f.NetSales) AS Revenue
FROM fact.FactSales f
INNER JOIN dim.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY
    p.ProductName
ORDER BY
    Revenue DESC;

/*==============================================================
Query 24
Average Selling Price
==============================================================*/

SELECT
    p.Category,
    AVG(f.UnitPrice) AS AverageSellingPrice
FROM fact.FactSales f
INNER JOIN dim.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY
    p.Category
ORDER BY
    AverageSellingPrice DESC;

/*==============================================================
Query 25
Rank Products by Revenue
==============================================================*/

SELECT
    p.ProductName,
    SUM(f.NetSales) AS Revenue,
    RANK() OVER (
        ORDER BY SUM(f.NetSales) DESC
    ) AS RevenueRank
FROM fact.FactSales f
INNER JOIN dim.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY
    p.ProductName
ORDER BY
    RevenueRank;

/*==============================================================
Query 26
Dense Rank Customers
==============================================================*/

SELECT
    c.CustomerName,
    SUM(f.NetSales) AS Revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(f.NetSales) DESC
    ) AS CustomerRank
FROM fact.FactSales f
INNER JOIN dim.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY
    c.CustomerName
ORDER BY
    CustomerRank;

/*==============================================================
Query 27
Running Total of Revenue
==============================================================*/

SELECT
    d.Date,
    SUM(f.NetSales) AS DailyRevenue,
    SUM(SUM(f.NetSales)) OVER (
        ORDER BY d.Date
    ) AS RunningTotal
FROM fact.FactSales f
INNER JOIN dim.DimDate d
    ON f.SalesDateKey = d.DateKey
GROUP BY
    d.Date
ORDER BY
    d.Date;

/*==============================================================
Query 28
Year-over-Year Sales
==============================================================*/

SELECT
    d.Year,
    SUM(f.NetSales) AS Revenue,
    LAG(SUM(f.NetSales), 1) OVER (
        ORDER BY d.Year
    ) AS PreviousYearRevenue
FROM fact.FactSales f
INNER JOIN dim.DimDate d
    ON f.SalesDateKey = d.DateKey
GROUP BY
    d.Year
ORDER BY
    d.Year;



/*==============================================================
Query 29
Top Products using CTE
==============================================================*/

WITH ProductRevenue AS
(
    SELECT
        p.ProductName,
        SUM(f.NetSales) AS Revenue
    FROM fact.FactSales f
    INNER JOIN dim.DimProduct p
        ON f.ProductKey = p.ProductKey
    GROUP BY
        p.ProductName
)

SELECT TOP (10)
    ProductName,
    Revenue
FROM ProductRevenue
ORDER BY
    Revenue DESC;


/*==============================================================
Query 30
Create Sales Summary View
==============================================================*/

CREATE OR ALTER VIEW rpt.vwSalesSummary AS

SELECT
    d.Year,
    d.MonthName,
    p.Category,
    SUM(f.NetSales) AS Revenue,
    SUM(f.Quantity) AS QuantitySold
FROM fact.FactSales f
INNER JOIN dim.DimDate d
    ON f.SalesDateKey = d.DateKey
INNER JOIN dim.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY
    d.Year,
    d.MonthName,
    p.Category;

/*==============================================================
Query the view with:
==============================================================*/

SELECT *
FROM rpt.vwSalesSummary
ORDER BY Year, MonthName;






