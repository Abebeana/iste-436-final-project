-- Context:
-- Concurrency demo: inventory (lost update prevention)
-- Session B

SET SERVEROUTPUT ON

VARIABLE order_id NUMBER

PROMPT Session B: placing order for item_id=1 quantity=1 (run near-simultaneously with Session A)
EXEC fd_orders_pkg.place_single_item_order(2, 1, 1, 1, :order_id);
PRINT order_id

PROMPT Session B done.
