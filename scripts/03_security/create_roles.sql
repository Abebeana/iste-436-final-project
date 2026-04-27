-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 03_security (step 2/5)
-- Run as: admin_1 (DBA)
-- Purpose: Create application roles (task-based) and user roles (job-based).
-- Run: @scripts/03_security/create_roles.sql
-- =====================================================================

PROMPT Creating roles...

-- Application roles (task-based)
CREATE ROLE place_order_role;
CREATE ROLE manage_order_items_role;
CREATE ROLE process_payment_role;
CREATE ROLE deliver_order_role;
CREATE ROLE update_customer_role;
CREATE ROLE review_order_role;
CREATE ROLE view_menu_role;

-- User roles (job-based)
CREATE ROLE customer_role;
CREATE ROLE driver_role;
CREATE ROLE restaurant_role;
CREATE ROLE admin_role;
CREATE ROLE developer_role;
