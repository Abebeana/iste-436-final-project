-- Admin script (may require DBA privileges)

PROMPT Instance status (requires access to V$INSTANCE)
SELECT instance_name, status, database_status FROM v$instance;
