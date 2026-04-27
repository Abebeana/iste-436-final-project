-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 02_schema
-- Run as: dev_1 (schema owner)
-- Purpose: Create tables, constraints, and indexes.
-- Run: @scripts/02_schema/install.sql
-- =====================================================================

SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT == 02_schema ==
@@create_tables.sql
@@add_constraints.sql
@@create_indexes.sql

PROMPT == Done 02_schema ==
