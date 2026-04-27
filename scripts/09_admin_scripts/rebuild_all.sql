-- Rebuild Smart Food Delivery from scratch (calls reset + runs install order)
-- Run as: SYS (or SYSDBA)
-- Run from repo root: @scripts/09_admin_scripts/rebuild_all.sql

SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

SET DEFINE ON
ACCEPT tns CHAR DEFAULT 'SFDBCLIENT' PROMPT 'TNS alias [SFDBCLIENT]: '
SET DEFINE OFF

PROMPT == RESET ==
@@reset_all.sql

PROMPT == 03_security (SYS) ==
@@../03_security/create_admin.sql

PROMPT == 03_security (admin_1) ==
CONNECT admin_1/"Food123"@&&tns
SET ROLE ALL;
@@../03_security/create_roles.sql
@@../03_security/create_users.sql
@@../03_security/grant_system_privileges.sql

PROMPT == 01_db_setup + 02_schema + 04_business_logic (dev_1) ==
CONNECT dev_1/"Food123"@&&tns
SET ROLE ALL;
@@../01_db_setup/create_tablespaces.sql
@@../02_schema/create_tables.sql
@@../02_schema/add_constraints.sql
@@../02_schema/create_indexes.sql
@@../04_business_logic/install.sql

PROMPT == 03_security (dev_1 object grants) ==
@@../03_security/grant_privileges.sql

PROMPT == 06_data ==
@@../06_data/load_data.sql

PROMPT == 05_views ==
@@../05_views/install.sql

PROMPT Optional: view grants (uncomment if needed)
PROMPT   -- @@../05_views/grants_on_views.sql

PROMPT == DONE ==
