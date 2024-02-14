# ATLIQ MART PROMOTION ANALYSIS

# Business Request

## Identify high value with base price > 500 and promo type of BOGOF (buy one get one free)
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

