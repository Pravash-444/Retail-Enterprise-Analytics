# Data Flow

## Overview

The Retail Enterprise Analytics solution processes retail source data through a sequence of data engineering and analytics layers in Microsoft Fabric.

The data flow begins with source Parquet files uploaded to the Bronze Lakehouse and ends with the Fabric Warehouse, Semantic Model and Power BI reporting layer.

---

# End-to-End Data Flow

```text
Source Parquet Files
        │
        ▼
Bronze Lakehouse Files
        │
        ▼
NB01 - Data Ingestion
        │
        ▼
Bronze Delta Tables
        │
        ▼
NB02 - Data Validation
        │
        ▼
NB03 - Medallion Transformation
Bronze → Silver
        │
        ▼
Silver Lakehouse
        │
        ▼
NB04 - Silver → Gold Transformation
        │
        ▼
Gold Lakehouse
        │
        ▼
NB05 - Data Quality
        │
        ▼
NB06 - Gold → Warehouse Transformation
        │
        ▼
Fabric Warehouse
        │
        ▼
Semantic Model
        │
        ▼
Power BI Report
```

---

# 1. Source Data

The solution receives source data as Parquet files.

The source entities used by the analytics solution are:

### Dimension Tables

```text
DimCustomer
DimDate
DimEmployee
DimProduct
DimPromotion
DimRegion
DimStore
DimSupplier
```

### Fact Tables

```text
FactSales
FactInventory
FactReturns
```

The source files are uploaded into the **Files** area of the Bronze Lakehouse.

---

# 2. Bronze Lakehouse

The Bronze Lakehouse is the initial ingestion layer.

The source Parquet files are stored in the Bronze Lakehouse **Files** area.

The purpose of this layer is to provide a centralized landing area for the source data before analytical transformations are applied.

---

# 3. NB01 - Data Ingestion

The first notebook reads the Parquet files from the Bronze Lakehouse Files area.

The data is loaded into Spark DataFrames and written as Delta tables.

## Processing Flow

```text
Parquet Files
      ↓
Spark DataFrames
      ↓
Delta Tables
      ↓
Bronze Lakehouse
```

The notebook loads the dimension and fact tables required for downstream processing.

---

# 4. NB02 - Data Validation

The second notebook validates the ingested data.

Validation is performed before the data moves through the transformation pipeline.

The validation process checks data consistency and business relationships within the dataset.

Examples include:

- Customer date validation
- Employee date validation
- Promotion date validation
- Inventory balance validation
- Return linkage validation

The validation results are used to identify data issues before downstream processing.

---

# 5. NB03 - Bronze to Silver Transformation

The third notebook performs the Medallion transformation from Bronze to Silver.

```text
Bronze
   │
   ▼
Cleaning
   │
   ▼
Standardization
   │
   ▼
Silver
```

The Silver layer contains processed and standardized data suitable for further analytical transformation.

---

# 6. NB04 - Silver to Gold Transformation

The fourth notebook transforms the Silver data into business-ready Gold datasets.

The Gold layer contains analytical datasets designed for reporting and business analysis.

The Gold datasets include:

```text
GoldSalesDaily
GoldSalesMonthly
GoldProductPerformance
GoldStorePerformance
GoldCustomerPerformance
GoldInventorySummary
GoldReturnsSummary
```

### Transformation Flow

```text
Silver
   │
   ▼
Business Transformations
   │
   ▼
Aggregations
   │
   ▼
Gold Analytical Datasets
```

---

# 7. NB05 - Data Quality

The fifth notebook performs Data Quality checks on the processed data.

The objective is to ensure that the datasets meet defined quality and business expectations before they are published to the Warehouse.

Examples of validated conditions include:

- Date consistency
- Inventory balance consistency
- Return linkage
- Business rule validation
- Data completeness
- Data consistency

---

# 8. NB06 - Gold to Warehouse Transformation

The sixth notebook publishes the processed Gold datasets to the Fabric Warehouse.

The Warehouse is organized into three logical schemas:

```text
WH_Retail
│
├── dim
├── fact
└── rpt
```

## Dimension Schema

The `dim` schema contains the published dimension tables.

Unlike the source/generated dimension names, the Warehouse uses simplified table names without the `Dim` prefix:

```text
Customer
Date
Product
Store
Region
Supplier
Employee
Promotion
```

## Fact Schema

The `fact` schema contains:

```text
FactSales
FactInventory
FactReturns
```

## Reporting Schema

The `rpt` schema contains:

```text
GoldSalesDaily
GoldSalesMonthly
GoldProductPerformance
GoldStorePerformance
GoldCustomerPerformance
GoldInventorySummary
GoldReturnsSummary
```

This naming convention reflects the actual table names implemented in the Fabric Warehouse.

---

# 9. Semantic Model

The Fabric Warehouse is used as the source for the analytical semantic model.

The semantic model provides the business relationships and analytical structure required by Power BI.

It supports:

- Dimension-to-fact relationships
- Business measures
- Time intelligence
- Year-over-year analysis
- Moving averages
- KPI calculations

---

# 10. Power BI Reporting

Power BI Desktop connects to the Fabric Warehouse through the Warehouse SQL endpoint.

The Power BI report provides interactive analysis across:

- Sales
- Products
- Customers
- Stores
- Regions
- Employees
- Promotions
- Inventory
- Returns

The report contains **9 analytical pages** designed for business and management reporting.

---

# End-to-End Processing Summary

```text
Source Parquet
      ↓
Bronze Lakehouse Files
      ↓
NB01 - Ingestion
      ↓
Bronze Delta Tables
      ↓
NB02 - Validation
      ↓
NB03 - Bronze → Silver
      ↓
Silver Lakehouse
      ↓
NB04 - Silver → Gold
      ↓
Gold Lakehouse
      ↓
NB05 - Data Quality
      ↓
NB06 - Gold → Warehouse
      ↓
Fabric Warehouse
      ↓
Semantic Model
      ↓
Power BI
```

---

# Key Design Principle

Each stage has a defined responsibility:

| Layer / Process | Responsibility |
|---|---|
| Source | Provide source data |
| Bronze | Land and ingest source data |
| Validation | Identify data issues |
| Silver | Clean and standardize data |
| Gold | Prepare business-ready analytical datasets |
| Data Quality | Verify data quality |
| Warehouse | Provide structured analytical storage |
| Semantic Model | Provide business relationships and calculations |
| Power BI | Provide interactive reporting and visualization |

The solution separates ingestion, validation, transformation, data quality, warehouse storage and reporting responsibilities to provide a structured and maintainable analytics workflow.
