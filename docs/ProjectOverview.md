# Retail Enterprise Analytics

## 1. Project Overview

Retail Enterprise Analytics is an end-to-end business intelligence and data engineering solution built using **Microsoft Fabric, PySpark, SQL, Power BI, Parquet and GitHub**.

The solution transforms source Parquet data into a structured analytical platform through a Medallion Architecture and delivers business-ready insights through a semantic model and Power BI reporting.

The project demonstrates a practical analytics workflow from source data ingestion through validation, transformation, data quality, analytical warehousing and business reporting.

---

## 2. Business Objective

The objective of the solution is to provide a centralized analytical platform for monitoring and analyzing key retail business areas, including:

- Sales and revenue performance
- Customer behavior and segmentation
- Product performance
- Inventory and stock levels
- Product returns
- Regional and store performance
- Employee performance
- Promotions and discounts
- Time-based sales trends

The solution enables users to analyze business performance through interactive dashboards, KPIs and analytical visuals.

---

## 3. Solution Architecture

The overall solution follows a layered data architecture:

```text
Source Parquet Data
        │
        ▼
Bronze Lakehouse
        │
        ▼
Data Validation
        │
        ▼
Silver Lakehouse
        │
        ▼
Gold Lakehouse
        │
        ▼
Data Quality
        │
        ▼
Fabric Warehouse
        │
        ▼
Semantic Model
        │
        ▼
Power BI
```

The project starts from source data ingestion and follows a structured data engineering and analytics workflow.

---

## 4. Technology Stack

| Technology | Purpose |
|---|---|
| Microsoft Fabric | Data engineering and analytical platform |
| Fabric Lakehouse | Bronze, Silver and Gold data layers |
| PySpark | Data ingestion, transformation and validation |
| Fabric Warehouse | Structured analytical serving layer |
| SQL | Analytical queries and reporting view |
| Semantic Model | Business relationships and analytical measures |
| Power BI | Interactive reporting and visualization |
| Parquet | Source data format |
| GitHub | Version control and project documentation |

---

## 5. Data Pipeline

The data pipeline consists of the following major stages.

### Source Data

Parquet files provide the source data for the solution.

The source dataset contains:

- Customer data
- Date data
- Employee data
- Product data
- Promotion data
- Region data
- Store data
- Supplier data
- Sales transactions
- Inventory transactions
- Return transactions

The source entities include:

```text
DimCustomer
DimDate
DimEmployee
DimProduct
DimPromotion
DimRegion
DimStore
DimSupplier

FactSales
FactInventory
FactReturns
```

### Bronze Layer

Source Parquet files are uploaded to the Bronze Lakehouse Files area and loaded into structured Delta tables.

The Bronze layer provides the initial landing and ingestion layer for downstream processing.

### Data Validation

The ingested Bronze data is validated before transformation.

The implemented validation checks include:

- Customer date validation
- Employee date validation
- Promotion date validation
- Inventory balance validation
- Return linkage validation

### Silver Layer

The Silver layer contains cleaned and standardized data prepared for analytical processing.

The transformation process applies the required cleansing, standardization and business transformations.

### Gold Layer

The Gold layer contains business-ready analytical datasets designed for reporting and business analysis.

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

These datasets support:

- Sales analysis
- Product analysis
- Customer analysis
- Store analysis
- Inventory analysis
- Returns analysis

### Data Quality

A dedicated Data Quality stage validates the processed data before it is published to the Warehouse.

The implemented checks include:

- Customer date validation
- Employee date validation
- Promotion date validation
- Inventory balance validation
- Return linkage validation

All implemented validation checks passed successfully for the validated dataset.

---

## 6. Fabric Warehouse

The processed Gold data is published to the `WH_Retail` Fabric Warehouse.

The Warehouse uses three logical schemas:

```text
WH_Retail
│
├── dim
├── fact
└── rpt
```

### Dimension Schema

The `dim` schema contains:

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

### Fact Schema

The `fact` schema contains:

```text
FactSales
FactInventory
FactReturns
```

### Reporting Schema

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

The Warehouse acts as the structured analytical serving layer for the semantic model.

---

## 7. Analytical Model

The semantic model is built from the Fabric Warehouse.

The model provides:

- Business relationships
- Analytical measures
- KPI calculations
- Time-based analysis
- Year-over-year analysis
- Moving-average analysis
- Filtering and slicing
- Business reporting logic

The `FactSales` table forms the core of the sales analytical model and connects with relevant dimensions such as:

```text
DimDate
DimCustomer
DimProduct
DimStore
DimEmployee
DimPromotion
```

Additional fact and dimension tables support inventory, returns, regional and supplier analysis.

---

## 8. Power BI Reporting

Power BI is used as the final business intelligence and visualization layer.

The final report contains **9 analytical pages**:

1. **Executive Overview**
2. **Sales Performance**
3. **Customer Insights**
4. **Product Performance**
5. **Inventory Overview**
6. **Return Analysis**
7. **Region & Store Analysis**
8. **Employee Performance**
9. **Trend Analysis**

The report provides interactive analysis across:

- Sales
- Customers
- Products
- Inventory
- Returns
- Stores
- Regions
- Employees
- Promotions
- Time-based trends

The report uses interactive filters, KPIs, charts, tables and analytical visuals to support business analysis and decision-making.

---

## 9. Data Quality and Governance

Data quality is incorporated into the data pipeline rather than being treated only as a final reporting activity.

The implemented validation process checks:

| Validation Check | Result |
|---|---:|
| Customer date violations | 0 |
| Employee date violations | 0 |
| Promotion date violations | 0 |
| Inventory balance errors | 0 |
| Return linkage errors | 0 |

### Overall Status

**ALL VALIDATION CHECKS PASSED**

These checks help reduce the risk of invalid or inconsistent data reaching the Warehouse, Semantic Model and Power BI reporting layers.

---

## 10. Repository Structure

The GitHub repository contains the main project artifacts:

```text
Retail Enterprise Analytics/
│
├── docs/
│   ├── Architecture.md
│   ├── BusinessRules.md
│   ├── DataDictionary.md
│   ├── DataFlow.md
│   ├── DataQuality.md
│   ├── ProjectOverview.md
│   └── Warehouse.md
│
├── images/
│   ├── architecture/
│   ├── fabric/
│   ├── warehouse/
│   └── powerbi/
│
├── notebooks/
│   └── Fabric data engineering notebooks
│
└── sql/
    └── SQL analytics scripts
```

---

## 11. Project Outcome

The solution provides an end-to-end analytical workflow connecting:

```text
Source Data
     ↓
Data Engineering
     ↓
Data Validation
     ↓
Medallion Transformation
     ↓
Data Quality
     ↓
Data Warehouse
     ↓
Semantic Model
     ↓
Business Intelligence
```

The project demonstrates how Microsoft Fabric can be used to build a structured retail analytics solution while maintaining clear separation between data engineering, analytical serving and business intelligence layers.

---

## 12. Key Capabilities Demonstrated

The project demonstrates practical experience with:

- Microsoft Fabric Lakehouse
- Medallion Architecture
- PySpark data processing
- Data validation
- Data quality
- Fabric Warehouse
- SQL analytics
- Dimensional data modeling
- Semantic models
- DAX measures
- Power BI reporting
- Time intelligence
- Business KPI development
- GitHub project organization
- Technical documentation
