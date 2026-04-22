-- Context:
-- Concurrency demo: driver assignment serialization
-- Session B
--
-- Expected behavior:
-- Session A and B both attempt to assign driver_id=1.
-- One session commits first; the other blocks on the driver row, then fails with "Driver is not available".
--
-- NOTE: fd_delivery_pkg.assign_driver enforces RBAC.
-- You must run the 03_security scripts and connect as a user with ADMIN_ROLE enabled.

SET SERVEROUTPUT ON

VARIABLE order_id NUMBER
VARIABLE delivery_id NUMBER

PROMPT Session B: create order (item_id=2)
EXEC fd_orders_pkg.place_single_item_order(2, 1, 2, 1, :order_id);
PRINT order_id

PROMPT Session B: assign driver 1 (run near-simultaneously with Session A)
EXEC fd_delivery_pkg.assign_driver(:order_id, 1, :delivery_id);
PRINT delivery_id

PROMPT Session B done.
