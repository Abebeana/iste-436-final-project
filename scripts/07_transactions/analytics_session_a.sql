SET DEFINE OFF
SET SERVEROUTPUT ON

CONNECT cust_1/"Food123"

VARIABLE order_count NUMBER
VARIABLE total_sales NUMBER

PROMPT A: READ ONLY start
SET TRANSACTION READ ONLY;

PROMPT A: summary #1
BEGIN
  fd_analytics_pkg.restaurant_sales_summary(1, :order_count, :total_sales);
END;
/
PRINT order_count
PRINT total_sales

ACCEPT dummy CHAR PROMPT 'Run B, then Enter: '

PROMPT A: summary #2 (should match)
BEGIN
  fd_analytics_pkg.restaurant_sales_summary(1, :order_count, :total_sales);
END;
/
PRINT order_count
PRINT total_sales

PROMPT A: COMMIT
COMMIT;
