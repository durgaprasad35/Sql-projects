create database e_commerce 

use e_commerce 
-- checking the orders table
select * from orders 
-- checking the users table
select * from users 
-- checking the products table
select * from products 

-- checking the datatypes of orders table 
select 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH, 
    IS_NULLABLE
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'orders'; 

--checking the datatypes of the users table 

select 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH, 
    IS_NULLABLE
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'users'; 

-- checking the datatypes of the products table 

select 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH, 
    IS_NULLABLE
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'products'; 

-- ISSUE: The product_id column having the datatype money need to fix 

-- Before going to perform the analysis first we have to prepare the data lets look into each table try to fix the dirty data 

 
--ORDERS TABLE:
    select * from orders
    -- splitting the date and time into two different columns 
 
    -- creating the order_time column
        alter table orders 
        add order_time time;  
        -- updating the time into the column 
        update orders 
        set order_time = cast(order_date as time)
        
    -- creating the date column 
        alter table orders 
        add OrderDate date; 
        -- updating the values in to the column  
        update orders 
        set OrderDate = cast(order_date as date) 

    -- Dropping the order_date column 
        alter table orders 
        drop column order_date 
        -- checking the any spaces exist in the categorical columns 
        select * 
        from (
                select len(order_status) as original_length , 
                len(trim(order_status)) as trimmed_length
                from orders 
              ) t where original_length <> trimmed_length 

        -- Observation : There are no spaces in the order_status column 

        EXEC sp_rename 'orders.order_status', 'OrderStatus', 'COLUMN'; 
        EXEC sp_rename 'orders.order_id', 'OrderID', 'COLUMN'; 
        EXEC sp_rename 'orders.user_id', 'UserID', 'COLUMN'; 
        EXEC sp_rename 'orders.order_time', 'OrderTime', 'COLUMN'; 
        EXEC sp_rename 'orders.total_amount', 'TotalAmount', 'COLUMN'; 
        select * from orders 

-- PRODUCTS TABLE 
    select * from products 
    -- sloving the issue 
    alter table products
    alter column product_id int;  

    -- checking the any spaces exist in the categorical columns 
        select * 
        from (
                select len(product_name) as original_length , 
                len(trim(product_name)) as trimmed_length
                from products 
              ) t where original_length <> trimmed_length 
        -- observation : This column is cleaned 

        select * 
        from (
                select len(category) as original_length , 
                len(trim(category)) as trimmed_length
                from products
              ) t where original_length <> trimmed_length  
       -- observation : This column is cleaned 
       
       select * 
        from (
                select len(brand) as original_length , 
                len(trim(brand)) as trimmed_length
                from products
              ) t where original_length <> trimmed_length 

      -- observation : This column is cleaned 

      -- Changing the column names 
      EXEC sp_rename 'products.product_id', 'ProductID', 'COLUMN';  
      EXEC sp_rename 'products.product_name', 'ProductName', 'COLUMN'; 
      EXEC sp_rename 'products.category', 'Category', 'COLUMN'; 
      EXEC sp_rename 'products.brand', 'Brand', 'COLUMN'; 
      EXEC sp_rename 'products.price', 'Price', 'COLUMN'; 
      EXEC sp_rename 'products.rating', 'Rating', 'COLUMN';

      select * from products


-- USERS TABLE 
    select * from users

    --Checking the categorical columns  
    select * 
        from (
                select len(name) as original_length , 
                len(trim(name)) as trimmed_length
                from users
              ) t where original_length <> trimmed_length 
    -- observation : This column is cleaned 
    select * 
        from (
                select len(email) as original_length , 
                len(trim(email)) as trimmed_length
                from users
              ) t where original_length <> trimmed_length  
    -- observation : This column is cleaned

    select * 
        from (
                select len(gender) as original_length , 
                len(trim(gender)) as trimmed_length
                from users
              ) t where original_length <> trimmed_length 
    -- observation : This column is cleaned
    select * 
        from (
                select len(city) as original_length , 
                len(trim(city)) as trimmed_length
                from users
              ) t where original_length <> trimmed_length
    -- observation : This column is cleaned 

    --Changing the names of the columns 

    EXEC sp_rename 'users.user_id', 'UserID', 'COLUMN';
    EXEC sp_rename 'users.name', 'Name', 'COLUMN';
    EXEC sp_rename 'users.email', 'Email', 'COLUMN';
    EXEC sp_rename 'users.gender', 'Gender', 'COLUMN';
    EXEC sp_rename 'users.city', 'City', 'COLUMN'; 
    EXEC sp_rename 'users.signup_date', 'JoiningDate', 'COLUMN'; 

    select * from users 

    select * from products 

    select * from orders


