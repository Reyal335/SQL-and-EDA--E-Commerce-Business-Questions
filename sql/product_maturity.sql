select * from products

/* Top selling product */

/*
	Product Maturity
	New/Unverified: <10 Reviews
	Niche: 10-100 reviews
	Established: 100-1,001 reviews
	Mega-Popular: 1000+ reviews
*/ 
WITH product_maturities AS (
	SELECT
		product_name,
		num_reviews,
		CASE
			WHEN num_reviews < 10 THEN 'New/Unverified'
			WHEN num_reviews BETWEEN 10 AND 100 THEN 'Niche'
			WHEN num_reviews BETWEEN 100 AND 1001 THEN 'Established'
			WHEN num_reviews > 1000 THEN 'Mega-Popular'
		END AS product_maturity
	FROM products
),
top_maturities AS (
	SELECT
		product_name,
		num_reviews,
		product_maturity,
		DENSE_RANK() OVER (
			PARTITION BY product_maturity
			ORDER BY num_reviews DESC
		) as rank
	FROM product_maturities
)
SELECT * from top_maturities WHERE rank <= 3;



/*
	Controversial Products: Top products with mediocre rating but people still buy them
*/


/*
	Product and Sentiment Optimization:

	The flawed best seller: Products with terrible ratings but get huge sales volumes
	
	Hidden Gem: Products with high rating but suffer from low sales 
	
	Maturity: The longer the product, is it dominating in sales or are they stagnating
*/


/*
	Pricing & Revenue Strategy:

	Price to value-sentiment rift: Do expensive products naturally get lower ratings because of higher 
	expectations, or cheap products get slammed for poor quality
*/

/*
	Inventory & Supply Chain Health:

	Stockout Risk Warning: high-demand products that are on the verge of vanishing

	Dead stock drain: Products that have low sales, terrible ratings, and take up much space in inventory
*/



