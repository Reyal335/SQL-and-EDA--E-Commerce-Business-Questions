-- Sales top products from each category
WITH ranked AS (
	SELECT 
		category,
		product_name,
		SUM(sales),
		RANK() OVER (
			PARTITION BY category
			ORDER BY SUM(sales) DESC
		)
	FROM products
	GROUP BY product_name, category
)
SELECT * FROM ranked 
WHERE rank <= 3