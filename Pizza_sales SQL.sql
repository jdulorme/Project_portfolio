/*
Answering Business Questions on Pizza Sales and gaining insight into the performance of the business  

*/

-- Shows the total revenue from pizzas sales  

SELECT 
	SUM(TOTAL_PRICE) AS TOTAL_REVENUE 
FROM 
	PIZZA_SALES


-- Shows the average order value 
	
SELECT 
	sum(total_price)/ count(DISTINCT order_id) as Avg_Order_Value
FROM 
	pizza_sales


-- Shows the total pizzas sold  
	
SELECT 
	sum(quantity) as Total_Pizza_Sold
FROM
	pizza_sales


-- Shows the total orders made 
	
SELECT 
	count(DISTINCT order_id) as Total_Orders
From 
	pizza_sales


-- Shows the average amount of pizzas sold per order 
	
SELECT 
	CAST(CAST(sum(quantity) as Decimal (10,2))/ 
	CAST(count(DISTINCT order_id) as Decimal (10,2)) as decimal (10,2)) as Avg_Pizzas_per_Order
From 
	pizza_sales


-- Shows the hourly trend for total pizzas sold 
	
SELECT 
	date_part('hour', order_time) as order_hour, sum(quantity) as Total_pizzas_sold
From 
	pizza_sales
Group by 
	date_part('hour', order_time)
order by 
	date_part('hour', order_time)


-- Shows the weekly trend for total pizzas sold	

select 
	date_part('week', order_date) as week_number, 
	date_part('year', order_date) as Order_year, 
	count(DISTINCT(order_id)) as Total_Orders
From 
	pizza_sales
Group by 
	date_part('week', order_date), 
	date_part('year', order_date) 
Order by 
	date_part('week', order_date),date_part('year', order_date)


-- Shows the percentage of pizza sold by pizza topping category 

Select
	pizza_category, sum(total_price) as Total_Sales,
	sum(total_price)* 100/ (SELECT sum(total_price) from pizza_sales) as Percentage_Total_Sales

From
	pizza_sales
Group by 
	pizza_category


-- Shows the percentage of pizza sold by pizza topping category for the month of January 	

Select
	pizza_category, sum(total_price) as Total_Sales,
	sum(total_price)* 100/ (SELECT sum(total_price) from pizza_sales where Extract(month from Order_date) = 1) as Percentage_Total_Sales
From
	pizza_sales
WHERE
	Extract(month from Order_date) = 1
Group by 
	pizza_category


--Shows the percentage of pizza sold by pizza size  
	
Select
	pizza_size, Cast(sum(total_price) as Decimal (10,2)) as Total_Sales,
	Cast(sum(total_price)* 100/ (SELECT sum(total_price) from pizza_sales) as Decimal (10,2)) as Percentage_Total_Sales
From
	pizza_sales
Group by 
	pizza_size
Order by 
	Percentage_Total_Sales DESC

	
--Shows the percentage of pizza sold by pizza size for one quarter 
	
Select
	pizza_size, Cast(sum(total_price) as Decimal (10,2)) as Total_Sales,
	Cast(sum(total_price)* 100/ 
		 (SELECT sum(total_price) from pizza_sales Where extract(quarter from order_date)=1) as Decimal (10,2)) as Percentage_Total_Sales
From
	pizza_sales
WHERE
	extract(quarter from order_date)=1
Group by 
	pizza_size
Order by 
	Percentage_Total_Sales DESC


--Shows the top five sellers by revenue 

SELECT
	pizza_name,
	Sum(total_price) as total_revenue
From 
	pizza_sales
group by 
	pizza_name 
order by total_revenue Desc
LIMIT 5


--Shows the top five worst sellers by revenue 
	
SELECT
	pizza_name,
	Sum(total_price) as total_revenue
From 
	pizza_sales
group by 
	pizza_name 
order by total_revenue ASC
LIMIT 5

