-- Context:
-- ISTE-436 Security Design
-- Layered RBAC:
--   Privileges -> Application Roles (task-based) -> User Roles (job-based) -> Users

PROMPT Creating roles...

-- Application roles (task-based)
CREATE ROLE place_order_role;
CREATE ROLE manage_order_items_role;
CREATE ROLE process_payment_role;
CREATE ROLE deliver_order_role;
CREATE ROLE update_customer_role;
CREATE ROLE review_order_role;
CREATE ROLE view_menu_role;
CREATE ROLE admin_full_access_role;

-- User roles (job-based)
CREATE ROLE customer_role;
CREATE ROLE driver_role;
CREATE ROLE restaurant_role;
CREATE ROLE admin_role;
CREATE ROLE developer_role;
