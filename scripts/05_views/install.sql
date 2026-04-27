-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 05_views
-- Run as: dev_1 (schema owner)
-- Purpose: Create row-level and column-level views.
-- Run: @scripts/05_views/install.sql
-- NOTE: grants_on_views.sql requires roles to exist first (03_security/create_roles.sql).
-- =====================================================================

SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT == 05_views ==
@@row_level_views.sql
@@column_level_views.sql

PROMPT Optional (after roles exist): grants_on_views.sql
PROMPT   @scripts/05_views/grants_on_views.sql

PROMPT == Done 05_views ==
