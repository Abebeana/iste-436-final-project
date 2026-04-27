-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 03_security (step 3/5)
-- Run as: admin_1 (DBA)
-- Purpose: Grant system privileges to roles (e.g., developer_role).
-- Run: @scripts/03_security/grant_system_privileges.sql
-- =====================================================================

PROMPT Granting developer system privileges...

-- Role for developer system privileges
GRANT CREATE SESSION TO developer_role;
GRANT UNLIMITED TABLESPACE TO developer_role;
GRANT CREATE TABLESPACE TO developer_role;
GRANT CREATE TABLE TO developer_role;
GRANT CREATE INDEX TO developer_role;
GRANT CREATE VIEW TO developer_role;
GRANT CREATE SEQUENCE TO developer_role;
GRANT CREATE PROCEDURE TO developer_role;
GRANT CREATE TRIGGER TO developer_role;
GRANT CREATE TYPE TO developer_role;
GRANT CREATE CLUSTER TO developer_role;

PROMPT Done.
