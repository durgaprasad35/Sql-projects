-- the running total by month
select 
order_month,
total_sales,
sum(total_sales) over(order by order_month) runningtotal
from
(
select 
datetrunc(month,order_date) as order_month,
sum(sales_amount) as total_sales 
from [gold.fact_sales] 
where order_date is not null 
group by datetrunc(month,order_date)
)t 
--Running total by year 
select 
order_year,
total_sales,
sum(total_sales) over(order by order_year) running_total
from(

select 
year(order_date) as order_year,
sum(sales_amount) as total_sales
from [gold.fact_sales] 
where order_date is not null 
group by year(order_date)  
)t ;
-- The moving average by month 
select
order_month,
total_sales,
sum(total_sales) over(order by order_month) as running_total ,
avg(avg_price) over(order by order_month) as moving_avg
from (
select 
datetrunc(month,order_date) as order_month,
sum(sales_amount) as total_sales,
avg(price) as avg_price 
from [gold.fact_sales] 
where order_date is not null 
group by datetrunc(month,order_date) 
)t 
-- moving average by year
select 
order_year,
total_sales,
sum(total_sales) over(order by order_year) as running_total ,
avg_price,
avg(avg_price) over(order by order_year) as moving_avg 
from(
select 
datetrunc(year,order_date) as order_year,
sum(sales_amount) as total_sales,
avg(price) as avg_price 
from [gold.fact_sales] 
where order_date is not null 
group by datetrunc(year,order_date)
)t