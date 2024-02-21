# Top 5 Products, ranked by IR% (Incremental Revenue %) and having column product_name, category and IR%

with cte as (SELECT 
	p.product_name,
	p.category,
	(SUM(base_price*quantity_sold_after_promo) - SUM(base_price*quantity_sold_before_promo))*100 / SUM(base_price*quantity_sold_before_promo) IR_PCT
 FROM fact_events e
 JOIN dim_products p
 ON
	e.product_code = p.product_code
GROUP BY product_name
)
SELECT 
	product_name,
    category,
    IR_PCT,
    rank() over (ORDER BY IR_PCT DESC ) AS ranking
 FROM cte
 LIMIT 5