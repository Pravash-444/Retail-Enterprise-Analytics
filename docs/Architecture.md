# Architecture

## Project

**Retail Enterprise Analytics**

## Overview

Retail Enterprise Analytics is an end-to-end analytics solution implemented using Microsoft Fabric and Power BI.

The solution follows a Medallion Architecture and processes source data through Bronze, Silver and Gold layers before publishing analytical datasets to a Fabric Warehouse. The Warehouse is then used as the source for the semantic model and Power BI reporting layer.

## End-to-End Architecture

Source Data
↓
Bronze Lakehouse
↓
Data Validation
↓
Silver Lakehouse
↓
Gold Lakehouse
↓
Fabric Warehouse
↓
Semantic Model
↓
Power BI Report

## Major Components

### 1. Source Data

Source data is provided as Parquet files representing the retail business entities required for analytics.

The source dataset contains:

- DimCustomer
- DimDate
- DimEmployee
- DimProduct
- DimPromotion
- DimRegion
- DimStore
- DimSupplier
- FactSales
- FactInventory
- FactReturns

### 2. Bronze Lakehouse

The source Parquet files are uploaded to the Files area of the Bronze Lakehouse in Microsoft Fabric.

The first notebook loads the source files into Delta tables for analytical processing.

### 3. Data Validation

A dedicated validation notebook performs validation checks on the ingested data before downstream transformation.

### 4. Silver Layer

The Bronze data is transformed into the Silver layer using PySpark.

The Silver layer contains cleaned and standardized data prepared for analytical processing.

### 5. Gold Layer

The Silver data is transformed into business-ready analytical datasets.

Gold datasets include:

- GoldSalesDaily
- GoldSalesMonthly
- GoldProductPerformance
- GoldStorePerformance
- GoldCustomerPerformance
- GoldInventorySummary
- GoldReturnsSummary

### 6. Data Quality

A dedicated Data Quality notebook performs data quality checks on the processed datasets.

### 7. Fabric Warehouse

The Gold layer is published to the Fabric Warehouse.

The Warehouse is organized into:

- `dim` — dimension tables
- `fact` — fact tables
- `rpt` — reporting/analytical tables

### 8. Semantic Model

A semantic model is created using the Fabric Warehouse as its source.

The semantic model provides the relationships and analytical structure required for Power BI reporting.

### 9. Power BI

Power BI Desktop connects to the Fabric Warehouse through its SQL endpoint.

The final report provides interactive analysis across sales, products, customers, stores, employees, promotions, inventory and returns.
