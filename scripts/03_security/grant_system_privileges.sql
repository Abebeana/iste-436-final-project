-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 03_security (step 3/5)
-- Run as: admin_1 (DBA) (script will CONNECT admin_1 automatically)
-- Purpose: Grant system privileges to roles (e.g., developer_role).
-- Run: @scripts/03_security/grant_system_privileges.sql
-- =====================================================================

SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT Switching to admin_1 (DBA) for system grants...
CONNECT admin_1/"Food123"
SET ROLE ALL;

PROMPT Granting developer system privileges...

-- Role for developer system privileges
GRANT CREATE SESSION TO developer_role;
GRANT CREATE TABLESPACE TO developer_role;
GRANT CREATE TABLE TO developer_role;
GRANT CREATE VIEW TO developer_role;
GRANT CREATE SEQUENCE TO developer_role;
GRANT CREATE PROCEDURE TO developer_role;
GRANT CREATE TRIGGER TO developer_role;
GRANT CREATE TYPE TO developer_role;
GRANT CREATE CLUSTER TO developer_role;

-- Oracle 12c: UNLIMITED TABLESPACE cannot be granted to a ROLE (ORA-01931).
-- Grant it directly to the schema owner user instead (create_users.sql runs before this).
GRANT UNLIMITED TABLESPACE TO dev_1;

PROMPT Done.
