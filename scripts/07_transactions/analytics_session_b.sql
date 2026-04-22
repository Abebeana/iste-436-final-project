-- Context:
-- Concurrency demo: consistent analytics snapshot
-- Session B

SET SERVEROUTPUT ON

VARIABLE order_id NUMBER

PROMPT Session B: place a new order while Session A is in READ ONLY
EXEC fd_orders_pkg.place_single_item_order(1, 1, 2, 1, :order_id);
PRINT order_id

PROMPT Session B done.
