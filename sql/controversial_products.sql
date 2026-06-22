/*
	Controversial Products: Top products with mediocre rating but people still buy them
*/

SELECT * FROM products 
WHERE rating 
BETWEEN 2 AND 3 
ORDER BY sales DESC
LIMIT 5;

