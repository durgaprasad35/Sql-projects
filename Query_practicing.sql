use EDA; 
-- to find the duplicate records in the table customers 
select first_name,last_name ,count(*) 
from [gold.dim_customers] 
group by first_name,last_name
having  count(*)>1 ; 


-- To find the duplicate records in the table products 
select product_name ,count(*) 
from [gold.dim_products] 
group by product_name 
having count(*)>1; 


-- To find the duplicates in the sales table 
select product_key,count(*) 
from [gold.fact_sales] 
group by product_key
having count(*) > 1; 

-- To retrive the second highest sales in the sales table 
select max(sales_amount) as second_highest_sales 
from [gold.fact_sales] 
where sales_amount < (select max(sales_amount  )from [gold.fact_sales]) ;


-- by joining the tables we can know the which product can make the second highest sales of each product 
select p.product_name,max(f.sales_amount) as second_highest_sales 
from [gold.fact_sales] f 
left join [gold.dim_products] p 
	on p.product_key = f.product_key 
where sales_amount < (select max(sales_amount) from [gold.fact_sales]) 
group by p.product_name; 


-- To know the second highest sales of each customer 

select c.first_name,c.last_name,max(f.sales_amount) as second_highest_sales 
from [gold.fact_sales] f 
left join [gold.dim_customers] c 
	on c.customer_key = f.customer_key 
where f.sales_amount < (select max(sales_amount) from [gold.fact_sales]) 
group by c.first_name , c.last_name; 
-- to calculate the total_revenue generated per each product 


select p.product_id,
sum(f.quantity*f.price) as total_revenue
from [gold.fact_sales] f 
left join [gold.dim_products] p 
	on p.product_key = f.product_key 
group by p.product_id 
order by total_revenue; 
-- To calculate the total revenue per each customer 


select c.customer_id,
sum(f.quantity*f.price) as total_revenue 
from [gold.fact_sales] f 
left join [gold.dim_customers] c 
ON c.customer_key = f.customer_key 
group by c.customer_id
order by total_revenue; 
-- Top 3 products get highest sales 


select top 3 product_name,total_sales
from 
(
select p.product_name,
sum(f.sales_amount) total_sales
from [gold.fact_sales] f 
left join [gold.dim_products] p 
	on p.product_key = f.product_key 
group by p.product_name 
) t 
-- to retrive the top 3 customer in the company 


select top 3 first_name,last_name,total_sales
from

(select c.first_name,c.last_name,sum(f.sales_amount) as total_sales 
from [gold.fact_sales] f 
left join [gold.dim_customers] c 
	on c.customer_key = f.customer_key 
group by c.first_name,c.last_name
)t 
-- To count the total_orders placed by the customer 


select c.first_name,c.last_name ,
count(f.order_number) as total_orders 
from [gold.fact_sales] f 
left join [gold.dim_customers] c 
	on c.customer_key = f.customer_key 
group by c.first_name,c.last_name 
having count(order_number) > 1; 
-- retriving the top 3 number of orders placed customers


select top 3 first_name,last_name,total_orders 
from (select c.first_name,c.last_name ,
count(f.order_number) as total_orders 
from [gold.fact_sales] f 
left join [gold.dim_customers] c 
	on c.customer_key = f.customer_key 
group by c.first_name,c.last_name 
having count(order_number) > 1)t 
order by total_orders desc;
-- retriving the bottom three customers who got places less no of orders 

select top 3 first_name,last_name,total_orders 
from (select c.first_name,c.last_name ,
count(f.order_number) as total_orders 
from [gold.fact_sales] f 
left join [gold.dim_customers] c 
	on c.customer_key = f.customer_key 
group by c.first_name,c.last_name 
)t 
order by total_orders asc;

-- order count per each product 
select p.product_name ,
count(f.order_number) total_orders
from [gold.fact_sales] f 
left join [gold.dim_products] p 
	on p.product_key = f.product_key 
group by p.product_name 
order by total_orders; 


-- retrive the top 5 products that are mostly ordred 
select top 5 product_name,total_orders 
from (select p.product_name ,
count(f.order_number) total_orders
from [gold.fact_sales] f 
left join [gold.dim_products] p 
	on p.product_key = f.product_key 
group by p.product_name 
)t 
order by total_orders desc; 

-- Top 3 total_revenue generated products 
select top 3 p.product_name,
sum(f.quantity*f.price) as total_revenue 
from [gold.fact_sales] f 
left join [gold.dim_products] p 
	on p.product_key = f.product_key 
group by p.product_name  
order by total_revenue desc; 

-- Top 3 total revenue generated categories 

select top 3 p.category,
sum(f.quantity*f.price) as total_revenue 
from [gold.fact_sales] f
left join [gold.dim_products] p 
	on p.product_key = f.product_key 
group by p.category 
order by total_revenue desc; 

--top 3 subcategories in generating the total_revenue 

select top 3 p.subcategory,
sum(f.quantity * f.price) as total_revenue 
from [gold.fact_sales] f 
left join [gold.dim_products] p 
	on p.product_key = f.product_key 
