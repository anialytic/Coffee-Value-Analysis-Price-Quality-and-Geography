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

--total amount of coffee by country
select count(coffee_name) as coffee_nmb,
	origin_country_clean
from coffee
where origin_country_clean is not null
group by origin_country_clean
order by coffee_nmb desc

--coffee with max_score in each country
select coffee_name,
       total_score,
       origin_country_clean
from(
    select coffee_name,
           total_score,
           origin_country_clean,
           row_number() over (partition by origin_country_clean order by total_score desc) as rn
    from coffee
    where origin_country_clean is not null
) t
where rn = 1
order by total_score desc