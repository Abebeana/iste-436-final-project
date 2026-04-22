-- Context:
-- ISTE-436 required query demonstrations
-- Includes: join, grouping, sorting, DISTINCT, numeric functions, string functions.

SET LINESIZE 200

PROMPT (1) Meaningful JOIN: Orders with customer + restaurant
SELECT
  o.order_id,
  c.name AS customer_name,
  r.name AS restaurant_name,
  o.status,
  o.total_amount,
  o.order_time
FROM orders o
JOIN customer c ON c.customer_id = o.customer_id
JOIN restaurant r ON r.restaurant_id = o.restaurant_id
ORDER BY o.order_time DESC;

PROMPT (2) Grouping + sorting + numeric functions (SUM/ROUND) + DISTINCT
SELECT
  r.name AS restaurant_name,
  COUNT(DISTINCT o.customer_id) AS unique_customers,
  COUNT(*) AS order_count,
  ROUND(SUM(o.total_amount), 2) AS total_sales,
  ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM orders o
JOIN restaurant r ON r.restaurant_id = o.restaurant_id
WHERE o.status IN ('Pending','Preparing','Delivered')
GROUP BY r.name
ORDER BY total_sales DESC;

PROMPT (3) String functions (UPPER, SUBSTR) + sorting
SELECT
  c.customer_id,
  UPPER(c.name) AS name_upper,
  SUBSTR(c.phone, 1, 3) AS phone_area,
  c.status
FROM customer c
ORDER BY c.customer_id;
