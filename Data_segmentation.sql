
-- DATA SEGMENTATION WITH THE COST
with data_seg as(
select 
product_key,
product_name,
cost,
case when cost<100 then 'below 100 ' 
	when cost between 100 and 500 then '100-500' 
	when cost between 500 and 1000 then '500-1000' 
	else 'above 1000' 
end case_study 
from [gold.dim_products]
) 
select 
case_study,
count(product_key) as total_products 
from data_seg 
group by case_study 
order by total_products; 
-- DATA SEGMENTATION WITH THE TOTAL_SPENDING OF THE CUSTOMER AND THEIR LIFE SPAN IN THE COMPANY
with customer_total_spending as (
select 
c.customer_key,
sum(f.sales_amount) total_spending,
min(f.order_date) as first_order_date,
max(f.order_date) as last_order_date,
datediff(month,min(f.order_date),max(f.order_date)) as life_span 
from [gold.fact_sales] f 
left join [gold.dim_customers] c 
	on c.customer_key = f.customer_key 
group by c.customer_key 
) 
select 
customer_key, 
life_span,
total_spending,
case when life_span >=12 and total_spending > 5000 then 'VIP' 
	when life_span >=12 and total_spending <=5000 then 'regular' 
	else 'new_to_business' 
end case_study
from customer_total_spending; 
-- DATA SEGMENTATION USING THE PRODUCT WISE SALES
with product_wise_sales as(
select 
p.product_name,
p.product_key, 
sum(f.sales_amount)  as total_sales 
from [gold.fact_sales] f 
left join [gold.dim_products] p 
	on p.product_key = f.product_key 
group by p.product_name ,p.product_key 
) 
select 
product_name,
total_sales,
product_key,
case when total_sales < 1000 then 'below 1000' 
	 when total_sales between 1000 and 5000 then '1000-5000'
	 when total_sales between 5000 and 10000 then '5000-10000' 
	 else 'Above 10000' 
end case_Study 
from product_wise_sales ;
-- DATA SEGMENTATION FOR CATEGORY extended 
with category_sales as(
select 
p.category,
sum(f.sales_amount) as total_sales 
from [gold.fact_sales] f 
left join [gold.dim_products] p 
	on p.product_key = f.product_key 
group by p.category 
) 
select 
category ,
total_sales,
case when total_sales = max(total_sales) over() then 'Best performer'
	 when total_sales = min(total_sales) over() then 'Poor performer' 
	 else 'moderate performer' 
end 
from category_sales ;
WITH category_sales AS (
    SELECT 
        p.category,
        SUM(f.sales_amount) AS total_sales 
    FROM [gold.fact_sales] f 
    LEFT JOIN [gold.dim_products] p 
        ON p.product_key = f.product_key 
    GROUP BY p.category 
)
SELECT 
    category,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank,
    CASE 
        WHEN RANK() OVER (ORDER BY total_sales DESC) = 1 THEN 'Best performer'
        WHEN RANK() OVER (ORDER BY total_sales ASC) = 1 THEN 'Poor performer'
        ELSE 'Moderate performer'
    END AS performance_label
FROM category_sales
ORDER BY sales_rank;

select * from [gold.dim_customers]
select *
from [gold.dim_products]