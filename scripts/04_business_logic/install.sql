-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 04_business_logic
-- Run as: dev_1 (schema owner)
-- Purpose: Create packages/procedures/triggers/functions.
-- Run: @scripts/04_business_logic/install.sql
-- NOTE: Run after 02_schema; run before 03_security/grant_privileges.sql.
-- =====================================================================

SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT == 04_business_logic ==
@@procedures.sql
@@triggers.sql


PROMPT == Done 04_business_logic ==
