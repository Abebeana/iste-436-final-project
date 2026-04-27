SET DEFINE OFF
SET SERVEROUTPUT ON

VARIABLE order_id NUMBER
VARIABLE delivery_id NUMBER

PROMPT B: create order
CONNECT cust_2/"Food123"
EXEC fd_orders_pkg.place_single_item_order(2, 1, 2, 1, :order_id);
PRINT order_id

PROMPT B: assign driver
CONNECT admin_1/"Food123"
SET ROLE ALL;
PAUSE Enter to assign (sync with other window)
EXEC fd_delivery_pkg.assign_driver(:order_id, 1, :delivery_id);
PRINT delivery_id

PROMPT B: done
