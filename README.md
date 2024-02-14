# ATLIQ MART PROMOTION ANALYSIS

# Business Request

## 1. Identify high-value products with base price > 500 and promo type of BOGOF (buy one get one free)
```
with cte as 
	(SELECT 
	DISTINCT(p.product_name),f.promo_type,f.base_price
FROM dim_products p
JOIN fact_events f
ON
	p.product_code = f.product_code)
SELECT * FROM cte
WHERE base_price > 500 and promo_type = "BOGOF"
```

## 2. Total number of stores in each city, the result is stored in descending order of store counts. Allowing in indentify the city with the highest store
```
SELECT
	city, COUNT(store_id) as total_no_store
FROM dim_stores
GROUP BY city 
ORDER BY total_no_store DESC
```

## 3. Display each campaign along with the total Revenue generated before and after campaign
```
SELECT 
	c.campaign_name,
	ROUND(SUM(e.base_price*e.quantity_sold_before_promo)/1000000,2) as total_Rev_before_promo_mln,
        ROUND(SUM(e.base_price*e.quantity_sold_after_promo)/1000000,2) as total_Rev_after_promo_mln
FROM fact_events e
JOIN dim_campaigns c
ON
	e.campaign_id = c.campaign_id
GROUP BY c.campaign_name;
```

## 4. 