/*
1.List all customers (name + city).

2.Find total number of orders.

3.Get all products with price greater than 1000.

4.Find total revenue (sum of all payments or order totals).

5.Count how many sellers are in each state.

6.Find the cheapest product and the costliest product.

7.Find total revenue generated in 2024 

8.Show number of orders placed by each customer.

9.List products along with their category.

10.Find how many orders are “Delivered”, “Cancelled”, etc. (order status count).*/  


-- 1.List all customers (name + city). 
select 
    Name,City 
from users  

-- 2.Find total number of orders. 

select 
    count(*) as total_orders
from orders 

-- 3.Get all products with price greater than 1000. 
select 
    ProductName ,
    Price
from products 
where Price > 1000 

-- 4.Find total revenue (sum of all payments or order totals). 
select 
sum(TotalAmount) as total_revenue
from orders 

-- 5.Count how many sellers are in each state. 

select 
    City,
    count(City) as total_sellers
from users 
group by City


-- 6.Find the cheapest product and the costliest product. 
    -- Cheapest product 
    select
        top 1 ProductName , Price 
    from products 
    order by Price  
    -- costly product 
    select 
        top 1 ProductName,Price 
    from products 
    order by Price desc 
-- 7.Find total revenue generated in 2024  
select 
    sum(TotalAmount) as total_revenue,
    year(OrderDate) as year_
from orders 
where year(OrderDate) = '2024' 
group by year(OrderDate)  

-- 8.Show number of orders placed by each customer. 
select 
    u.Name,
    count(o.OrderID) as total_orders 
from users u 
left join orders o
on o.UserID = u.UserID 
group by u.Name

-- 9.List products along with their category. 
select 
    ProductName,
    Category 
from products

-- 10.Find how many orders are “Delivered”, “Cancelled” 

select OrderStatus ,
count(OrderStatus) total_orders
from orders
group by OrderStatus  


/* 
1.Find total revenue per product category.

2.List top 10 customers by number of orders.

3.Find customers who have placed more than 5 orders (HAVING).

4.Find average order value.

5.List orders along with customer names and product names (multi JOIN).

6.Find total revenue contributed by each seller.

7.Find month-wise revenue (GROUP BY month from order date).

8.List products that were never ordered.

9.Find repeat customers (who placed more than 1 order).

10.Find delivery success rate = Delivered Orders / Total Orders.

11.CTE practice: Create a CTE that stores category revenue and select only categories above average revenue
*/

-- 1.Find total revenue per product category. 

select 
    Category,
    sum(Price) as total_revenue 
from products 
group by Category 
order by sum(Price) 

-- 2.List top 10 customers by number of orders 

select 
    top 10 u.Name as customer_name,
    count(o.OrderID) as total_orders 
from users u 
left join orders o 
on o.UserID = u.UserID 
group by u.Name ,u.UserID
order by total_orders desc
 
 
-- 3.Find customers who have placed more than 5 orders 
select * from 
(
select 
    u.Name as customer_name , 
    count(o.OrderID) as total_orders 
from users u 
left join orders o 
on o.UserID = u.UserID 
group by u.Name , u.UserID ) t where  total_orders>5 

-- 4.Find average order value 
-- First approach
select 
    avg(TotalAmount) as total_avg 
from orders  

-- second approach according to the mathematics
select count(OrderID) as total_orders ,
sum(TotalAmount) as total_revenue ,
sum(TotalAmount) /  count(OrderID) 
from orders 

--7.Find month-wise revenue (GROUP BY month from order date). 
select distinct year(OrderDate) from orders 
    -- There are two years of data in our dataset 2024,2025 

    -- 2024 month-wise revenue
    select OrderDate, month(OrderDate) as month_, 
    sum(TotalAmount) as total_revenue 
    from orders 
    where year(OrderDate) = '2024'
    group by OrderDate , month(OrderDate) 
    order by sum(TotalAmount) desc  

    --2025 monthwise-revenue  

    select OrderDate, month(OrderDate) as month_, 
    sum(TotalAmount) as total_revenue 
    from orders 
    where year(OrderDate) = '2025'
    group by OrderDate , month(OrderDate) 
    order by sum(TotalAmount) desc 
--9.Find repeat customers (who placed more than 1 order). 
    select * 
    from (
    select u.Name,
    count(o.OrderID) as total_orders
    from orders o 
    left join users u
    on o.UserID = u.UserID 
    group by u.Name ) t 
    where total_orders > 1  

