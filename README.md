# # End-to-End-Data-Cleaning-and-Visualization-on-Electronic-Sales-Dataset

## Overview

This project focuses on the analysis of an electronics sales dataset using SQL for data cleaning and Power BI for building insightful dashboards. The workflow covers importing, cleaning, and standardizing multiple tables, and creating interactive reports to drive business insights.

---

## Data Preparation

### 1. **Importing and Cleaning Data**

#### **Tables Imported:**
- `sales`
- `customer`
- `exchange`
- `stores`
- `products` 

#### **Key Cleaning Steps:**
- **Duplicates Detection & Removal:** Used CTEs with `ROW_NUMBER()` to identify duplicate records in all tables.
- **Standardizing Data:** Trimmed leading/trailing spaces in all relevant columns.
- **Null Values:** Counted and investigated nulls in all columns.
- **Date Formatting:** Converted string dates to `DATE` type using `STR_TO_DATE()`.
- **Irrelevant Columns:** Dropped columns with excessive nulls (e.g., `DeliveryDate` in `sales`).
- **Data Type Corrections:** Adjusted columns to correct types (e.g., `FLOAT` for prices).
- **Consistency Checks:** Ensured values like colors, categories, and product names match across tables.

### 2. **SQL Data Loading (Sample)**
```sql
LOAD DATA LOCAL INFILE 'path/to/file.csv'
INTO TABLE tablename
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(column1, column2, ...);
```
Repeat for each table, with respective columns.

---

## Power BI Data Model

- **Relationships:** Established between `sales`, `products`, `customer`, `stores`, and `exchange` tables.
- **Currency Conversion:** Used exchange rates for sales normalization.
- **Calculated Columns/Measures:**
  - **Total Revenue:**  
    ```DAX
    Total_Revenue = 
      VAR UnitPrice = RELATED('products'[Unit_Price_USD])
      RETURN 'sales_usd'[Quantity] * UnitPrice
    ```
  - **Total Profit:**  
    ```DAX
    Total_Profit = 
      VAR UnitPrice = RELATED('products'[Unit_Price_USD])
      VAR UnitCost = RELATED('products'[Unit_Cost_USD])
      RETURN (UnitPrice - UnitCost) * 'sales_usd'[Quantity]
    ```
  - **Average Profit Margin, Total Quantity:** Additional KPIs as needed.

---

## Power BI Dashboard Structure

### **Page 1: Executive Summary**
- **KPIs:** Total Profit, Total Revenue, Average Profit Margin, Total Quantity
- **Trend Analysis:** Line chart showing revenue/profit trends over years

### **Page 2: Product & Demographics Analysis**
- **Slicers:** Subcategory, Age Group, Country
- **Visuals:**
  - Total Revenue by Brand
  - Total Profit by Category

### **Page 3: Regional Analysis**
- **Slicers:** Continent, Category
- **Visuals:**
  - Images of Top-Selling Products
  - Revenue by Country
  - Revenue by Continent

### **Page 4: Detailed Demographics**
- **Slicers:** Year
- **Visuals:**
  - Revenue by Age Group
  - Revenue by Gender
  - Count of Genders

---

## Usage Instructions

1. **Prepare Data:**
   - Run SQL scripts to clean and format your tables as shown above.
   - Export cleaned tables as CSVs or connect directly to your database.

2. **Power BI Setup:**
   - Import cleaned data into Power BI.
   - Set up relationships as per the data model.
   - Add DAX measures for KPIs and calculations.
   - Build visuals as outlined for each dashboard page.

3. **Interactivity:**
   - Use slicers for dynamic filtering by category, age group, country, continent, and year.
   - Hover and drill-down for detailed insights.

---

## Insights Enabled

- **Business Trends:** Track sales and profit growth over time.
- **Product Insights:** Identify top-performing brands, categories, and products.
- **Customer Segmentation:** Analyze revenue/profit by age group, gender, and geography.
- **Regional Performance:** Compare sales across countries and continents.
- **Operational Improvements:** Spot data quality issues and ensure clean reporting.

---

## Notes

- Ensure all preprocessing is completed in SQL before importing into Power BI for optimal performance.
- Adjust DAX formulas if your column/table names differ from the above.
- For best results, refresh data regularly and validate relationships in the Power BI data model.

---

## Example DAX Measures

```DAX
Total_Revenue = 
  VAR UnitPrice = RELATED('products'[Unit_Price_USD])
  RETURN 'sales_usd'[Quantity] * UnitPrice

Total_Profit = 
  VAR UnitPrice = RELATED('products'[Unit_Price_USD])
  VAR UnitCost = RELATED('products'[Unit_Cost_USD])
  RETURN (UnitPrice - UnitCost) * 'sales_usd'[Quantity]
```

---

## Contact

