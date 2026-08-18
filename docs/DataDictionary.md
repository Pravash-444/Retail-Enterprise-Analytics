# Data Dictionary

## Overview

This document describes the tables and important columns used in the Retail Enterprise Analytics solution.

The analytical model consists of dimension tables, fact tables and Gold reporting datasets.

---

# 1. Dimension Tables

## DimCustomer

Contains customer master information used for customer-level analysis.

| Column | Data Type | Description |
|---|---|---|
| CustomerKey | BIGINT | Surrogate key identifying the customer |
| CustomerID | STRING | Business/customer identifier |
| CustomerName | STRING | Customer name |
| Gender | STRING | Customer gender |
| DateOfBirth | DATE | Customer date of birth |
| Age | BIGINT | Customer age |
| AgeGroup | STRING | Customer age segment |
| City | STRING | Customer city |
| State | STRING | Customer state |
| RegionKey | BIGINT | Region associated with the customer |
| Email | STRING | Customer email |
| Phone | STRING | Customer phone number |
| JoinDate | DATE | Customer joining date |
| LoyaltyTier | STRING | Customer loyalty tier |

---

## DimDate

Provides the calendar and time-intelligence attributes used throughout the analytical model.

| Column | Data Type | Description |
|---|---|---|
| DateKey | BIGINT | Surrogate date key |
| Date | DATE | Calendar date |
| Year | INT | Calendar year |
| Quarter | STRING | Calendar quarter |
| MonthNumber | INT | Numeric month |
| MonthName | STRING | Month name |
| YearMonth | STRING | Year and month reporting label |
| YearMonthNumber | INT | Numeric year-month sorting key |
| WeekNumber | BIGINT | Week number |
| Day | INT | Day of month |
| DayName | STRING | Day name |
| IsWeekend | BOOLEAN | Indicates whether the date falls on a weekend |
| FiscalYear | INT | Fiscal year |

`YearMonth` and `YearMonthNumber` support chronological monthly analysis and time-intelligence reporting, including moving-average analysis.

---

## DimEmployee

Contains employee master information.

| Column | Data Type | Description |
|---|---|---|
| EmployeeKey | BIGINT | Surrogate employee key |
| EmployeeID | STRING | Business employee identifier |
| EmployeeName | STRING | Employee name |
| Department | STRING | Employee department |
| Designation | STRING | Employee designation |
| StoreKey | BIGINT | Store associated with the employee |
| HireDate | DATE | Employee hire date |
| Salary | DOUBLE | Employee salary |

---

## DimProduct

Contains product master information.

| Column | Data Type | Description |
|---|---|---|
| ProductKey | BIGINT | Surrogate product key |
| ProductCode | STRING | Product business code |
| ProductName | STRING | Product name |
| Category | STRING | Product category |
| SubCategory | STRING | Product subcategory |
| Brand | STRING | Product brand |
| SupplierKey | BIGINT | Supplier associated with the product |
| UnitCost | DOUBLE | Product unit cost |
| UnitPrice | DOUBLE | Product unit selling price |
| IsActive | BOOLEAN | Indicates whether the product is active |

---

## DimPromotion

Contains promotion master information.

| Column | Data Type | Description |
|---|---|---|
| PromotionKey | BIGINT | Surrogate promotion key |
| PromotionName | STRING | Promotion name |
| PromotionType | STRING | Promotion type |
| DiscountPercent | BIGINT | Promotion discount percentage |
| StartDate | DATE | Promotion start date |
| EndDate | DATE | Promotion end date |

---

## DimRegion

Contains geographical region information.

| Column | Data Type | Description |
|---|---|---|
| RegionKey | BIGINT | Surrogate region key |
| RegionName | STRING | Region name |
| Country | STRING | Country associated with the region |

---

## DimStore

Contains store master information.

| Column | Data Type | Description |
|---|---|---|
| StoreKey | BIGINT | Surrogate store key |
| StoreCode | STRING | Store business code |
| StoreName | STRING | Store name |
| City | STRING | Store city |
| State | STRING | Store state |
| RegionKey | BIGINT | Region associated with the store |
| StoreType | STRING | Store type |
| OpeningDate | DATE | Store opening date |
| IsActive | BOOLEAN | Indicates whether the store is active |

---

## DimSupplier

Contains supplier master information.

| Column | Data Type | Description |
|---|---|---|
| SupplierKey | BIGINT | Surrogate supplier key |
| SupplierCode | STRING | Supplier business code |
| SupplierName | STRING | Supplier name |
| GSTIN | STRING | Supplier GST identification number |
| City | STRING | Supplier city |
| State | STRING | Supplier state |
| RegionKey | BIGINT | Region associated with the supplier |

