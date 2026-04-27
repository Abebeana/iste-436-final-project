SET DEFINE OFF
SET SERVEROUTPUT ON

CONNECT cust_2/"Food123"

VARIABLE order_id NUMBER

PROMPT B: order item_id=1 qty=1 (run near same time)
EXEC fd_orders_pkg.place_single_item_order(2, 1, 1, 1, :order_id);
PRINT order_id

PROMPT B: done
