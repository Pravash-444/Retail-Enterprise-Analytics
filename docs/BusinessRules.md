# Business Rules

## Overview

This document describes the key business rules and calculation logic used in the Retail Enterprise Analytics solution.

The rules are applied across the data engineering, warehouse, semantic model and Power BI reporting layers.

---

# 1. Sales and Revenue Rules

## Total Revenue / Gross Sales

**Total Revenue represents Gross Sales.**

Gross Sales is the total sales value before discounts are deducted.

```text
Total Revenue = Gross Sales
```
The calculation is:
```
Total Revenue =
SUM('Fact Sales'[SalesAmount])
```
## Sales / Net Sales

**Sales represents Net Sales.**

Net Sales is the sales value after the applicable discount amount is deducted.
```
Sales = Net Sales
```
The calculation is:
```
Net Sales =
SUM('Fact Sales'[NetSales])
```
## Important Terminology Clarification

The following terminology is used consistently across the Warehouse, Semantic Model, SQL analytics and Power BI reporting layers:
| Report Term   | Business Definition          |
| ------------- | ---------------------------- |
| Total Revenue | Gross Sales                  |
| Revenue       | Gross Sales                  |
| Gross Sales   | Sales value before discounts |
| Sales         | Net Sales                    |
| Net Sales     | Sales value after discounts  |

Therefore:
```
Gross Sales / Total Revenue
            ↓
     Less: Discount
            ↓
    Net Sales / Sales
```
**Total Revenue** and **Net Sales** are not the same metric.

Total Revenue represents **Gross Sales**, while Sales/Net Sales represents the value **after discounts.**

## Quantity Sold

**Quantity Sold represents the total number of units sold.**
```
Total Quantity Sold =
SUM('Fact Sales'[Quantity])
```
## Total Orders

**Total Orders represents the number of sales transactions.**

Where each SalesKey represents a sales transaction:
```
Total Orders =
COUNT('Fact Sales'[SalesKey])
```
---
# 2. Discount Rules

**Discount Amount represents the monetary discount applied to a sales transaction.**

The relationship between gross sales, discounts and net sales is:
```
Net Sales =
Gross Sales - Discount Amount
```
Discount-related metrics are used to evaluate the impact of promotions and discounts on sales performance.

---
# 3. Promotion Rules

A sales transaction may be associated with a promotion through PromotionKey.

Promotion information is maintained in Promotion.

Key promotion attributes include:


- PromotionName

- PromotionType

- DiscountPercent

- StartDate

- EndDate

Promotion analysis can be used to compare sales performance across promotional and non-promotional transactions.

---
# 4. Inventory Rules

Inventory is tracked at the product and store level.

The inventory balance follows:
```
Closing Stock =
Opening Stock + Stock Received - Stock Sold
```
The Data Quality process validates this relationship.

An inventory balance error occurs when:
```
Closing Stock != Opening Stock + Stock Received - Stock Sold
```
---
# 5. Return Rules

Returns are linked to the original sales transaction using SalesKey.

The return dataset contains:

- ReturnKey
- SalesKey
- ReturnDateKey
- CustomerKey
- ProductKey
- StoreKey
- ReturnQuantity
- ReturnAmount
- ReturnReason

Return linkage validation ensures that return transactions can be associated with the corresponding sales transactions.

---
# 6. Customer Rules

Customer analysis is based on the customer ension.

Important customer attributes include:

- LoyaltyTier
- AgeGroup
- Gender
- City
- State
- RegionKey
- JoinDate

Customers can be analyzed according to their purchasing activity, sales contribution and loyalty segment.

---
# 7. Product Rules

Product performance is analyzed using:

- Category
- SubCategory
- Brand
- Supplier
- UnitCost
- UnitPrice
- Quantity Sold
- Sales Amount
- Net Sales

Product performance can be evaluated using both revenue and volume-based metrics.

Where revenue is used, it represents Gross Sales. Where Sales or Net Sales is used, it represents the value after discounts.

---
# 8. Store Rules

Store performance is analyzed using:

- Store
- StoreType
- City
- State
- Region
- Sales
- Net Sales
- Quantity
- Orders

Store-level analysis can be used to identify high-performing and underperforming locations.

In reporting, Sales/Net Sales represents sales after discounts.

---
# 9. Regional Rules

Regions are maintained in Region.

Stores, customers and suppliers can be associated with regions through RegionKey.

Regional analysis can therefore be performed across multiple business entities.

---
# 10. Employee Rules

Employee information is maintained in Employee.

Sales performance can be analyzed using the employee associated with a sales transaction through EmployeeKey.

Employee analysis includes:

- Employee
- Department
- Designation
- Store
- Sales
- Net Sales
- Orders
- Quantity

---
# 11. Date and Time Rules

Date is the central date ension used for time-based analysis.

Important fields include:

- Date
- Year
- Quarter
- MonthNumber
- MonthName
- YearMonth
- YearMonthNumber
- WeekNumber
- Day
- DayName
- IsWeekend
- FiscalYear

YearMonthNumber is used to maintain chronological sorting of monthly reporting periods.

