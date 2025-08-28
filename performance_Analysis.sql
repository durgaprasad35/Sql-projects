with cte as (
    select 
        year(f.order_date) as order_year, 
        sum(f.sales_amount) as total_amount,
        p.product_name 
    from [gold.fact_sales] f
    left join [gold.dim_products] p 
        on p.product_key = f.product_key
    where f.order_date is not null
    group by year(f.order_date), p.product_name
)
select 
order_year,
product_name,
total_amount,
avg(total_amount) over(partition by product_name) as avg_total ,
(total_amount) - (avg(total_amount) over(partition by product_name)) as change_,
case 
     when (total_amount) - (avg(total_amount) over(partition by product_name))>0 then 'above avg' 
     when (total_amount) - (avg(total_amount) over(partition by product_name)) <0 then 'below avg' 
     else 'avg' 
end avg_change, 
lag(total_amount) over(partition by product_name order by order_year) as prev,
(total_amount)- (lag(total_amount) over(partition by product_name order by order_year)) as prev_change ,
case 
     when (total_amount)- (lag(total_amount) over(partition by product_name order by order_year)) > 0 then 'increase' 
     when (total_amount)- (lag(total_amount) over(partition by product_name order by order_year)) < 0 then 'decrease' 
     else 'No change'
end prev_change
from cte;
