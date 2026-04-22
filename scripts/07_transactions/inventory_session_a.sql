-- Context:
-- Concurrency demo: inventory (lost update prevention)
-- Session A
--
-- Expected behavior:
-- Two sessions attempt to buy the only remaining unit of MENU_ITEM item_id=1 (stock_qty=1).
-- Exactly one succeeds; the other fails with "Insufficient stock...".

SET SERVEROUTPUT ON

VARIABLE order_id NUMBER

PROMPT Session A: placing order for item_id=1 quantity=1
EXEC fd_orders_pkg.place_single_item_order(1, 1, 1, 1, :order_id);
PRINT order_id

PROMPT Session A done.