---

# 2. Fact Tables

## FactSales

Contains individual retail sales transactions.

| Column | Data Type | Description |
|---|---|---|
| SalesKey | BIGINT | Unique sales transaction identifier |
| SalesDateKey | BIGINT | Date key associated with the sale |
| CustomerKey | BIGINT | Customer associated with the sale |
| ProductKey | BIGINT | Product sold |
| StoreKey | BIGINT | Store where the sale occurred |
| EmployeeKey | BIGINT | Employee associated with the sale |
| PromotionKey | BIGINT | Promotion associated with the sale |
| Quantity | BIGINT | Quantity sold |
| UnitPrice | DOUBLE | Selling price per unit |
| DiscountAmount | DOUBLE | Discount amount applied |
| SalesAmount | DOUBLE | Sales amount before discount |
| NetSales | DOUBLE | Sales amount after discount |

---

## FactInventory

Contains inventory movement and stock balance information.

| Column | Data Type | Description |
|---|---|---|
| InventoryKey | BIGINT | Unique inventory record identifier |
| DateKey | BIGINT | Date associated with the inventory record |
| ProductKey | BIGINT | Product associated with the inventory record |
| StoreKey | BIGINT | Store associated with the inventory record |
| OpeningStock | BIGINT | Opening inventory quantity |
| StockReceived | BIGINT | Quantity received during the period |
| StockSold | BIGINT | Quantity sold during the period |
| ClosingStock | BIGINT | Closing inventory quantity |

The inventory balance follows the relationship:

```text
Closing Stock =
Opening Stock + Stock Received - Stock Sold
```

---

## FactReturns

Contains returned sales transaction information.

| Column | Data Type | Description |
|---|---|---|
| ReturnKey | BIGINT | Unique return identifier |
| SalesKey | BIGINT | Related sales transaction |
| ReturnDateKey | BIGINT | Date key associated with the return |
| CustomerKey | BIGINT | Customer associated with the return |
| ProductKey | BIGINT | Returned product |
| StoreKey | BIGINT | Store associated with the return |
| ReturnQuantity | BIGINT | Quantity returned |
| ReturnAmount | DOUBLE | Monetary value of the return |
| ReturnReason | STRING | Reason for the return |

---

# 3. Gold Reporting Tables

## GoldSalesDaily

Daily aggregated sales dataset used for reporting and trend analysis.

| Column | Data Type | Description |
|---|---|---|
| SalesDateKey | BIGINT | Sales date key |
| TotalSales | DOUBLE | Total sales amount |
| TotalNetSales | DOUBLE | Total net sales |
| TotalDiscount | DOUBLE | Total discount amount |
| TotalQuantity | BIGINT | Total quantity sold |
| TotalOrders | BIGINT | Total orders |
| Date | DATE | Calendar date |
| Year | INT | Calendar year |
| Quarter | STRING | Calendar quarter |
| MonthNumber | INT | Numeric month |
| MonthName | STRING | Month name |
| YearMonth | STRING | Year-month reporting label |
| YearMonthNumber | INT | Numeric year-month sorting key |
| WeekNumber | BIGINT | Week number |
| Day | INT | Day of month |
| DayName | STRING | Day name |
| IsWeekend | BOOLEAN | Weekend indicator |
| FiscalYear | INT | Fiscal year |

---

## GoldSalesMonthly

Monthly aggregated sales dataset.

| Column | Data Type | Description |
|---|---|---|
| Year | INT | Calendar year |
| Quarter | STRING | Calendar quarter |
| MonthNumber | INT | Numeric month |
| MonthName | STRING | Month name |
| FiscalYear | INT | Fiscal year |
| MonthlySales | DOUBLE | Monthly sales |
| MonthlyNetSales | DOUBLE | Monthly net sales |
| MonthlyDiscount | DOUBLE | Monthly discount |
| MonthlyQuantity | BIGINT | Monthly quantity sold |
| MonthlyOrders | BIGINT | Monthly order count |

---

## GoldProductPerformance

Aggregated product-level performance dataset.

| Column | Data Type | Description |
|---|---|---|
| ProductKey | BIGINT | Product key |
| TotalSales | DOUBLE | Total sales |
| TotalNetSales | DOUBLE | Total net sales |
| TotalDiscount | DOUBLE | Total discount |
| TotalQuantity | BIGINT | Total quantity sold |
| TotalOrders | BIGINT | Total orders |
| ProductCode | STRING | Product code |
| ProductName | STRING | Product name |
| Category | STRING | Product category |
| SubCategory | STRING | Product subcategory |
| Brand | STRING | Product brand |
| SupplierKey | BIGINT | Supplier key |
| UnitCost | DOUBLE | Unit cost |
| UnitPrice | DOUBLE | Unit price |
| IsActive | BOOLEAN | Product active status |

