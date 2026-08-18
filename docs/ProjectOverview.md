# Retail Enterprise Analytics

## 1. Project Overview

Retail Enterprise Analytics is an end-to-end business intelligence and data engineering solution built using Microsoft Fabric, SQL, and Power BI.

The solution transforms source Parquet data into a structured analytical platform through a Medallion Architecture and delivers business-ready insights through a semantic model and Power BI reporting.

The project is designed to demonstrate a practical enterprise analytics workflow from source data ingestion to business reporting.

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

The solution enables users to analyze business performance through interactive dashboards and analytical KPIs.

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

The project starts from source data ingestion rather than data generation, reflecting a typical enterprise data analytics workflow.

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
| GitHub | Source control and project documentation |

---

## 5. Data Pipeline

The data pipeline consists of the following major stages:

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

### Bronze Layer

Source Parquet files are uploaded to the Bronze Lakehouse and loaded into structured tables.

The Bronze layer preserves the ingested source data and provides the starting point for downstream processing.

### Validation

The ingested Bronze data is validated before transformation.

Validation includes:

- Row count validation
- Null value validation
- Duplicate primary key validation
- Data integrity checks

Only validated data proceeds to the transformation layer.

### Silver Layer

The Silver layer contains cleaned and transformed data prepared for analytical processing.

The transformation process applies the required cleansing, standardization and business transformations.

### Gold Layer

The Gold layer contains business-ready analytical datasets and aggregated reporting tables.

These datasets support:

- Sales analysis
- Product analysis
- Customer analysis
- Store analysis
- Inventory analysis
- Returns analysis

### Data Quality

A dedicated data quality stage validates the Gold layer before it is published to the Warehouse.

The quality checks include:

- Row count validation
- Primary key NULL validation
- Duplicate primary key validation
- Referential integrity validation
- Business table validation

The Gold layer is approved for Warehouse loading after the required quality checks pass.

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

The schemas separate:

- Dimension tables
- Transactional fact tables
- Reporting and analytical datasets

The Warehouse acts as the structured serving layer for the semantic model.

---

## 7. Analytical Model

The semantic model is built from the Fabric Warehouse.

The model provides:

- Business relationships
- Analytical measures
- KPI calculations
- Time-based analysis
- Filtering and slicing
- Business reporting logic

The sales fact table forms the core of the analytical model and connects with relevant business dimensions such as Date, Customer, Product, Store, Employee and Promotion.

---

## 8. Power BI Reporting

Power BI is used as the final business intelligence and visualization layer.

The report provides multiple analytical perspectives covering:

- Executive overview
- Sales performance
- Customer insights
- Product performance
- Inventory overview
- Return analysis
- Region and store analysis
- Employee performance
- Trend analysis

The report uses interactive filters, KPIs, charts, tables and analytical visuals to support business decision-making.

---

## 9. Data Quality and Governance

Data quality is incorporated throughout the pipeline rather than being treated as a final reporting activity.

The solution applies validation and quality checks at important stages of the data pipeline to reduce the risk of inaccurate or inconsistent analytical results.

The project also separates data engineering, analytical serving and reporting responsibilities across the architecture.

---

## 10. Repository Structure

The GitHub repository contains the main project artifacts:

```text
Retail Enterprise Analytics/
│
├── data/
│   └── Source Parquet files
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
├── power bi/
│   └── Power BI project artifacts
│
└── sql/
    └── SQL analytics scripts
```

---

## 11. Project Outcome

The solution provides an end-to-end analytical workflow that connects source data ingestion, data validation, transformation, data quality, analytical warehousing, semantic modeling and business reporting.

It demonstrates how Microsoft Fabric can be used to build a structured and scalable analytics solution while maintaining clear separation between data engineering and business intelligence layers.

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
- Dimensional analytical modeling
- Semantic models
- DAX measures
- Power BI reporting
- GitHub project organization and documentation
