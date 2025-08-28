-- FIND THE TOTAL SALES 
SELECT 
	SUM(sales_amount) AS TOTAL_SALES
FROM [gold.fact_sales]; 
-- HOW MANY ITEMS ARE SOLD 
SELECT 
	SUM(quantity) as total_items 
FROM [gold.fact_sales]; 
-- TO KNOW THE AVERAGE SELLING PRICE 
SELECT 
	AVG(price) AS AVG_PRICE
FROM [gold.fact_sales];
-- TO COUNT THE TOTAL NUMBER OF ORDERS 
SELECT 
	COUNT(order_number)  AS TOTAL_NO_OF_ORDERS
FROM [gold.fact_sales]; 
-- ADD DISTINCT ORDERS 
SELECT 
	COUNT(DISTINCT order_number)  TOTAL_ORDERS
FROM [gold.fact_sales]; 
-- TO FIND THE TOTAL NO OF PRODUCTS 
SELECT 
	COUNT(product_key)  AS TOTAL_PRODUCTS
FROM [gold.dim_products]; 
-- ADD DISTINCT TO IT (THIS WILL GIVE US A IDEA ABOUT THE NUMBER OF DUPLICATES)
SELECT 
	COUNT(DISTINCT product_key)  
FROM [gold.dim_products];
-- TO FIND THE TOTAL NUMBER OF CUSTOMERS 
SELECT 
	COUNT(customer_key)  
FROM [gold.dim_customers] ;
-- ADD DSITINCT TO IT 
SELECT 
	COUNT(DISTINCT customer_key) AS TOTAL_CUSTOMERS
FROM [gold.dim_customers]; 
-- MAKING A REPORT TO SEE THE ALL KEY METRIX IN ONE PLACE 
SELECT 'TOTAL SALES' , SUM(sales_amount) FROM [gold.fact_sales] 
UNION ALL 
SELECT 'TOTAL QUANTITY' , SUM(quantity) FROM [gold.fact_sales] 
UNION ALL 
SELECT 'AVERAGE_SELLING_PRICE' , AVG(price) FROM [gold.fact_sales] 
UNION ALL 
SELECT 'TOTAL PRODUCTS' , COUNT(DISTINCT product_key) FROM [gold.dim_products] 
UNION ALL 
SELECT 'TOTAL CUSTOMERS ' , COUNT(DISTINCT customer_key) FROM [gold.dim_customers] 
UNION ALL 
SELECT 'TOTAL ORDERS ' , COUNT(DISTINCT order_number) FROM [gold.fact_sales];