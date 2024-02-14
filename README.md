# Promotion_Analysis
with cte as 
	(SELECT 
	DISTINCT(p.product_name),f.promo_type,f.base_price
FROM dim_products p
JOIN fact_events f
ON
	p.product_code = f.product_code)
SELECT * FROM cte
WHERE base_price > 500 and promo_type = "BOGOF"

kfheiyejrkejhierre rerere
