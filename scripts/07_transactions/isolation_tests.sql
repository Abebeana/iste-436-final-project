-- Context:
-- ISTE-436 isolation / consistency tests
--
-- Goal:
-- Demonstrate a consistent snapshot for multi-statement analytics using READ ONLY.
--
-- How to run:
-- - Session A: run this script.
-- - Session B: while A is paused, place a new order and COMMIT.
-- - Session A should see the same analytics results before COMMIT.

SET SERVEROUTPUT ON

VARIABLE order_count NUMBER
VARIABLE total_sales NUMBER

PROMPT Session A: begin READ ONLY transaction
SET TRANSACTION READ ONLY;

PROMPT Session A: first summary (restaurant_id=1)
BEGIN
  fd_analytics_pkg.restaurant_sales_summary(1, :order_count, :total_sales);
END;
/
PRINT order_count
PRINT total_sales

PROMPT Run Session B now (place an order and commit), then press Enter here.
ACCEPT dummy CHAR PROMPT 'Press Enter to run the summary again: '

PROMPT Session A: second summary (should match first)
BEGIN
  fd_analytics_pkg.restaurant_sales_summary(1, :order_count, :total_sales);
END;
/
PRINT order_count
PRINT total_sales

PROMPT Ending transaction
COMMIT;
