# ATLIQ MART PROMOTION ANALYSIS

# Introduction
-AtliQ Mart is a retail giant with over 50 supermarkets in the southern region of India. All their 50 stores ran a massive promotion 
during the Diwali 2023 and Sankranti 2024 (festive time n India) on their AtliQ branded products.  

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

## 4. Report having ISU% for each category during the diwali campaign and providing the ranking for the categories base on their ISU%
```
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
```

## 5. Top 5 Products, ranked by IR% (Incremental Revenue %) and having column product_name, category and IR%
```
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
 select 
	product_name,
    category,
    IR_PCT,
    rank() over (ORDER BY IR_PCT DESC ) AS ranking
 from cte
 LIMIT 5
```
# Result of analysis
- Gain insights into customer preferences and buying behavior during festive seasons.
- Leverage data to tailor future promotions to specific products, categories, and locations.
- Develop more effective strategies to maximize sales, revenue, and brand loyalty.
- Identify market trends and adapt promotional strategies accordingly.
- Stay ahead of the competition by offering targeted and impactful promotions.

# Conclusion
- By analyzing AtliQ Mart's recent promotions, we can gain valuable insights to optimize future campaigns, maximize profitability, and stay ahead of the competition in
  the South Indian retail market. 
👉Remember, data-driven decisions are key to success in today's competitive landscape.