For example:
```
2023-01
2023-02
2023-03
...
2023-12
```
rather than alphabetical sorting.

---
# 12. Year-over-Year Analysis

Year-over-year analysis compares the current period with the corresponding period in the previous year.

For example:
```
2024 Sales
    vs
2023 Sales
```
A typical YoY growth calculation is:
```
YoY Growth % =
(Current Period - Previous Year Period)
/
Previous Year Period
```
In Power BI:
```
Total Revenue LY =
CALCULATE(
    [Total Revenue],
    DATEADD(
        'Date'[Date],
        -1,
        YEAR
    )
)
```
```
Total Revenue YoY Growth % =
VAR LY = [Total Revenue LY]

RETURN
IF(
    ISBLANK(LY) || LY = 0,
    BLANK(),
    DIVIDE(
        [Total Revenue] - LY,
        LY
    )
)
```
The measure returns blank when a valid prior-year comparison is not available or when the prior-year value is zero.

---
# 13. Moving Average Rules

A three-month moving average is used to smooth short-term fluctuations in monthly Net Sales.

The metric considers the current month and the preceding two months.
```
3M Moving Average =
Average of the latest 3 monthly Net Sales values
```
The YearMonth and YearMonthNumber fields in Date support chronological monthly analysis.

The moving average is used alongside monthly Net Sales to identify the underlying trend.

---
# 14. Active Customer Analysis

An active customer is a customer with sales activity during the selected reporting period.

Active customer metrics are therefore dependent on the current filter context.

---
# 15. Active Store Analysis

An active store represents a store considered active according to the store ension and/or having relevant sales activity within the selected reporting period.

Store performance measures should therefore be evaluated within the applicable reporting period.

---
# 16. Data Quality Rules

The data quality process includes validation of key business relationships and balances.

Important checks include:

## Customer Date Validation

Customer-related dates must satisfy the defined business date rules.

## Employee Date Validation

Employee dates must satisfy the defined business date rules.

## Promotion Date Validation

Promotion start and end dates must satisfy the defined business date rules.

## Inventory Balance Validation
```
Opening Stock
+ Stock Received
- Stock Sold
= Closing Stock
```
## Return Linkage Validation
Returns must be associated with valid sales transactions.

---
# 17. ensional Modeling Rules

The analytical model follows a ensional/star-schema-oriented structure.

ension tables provide descriptive attributes while fact tables contain transactional or measurable business events.

## Main Sales Relationships
```
Date
    ↓
FactSales

Customer
    ↓
FactSales

Product
    ↓
FactSales

Store
    ↓
FactSales

Employee
    ↓
FactSales

Promotion
    ↓
FactSales
```

---
# 18. Reporting Principles

Power BI reporting follows several principles:

- Use consistent business definitions across visuals.
- Use Gross Sales / Total Revenue when referring to sales before discounts.
- Use Sales / Net Sales when referring to sales after discounts.
- Prefer Net Sales for post-discount sales analysis.
- Use Year-over-Year metrics for period comparison.
- Use monthly trends for time-series analysis.
- Use appropriate ensions for slicing and filtering.
- Avoid interpreting incomplete periods as full-period comparisons.
- Return blank rather than misleading growth percentages when a valid comparison period does not exist.
- Use chronological date sorting for monthly analysis.

  ---
# 19. Currency Presentation

Currency values should use a consistent presentation format throughout the report.

The chosen display scale should be appropriate to the magnitude of the metric.

Examples include:
```
₹K  - Thousands
₹M  - Millions
₹B  - Billions
```
The underlying measure should remain numeric; formatting is applied at the reporting layer.

---
# 20. Business Rule Summary
```
| Area           | Primary Rule                                      |
| -------------- | ------------------------------------------------- |
| Total Revenue  | Represents Gross Sales                            |
| Gross Sales    | Sales value before discounts                      |
| Sales          | Represents Net Sales                              |
| Net Sales      | Sales value after discounts                       |
| Discount       | Gross Sales minus Net Sales                       |
| Quantity       | Sum of Quantity                                   |
| Orders         | Count of sales transactions                       |
| Inventory      | Opening + Received - Sold = Closing               |
| Returns        | Linked to original SalesKey                       |
| Promotions     | Associated through PromotionKey                   |
| Customer       | Analyzed through Customer                      |
| Product        | Analyzed through Product                       |
| Store          | Analyzed through Store                         |
| Employee       | Analyzed through Employee                      |
| Region         | Associated through RegionKey                      |
| Time           | Controlled through Date                        |
| YoY            | Current period vs corresponding prior-year period |
| Moving Average | Three-month monthly Net Sales average             |
| Data Quality   | Validate business and referential rules           |
```

---
# 21. Business Rules and Data Engineering

The business rules are implemented across multiple layers of the solution.
```
Source Data
     ↓
Bronze Lakehouse
     ↓
Validation
     ↓
Silver Transformation
     ↓
Gold Transformation
     ↓
Data Quality
     ↓
Fabric Warehouse
     ↓
Semantic Model
     ↓
Power BI
```
The same business definitions should be maintained consistently across these layers to ensure that analytical results remain aligned from source data through final reporting.










