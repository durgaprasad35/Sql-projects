use EDA;
-- highest contributing category in the company
;WITH category_sales AS (
    SELECT 
        p.category,
        SUM(f.sales_amount) AS total_amount 
    FROM [gold.fact_sales] f 
    LEFT JOIN [gold.dim_products] p 
        ON p.product_key = f.product_key 
    GROUP BY p.category
)
SELECT 
    category,
    SUM(total_amount) OVER() AS grand_total,
    CAST(total_amount AS float) / SUM(total_amount) OVER() AS total_sales_ratio
FROM category_sales 
ORDER BY total_sales_ratio; 
-- highest contributing product in the company 
with product_sales as (
select 
p.product_name, 
sum(f.sales_amount) as total_sales 
from [gold.fact_sales] f
left join [gold.dim_products] p 
    on p.product_key = f.product_key  
group by product_name
)
select 
product_name,
sum(total_sales) over() as total_amount ,
round(cast((total_sales) as float) / (sum(total_sales) over())*100,2) as percentage_sales 
from product_sales 
order by total_amount; 
-- quantity wise product sales analysis
with quantiy_product_sales as( 
select 
p.product_name,
f.quantity,
sum(f.sales_amount) as total_sales 
from [gold.fact_sales] f 
left join [gold.dim_products] p 
    on p.product_key = f.product_key 
group by p.product_name,f.quantity
) 
select 
product_name,
quantity,
sum(total_sales) over() as total_amount ,
cast((total_sales) as float)/ (sum(total_sales) over()) * 100 
from quantiy_product_sales  
order by total_amount