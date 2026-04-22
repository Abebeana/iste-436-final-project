-- Context:
-- ISTE-436 analysis: basic performance / indexing demonstration
-- Note: DBMS_XPLAN access may require privileges in some environments.

SET LINESIZE 200

PROMPT Explain plan for a join query
EXPLAIN PLAN FOR
SELECT
  o.order_id,
  c.name,
  r.name,
  o.total_amount
FROM orders o
JOIN customer c ON c.customer_id = o.customer_id
JOIN restaurant r ON r.restaurant_id = o.restaurant_id
WHERE o.status IN ('Pending','Preparing','Delivered');

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
