-- Context:
-- Optional: grant view access to roles (preferred over granting base tables for SELECT-only use cases)

PROMPT Granting view access...

GRANT SELECT ON vw_available_menu_items TO view_menu_role;
GRANT SELECT ON vw_customer_directory TO update_customer_role;
GRANT SELECT ON vw_delivery_tracking TO deliver_order_role;
GRANT SELECT ON vw_delivery_tracking TO admin_full_access_role;
