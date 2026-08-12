# Fabric Warehouse

## Overview

The Fabric Warehouse provides the structured analytical serving layer for the Retail Enterprise Analytics solution.

The Warehouse receives processed and business-ready data from the Gold layer and provides the primary data source for the analytical semantic model and Power BI reporting.

The Warehouse is named:

WH_Retail

## 1. Warehouse Architecture

The Warehouse is organized into three logical schemas:

```text
WH_Retail
│
├── dim
│
├── fact
│
└── rpt
```
Each schema has a specific responsibility.

| Schema | Purpose                                      |
| ------ | -------------------------------------------- |
| `dim`  | Dimension and descriptive business entities  |
| `fact` | Transactional and measurable business events |
| `rpt`  | Reporting and analytical datasets            |

## 2. Dimension Schema

The dim schema contains the dimension tables used to provide descriptive attributes for analytical reporting.
```
dim
├── DimCustomer
├── DimDate
├── DimEmployee
├── DimProduct
├── DimPromotion
├── DimRegion
├── DimStore
└── DimSupplier
```

### DimCustomer

Contains customer master information.

Key analytical attributes include:
```
Customer
Gender
Age
AgeGroup
City
State
Region
LoyaltyTier
JoinDate

```

The table supports customer-level sales and customer segmentation analysis.

### DimDate

Contains calendar and fiscal date attributes used for time-based analysis.

Important attributes include:
```
Date
Year
Quarter
MonthNumber
MonthName
YearMonth
YearMonthNumber
WeekNumber
Day
DayName
IsWeekend
FiscalYear
```
DimDate acts as the central date dimension for time-based reporting.

### DimEmployee

Contains employee master information.

Important attributes include:
```
Employee
Department
Designation
Store
HireDate
Salary
```
The table supports employee-level sales performance analysis.

### DimProduct

Contains product master information.

Important attributes include:
```
Product
Category
SubCategory
Brand
Supplier
UnitCost
UnitPrice
Active Status
```
The table supports product and category performance analysis.

### DimPromotion

Contains promotion master information.

Important attributes include:
```
Promotion
PromotionType
DiscountPercent
StartDate
EndDate
```
The table supports promotion and discount analysis.

### DimRegion

Contains geographical region information.

Important attributes include:
```
Region
Country
```
The table supports regional performance analysis.

### DimStore

Contains store master information.

Important attributes include:
```
Store
City
State
Region
StoreType
OpeningDate
Active Status
```
The table supports store and regional performance analysis.

### DimSupplier

Contains supplier master information.

Important attributes include:
```
Supplier
SupplierCode
GSTIN
City
State
Region
```
The table supports supplier and product-related analysis.

## 3. Fact Schema

The fact schema contains transactional and measurable business events.
```
fact
├── FactInventory
├── FactReturns
└── FactSales
```

### FactSales

Contains retail sales transactions.

Important measures and keys include:
```
SalesKey
SalesDateKey
CustomerKey
ProductKey
StoreKey
EmployeeKey
PromotionKey
Quantity
UnitPrice
DiscountAmount
SalesAmount
NetSales
```
FactSales is the primary transactional fact table used for sales and revenue analysis.

### FactInventory

Contains inventory movement and stock information.

Important fields include:
```
InventoryKey
DateKey
ProductKey
StoreKey
OpeningStock
StockReceived
StockSold
ClosingStock
```
Inventory balance is validated using:

```
Closing Stock =
Opening Stock + Stock Received - Stock Sold
```

### FactReturns

Contains product return transactions.

Important fields include:
```
ReturnKey
SalesKey
ReturnDateKey
CustomerKey
ProductKey
StoreKey
ReturnQuantity
ReturnAmount
ReturnReason
```
SalesKey provides the link between a return transaction and the original sales transaction.

## 4. Reporting Schema

The rpt schema contains reporting-oriented and analytical datasets.
```
rpt
├── GoldCustomerPerformance
├── GoldInventorySummary
├── GoldProductPerformance
├── GoldReturnsSummary
├── GoldSalesDaily
├── GoldSalesMonthly
├── GoldStorePerformance
└── vwSalesSummary
```

### GoldCustomerPerformance

Provides aggregated customer-level performance information.

It supports analysis of:
```
Customer sales
Net sales
Discounts
Quantity
Orders
Customer demographics
Loyalty tiers
```

### GoldInventorySummary

Provides inventory information at the product and store level.

It supports analysis of:
```
Opening stock
Stock received
Stock sold
Closing stock
Product
Category
Store
Location
```

### GoldProductPerformance

Provides aggregated product-level performance.

It supports analysis of:
```
Sales
Net sales
Discounts
Quantity
Orders
Product
Category
SubCategory
Brand
Supplier
```

### GoldReturnsSummary

Provides aggregated return information.

It supports analysis of:
```
Returned quantity
Return amount
Return transactions
Product
Category
Brand
Store
Location
```

### GoldSalesDaily

Provides daily aggregated sales information.

It contains metrics such as:
```
Total Sales
Total Net Sales
Total Discount
Total Quantity
Total Orders
```
It also contains calendar attributes for daily and time-based reporting.

### GoldSalesMonthly

