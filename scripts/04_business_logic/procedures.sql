-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 04_business_logic
-- Run as: dev_1 (schema owner)
-- Purpose: Create PL/SQL packages.
-- Run: @scripts/04_business_logic/procedures.sql
-- =====================================================================

-- Context:
-- Smart Food Delivery Management System (ISTE-436)
-- Stored procedures / packages

SET SERVEROUTPUT ON

PROMPT Creating packages...

@@orders_pkg.sql
@@delivery_pkg.sql
@@analytics_pkg.sql
