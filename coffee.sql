SELECT * FROM coffee;

--the most expensive coffee (top 10)
SELECT coffee_name,
	price_per_100g
FROM coffee
WHERE price_per_100g IS NOT NULL
ORDER BY price_per_100g DESC
LIMIT 10

--average score by countries
select avg(total_score) as avg_score,
	origin_country_clean
from coffee
where origin_country_clean is not null
group by origin_country_clean
order by avg_score desc