Provides monthly aggregated sales information.

It supports analysis of:
```
Monthly Sales
Monthly Net Sales
Monthly Discount
Monthly Quantity
Monthly Orders
Year
Quarter
Month
Fiscal Year
```

### GoldStorePerformance

Provides aggregated store-level performance information.

It supports analysis of:
```
Sales
Net Sales
Discounts
Quantity
Orders
Store
Store Type
City
State
Region
```

## 5. Sales Reporting View
vwSalesSummary

The rpt schema also contains the reporting view:
```
rpt.vwSalesSummary
```
This view provides a reporting-oriented representation of sales information.

It is part of the Warehouse reporting layer and can be used for SQL-based analytical consumption where appropriate.

## 6. Warehouse Object Summary

The final Warehouse contains the following objects.
### Dimension Tables
```
| Schema | Object       |
| ------ | ------------ |
| dim    | DimCustomer  |
| dim    | DimDate      |
| dim    | DimEmployee  |
| dim    | DimProduct   |
| dim    | DimPromotion |
| dim    | DimRegion    |
| dim    | DimStore     |
| dim    | DimSupplier  |
```
### Fact Tables
```
| Schema | Object        |
| ------ | ------------- |
| fact   | FactInventory |
| fact   | FactReturns   |
| fact   | FactSales     |
```
### Reporting Tables
```
| Schema | Object                  |
| ------ | ----------------------- |
| rpt    | GoldCustomerPerformance |
| rpt    | GoldInventorySummary    |
| rpt    | GoldProductPerformance  |
| rpt    | GoldReturnsSummary      |
| rpt    | GoldSalesDaily          |
| rpt    | GoldSalesMonthly        |
| rpt    | GoldStorePerformance    |
```
### Reporting View
```
| Schema | Object         |
| ------ | -------------- |
| rpt    | vwSalesSummary |
```

## 7. Warehouse Data Flow

The Warehouse receives data from the Gold Lakehouse layer.
```
Gold Lakehouse
      │
      ▼
NB06 - Gold to Warehouse
      │
      ▼
WH_Retail
      │
      ├── dim
      │
      ├── fact
      │
      └── rpt
      │
      ▼
Semantic Model
      │
      ▼
Power BI
```
## 8. Warehouse Role in the Architecture

The Warehouse acts as the structured serving layer between the data engineering platform and the business intelligence layer.

Its responsibilities include:
```
Providing structured analytical tables
Separating dimensions and facts
Providing reporting-oriented datasets
Supporting SQL-based analysis
Serving as the source for the semantic model
Providing a stable analytical layer for Power BI
```

## 9. Analytical Model

The core analytical model is based around the sales fact table and related dimensions.

Conceptually:
```
                    DimDate
                       │
                       │
DimCustomer ─────── FactSales ─────── DimProduct
                       │
                       │
                   DimStore
                       │
              ┌────────┴────────┐
              │                 │
        DimEmployee       DimPromotion
```
Additional dimensions and facts support inventory, returns, supplier and regional analysis.

## 10. Warehouse and Semantic Model

The Fabric Warehouse serves as the source for the analytical semantic model.

The semantic model provides:
```
Business relationships
Measures
Time intelligence
KPI calculations
Filtering and slicing
Analytical calculations
```
Power BI consumes the semantic model rather than directly implementing the underlying data-engineering transformations.

## 11. Warehouse and Power BI

The final reporting architecture is:
```
Source Data
     ↓
Bronze Lakehouse
     ↓
Silver Lakehouse
     ↓
Gold Lakehouse
     ↓
Fabric Warehouse
     ↓
Semantic Model
     ↓
Power BI
```
Power BI Desktop connects to the Fabric Warehouse through the Warehouse SQL endpoint during model/report development.

## 12. Design Principles

The Warehouse design follows these principles:
```
Separate dimensions from facts.
Keep transactional data in fact tables.
Keep descriptive business entities in dimension tables.
Maintain reporting-oriented datasets separately in the rpt schema.
Use a central date dimension for time analysis.
Provide a structured serving layer for downstream analytics.
Keep business reporting logic in the semantic model and reporting layer where appropriate.
```

## 13. Final Warehouse Structure
```
WH_Retail
│
├── dim
│   ├── DimCustomer
│   ├── DimDate
│   ├── DimEmployee
│   ├── DimProduct
│   ├── DimPromotion
│   ├── DimRegion
│   ├── DimStore
│   └── DimSupplier
│
├── fact
│   ├── FactInventory
│   ├── FactReturns
│   └── FactSales
│
└── rpt
    ├── GoldCustomerPerformance
    ├── GoldInventorySummary
    ├── GoldProductPerformance
    ├── GoldReturnsSummary
    ├── GoldSalesDaily
    ├── GoldSalesMonthly
    ├── GoldStorePerformance
    └── vwSalesSummary
```
### Summary

The Fabric Warehouse provides the structured analytical layer of the Retail Enterprise Analytics solution.

It separates:

**Dimensions** for descriptive analysis

**Facts** for transactional measurements

**Reporting objects** for analytical consumption

The Warehouse then serves as the foundation for the semantic model and final Power BI reporting solution.
