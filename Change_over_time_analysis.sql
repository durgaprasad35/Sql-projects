USE EDA;
-- CHANGE OVER TIME ANALYSIS(DAY) 
SELECT 
order_date ,
SUM(sales_amount) AS TOTAL_SALES
FROM [gold.fact_sales]  
WHERE order_date IS NOT NULL 
GROUP BY order_date 
ORDER BY order_date ; 
-- CHANGE OVER TIME ANALYSIS(MONTH) 
SELECT 
MONTH(order_date),
SUM(sales_amount) AS TOTAL_SALES 
FROM [gold.fact_sales] 
WHERE order_date IS NOT NULL 
GROUP BY month(order_date) 
ORDER BY order_date; 
-- CHANGE OVER TIME ANALYSIS (YEAR ) 
SELECT  
YEAR(order_date) order_date,
SUM(sales_amount) AS TOTAL_SALES 
FROM [gold.fact_sales] 
WHERE order_date is not null 
group by year(order_date) 
order by TOTAL_SALES; 
--analysing the evolution of the customers (years) 
select year(order_date) as order_date,
sum(sales_amount) as total_sales,
count(customer_key) as total_customers 
from [gold.fact_sales]
where order_date is not null 
group by year(order_date)  
order by order_date; 
-- TOTAL QUANTITY ENVOVLED BY YEAR 
select 
year(order_date) as order_year ,
count(customer_key) as total_customers,
sum(sales_amount) as total_sales,
count(quantity) as total_quantity
from [gold.fact_sales] 
where order_date is not null 
group by year(order_date) 
order by year(order_date);
 select * from [gold.fact_sales]; 
-- same analysis but for the month 
select 
month(order_date) as order_month ,
sum(sales_amount) as total_sales,
count(customer_key) as total_customers 
from [gold.fact_sales] 
where order_date is not null 
group by month(order_date) 
order by month(order_date);
-- average price by month
select 
month(order_date) as order_date,
avg(price) as avg_price 
from [gold.fact_sales] 
where order_date is not null 
group by month(order_date) 
order by month(order_date); 
-- average year by month 
select 
year(order_date) as order_date,
avg(price) as avg_price 
from [gold.fact_sales] 
where order_date is not null 
group by year(order_date) 
order by year(order_date) ;