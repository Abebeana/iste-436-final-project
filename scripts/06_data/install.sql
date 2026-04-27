-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 06_data (seed/demo)
-- Run as: dev_1 (schema owner)
-- Purpose: Load demo data using SQL*Loader.
-- Run: @scripts/06_data/install.sql
-- NOTE: Requires SQL*Loader (sqlldr) available on the machine running SQL*Plus.
-- =====================================================================

SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT == 06_data ==
@@load_data.sql

PROMPT == Done 06_data ==
