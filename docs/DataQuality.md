# Data Quality

## Overview

Data Quality is a dedicated stage of the Retail Enterprise Analytics data pipeline.

The objective is to identify data inconsistencies, broken relationships and invalid business conditions before the data is consumed by the Warehouse, Semantic Model and Power BI reporting layer.

The Data Quality process is implemented using PySpark in Microsoft Fabric.

---

# Data Quality Flow

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
Data Quality Checks
     ↓
Fabric Warehouse
     ↓
Semantic Model
     ↓
Power BI
```

---

# Data Quality Objectives

The Data Quality process focuses on:

- Data validity
- Data consistency
- Referential integrity
- Date consistency
- Inventory balance integrity
- Return transaction linkage
- Business-rule validation
- Analytical reliability

The objective is to prevent invalid or inconsistent data from reaching the final reporting layer.

---

# Validation Checks

The implemented validation process includes the following checks:

| Validation Check | Purpose |
|---|---|
| Customer Date Validation | Identifies invalid customer-related dates |
| Employee Date Validation | Identifies invalid employee-related dates |
| Promotion Date Validation | Identifies invalid promotion dates |
| Inventory Balance Validation | Verifies inventory movement calculations |
| Return Linkage Validation | Verifies that returns are linked to valid sales transactions |

---

# 1. Customer Date Validation

Customer-related dates are checked against the defined business rules.

The validation process identifies customer records where date relationships do not satisfy the expected conditions.

The validation is associated with the customer data represented by `DimCustomer`.

## Validation Result

```text
Customer date violations: 0
```

No customer date violations were identified in the validated dataset.

---

# 2. Employee Date Validation

Employee-related dates are validated against the defined business rules.

The validation process identifies employee records where the relevant date relationships are inconsistent.

The validation is associated with the employee data represented by `DimEmployee`.

## Validation Result

```text
Employee date violations: 0
```

No employee date violations were identified in the validated dataset.

---

# 3. Promotion Date Validation

Promotion start and end dates are checked to ensure that promotion date relationships satisfy the expected business conditions.

The validation is associated with the promotion data represented by `DimPromotion`.

## Validation Result

```text
Promotion date violations: 0
```

No promotion date violations were identified in the validated dataset.

---

# 4. Inventory Balance Validation

Inventory consistency is validated using the inventory balance equation:

```text
Closing Stock =
Opening Stock + Stock Received - Stock Sold
```

An inventory balance error occurs when the calculated closing stock does not match the recorded closing stock.

The validation is performed against the inventory data represented by `FactInventory`.

## Validation Result

```text
Inventory balance errors: 0
```

No inventory balance errors were identified in the validated dataset.

---

# 5. Return Linkage Validation

Returns are linked to the original sales transactions using `SalesKey`.

The validation process checks whether return records can be correctly associated with valid sales transactions.

The validation uses the relationship between `FactReturns` and `FactSales`.

## Validation Result

```text
Return linkage errors: 0
```

No return linkage errors were identified in the validated dataset.

---

# Overall Validation Result

The final dataset validation produced the following results:

| Validation Check | Result |
|---|---:|
| Customer date violations | 0 |
| Employee date violations | 0 |
| Promotion date violations | 0 |
| Inventory balance errors | 0 |
| Return linkage errors | 0 |

## Overall Status

**ALL VALIDATION CHECKS PASSED**

This indicates that all implemented validation checks passed successfully for the validated dataset.

---

# Data Quality Layers

Data quality is considered at multiple stages of the pipeline.

## Source / Bronze

Checks whether the expected source datasets are available and readable.

## Validation

Checks structural, date, relationship and business conditions.

## Silver

Ensures that transformations produce clean and standardized datasets.

## Gold

Ensures that analytical datasets are generated correctly.

## Warehouse

Ensures that the published analytical tables contain the expected structures and data.

## Semantic Model

Provides the analytical relationships and calculations required by Power BI.

---

# Data Quality Principles

The project follows the following principles:

## Accuracy

Data should represent valid business conditions.

## Consistency

Related datasets should follow consistent business rules.

## Completeness

Required business entities and relationships should be available.

## Validity

Values should conform to the expected data types and business constraints.

## Referential Integrity

Fact records should reference valid dimension or transaction records where applicable.

## Balance Integrity

Inventory movements should reconcile according to the defined inventory equation.

---

# Data Quality and Reporting

Data quality checks are performed before the final data is consumed by the reporting layer.

The intended flow is:

```text
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
```

This helps reduce the risk of inaccurate or inconsistent information reaching business users.

---

# Validation Summary

The validated dataset successfully passed all implemented validation checks.

```text
Customer Date Violations       = 0

Employee Date Violations       = 0

Promotion Date Violations      = 0

Inventory Balance Errors       = 0

Return Linkage Errors          = 0
```

## Overall Status

**ALL VALIDATION CHECKS PASSED**

The validation results provide confidence that the processed dataset satisfies the implemented data quality and business-rule checks before consumption by the Warehouse and reporting layers.

---

# Future Data Quality Enhancements

The following capabilities may be considered in future versions of the solution:

- Automated data quality scoring
- Null-value profiling
- Duplicate detection
- Outlier detection
- Referential integrity monitoring
- Schema drift detection
- Automated quality thresholds
- Data quality alerting
- Historical quality trend tracking
- Pipeline-level quality gates