For questions or suggestions, please open an issue or contact the project maintainer.

## Overview

This project focuses on the analysis of an electronics sales dataset using SQL for data cleaning and Power BI for building insightful dashboards. The workflow covers importing, cleaning, and standardizing multiple tables, and creating interactive reports to drive business insights.

---

## Data Preparation

### 1. **Importing and Cleaning Data**

#### **Tables Imported:**
- `sales`
- `customer`
- `exchange`
- `stores`
- `products` (assumed, as cleaning steps are included)

#### **Key Cleaning Steps:**
- **Duplicates Detection & Removal:** Used CTEs with `ROW_NUMBER()` to identify duplicate records in all tables.
- **Standardizing Data:** Trimmed leading/trailing spaces in all relevant columns.
- **Null Values:** Counted and investigated nulls in all columns.
- **Date Formatting:** Converted string dates to `DATE` type using `STR_TO_DATE()`.
- **Irrelevant Columns:** Dropped columns with excessive nulls (e.g., `DeliveryDate` in `sales`).
- **Data Type Corrections:** Adjusted columns to correct types (e.g., `FLOAT` for prices).
- **Consistency Checks:** Ensured values like colors, categories, and product names match across tables.

### 2. **SQL Data Loading (Sample)**
```sql
LOAD DATA LOCAL INFILE 'path/to/file.csv'
INTO TABLE tablename
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(column1, column2, ...);
```
Repeat for each table, with respective columns.

---

## Power BI Data Model

- **Relationships:** Established between `sales`, `products`, `customer`, `stores`, and `exchange` tables.
- **Currency Conversion:** Used exchange rates for sales normalization.
- **Calculated Columns/Measures:**
  - **Total Revenue:**  
    ```DAX
    Total_Revenue = 
      VAR UnitPrice = RELATED('products'[Unit_Price_USD])
      RETURN 'sales_usd'[Quantity] * UnitPrice
    ```
  - **Total Profit:**  
    ```DAX
    Total_Profit = 
      VAR UnitPrice = RELATED('products'[Unit_Price_USD])
      VAR UnitCost = RELATED('products'[Unit_Cost_USD])
      RETURN (UnitPrice - UnitCost) * 'sales_usd'[Quantity]
    ```
  - **Average Profit Margin, Total Quantity:** Additional KPIs as needed.

---

## Power BI Dashboard Structure

### **Page 1: Executive Summary**
- **KPIs:** Total Profit, Total Revenue, Average Profit Margin, Total Quantity
- **Trend Analysis:** Line chart showing revenue/profit trends over years

### **Page 2: Product & Demographics Analysis**
- **Slicers:** Subcategory, Age Group, Country
- **Visuals:**
  - Total Revenue by Brand
  - Total Profit by Category

### **Page 3: Regional Analysis**
- **Slicers:** Continent, Category
- **Visuals:**
  - Images of Top-Selling Products
  - Revenue by Country
  - Revenue by Continent

### **Page 4: Detailed Demographics**
- **Slicers:** Year
- **Visuals:**
  - Revenue by Age Group
  - Revenue by Gender
  - Count of Genders

---

## Usage Instructions

1. **Prepare Data:**
   - Run SQL scripts to clean and format your tables as shown above.
   - Export cleaned tables as CSVs or connect directly to your database.

2. **Power BI Setup:**
   - Import cleaned data into Power BI.
   - Set up relationships as per the data model.
   - Add DAX measures for KPIs and calculations.
   - Build visuals as outlined for each dashboard page.

3. **Interactivity:**
   - Use slicers for dynamic filtering by category, age group, country, continent, and year.
   - Hover and drill-down for detailed insights.

---

## Insights Enabled

- **Business Trends:** Track sales and profit growth over time.
- **Product Insights:** Identify top-performing brands, categories, and products.
- **Customer Segmentation:** Analyze revenue/profit by age group, gender, and geography.
- **Regional Performance:** Compare sales across countries and continents.
- **Operational Improvements:** Spot data quality issues and ensure clean reporting.

---

## Notes

- Ensure all preprocessing is completed in SQL before importing into Power BI for optimal performance.
- Adjust DAX formulas if your column/table names differ from the above.
- For best results, refresh data regularly and validate relationships in the Power BI data model.

---

## Example DAX Measures

```DAX
Total_Revenue = 
  VAR UnitPrice = RELATED('products'[Unit_Price_USD])
  RETURN 'sales_usd'[Quantity] * UnitPrice

Total_Profit = 
  VAR UnitPrice = RELATED('products'[Unit_Price_USD])
  VAR UnitCost = RELATED('products'[Unit_Cost_USD])
  RETURN (UnitPrice - UnitCost) * 'sales_usd'[Quantity]
```

---

## Contact

For questions or suggestions, please open an issue or contact the project maintainer.

