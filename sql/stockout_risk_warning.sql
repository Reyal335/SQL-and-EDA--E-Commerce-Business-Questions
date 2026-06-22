
/*
	Inventory & Supply Chain Health

	Stockout Risk Warning
*/

WITH days_elapsed AS (
	SELECT
		product_name,
		sales,
		date_added,
		stock_quantity,
		(CURRENT_DATE - date_added) AS days_elapsed
	FROM products
),
sales_rate AS (
	SELECT 
		product_name,
		stock_quantity,
		sales,
		ROUND(CAST((sales::real / days_elapsed) AS numeric), 3) AS daily_sales_rate
	FROM days_elapsed
) ,
supply_days AS (
	select 
		product_name,
		stock_quantity,
		sales,
		daily_sales_rate,
		CASE
			WHEN daily_sales_rate = 0 THEN 0
			ELSE ROUND((stock_quantity/daily_sales_rate), 2)
		END AS days_of_supply
	from sales_rate
),
inventory_health AS (
	SELECT 
		product_name,
		stock_quantity,
		sales,
		daily_sales_rate,
		days_of_supply,
		CASE
			WHEN days_of_supply < 3 THEN 'Critical Stockout Risk'
			WHEN days_of_supply BETWEEN 3 AND 7 THEN 'Low Stock Warning'
			WHEN days_of_supply > 7 THEN 'Healthy Stock'
		END AS inventory_health
	FROM supply_days 
)
SELECT * FROM inventory_health ih where ih.inventory_health = 'Critical Stockout Risk' 
