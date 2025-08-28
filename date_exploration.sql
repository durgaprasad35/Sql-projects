-- RETRIVE THE FIRST AND LAST DATES FROM A DATASET AND NO.OFMONTHS AND NO.OF YEARS
SELECT 
	MIN(order_date) AS FISRT_DATE ,
	MAX(order_date) AS LAST_DATE,
	DATEDIFF(MONTH,MIN(order_date),max(order_date)) months,
	DATEDIFF(year,MIN(order_date),max(order_date)) years 
FROM [gold.fact_sales];  
-- TO FIND THE YOUNGEST AND OLDEST CUSTOMER 
SELECT 
	DATEDIFF(YEAR,MIN(birthdate),getdate()) as older_age,
	DATEDIFF(YEAR,MAX(birthdate),GETDATE()) 
from [gold.dim_customers];