---

## GoldStorePerformance

Aggregated store-level performance dataset.

| Column | Data Type | Description |
|---|---|---|
| RegionKey | BIGINT | Region key |
| StoreKey | BIGINT | Store key |
| TotalSales | DOUBLE | Total sales |
| TotalNetSales | DOUBLE | Total net sales |
| TotalDiscount | DOUBLE | Total discount |
| TotalQuantity | BIGINT | Total quantity sold |
| TotalOrders | BIGINT | Total orders |
| StoreCode | STRING | Store code |
| StoreName | STRING | Store name |
| City | STRING | Store city |
| State | STRING | Store state |
| StoreType | STRING | Store type |
| OpeningDate | DATE | Store opening date |
| IsActive | BOOLEAN | Store active status |
| RegionName | STRING | Region name |
| Country | STRING | Country |

---

## GoldCustomerPerformance

Aggregated customer-level performance dataset.

| Column | Data Type | Description |
|---|---|---|
| CustomerKey | BIGINT | Customer key |
| TotalSales | DOUBLE | Total sales |
| TotalNetSales | DOUBLE | Total net sales |
| TotalDiscount | DOUBLE | Total discount |
| TotalQuantity | BIGINT | Total quantity purchased |
| TotalOrders | BIGINT | Total orders |
| CustomerID | STRING | Customer identifier |
| CustomerName | STRING | Customer name |
| Gender | STRING | Customer gender |
| DateOfBirth | DATE | Customer date of birth |
| Age | BIGINT | Customer age |
| AgeGroup | STRING | Customer age group |
| City | STRING | Customer city |
| State | STRING | Customer state |
| RegionKey | BIGINT | Region key |
| Email | STRING | Customer email |
| Phone | STRING | Customer phone |
| JoinDate | DATE | Customer joining date |
| LoyaltyTier | STRING | Customer loyalty tier |

---

## GoldInventorySummary

Aggregated inventory dataset by store and product.

| Column | Data Type | Description |
|---|---|---|
| StoreKey | BIGINT | Store key |
| ProductKey | BIGINT | Product key |
| OpeningStock | BIGINT | Opening stock |
| StockReceived | BIGINT | Stock received |
| StockSold | BIGINT | Stock sold |
| ClosingStock | BIGINT | Closing stock |
| ProductName | STRING | Product name |
| Category | STRING | Product category |
| SubCategory | STRING | Product subcategory |
| Brand | STRING | Product brand |
| StoreName | STRING | Store name |
| StoreType | STRING | Store type |
| City | STRING | Store city |
| State | STRING | Store state |

---

## GoldReturnsSummary

Aggregated returns dataset by store and product.

| Column | Data Type | Description |
|---|---|---|
| StoreKey | BIGINT | Store key |
| ProductKey | BIGINT | Product key |
| TotalReturnedQuantity | BIGINT | Total returned quantity |
| TotalReturnAmount | DOUBLE | Total return amount |
| TotalReturnTransactions | BIGINT | Total return transactions |
| ProductName | STRING | Product name |
| Category | STRING | Product category |
| SubCategory | STRING | Product subcategory |
| Brand | STRING | Product brand |
| StoreName | STRING | Store name |
| StoreType | STRING | Store type |
| City | STRING | Store city |
| State | STRING | Store state |

---

# 4. Data Model Classification

The tables can be broadly classified as follows.

### Dimensions

```text
DimDate
DimCustomer
DimProduct
DimStore
DimRegion
DimSupplier
DimEmployee
DimPromotion
```

### Facts

```text
FactSales
FactInventory
FactReturns
```

### Gold Reporting / Analytical Tables

```text
GoldSalesDaily
GoldSalesMonthly
GoldProductPerformance
GoldStorePerformance
GoldCustomerPerformance
GoldInventorySummary
GoldReturnsSummary
```

---

# 5. Key Analytical Fields

Several fields are particularly important for Power BI analysis.

### Sales

- SalesAmount
- NetSales
- Quantity
- DiscountAmount

### Time

- Date
- Year
- Quarter
- MonthNumber
- MonthName
- YearMonth
- YearMonthNumber
- FiscalYear

### Customer

- CustomerKey
- CustomerID
- LoyaltyTier
- AgeGroup
- RegionKey

### Product

- ProductKey
- Category
- SubCategory
- Brand
- SupplierKey

### Store

- StoreKey
- StoreType
- RegionKey
- RegionName

### Inventory

- OpeningStock
- StockReceived
- StockSold
- ClosingStock

### Returns

- ReturnQuantity
- ReturnAmount
- ReturnReason
