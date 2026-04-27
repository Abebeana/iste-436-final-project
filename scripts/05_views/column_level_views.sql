-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 05_views
-- Run as: dev_1 (schema owner)
-- Purpose: Create column-level views to limit sensitive columns.
-- Run: @scripts/05_views/column_level_views.sql
-- =====================================================================

-- Context:
-- ISTE-436 Views
-- Column-level views to reduce exposure of sensitive fields.

PROMPT Creating column-filtered views...

-- Customer directory without full address.
CREATE OR REPLACE VIEW vw_customer_directory AS
SELECT
  c.customer_id,
  c.name,
  c.phone
FROM customer c
WHERE c.status = 'A';

-- Delivery tracking without driver performance details.
CREATE OR REPLACE VIEW vw_delivery_tracking AS
SELECT
  d.delivery_id,
  d.order_id,
  d.driver_id,
  d.pickup_time,
  d.delivery_time,
  d.delivery_status
FROM delivery d;
