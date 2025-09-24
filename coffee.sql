SELECT * FROM coffee;

--the most expensive coffee (top 10)
SELECT coffee_name,
	price_per_100g
FROM coffee
WHERE price_per_100g IS NOT NULL
ORDER BY price_per_100g DESC
LIMIT 10