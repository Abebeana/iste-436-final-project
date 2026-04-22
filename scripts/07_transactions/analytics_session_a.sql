-- Context:
-- Concurrency demo: consistent analytics snapshot
-- Session A
--
-- Expected behavior:
-- This session runs READ ONLY and repeats the summary.
-- Even if Session B places a new order and commits, Session A should keep seeing its original snapshot.

SET SERVEROUTPUT ON

VARIABLE order_count NUMBER
VARIABLE total_sales NUMBER

PROMPT Session A: begin read-only transaction
SET TRANSACTION READ ONLY;

PROMPT Session A: first summary (restaurant_id=1)
BEGIN
  fd_analytics_pkg.restaurant_sales_summary(1, :order_count, :total_sales);
END;
/
PRINT order_count
PRINT total_sales

PROMPT Session A: run Session B now, then press Enter here to continue
ACCEPT dummy CHAR PROMPT 'Press Enter to run the summary again: '

PROMPT Session A: second summary (should match first)
BEGIN
  fd_analytics_pkg.restaurant_sales_summary(1, :order_count, :total_sales);
END;
/
PRINT order_count
PRINT total_sales

PROMPT Session A: ending transaction
COMMIT;
