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

