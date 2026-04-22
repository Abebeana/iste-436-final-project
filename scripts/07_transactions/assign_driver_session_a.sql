-- Context:
-- Concurrency demo: driver assignment serialization
-- Session A
--
-- Steps:
-- 1) Create an order (item_id=2 has ample stock)
-- 2) Assign driver_id=1
-- 3) Run Session B near-simultaneously; it should block then fail (driver unavailable)
--
-- NOTE: fd_delivery_pkg.assign_driver enforces RBAC.
-- You must run the 03_security scripts and connect as a user with ADMIN_ROLE enabled.

SET SERVEROUTPUT ON

VARIABLE order_id NUMBER
VARIABLE delivery_id NUMBER

PROMPT Session A: create order
EXEC fd_orders_pkg.place_single_item_order(1, 1, 2, 1, :order_id);
PRINT order_id

PROMPT Session A: assign driver 1
EXEC fd_delivery_pkg.assign_driver(:order_id, 1, :delivery_id);
PRINT delivery_id

PROMPT Session A done.
