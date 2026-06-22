/*
	Product and Sentiment Optimization:

	The flawed best seller: Products with terrible ratings but get huge sales volumes
	
	Hidden Gem: Products with high rating but suffer from low sales 
	
	Maturity: The longer the product, is it dominating in sales or are they stagnating
*/

/* Divide the sales data into quartiles, sales in Q4 considered 'many', while sales in Q1 */
WITH sales_percentiles AS (
    SELECT 
        percentile_cont(0.25) WITHIN GROUP (ORDER BY sales ASC) AS p25,
        percentile_cont(0.50) WITHIN GROUP (ORDER BY sales ASC) AS p50,
        percentile_cont(0.75) WITHIN GROUP (ORDER BY sales ASC) AS p75,
        percentile_cont(1.00) WITHIN GROUP (ORDER BY sales ASC) AS p100
    FROM products
),
sales_quartiled AS (
    SELECT 
        product_name, 
        sales, 
        rating,
        CASE
            WHEN sales <= sp.p25 THEN 'Q1'
            WHEN sales <= sp.p50 THEN 'Q2'
            WHEN sales <= sp.p75 THEN 'Q3'
            WHEN sales <= sp.p100 THEN 'Q4'
        END AS percentile_category
    FROM products
    CROSS JOIN sales_percentiles sp -- A cleaner, explicit way to join the single-row CTE
)

-- 1. The Flawed Bestseller Query
(
    SELECT 'Flawed Bestseller' AS business_insight, product_name, rating, sales, percentile_category 
    FROM sales_quartiled
    WHERE percentile_category = 'Q4' AND rating <= 2.0 -- Expanded slightly since exactly 1.0 might return nothing
    ORDER BY sales DESC
    LIMIT 5
)
UNION ALL
-- 2. The Hidden Gem Query
(
    SELECT 'Hidden Gem' AS business_insight, product_name, rating, sales, percentile_category 
    FROM sales_quartiled
    WHERE percentile_category = 'Q1' AND rating >= 4.0 -- Expanded slightly to catch high ratings close to 5
    ORDER BY sales DESC
    LIMIT 5
);

-- 3. The longer the product, is it dominating in sales or stagnating
SELECT CURRENT_DATE

WITH days_elapsed AS (
	SELECT
		product_name,
		sales,
		date_added,
		(CURRENT_DATE - date_added) AS days_elapsed
	FROM products
)
SELECT 
	product_name,
	ROUND(CAST((sales::real / days_elapsed) AS numeric), 2) AS daily_sales_rate
FROM days_elapsed
