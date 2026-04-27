-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 05_views
-- Run as: dev_1 (schema owner)
-- Purpose: Create row-level (row-filtered) views.
-- Run: @scripts/05_views/row_level_views.sql
-- =====================================================================

-- Context:
-- ISTE-436 Views
-- "Row-level" views used to restrict rows by business rules.

PROMPT Creating row-filtered views...

-- Only show menu items currently available.
CREATE OR REPLACE VIEW vw_available_menu_items AS
SELECT
  mi.item_id,
  mi.restaurant_id,
  mi.name,
  mi.price,
  mi.category,
  mi.stock_qty
FROM menu_item mi
WHERE mi.is_available = 'Y';

-- Only show active customers.
CREATE OR REPLACE VIEW vw_active_customers AS
SELECT
  c.customer_id,
  c.name,
  c.phone,
  c.address,
  c.created_at
FROM customer c
WHERE c.status = 'A';
