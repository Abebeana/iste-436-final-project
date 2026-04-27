-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 03_security (step 5/5)
-- Run as: dev_1 (schema owner). This script also CONNECTs to admin_1 for role-to-role grants.
-- Purpose: Grant object/execute privileges to roles and assign roles to users.
-- Run: @scripts/03_security/grant_privileges.sql
-- NOTE: Run after 02_schema + 04_business_logic (packages) exist.
-- =====================================================================
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT Connecting as dev_1...
CONNECT dev_1/"Food123"

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

PROMPT Granting EXECUTE on business logic...
GRANT EXECUTE ON fd_orders_pkg TO place_order_role;
GRANT EXECUTE ON fd_delivery_pkg TO deliver_order_role;
GRANT EXECUTE ON fd_analytics_pkg TO customer_role;

PROMPT Grouping application roles into user roles...

-- IMPORTANT:
-- Granting roles to roles requires ADMIN OPTION on those roles or system privilege.
-- Run this section as admin_1 (DBA).
PROMPT Switching to admin_1 for role hierarchy grants...
CONNECT admin_1/"Food123"

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

-- Developer job role (object creation in your own schema)
-- Note: developer system privileges are granted by admin_1 (DBA) in 03_security/grant_system_privileges.sql

PROMPT Switching back to dev_1...
CONNECT dev_1/"Food123"

PROMPT Granting job roles to users (developer-managed access)...
GRANT customer_role TO cust_1;
GRANT customer_role TO cust_2;
GRANT driver_role TO driver_1;
GRANT restaurant_role TO rest_1;

PROMPT Done granting privileges.
