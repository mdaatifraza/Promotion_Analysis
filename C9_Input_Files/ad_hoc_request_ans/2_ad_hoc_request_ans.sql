# Total number of stores in each city, the result is stored 
# in descending order of store counts. Allowing in indentify the 
# city with the highest store

SELECT
	city, COUNT(store_id) as total_no_store
FROM dim_stores
GROUP BY city 
ORDER BY total_no_store DESC