--10.Find delivery success rate = Delivered Orders / Total Orders. 
    -- Counting the total_orders
    with cte1 as(
    select count(OrderID) as total_orders 
    from orders
    ) ,
    
    -- Counting the Delivered_orders
    cte2 as
    (select Count(OrderStatus) as Total_delivered 
    from orders 
    where OrderStatus = 'completed') ,

    cte3 as 
    (select Count(OrderStatus) as total_retuned 
    from orders 
    where OrderStatus = 'returned'
    ) ,
    cte4 as (
        select Count(OrderStatus) as total_Cancelled
        from orders 
        where OrderStatus = 'cancelled'
    ),
    cte5 as (
        select Count(OrderStatus) as total_processing
        from orders 
        where OrderStatus = 'processing'
        )
     
    select 
           -- Calculating the percentage of delivered orders in the organization
           cast(cast(c2.Total_delivered as float) / cast(c1.total_orders as float)*100 as varchar(50)) + '%' as delivered_percentage,
           -- Calculating the percentage of returned orders in the Organization 
           cast(cast(c3.total_retuned as float) / cast(c1.total_orders as float)*100 as varchar(50)) + '%' as returned_percentage,
           -- Calculating the percentage of cancelled orders in the Organization 
           cast(cast(c4.total_Cancelled as float) / cast(c1.total_orders as float)*100 as varchar(50)) + '%' as Cancelled_orders,
           --Calculating the percentage of processsin orders in the Organization 
           cast(cast(c5.total_processing as float) / cast(c1.total_orders as float)*100 as varchar(50)) + '%' as Processing_orders
    from cte1 c1 
    cross join cte2 c2 
    cross join cte3 c3
    cross join cte4 c4
    cross join cte5 c5 






/*Advanced (Window functions, ranking, complex logic, nested queries)

Rank sellers by revenue using RANK() window function.

Find the top 3 products in each category by revenue .

Find cumulative revenue month-by-month .

Find the customer who generated the highest revenue in each state.

Find seller performance tier:

revenue > 10L → "Gold"

5L to 10L → "Silver"

< 5L → "Bronze"

Find the most purchased product pair (products frequently bought together in same order).

Create a dashboard-ready output query combining:

Customer name

Total orders

Total spend

Favorite category (most purchased)

Find anomaly orders where order value is > 3× average order value.
*/
    
--Rank customers by revenue using RANK() window function. 
    select u.Name ,
    sum(o.TotalAmount) as Total_amount_customers,
    row_number() over(order by sum(o.TotalAmount) desc) as Ranking_customers 
    from orders o 
    left join users u
        on o.UserID = u.UserID 
    group by u.Name 


-- Find the top 3 products in each category by revenue 
    select ProductName,Category , Price,
    sum(Price) over() as total_revenue,
    row_number() over(partition by Category order by sum(Price) desc)
    from products 
    group by ProductName,Category,Price 

--Find cumulative revenue month-by-month (SUM() OVER ORDER BY).
    select month_,
    sum(total_revenue) over(order by month_) as cummulative_revenue 
    from (

    select distinct month(OrderDate) as month_, 
    sum(TotalAmount) as total_revenue 
    from orders 
    group by month(OrderDate) 
    ) t 

--Find the customer who generated the highest revenue in each state 
    select * from(
    select name_,state ,total_revenue,
    rank() over(partition by state order by total_revenue desc) as rank_
    from(
    select u.Name as name_ , u.City as state ,
    sum(o.TotalAmount) total_revenue 
    from orders o 
    left join users u 
        on u.UserID = o.UserID 
    group by u.Name ,u.City,o.TotalAmount
    )t  
    )t2 
    where rank_ = 1 

/*Find customer performance tier:revenue > 10L → "Gold",5L to 10L → "Silver",< 5L → "Bronze"*/ 
    select *, 
        case 
            when total_amount > 7000 then 'Gold'
            when total_amount between 5000 and 7000 then 'Silver' 
            else 'Bronze'
        end  buckets
    from 
    (
    select u.Name,
    sum(o.TotalAmount) as total_amount 
    from orders o 
    left join users u 
    on u.UserID = o.UserID
    group by u.Name,o.TotalAmount) t 
    where 
    case 
            when total_amount >7000 then 'Gold'
            when total_amount between 5000 and 7000 then 'Silver' 
            else 'Bronze'
    end = 'Gold'