group by p.subcategory 
order by total_revenue desc; 

-- gender wise total revenue 

select c.gender ,
sum(f.quantity * f.price)  as total_revenue 
from [gold.fact_sales] f 
left join [gold.dim_customers] c 
	on c.customer_key = f.customer_key 
group by c.gender 
order by total_revenue desc; 

-- Gender wise total orders placed 
select c.gender ,
count(f.order_number ) as  total_orders 
from [gold.fact_sales] f 
left join [gold.dim_customers] c 
	on c.customer_key = f.customer_key 
group by c.gender 
order by total_orders desc; 

-- Top 5 countries generating the highest revenue  

select top 5 c.country ,
sum(f.quantity * f.price) as total_revenue 
from [gold.fact_sales] f
left join [gold.dim_customers] c
	on c.customer_key = f.customer_key 
group by c.country 
order by total_revenue desc;  

-- TOP 5 countries with highly perfromed product name
 
select 
    c.country,
    t.product_name,
    sum(t.total_sales) as total_sales
from (
    select top 5 
        p.product_name,
        f.customer_key,
        sum(f.sales_amount) as total_sales 
    from [gold.fact_sales] f 
    left join [gold.dim_products] p 
        on p.product_key = f.product_key 
    group by p.product_name, f.customer_key
) t 
left join [gold.dim_customers] c 
    on c.customer_key = t.customer_key 
group by c.country, t.product_name
order by total_sales desc; 



-- Retrieve the top 5 best-performing products by sales amount in each country

with product_sales as (
    select 
        c.country,
        p.product_name,
        sum(f.sales_amount) as total_sales
    from [gold.fact_sales] f
    join [gold.dim_products] p
        on f.product_key = p.product_key
    join [gold.dim_customers] c
        on f.customer_key = c.customer_key
    group by c.country, p.product_name
),
ranked_products as (
    select 
        country,
        product_name,
        total_sales,
        row_number() over (partition by country order by total_sales desc) as rn
    from product_sales
)
select country, product_name, total_sales
from ranked_products
where rn <= 5
order by country, total_sales desc;

-- retriving the all customers ordered in the year of 2010 
select c.first_name,c.last_name , year(f.order_date)
from [gold.fact_sales] f 
left join [gold.dim_customers] c
    on c.customer_key = f.customer_key 
where year(f.order_date) = '2010' 
group by c.first_name , c.last_name ,year(order_date);

-- retriving the all customers ordered in the year of 2011 
select c.first_name,c.last_name,year(f.order_date) ,sum(f.sales_amount) as total_sales
from [gold.fact_sales] f 
left join [gold.dim_customers] c 
    on c.customer_key = f.customer_key 
where year(f.order_date) = '2011' 
group by c.first_name,c.last_name,year(f.order_date); 

-- retriving the top 3 customers in the year of the 2010 and 2011 
select top 3 
    first_name,
    last_name,
    total_sales
from (
    select 
        c.first_name,
        c.last_name,
        year(f.order_date) as order_year,
        sum(f.sales_amount) as total_sales
    from [gold.fact_sales] f 
    left join [gold.dim_customers] c 
        on c.customer_key = f.customer_key 
    where year(f.order_date) in (2010, 2011)
    group by c.first_name, c.last_name, year(f.order_date)
) t
order by total_sales desc;
 
-- retriving the top customers in the year of the 2011 and 2012 

select top 3 
    first_name,
    last_name,
    total_sales
from (
    select 
        c.first_name,
        c.last_name,
        year(f.order_date) as order_year,
        sum(f.sales_amount) as total_sales
    from [gold.fact_sales] f 
    left join [gold.dim_customers] c 
        on c.customer_key = f.customer_key 
    where year(f.order_date) in (2011, 2012)
    group by c.first_name, c.last_name, year(f.order_date)
) t
order by total_sales desc; 

-- calculating the average order value per customer 
select c.first_name ,c.last_name,
avg(f.sales_amount) as avg_sales 
from [gold.fact_sales] f 
left join [gold.dim_customers] c 
    on c.customer_key = f.customer_key 
group by c.first_name,c.last_name
order by avg_sales desc; 

-- calculating the average order value per product 
select p.product_name,
avg(f.sales_amount) as avg_sales 
from [gold.fact_sales] f 
left join [gold.dim_products] p 
    on p.product_key = f.product_key 
group by p.product_name 
order by avg_sales desc;  

-- calculating the average order value per category 

select p.category ,
avg(f.sales_amount) as avg_sales 
from [gold.fact_sales] f 
left join [gold.dim_products] p 
    on p.product_key = f.product_key 
group by p.category 
order by avg_sales desc; 

-- calculating the average order value per country 
select  c.country , 
avg(sales_amount ) as avg_sales 
from [gold.fact_sales] f 
left join [gold.dim_customers] c 
    on c.customer_key = f.customer_key 
group by c.country 
order by avg_sales desc;