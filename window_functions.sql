use sales

select * from orders


-- Practicing the window functions 
-- Window Aggregate functions 
-- count window function

-- 1. To know how many records are there in the dataset
select Customer_Name,
count(*) over() -- Over() function tells the window function is come into play  
from orders 

-- 2. To find the duplicates in the dataset  
-- Syntax to find the duplicates in the dataset 
-- count(*) over(partition by primary key)
select * 
from (
select 
Order_ID,  
count(*) over(partition by Order_ID) duplicated_values
from orders 
)t where duplicated_values > 1


-- 2.sum() window aggregate function 
-- Country wise total sales
select Country,
sum(Sales) over(partition by Country) sum_of_sales_by_category 
from orders  
-- Product wise totalsales 
select Product_ID ,
sum(Sales) over(partition by Product_ID) 
from orders 
--Category wise total sales 
select Category,
sum(Sales) over(partition by Category) 
from orders 

--3.average window aggregate funtion 

select Product_Name, Country,
avg(Sales) over(partition by Country) 
from orders 
-- Average sales for the Category: 'Office supplies' 
select 
*
from (
select  Category,
avg(Sales) over(partition by Category) avg_sales
from orders 
)t where Category = 'Office Supplies'

-- Average sales for the Category: 'Furniture'
select *
from (
select Category, 
avg(Sales) over(partition by Category) average_sales 
from orders 
)t where Category = 'Furniture' 

-- Average Sales for the Category : 'Technology' 
select * 
from (
select Category,
avg(Sales) over(partition by Category) as avg_sales 
from orders 
) t where Category = 'Technology' 

-- 3.Max/min window aggregate funnctions 
-- Maximum sales from each state
select State,
max(Sales) over(partition by State)
from orders 
-- minimum sales from each state 
select State,
min(Sales) over(partition by State) 
from orders 

-- RANKING WINDOW FUNCTIONS 
	-- 1.ROW_NUMBER() 
	-- 2.RANK() 
	-- 3.DENSE_RANK() 
	-- 4.NTILE(n) WHERE n IS A INTEGER  
-- In these ranking window functions the order by clause is must be requires

-- RANKING THE STATES BASED ON THE SALES (ROW_NUMBER())
	select State,
	sum(Sales) as total_sales ,
	row_number() over(order by sum(Sales) desc) as ranking 
	from orders 
	group by State 
	-- DRAWBACK:
		-- This can not able to the tie
	
-- RANKING THE CATEGORIES BASED ON THIER TOTAL SALES (RANK())

	select Category,
	sum(Sales) as total_sales ,
	rank() over(order by sum(Sales) desc) 
	from orders 
	group by category 
	-- ADVANTAGE OVER ROW_NUMBER(): IT CAN HANDLE THE TIE 
	-- DRAWBACK:
		-- IT CAN SKIP THE TIE NUMBER 
-- RANKING THE SUB_CATEGORY BASED ON THEIR SALES (DENSE_RANK()) 

select Sub_Category,
sum(Sales) as total_sales ,
dense_rank() over(order by sum(Sales) desc) 
from orders 
group by Sub_Category 
	-- It can handle tie and does not skip the rank... 

-- Find the highest sales for each product
select * from 
(
select Order_ID,Product_ID,Sales,
row_number() over(partition by Product_ID order by Sales desc) ranking
from orders
)t where ranking = 1 

-- NTILE(n) 
select * 
from (
select Order_ID ,
ntile(3) over(order by Sales desc) Bucket_NO
from orders
)t where Bucket_NO = 1 

select * 
from (
select Order_ID ,
ntile(3) over(order by Sales desc) Bucket_NO
from orders
)t where Bucket_NO = 2 

select * 
from (
select Order_ID ,
ntile(3) over(order by Sales desc) Bucket_NO
from orders
)t where Bucket_NO = 3
