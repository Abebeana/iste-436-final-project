-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 03_security (multi-user)
-- Run as: This file prints the run order; execute the scripts below as SYS/admin_1/dev_1.
-- Purpose: Create admin, roles, users, system privileges, and object/execute grants.
-- Run: @scripts/03_security/install.sql
-- =====================================================================

SET DEFINE OFF
SET SERVEROUTPUT ON

PROMPT == 03_security ==
PROMPT (1) As SYS:
PROMPT     @scripts/03_security/create_admin.sql
PROMPT     (If you are using a CDB/PDB setup, connect to the correct PDB service first.)
PROMPT (2) As admin_1:
PROMPT     @scripts/03_security/create_roles.sql
PROMPT     @scripts/03_security/create_users.sql
PROMPT     @scripts/03_security/grant_system_privileges.sql
PROMPT (2b) As dev_1 (after system privileges):
PROMPT     Optional tablespaces: @scripts/01_db_setup/create_tablespaces.sql
PROMPT (3) As dev_1 (after schema objects exist):
PROMPT     @scripts/03_security/grant_privileges.sql

PROMPT == Done 03_security (instructions) ==

