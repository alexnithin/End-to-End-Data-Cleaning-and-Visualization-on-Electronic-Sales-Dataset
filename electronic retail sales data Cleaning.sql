
## importin tables 

CREATE TABLE sales (
  OrderNumber VARCHAR(50),
  LineItem INT,
  OrderDate VARCHAR(90),
  DeliveryDate VARCHAR(90),
  CustomerKey INT,
  StoreKey INT,
  ProductKey INT,
  Quantity INT,
  CurrencyCode VARCHAR(10)
);
SEt	 GLOBAL LOCAL_INFILE=on;
LOAD DATA LOCAL INFILE 'C:/Users/Dell/Desktop/first sql major project/sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrderNumber, LineItem, OrderDate, DeliveryDate, CustomerKey, StoreKey, ProductKey, Quantity, CurrencyCode);
CREATE TABLE customer (
  CustomerKey INT,
  Gender VARCHAR(10),
  Name VARCHAR(100),
  City VARCHAR(100),
  State_Code VARCHAR(10),
  State VARCHAR(100),
  Zip_Code VARCHAR(20),
  Country VARCHAR(100),
  Continent VARCHAR(50),
  Birthday VARCHAR(20)
);
LOAD DATA LOCAL INFILE 'C:/Users/Dell/Desktop/first sql major project/cust_info.csv'
INTO TABLE customer
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CustomerKey, Gender, Name, City, State_Code, State, Zip_Code, Country, Continent, Birthday);

CREATE TABLE exchange (
  Date VARCHAR(20),
  Currency VARCHAR(10),
  Exchange DECIMAL(10, 4)
);


LOAD DATA LOCAL INFILE 'C:/Users/Dell/Desktop/first sql major project/exchange.csv'
INTO TABLE exchange
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Date, Currency, Exchange);



CREATE TABLE stores (
    Store_Key INT PRIMARY KEY,
    Country VARCHAR(100),
    State VARCHAR(100),
    Square_Meters INT,
    Open_Date VARCHAR(20)
);
LOAD DATA LOCAL INFILE 'C:/Users/Dell/Desktop/first sql major project/stores.csv'
INTO TABLE stores
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Store_Key, Country, State, Square_Meters, Open_Date);
#  1. Customer Table Cleaning 

with dupicate_cte as
( SELECT *,
ROW_NUMBER() over(
PARTITION BY CustomerKey,Gender,Name,City,State_Code,State,Zip_Code,Country,Continent,Birthday) as row_num
FROM customer)
SELECT* FROM dupicate_cte 
WHERE row_num > 1;

## standardizing the columns
select *  from customer;
update customer
SET Gender = trim(Gender);

update customer
SET Name = trim(Name);
update customer
SET City = trim(City);
update customer
SET State = trim(State);

update customer
SET Country = trim(Country);

update customer
SET Continent = trim(Continent);

## Identifing the null values
SELECT 
  COUNT(*) AS totalRows,
  COUNT(CASE WHEN CustomerKey IS NULL THEN 1 END) AS nullCK,
  COUNT(CASE WHEN Gender IS NULL THEN 1 END) AS nullGender,
  COUNT(CASE WHEN Name IS NULL THEN 1 END) AS nullName,
  COUNT(CASE WHEN City IS NULL THEN 1 END) AS nullCity,
  COUNT(CASE WHEN State_Code IS NULL THEN 1 END) AS nullState_Code,
  COUNT(CASE WHEN State IS NULL THEN 1 END) AS nullState,
  COUNT(CASE WHEN Zip_Code IS NULL THEN 1 END) AS nullZip_Code,
  COUNT(CASE WHEN Country IS NULL THEN 1 END) AS nullCountry,
  COUNT(CASE WHEN Continent IS NULL THEN 1 END) AS nullContinent,
  COUNT(CASE WHEN Birthday IS NULL THEN 1 END) AS nullBirthday
FROM customer;
## updating and changing the format
UPDATE customer
SET birthday = str_to_date(birthday, '%m/%d/%Y');

alter TABLE customer
MODIFY COLUMN Birthday date;



