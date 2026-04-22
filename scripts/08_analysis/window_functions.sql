-- Context:
-- ISTE-436 analysis: window functions

SET LINESIZE 200

PROMPT Top orders per customer (ROW_NUMBER)
SELECT
  o.customer_id,
  o.order_id,
  o.total_amount,
  o.order_time,
  ROW_NUMBER() OVER (
    PARTITION BY o.customer_id
    ORDER BY o.total_amount DESC, o.order_time DESC
  ) AS rn
FROM orders o
WHERE o.status IN ('Pending','Preparing','Delivered')
ORDER BY o.customer_id, rn;

PROMPT Running sales total per restaurant (SUM OVER)
SELECT
  o.restaurant_id,
  o.order_time,
  o.total_amount,
  SUM(o.total_amount) OVER (
    PARTITION BY o.restaurant_id
    ORDER BY o.order_time
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS running_sales
FROM orders o
WHERE o.status IN ('Pending','Preparing','Delivered')
ORDER BY o.restaurant_id, o.order_time;

PROMPT Top restaurants by revenue (SUM OVER)
SELECT restaurant_id, revenue
FROM (
  SELECT
    o.restaurant_id,
    SUM(o.total_amount) OVER (PARTITION BY o.restaurant_id) AS revenue,
    ROW_NUMBER() OVER (PARTITION BY o.restaurant_id ORDER BY o.restaurant_id) AS rn
  FROM orders o
  WHERE o.status IN ('Pending','Preparing','Delivered')
)
WHERE rn = 1
ORDER BY revenue DESC, restaurant_id;

PROMPT Order delay analysis (RANK by delivery_time - order_time)
SELECT
  o.order_id,
  o.order_time,
  d.delivery_time,
  ROUND((d.delivery_time - o.order_time) * 24 * 60, 1) AS delay_minutes,
  RANK() OVER (ORDER BY (d.delivery_time - o.order_time) DESC) AS delay_rank
FROM orders o
JOIN delivery d
  ON d.order_id = o.order_id
WHERE d.delivery_time IS NOT NULL
ORDER BY delay_rank, o.order_id;

PROMPT Customer ranking (RANK by order count)
SELECT
  customer_id,
  order_count,
  RANK() OVER (ORDER BY order_count DESC) AS customer_rank
FROM (
  SELECT customer_id, COUNT(*) AS order_count
  FROM orders
  GROUP BY customer_id
)
ORDER BY customer_rank, customer_id;
