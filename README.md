# End-to-End-Data-Cleaning-and-Visualization-on-Electronic-Sales-Dataset
# 💼 Electronics Sales Analysis Project

This is a complete data analytics project where raw Excel files were transformed into clean, analysis-ready data using **MySQL**, and visualized using **Power BI**. The project includes advanced SQL cleaning, feature engineering, and interactive dashboards built on key performance metrics.

---

## 📁 Data Source

All data files were provided in Excel format (`.csv`) and included the following:

- `sales.csv`
- `cust_info.csv`
- `exchange.csv`
- `stores.csv`
- `products.csv`

---

## 🔧 Tools & Technologies Used

- 🐬 MySQL – For data cleaning, transformation, and creating structured tables  
- 📊 Power BI – For DAX measures and visual storytelling  
- 📁 Excel – Initial raw dataset format  

---

## 🛠️ Step-by-Step Workflow

### 🔹 1. Data Import and Table Creation
- Created tables for: `sales`, `customer`, `exchange`, `stores`, and `products`
- Loaded CSVs using `LOAD DATA LOCAL INFILE`
- Enabled `LOCAL_INFILE` globally

### 🔹 2. SQL Data Cleaning

#### ✅ `customer` Table:
- Removed duplicates using `ROW_NUMBER()`
- Trimmed whitespaces from string columns
- Converted `Birthday` to `DATE` format
- Identified null values using `COUNT(CASE...)`

#### ✅ `sales` Table:
- Removed duplicates using `ROW_NUMBER()`
- Formatted `OrderDate` to `DATE`
- Dropped `DeliveryDate` due to 83%+ missing values
- Checked for nulls

#### ✅ `products` Table:
- Standardized naming and formatting
- Trimmed currency symbols from `Unit_Cost_USD` and converted to `FLOAT`
- Verified `Color` with extracted color logic
- Checked for nulls and duplicates

#### ✅ `exchange` Table:
- Converted `Date` to `DATE` format
- Removed duplicates and checked for nulls

#### ✅ `stores` Table:
- Trimmed text data
- Converted `Open_Date` to `DATE`
- Verified nulls and duplicates

---

### 🔹 3. Feature Engineering

Created a new table: `sales_usd`  
- Added a column: `price_usd = Quantity * Exchange`  
- Joined `sales` and `exchange` on `OrderDate` and `CurrencyCode`  
- Final table was used for analysis in Power BI

```sql
CREATE TABLE sales_usd LIKE sales;
ALTER TABLE sales_usd ADD COLUMN price_usd FLOAT;
INSERT INTO sales_usd (...)
SELECT ..., Quantity * Exchange AS price_usd
FROM sales
LEFT JOIN exchange ON CurrencyCode = Currency AND OrderDate = Date;

# 📊 Electronics Sales Dashboard – Power BI

This Power BI report visualizes electronic sales data across countries, age groups, genders, and product categories. It includes dynamic insights built using DAX, slicers, and multiple dashboard pages, allowing stakeholders to explore business performance from multiple angles.

---

## 🎯 Project Objective

To analyze sales performance using cleaned and enriched SQL data, calculate KPIs using DAX, and deliver executive insights across products, geography, and customer demographics.

---

## 🧮 DAX Measures

### 1. **Total Revenue**
```DAX
Total_Revenue = 
VAR UnitPrice = RELATED('electronic_sales products'[Unit_Price_USD])
RETURN 
'electronic_sales sales_usd'[Quantity] * UnitPrice
2. Total Profit
DAX

Total_Profit = 
VAR UnitPrice = RELATED('electronic_sales products'[Unit_Price_USD])
VAR UnitCost = RELATED('electronic_sales products'[Unit_Cost_USD])
RETURN 
(UnitPrice - UnitCost) * 'electronic_sales sales_usd'[Quantity]

3. Average Profit Margin
DAX
Avg_Profit_Margin = 
DIVIDE([Total_Profit], [Total_Revenue])
📊 Dashboard Pages & Visuals
🔹 Page 1: Executive Summary
KPIs: ✅ Total Revenue, ✅ Total Profit, ✅ Average Profit Margin, ✅ Total Quantity Sold

Line Chart: Total Revenue trend by Year

Clean, boardroom-style layout for top-level insights

🔹 Page 2: Product & Customer Analysis
Slicers: Subcategory, Age Group, Country

Charts:

Total Revenue by Brand

Total Profit by Product Category

🔹 Page 3: Regional & Category Overview
Slicers: Continent, Category

Visuals:

Images of Top-Selling Products

Revenue by Country 
Revenue by Continent

🔹 Page 4: Demographic Revenue Breakdown
Slicers: Year

Charts:

Revenue by Age Group

Revenue by Gender

Gender Count 

🔧 Tools Used
Power BI Desktop – Data modeling, DAX, and dashboard design

MySQL – Raw data cleaning and transformation

Excel – Initial data source and testing

📁 Files Included
File	Description
dashboard.pbix	Final Power BI file with all visuals and DAX
sales_usd.sql	SQL script to generate the price_usd column
README.md	This documentation


📈 Key Takeaways
Created DAX measures for profit, revenue, and margin

Designed clean and business-focused dashboards

Used slicers and visual filters for dynamic exploration

Connected cleaned SQL data to Power BI for powerful visuals









