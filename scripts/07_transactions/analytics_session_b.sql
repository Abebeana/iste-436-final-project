SET DEFINE OFF
SET SERVEROUTPUT ON

CONNECT cust_2/"Food123"

VARIABLE order_id NUMBER

PROMPT B: place order + COMMIT
EXEC fd_orders_pkg.place_single_item_order(1, 1, 2, 1, :order_id);
PRINT order_id

PROMPT B: done
