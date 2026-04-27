-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 05_views (optional)
-- Run as: dev_1 (schema owner)
-- Purpose: Grant SELECT on views to roles.
-- Run: @scripts/05_views/grants_on_views.sql
-- NOTE: Requires roles to exist first (03_security/create_roles.sql).
-- =====================================================================

-- Context:
-- Optional: grant view access to roles (preferred over granting base tables for SELECT-only use cases)

PROMPT Granting view access...

GRANT SELECT ON vw_available_menu_items TO view_menu_role;
GRANT SELECT ON vw_customer_directory TO update_customer_role;
GRANT SELECT ON vw_delivery_tracking TO deliver_order_role;
GRANT SELECT ON vw_delivery_tracking TO admin_role;