#2  Sales Table Cleaning 
## identifing the duplicates
SELECT * FROM sales;
with dupicate_cte as
( SELECT *,
ROW_NUMBER() over(
PARTITION BY OrderNumber,OrderDate,CustomerKey,StoreKey,ProductKey,Quantity,CurrencyCode) as row_num
FROM sales)
SELECT* FROM dupicate_cte 
WHERE row_num > 1;
# checking the duplicate valuess that found weather i can remove that or not 
SELECT * FROM sales WHERE OrderNumber = 2206003;

### identifing the nulls

SELECT 
  COUNT(*) AS totalRows,
  COUNT(CASE WHEN OrderNumber IS NULL THEN 1 END) AS nullOrder_Number,
  COUNT(CASE WHEN LineItem IS NULL THEN 1 END) AS nullLine_Item,
  COUNT(CASE WHEN OrderDate IS NULL THEN 1 END) AS nullOrder_Date,
  COUNT(CASE WHEN CustomerKey IS NULL THEN 1 END) AS nullCustomerKey,
  COUNT(CASE WHEN StoreKey IS NULL THEN 1 END) AS nullStoreKey,
  COUNT(CASE WHEN ProductKey IS NULL THEN 1 END) AS nullProductKey,
  COUNT(CASE WHEN Quantity IS NULL THEN 1 END) AS nullQuantity,
  COUNT(CASE WHEN CurrencyCode IS NULL THEN 1 END) AS nullCurrency_Code
FROM sales;


##  changing the formate and data type

UPDATE sales
SET OrderDate = str_to_date(OrderDate, '%m/%d/%Y');

alter TABLE sales
MODIFY COLUMN OrderDate  date;

## Removing an unwanted column it contains more than 83% null value and cant repopulate it
SELECT 
  COUNT(*) AS totalRows,
  SUM(TRIM(DeliveryDate) = '') AS emptyDelivery_Date
FROM sales;
alter TABLE sales
DROP COLUMN DeliveryDate;

# 3. products table cleaning 

## Identifing the duplicates
with dupicate_cte as
( SELECT *,
ROW_NUMBER() over(
PARTITION BY Product_Key,Product_Name,Brand,Color,Unit_Cost_USD,Unit_Price_USD,Subcategory_Key,Subcategory,CategoryKey,Category) as row_num
FROM products)
SELECT* FROM dupicate_cte 
WHERE row_num > 1;

## standardizing the data
SELECT* FROM products;
SELECT 
  Product_Name,
  Color,
  TRIM(SUBSTRING_INDEX(Product_Name, ' ', -1)) AS ExtractedColor
FROM products;

SELECT 
  Product_Name,
  Color,
  TRIM(SUBSTRING_INDEX(Product_Name, ' ', -1)) AS ExtractedColor
FROM products
WHERE TRIM(SUBSTRING_INDEX(Product_Name, ' ', -1)) != TRIM(Color);

update products
SET Product_Key = trim(Product_Key);
update products
SET Product_Name = trim(Product_Name);
update products
SET Brand = trim(Brand);

update products
SET Color = trim(Color);

update products
SET Unit_Cost_USD = trim(Unit_Cost_USD);
update products
SET Unit_Price_USD = trim(Unit_Price_USD);
update products
SET Subcategory_Key = trim(Subcategory_Key);

update products
SET Subcategory = trim(Subcategory);

update products
SET CategoryKey = trim(CategoryKey);

update products
SET Category = trim(Category);
## identifing the dulicates
with dupicate_cte as
( SELECT *,
ROW_NUMBER() over(
PARTITION BY Product_Key,Product_Name,Brand,Color,Unit_Cost_USD,Unit_Price_USD,Subcategory_Key,Subcategory,CategoryKey,Category) as row_num
FROM products)
SELECT* FROM dupicate_cte 
WHERE row_num > 1;


