SELECT 
	date_part('dow', order_date) as order_day, count(DISTINCT order_id) as Total_orders
From 
	pizza_sales
Group by 
	date_part('dow', order_date)
