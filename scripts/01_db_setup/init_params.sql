-- Context:
-- AWS Oracle VM (smartfood) initialization parameters (DBA/SYSDBA).
--
-- You provided:
--   audit_file_dest=/u01/app/oracle/admin/smartfood/adump
--   core_dump_dest=/u01/app/oracle/diag/rdbms/smartfood/SFDB/incident
--   diagnostic_dest=/u01/app/oracle
--
-- Notes:
-- - Many init parameters require SYSDBA.
-- - Some are static and require SCOPE=SPFILE + restart.
-- - This script attempts to apply them but will continue on errors.

SET SERVEROUTPUT ON

PROMPT Attempting to apply initialization parameter paths (continues on error)...
PROMPT Run as SYSDBA if you want these to actually apply.

WHENEVER SQLERROR CONTINUE

ALTER SYSTEM SET audit_file_dest='/u01/app/oracle/admin/smartfood/adump' SCOPE=SPFILE;
ALTER SYSTEM SET core_dump_dest='/u01/app/oracle/diag/rdbms/smartfood/SFDB/incident' SCOPE=SPFILE;
ALTER SYSTEM SET diagnostic_dest='/u01/app/oracle' SCOPE=SPFILE;

WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT NOTE: If any parameter was set with SCOPE=SPFILE, restart the instance to apply it.
