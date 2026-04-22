-- Context:
-- Master install script (schema owner)
-- Run from repo root in SQL*Plus / SQLcl:
--   @scripts/install.sql

SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT == 01_db_setup (conceptual) ==
@scripts/01_db_setup/init_params.sql
@scripts/01_db_setup/create_tablespaces.sql

PROMPT == 02_schema ==
@scripts/02_schema/create_tables.sql
@scripts/02_schema/add_constraints.sql
@scripts/02_schema/create_indexes.sql

PROMPT == 06_data (seed/demo) ==
@scripts/06_data/load_data.sql

PROMPT == 04_business_logic ==
@scripts/04_business_logic/procedures.sql
@scripts/04_business_logic/triggers.sql
@scripts/04_business_logic/functions.sql

PROMPT == 05_views ==
@scripts/05_views/row_level_views.sql
@scripts/05_views/column_level_views.sql

PROMPT == 05_views (optional grants) ==
PROMPT View grants require roles to exist. Run after 03_security/create_roles.sql:
PROMPT   @scripts/05_views/grants_on_views.sql

PROMPT == 03_security (roles + grants; users require admin) ==
PROMPT Run these if you have the required privileges:
PROMPT   @scripts/03_security/create_roles.sql
PROMPT   @scripts/03_security/grant_privileges.sql
PROMPT   @scripts/03_security/create_users.sql

PROMPT == Done ==
PROMPT For concurrency demos, open two sessions and use scripts/07_transactions.
