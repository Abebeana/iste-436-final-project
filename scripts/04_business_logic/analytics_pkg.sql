-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 04_business_logic
-- Run as: dev_1 (schema owner)
-- Run: @scripts/04_business_logic/analytics_pkg.sql
-- =====================================================================

-- Context:
-- Smart Food Delivery Management System (ISTE-436)
-- Simple analytics procedure(s). For multi-statement consistency, prefer using
-- SET TRANSACTION READ ONLY in the calling script.

CREATE OR REPLACE PACKAGE fd_analytics_pkg AUTHID CURRENT_USER AS
  PROCEDURE restaurant_sales_summary(
    p_restaurant_id IN  NUMBER,
    o_order_count   OUT NUMBER,
    o_total_sales   OUT NUMBER
  );
END fd_analytics_pkg;
/

CREATE OR REPLACE PACKAGE BODY fd_analytics_pkg AS
  PROCEDURE restaurant_sales_summary(
    p_restaurant_id IN  NUMBER,
    o_order_count   OUT NUMBER,
    o_total_sales   OUT NUMBER
  ) AS
  BEGIN
    SELECT COUNT(*), NVL(SUM(total_amount), 0)
      INTO o_order_count, o_total_sales
      FROM orders
     WHERE restaurant_id = p_restaurant_id
       AND status IN ('Pending','Preparing','Delivered');
  END restaurant_sales_summary;
END fd_analytics_pkg;
/