## identifing the nulls
SELECT 
  COUNT(*) AS totalRows,
  COUNT(CASE WHEN Product_Key IS NULL THEN 1 END) AS nullProduct_Key,
  COUNT(CASE WHEN Product_Name IS NULL THEN 1 END) AS nullProduct_Name,
  COUNT(CASE WHEN Brand IS NULL THEN 1 END) AS nulBrand,
  COUNT(CASE WHEN Color IS NULL THEN 1 END) AS nullColor,
  COUNT(CASE WHEN Unit_Cost_USD IS NULL THEN 1 END) AS nullUnit_Cost_USD,
  COUNT(CASE WHEN Unit_Price_USD IS NULL THEN 1 END) AS Unit_Price_USD,
  COUNT(CASE WHEN Subcategory_Key IS NULL THEN 1 END) AS nullSubcategory_Key,
  COUNT(CASE WHEN Subcategory IS NULL THEN 1 END) AS nullSubcategory,
  COUNT(CASE WHEN CategoryKey IS NULL THEN 1 END) AS nullCategoryKey,
  COUNT(CASE WHEN Category IS NULL THEN 1 END) AS nullCategory
FROM products;

## standarizing th data
UPDATE products
set Unit_Cost_USD = replace(Unit_Cost_USD,'$','');

UPDATE products
set Unit_Cost_USD = replace(Unit_Cost_USD,',','');
## changing the data format
ALTER TABLE products
MODIFY COLUMN Unit_Cost_USD FLOAT;

# 4. exchange Table Cleaning

## finding duplcates
SELECT * FROM exchange;
WITH duplicate_cte as 
( SELECT *, 
ROW_NUMBER() OVER(PARTITION BY Date, Currency,Exchange) as row_num
FROM exchange)
SELECT * FROM duplicate_cte
WHERE row_num > 1;

## finding nulls
SELECT count(*) as totalrow,
 COUNT(CASE WHEN Date IS NULL THEN 1 END) AS nullDate,
  COUNT(CASE WHEN Currency IS NULL THEN 1 END) AS nullCurrency,
  COUNT(CASE WHEN Exchange IS NULL THEN 1 END) AS nullExchange
  FROM exchange;

##Changing the format and datatype  
 UPDATE exchange
 SET date = str_to_date(date, '%m/%d/%Y');
 ALTER TABLE exchange
 MODIFY COLUMN date date;


# 5. stores Table Cleaning
 
 ## finding dupicates
SELECT * FROM stores;

WITH dup_cte as(
SELECT* ,
ROW_NUMBER() OVER(PARTITION BY Store_Key,Country,State,Square_Meters,Open_Date) as rown
FROM stores)
SELECT * FROM dup_cte
WHERE rown > 1;
## finding Nulls
SELECT count(*) as total,
count(CASE WHEN Store_Key is null THEN 1 end) as nullStore_Key,
count(CASE WHEN Country is null THEN 1 end) as nullCountry,
count(CASE WHEN State is null THEN 1 end) as nullState,
count(CASE WHEN Square_Meters is null THEN 1 end) as nullSquare_Meters,
count(CASE WHEN Open_Date is null THEN 1 end) as nullOpen_Date
FROM stores;

# standardizing the data
UPDATE stores
SET Country =trim(Country);

UPDATE stores
SET State =trim(State);

## changing the formt and datatype
UPDATE stores
SET Open_Date = str_to_date(Open_Date, '%m/%d/%Y');

ALTER TABLE stores
MODIFY COLUMN Open_Date date;

### eda ###

## make a new table and add new colum for price in usd total revenue and profit

cREATE TABLE sales_usd LIKE sales;

ALTER TABLE sales_usd
ADD COLUMN price_usd FLOAT;
INSERT INTO sales_usd (
    OrderNumber,
    LineItem,
    OrderDate,
    CustomerKey,
    StoreKey,
    ProductKey,
    Quantity,
    CurrencyCode,
    price_usd
)
SELECT
    s.OrderNumber,
    s.LineItem,
    s.OrderDate,
    s.CustomerKey,
    s.StoreKey,
    s.ProductKey,
    s.Quantity,
    s.CurrencyCode,
    s.Quantity * e.Exchange AS price_usd
FROM sales s
LEFT JOIN exchange e
    ON s.CurrencyCode = e.Currency
    AND s.OrderDate = e.Date;





































