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

-- top 3 countries with avg_price per 100g higher
select 
	origin_country_clean, 
	avg(price_per_100g) as avg_price
from coffee
where origin_country_clean is not null
group by origin_country_clean
having avg(price_per_100g) > 
(
select 
	avg(price_per_100g) as avg_price
from coffee
)
order by avg_price desc
limit 3

-- countries with coffee amount > 20 + average score
select 
	origin_country_clean
	, avg(total_score) as avg_score
	, count(distinct coffee_name) as coffee_nmb
from coffee
where origin_country_clean is not null
group by origin_country_clean
having count(distinct coffee_name) > 20

--avg_price for medium light per each country
select 
	origin_country_clean
	, avg(price_per_100g) as avg_price
from coffee
where roast_level = 'Medium Light' and origin_country_clean is not null
group by origin_country_clean
order by avg_price desc