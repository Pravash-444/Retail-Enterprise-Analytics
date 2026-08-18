# Retail Enterprise Analytics

An end-to-end **Retail Enterprise Analytics** solution built using **Microsoft Fabric, SQL, Power BI, Python, and GitHub**.

The project demonstrates a complete analytics workflow from source data generation and ingestion through data validation, medallion transformation, data quality, warehouse analytics, and interactive Power BI reporting.

---

## Project Overview

The solution analyzes retail business operations across:

- Sales
- Customers
- Products
- Inventory
- Returns
- Stores
- Regions
- Employees
- Promotions

The objective is to transform raw retail data into a structured analytical solution that supports business reporting and decision-making.

---

## Technology Stack

| Technology | Purpose |
|---|---|
| Python | Source data generation and preparation |
| Parquet | Source data storage format |
| Microsoft Fabric | Data engineering and analytics platform |
| Fabric Lakehouse | Data storage and transformation |
| PySpark Notebooks | Validation and medallion transformations |
| Fabric Warehouse | SQL-based analytical layer |
| SQL | Analytical queries and reporting views |
| Power BI | Data visualization and business reporting |
| GitHub | Version control and project documentation |

---

## Solution Architecture

The project follows a layered data architecture:

```text
Source Data
    ↓
Bronze Lakehouse
    ↓
Data Validation
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

![Architecture](images/architecture/architecture.png)

---

## Data Pipeline

The data pipeline follows a structured progression from raw data to business reporting.

### Bronze Layer

Raw Parquet files are ingested into the Bronze Lakehouse.

### Validation

Initial validation checks include:

- Row count validation
- Null value validation
- Duplicate primary key validation

### Silver Layer

The Bronze data is transformed and cleaned into the Silver layer.

### Gold Layer

Business-ready analytical tables are created in the Gold layer.

### Data Quality

Final validation checks are performed before loading data into the Warehouse.

### Warehouse

Validated Gold-layer data is loaded into the Fabric Warehouse for SQL-based analytics.

---

## Data Quality

The solution includes validation of important business and referential relationships, including:

- Customer date validation
- Employee date validation
- Promotion date validation
- Inventory balance validation
- Return linkage validation
- Primary key validation
- Duplicate key validation
- Null value validation

The final data quality process confirms that the Gold layer is ready for Warehouse consumption.

---

## Sales Terminology

The project uses the following business definitions consistently across the Warehouse, Semantic Model, SQL analytics and Power BI reports:

| Term | Definition |
|---|---|
| Total Revenue | Gross Sales |
| Revenue | Gross Sales |
| Gross Sales | Sales value before discounts |
| Sales | Net Sales |
| Net Sales | Sales value after discounts |

Therefore:

```text
Gross Sales / Total Revenue
            ↓
     Less: Discount
            ↓
    Net Sales / Sales
```

For detailed business definitions and calculation rules, see [`BusinessRules.md`](docs/BusinessRules.md).

---

## SQL Analytics

The Warehouse includes SQL analytics covering:

- Customer and product dimensions
- Sales transactions
- Total customers
- Total products
- Total stores
- Total transactions
- Total revenue
- Total quantity sold
- Average order value
- Sales by year and month
- Sales by category
- Top products
- Top customers
- Sales by region
- Sales by store
- Customer analysis
- Product analysis
- Ranking analysis
- Running totals
- Year-over-year analysis
- CTE-based analysis
- Sales summary view

The SQL analytics scripts are available in the [`sql`](sql) folder.

---

## Power BI Report

The final Power BI solution contains **9 analytical pages**:

1. **Executive Overview** — Overall business performance
2. **Sales Performance** — Sales trends and performance
3. **Customer Insights** — Customer behavior and value analysis
4. **Product Performance** — Product, category and brand performance
5. **Inventory Overview** — Inventory levels and stock movement
6. **Return Analysis** — Return trends, reasons and regional analysis
7. **Region & Store Analysis** — Regional and store performance
8. **Employee Performance** — Workforce and employee sales contribution
9. **Trend Analysis** — Time-based trends and growth analysis

Power BI report screenshots are available in [`images/powerbi`](images/powerbi).

---

## Key Analytical Areas

The solution provides insights into:

- Revenue and Net Sales performance
- Sales growth and trends
- Customer value and segmentation
- Product and category performance
- Inventory movement
- Return patterns
- Regional and store performance
- Employee performance
- Promotion impact
- Time-series and moving-average analysis

---

## Repository Structure

```text
Retail-Enterprise-Analytics/
│
├── data/
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
│   ├── powerbi/
│   └── warehouse/
│
├── notebooks/
│
├── sql/
│
└── README.md
```

---

## Documentation

Additional project documentation is available in the [`docs`](docs) folder:

- [`Architecture.md`](docs/Architecture.md) — Solution architecture and data platform design
- [`BusinessRules.md`](docs/BusinessRules.md) — Business definitions and calculation rules
- [`DataDictionary.md`](docs/DataDictionary.md) — Data and field definitions
- [`DataFlow.md`](docs/DataFlow.md) — Data pipeline and transformation flow
- [`DataQuality.md`](docs/DataQuality.md) — Data quality and validation approach
- [`ProjectOverview.md`](docs/ProjectOverview.md) — Project overview
- [`Warehouse.md`](docs/Warehouse.md) — Warehouse design and analytical layer

---

## Project Objective

The project demonstrates how a retail organization can build an end-to-end analytics platform using Microsoft Fabric and Power BI.

It combines:

**Data Engineering → Data Quality → Data Warehousing → SQL Analytics → Business Intelligence**

to transform raw retail data into actionable business insights.

---

## Author

**Pravash Paul**

Microsoft Certified: Power BI Data Analyst

Skills demonstrated in this project include:

- Microsoft Fabric
- Power BI
- SQL
- Python
- Data Cleaning
- Data Validation
- Data Modeling
- Data Visualization
- Data Analytics
- GitHub
