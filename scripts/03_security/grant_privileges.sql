-- Context:
-- ISTE-436 Security Design
-- Grants are done in two layers:
--   1) Object privileges -> application (task) roles
--   2) Application roles -> user (job) roles
--
-- Run this as the schema owner (object owner) after schema and business logic are created.

PROMPT Granting object privileges to application roles...

-- Browse menu
GRANT SELECT ON menu_item TO view_menu_role;
GRANT SELECT ON restaurant TO view_menu_role;

-- Place order: needs to create orders and safely decrement stock
GRANT INSERT ON orders TO place_order_role;
GRANT UPDATE ON menu_item TO place_order_role;
GRANT SELECT ON menu_item TO place_order_role;

-- Add items to order
GRANT INSERT ON order_item TO manage_order_items_role;
GRANT SELECT ON menu_item TO manage_order_items_role;

-- Payments
GRANT INSERT ON payment TO process_payment_role;
GRANT SELECT ON orders TO process_payment_role;

-- Deliveries (driver completion)
GRANT SELECT, UPDATE ON delivery TO deliver_order_role;
GRANT UPDATE ON orders TO deliver_order_role;
GRANT UPDATE ON driver TO deliver_order_role;

-- Customer profile updates
GRANT SELECT, UPDATE ON customer TO update_customer_role;

-- Reviews
GRANT INSERT ON review TO review_order_role;

-- Admin full access to application objects
GRANT SELECT, INSERT, UPDATE, DELETE ON customer TO admin_full_access_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON restaurant TO admin_full_access_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON menu_item TO admin_full_access_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON orders TO admin_full_access_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON order_item TO admin_full_access_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON driver TO admin_full_access_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON delivery TO admin_full_access_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON payment TO admin_full_access_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON review TO admin_full_access_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON order_status_log TO admin_full_access_role;

PROMPT Granting EXECUTE on business logic...
GRANT EXECUTE ON fd_orders_pkg TO place_order_role;
GRANT EXECUTE ON fd_delivery_pkg TO deliver_order_role;
GRANT EXECUTE ON fd_delivery_pkg TO admin_full_access_role;
GRANT EXECUTE ON fd_analytics_pkg TO admin_full_access_role;
GRANT EXECUTE ON fd_analytics_pkg TO customer_role;

PROMPT Grouping application roles into user roles...

-- Customer job role
GRANT place_order_role TO customer_role;
GRANT manage_order_items_role TO customer_role;
GRANT process_payment_role TO customer_role;
GRANT review_order_role TO customer_role;
GRANT view_menu_role TO customer_role;
GRANT update_customer_role TO customer_role;

-- Driver job role
GRANT deliver_order_role TO driver_role;

-- Restaurant job role (browse-only for now)
GRANT view_menu_role TO restaurant_role;

-- Admin job role
GRANT admin_full_access_role TO admin_role;

-- Developer job role (object creation in your own schema)
-- Note: these are system privileges; in a restricted environment you may not have them.
-- GRANT CREATE TABLE, CREATE VIEW, CREATE PROCEDURE, CREATE SEQUENCE TO developer_role;

PROMPT Done granting privileges.
