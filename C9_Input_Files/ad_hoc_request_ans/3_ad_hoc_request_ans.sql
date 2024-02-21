# Display each campaign along with the total Revenue generated before 
# and after campaign

SELECT 
	c.campaign_name,
	ROUND(SUM(e.base_price*e.quantity_sold_before_promo)/1000000,2) as total_Rev_before_promo_mln,
    ROUND(SUM(e.base_price*e.quantity_sold_after_promo)/1000000,2) as total_Rev_after_promo_mln
FROM fact_events e
JOIN dim_campaigns c
ON
	e.campaign_id = c.campaign_id
GROUP BY c.campaign_name;
