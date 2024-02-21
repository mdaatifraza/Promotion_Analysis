# Report having ISU% for each category during the diwali campaign 
# and providing the ranking for the categories base on their ISU%

with cte as (SELECT 
	p.category,
   (SUM(quantity_sold_after_promo) - SUM(quantity_sold_before_promo))*100 / SUM(quantity_sold_before_promo) as ISU_PCT
FROM fact_events e
JOIN dim_products p
ON
	e.product_code = p.product_code
WHERE campaign_id = "CAMP_DIW_01"
GROUP BY category)

SELECT 
	category,
    ISU_PCT,
    RANK() OVER (ORDER BY ISU_PCT DESC) as ranking
FROM cte
