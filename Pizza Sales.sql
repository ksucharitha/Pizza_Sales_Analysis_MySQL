use pizzamania;
-- Unique Pizza Categories--	
SELECT DISTINCT(category) FROM pizza_types;
-- Unique Pizza Types--
SELECT DISTINCT(pizza_type_id) FROM pizza_types;

-- Top 5 most ordered pizza types?--
SELECT pt.name, COUNT(od.order_id) AS order_count
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY order_count DESC
LIMIT 5;
-- Busiest Time of day
SELECT HOUR(o.order_time) AS order_hour, COUNT(o.order_id) AS order_count
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY order_hour
ORDER BY order_count DESC
LIMIT 1;

-- Average price of pizzas ordered?
SELECT ROUND(AVG(p.price),2) AS average_price
FROM pizzas p
JOIN order_details od ON p.pizza_id = od.pizza_id;
-- total quarter wise revenue generated from pizza sales?
SELECT ROUND(SUM(p.price * od.quantity),2) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN orders o ON od.order_id = o.order_id
GROUP BY QUARTER(order_date);

-- pizzas of each size (small, medium, large) have been ordered?--
SELECT COUNT(p.size) AS size, COUNT(od.quantity) AS quantity_ordered FROM pizzas p 
JOIN order_details od
ON od.pizza_id=p.pizza_id
GROUP BY size;

-- Pizza per date--
SELECT o.order_date,COUNT(od.quantity) AS pizza_orders FROM order_details od
INNER JOIN orders o
ON od.order_id=o.order_id
GROUP BY o.order_date;
