-- find total customers for each country 
select country ,
	count(customer_key) as total_customers 
FROM [gold.dim_customers]
group by country 
ORDER BY total_customers desc; 
-- find total customers by gender 
select gender ,
	count(customer_key) as total_customers 
from [gold.dim_customers] 
group by gender 
order by total_customers desc; 
-- find total number of products by category 
select category,
	count(product_key) as total_products 
from [gold.dim_products] 
group by category  
order by total_products; 
-- what is the average cost of the each category 
select p.category,
	avg(f.price) as avg_price 
from [gold.fact_sales] f 
left join [gold.dim_products] p 
	on p.product_key = f.product_key 
group by p.category 
order by avg_price;

