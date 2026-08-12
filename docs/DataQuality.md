# Data Quality

## Overview

Data Quality is a dedicated stage of the Retail Enterprise Analytics data pipeline.

The objective is to identify data inconsistencies, broken relationships and invalid business conditions before the data is consumed by the Warehouse, Semantic Model and Power BI reporting layer.

The Data Quality process is implemented using PySpark in Microsoft Fabric.



## Data Quality Flow


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
Data Quality Checks
     ↓
Fabric Warehouse
     ↓
Semantic Model
     ↓
Power BI

## Data Quality Objectives

The Data Quality process focuses on the following areas:

Data validity
Data consistency
Referential integrity
Date consistency
Inventory balance integrity
Return transaction linkage
Business-rule validation
Analytical reliability

The objective is to prevent invalid or inconsistent data from reaching the final reporting layer.

## Validation Checks

The implemented validation process includes the following checks.

| Validation Check             | Purpose                                                      |
| ---------------------------- | ------------------------------------------------------------ |
| Customer Date Validation     | Identifies invalid customer-related dates                    |
| Employee Date Validation     | Identifies invalid employee-related dates                    |
| Promotion Date Validation    | Identifies invalid promotion dates                           |
| Inventory Balance Validation | Verifies inventory movement calculations                     |
| Return Linkage Validation    | Verifies that returns are linked to valid sales transactions |


## Customer Date Validation

Customer-related dates are checked against the defined business rules.

The validation process identifies customer records where date relationships do not satisfy the expected conditions.

### Validation Result
Customer date violations: 0

No customer date violations were identified in the validated V2 dataset.

## Employee Date Validation

Employee-related dates are validated against the defined business rules.

The validation identifies employee records where the relevant date relationships are inconsistent.

### Validation Result
Employee date violations: 0

No employee date violations were identified in the validated V2 dataset.

## Promotion Date Validation

Promotion start and end dates are checked to ensure that promotion date relationships satisfy the expected business conditions.

### Validation Result
Promotion date violations: 0

No promotion date violations were identified in the validated V2 dataset.

## Inventory Balance Validation

Inventory consistency is validated using the inventory balance equation:

Closing Stock =
Opening Stock + Stock Received - Stock Sold

An inventory balance error occurs when the calculated closing stock does not match the recorded closing stock.

### Validation Result
Inventory balance errors: 0

No inventory balance errors were identified in the validated dataset.

## Return Linkage Validation

Returns are linked to the original sales transactions using SalesKey.

The validation process checks whether return records can be correctly associated with valid sales transactions.

### Validation Result
Return linkage errors: 0

No return linkage errors were identified in the validated V2 dataset.

## Overall Validation Result

The final V2 dataset validation produced the following results:

| Validation Check          | Result |
| ------------------------- | -----: |
| Customer date violations  |      0 |
| Employee date violations  |      0 |
| Promotion date violations |      0 |
| Inventory balance errors  |      0 |
| Return linkage errors     |      0 |

### Overall Status
ALL VALIDATION CHECKS PASSED

This indicates that all implemented validation checks passed successfully for the validated V2 dataset.

## Business Shape Validation

In addition to structural and integrity checks, the validation process also evaluates the overall shape of the business data.

The validated V2 dataset produced the following results:

| Metric                   |                Result |
| ------------------------ | --------------------: |
| Total Net Sales          | INR 10,834,943,018.03 |
| Average Net Sales / Sale |         INR 10,834.94 |
| Promotion Rate           |                13.49% |
| Return Row Rate          |                 7.71% |
| Active Customers         |       49,073 / 50,000 |
| Sales-Active Employees   |             140 / 500 |


These metrics provide a high-level sanity check on the generated business dataset.

## Category Sales Distribution

The validation process also evaluates the distribution of sales across product categories.

| Category       | Sales Share |
| -------------- | ----------: |
| Electronics    |       42.9% |
| Home & Kitchen |       22.3% |
| Fashion        |       15.3% |
| Sports         |        7.6% |
| Beauty         |        5.7% |
| Groceries      |        3.9% |
| Books          |        2.4% |


This distribution provides a high-level view of category contribution to total sales.

## Product Concentration

Product concentration is evaluated using the percentage of sales contributed by the highest-performing products.

| Product Group    | Sales Share |
| ---------------- | ----------: |
| Top 1 Product    |       0.34% |
| Top 10 Products  |       2.52% |
| Top 100 Products |       14.5% |


These values help assess whether sales are heavily concentrated in a small number of products or distributed across the wider product portfolio.

## Store Concentration

Store concentration is also evaluated.

Top 10 Stores Sales Share: 15.17%

This provides an indication of how sales are distributed across the store network.

## Monthly Growth Validation

Monthly and yearly growth distributions are evaluated to identify unusual business patterns.

### Month-over-Month Growth

| Metric                              | Result |
| ----------------------------------- | -----: |
| Median MoM Growth                   |   5.7% |
| 95th Percentile Absolute MoM Growth |  33.2% |
| Maximum Absolute MoM Growth         |  34.2% |

### Year-over-Year Growth

| Metric             | Result |
| ------------------ | -----: |
| Median YoY Growth  |   8.3% |
| Maximum YoY Growth |  17.2% |
| Minimum YoY Growth |   1.6% |


These metrics are used as business-shape diagnostics rather than strict data-quality pass/fail rules.

## Data Quality Layers

Data quality is considered at multiple stages of the pipeline.

### Source / Bronze

Checks whether the expected source datasets are available and readable.

### Validation

Checks structural, date, relationship and business conditions.

### Silver

Ensures that transformations produce clean and standardized datasets.

### Gold

Ensures that analytical datasets are generated correctly.

### Warehouse

Ensures that the published analytical tables contain the expected structures and data.

### Semantic Model

Ensures that the analytical model can correctly consume the Warehouse data.

## Data Quality Principles

The project follows these principles:

### Accuracy

Data should represent valid business conditions.

### Consistency

Related datasets should follow consistent business rules.

### Completeness

Required business entities and relationships should be available.

### Validity

Values should conform to the expected data types and business constraints.

### Referential Integrity

Fact records should reference valid dimension or transaction records where applicable.

### Balance Integrity

Inventory movements should reconcile according to the defined inventory equation.

## Data Quality and Reporting

Data quality checks are performed before the final data is consumed by the reporting layer.

The intended flow is:

Data Engineering
      ↓
Validation
      ↓
Transformation
      ↓
Data Quality
      ↓
Warehouse
      ↓
Semantic Model
      ↓
Power BI

This helps reduce the risk of inaccurate information reaching business users.

## Validation Summary

The V2 dataset successfully passed all implemented validation checks.

Customer Date Violations       = 0

Employee Date Violations       = 0

Promotion Date Violations      = 0

Inventory Balance Errors       = 0

Return Linkage Errors          = 0

Overall Status:

ALL VALIDATION CHECKS PASSED

The business-shape metrics are retained as diagnostic indicators to support further monitoring and refinement of the analytical dataset.

## Future Data Quality Enhancements

Potential future improvements include:

Automated data quality scoring

Null-value profiling

Duplicate detection

Outlier detection

Referential integrity monitoring

Schema drift detection

Automated quality thresholds

Data quality alerting

Historical quality trend tracking

Data Quality dashboard in Power BI

Pipeline-level quality gates
