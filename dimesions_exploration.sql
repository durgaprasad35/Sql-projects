SELECT * FROM [gold.dim_products];


-- RETRIVE THE ALL DISTICT THE COUNTRIES
SELECT 
	DISTINCT COUNTRY 
FROM [gold.dim_customers]
ORDER BY COUNTRY;  
-- RETRIVE THE ALL DISTINCT CATEGORIES 
SELECT 
	DISTINCT 
	category 
FROM [gold.dim_products]
ORDER  BY category; 
-- RETRIVE ALL DISTICT SUBCATEGORIES 
SELECT 
	DISTINCT subcategory 
FROM [gold.dim_products] 
ORDER BY subcategory; 
-- RETRIVE ALL DISTINCT PRODUCTS 
SELECT 
	DISTINCT product_name 
FROM [gold.dim_products]
ORDER BY product_name;
