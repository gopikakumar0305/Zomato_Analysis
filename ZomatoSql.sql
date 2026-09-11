CREATE DATABASE ZomatoDB;
USE ZomatoDB;
SELECT COUNT(*) FROM Zomato_Restaurants;
SELECT COUNT(*) FROM Zomato_Orders;
ALTER TABLE Zomato_Restaurants
CHANGE COLUMN `ï»¿restaurant_id` restaurant_id TEXT;
ALTER TABLE Zomato_Orders
CHANGE COLUMN `ï»¿order_id` order_id TEXT;
SELECT * FROM Zomato_Restaurants LIMIT 5;
SELECT * FROM Zomato_Orders LIMIT 5;

-- Check for duplicate restaurant records
SELECT restaurant_id, COUNT(*) AS cnt
FROM Zomato_Restaurants
GROUP BY restaurant_id
HAVING cnt > 1;

-- Check for duplicate orders
SELECT order_id, COUNT(*) AS cnt
FROM Zomato_Orders
GROUP BY order_id
HAVING cnt > 1;

-- Check restaurant table for NULLs
SELECT
  SUM(restaurant_name IS NULL) AS null_name,
  SUM(city IS NULL) AS null_city,
  SUM(area IS NULL) AS null_area,
  SUM(cuisine IS NULL) AS null_cuisine,
  SUM(avg_rating IS NULL) AS null_avg_rating,
  SUM(total_ratings IS NULL) AS null_total_ratings,
  SUM(price_range IS NULL) AS null_price_range,
  SUM(delivery_available IS NULL) AS null_delivery
FROM Zomato_Restaurants;

-- Check orders table for NULLs
SELECT
  SUM(customer_id IS NULL) AS null_customer,
  SUM(order_date IS NULL) AS null_date,
  SUM(order_time IS NULL) AS null_time,
  SUM(delivery_time IS NULL) AS null_delivery_time,
  SUM(total_cost IS NULL) AS null_cost,
  SUM(item_count IS NULL) AS null_items,
  SUM(payment_method IS NULL) AS null_payment,
  SUM(customer_rating IS NULL) AS null_rating
FROM Zomato_Orders;

-- Step 1: Number of restaurants per city
SELECT city, COUNT(*) AS restaurant_count
FROM Zomato_Restaurants
GROUP BY city
ORDER BY restaurant_count DESC;

-- Step 2: Top 5 cities by number of orders
SELECT r.city, COUNT(o.order_id) AS order_count
FROM Zomato_Orders o
JOIN Zomato_Restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.city
ORDER BY order_count DESC
LIMIT 5;

-- Step 3: Total revenue per restaurant
SELECT o.restaurant_id, r.restaurant_name, SUM(o.total_cost) AS total_revenue
FROM Zomato_Orders o
JOIN Zomato_Restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY o.restaurant_id, r.restaurant_name
ORDER BY total_revenue DESC;

-- Step 4: Average order amount per city
SELECT r.city, AVG(o.total_cost) AS avg_order_amount
FROM Zomato_Orders o
JOIN Zomato_Restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.city
ORDER BY avg_order_amount DESC;

-- Step 5: Top 5 restaurants by total sales
SELECT o.restaurant_id, r.restaurant_name, SUM(o.total_cost) AS total_sales
FROM Zomato_Orders o
JOIN Zomato_Restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY o.restaurant_id, r.restaurant_name
ORDER BY total_sales DESC
LIMIT 5;


-- Step 6: The full join (this is the one you'll export)
SELECT
  o.order_id,
  o.restaurant_id,
  r.restaurant_name,
  r.city,
  r.area,
  r.cuisine,
  r.avg_rating,
  r.total_ratings,
  r.price_range,
  r.delivery_available,
  o.customer_id,
  o.order_date,
  o.order_time,
  o.delivery_time,
  o.total_cost,
  o.item_count,
  o.payment_method,
  o.customer_rating
FROM Zomato_Orders o
JOIN Zomato_Restaurants r ON o.restaurant_id = r.restaurant_id;