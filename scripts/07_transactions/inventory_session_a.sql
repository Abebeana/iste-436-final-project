SET DEFINE OFF
SET SERVEROUTPUT ON

CONNECT cust_1/"Food123"

VARIABLE order_id NUMBER

PROMPT A: order item_id=1 qty=1
EXEC fd_orders_pkg.place_single_item_order(1, 1, 1, 1, :order_id);
PRINT order_id

PROMPT A: done
