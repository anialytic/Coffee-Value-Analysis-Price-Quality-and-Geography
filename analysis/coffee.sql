SELECT * FROM coffee;

--the most expensive coffee (top 10)
SELECT coffee_name,
	price_per_100g
FROM coffee
ORDER BY price_per_100g DESC
LIMIT 10


-- Fixing 
UPDATE coffee
SET origin_country = 'USA'
WHERE origin_country = 'USa';

--average score by countries
select avg(total_score) as avg_score,
	origin_country
from coffee
where origin_country is not null
group by origin_country
order by avg_score desc

--total amount of coffee by country
select count(coffee_name) as coffee_nmb,
	origin_country
from coffee
where origin_country is not null
group by origin_country
order by coffee_nmb desc

--coffee with max_score in each country
select coffee_name,
       total_score,
       origin_country
from(
    select coffee_name,
           total_score,
           origin_country,
           row_number() over (partition by origin_country order by total_score desc) as rn
    from coffee
    where origin_country is not null
) t
where rn = 1
order by total_score desc

-- top 3 countries with avg_price per 100g higher
select 
	origin_country, 
	avg(price_per_100g) as avg_price
from coffee
where origin_country is not null
group by origin_country
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
	origin_country
	, avg(total_score) as avg_score
	, count(distinct coffee_name) as coffee_nmb
from coffee
where origin_country is not null
group by origin_country
having count(distinct coffee_name) > 20

--avg_price for medium light per each country
select 
	origin_country
	, avg(price_per_100g) as avg_price
from coffee
where roast_level = 'Medium Light' and origin_country is not null
group by origin_country
order by avg_price desc

--segmentation by roast_level
select roast_level
	, count(*) as amount
from coffee 
group by roast_level
order by amount desc

--segmentation by price
select price_per_100g 
	, count(*) as amount
from coffee
group by price_per_100g
order by price_per_100g desc

select
    case
        when price_per_100g < 15 then 'budget'
        when price_per_100g between 15 and 99 then 'mid'
        else 'premium'
    end as price_segment,
    count(*) as total
from coffee
group by price_segment;

