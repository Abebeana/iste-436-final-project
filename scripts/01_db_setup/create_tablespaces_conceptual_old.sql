-- Context:
-- Oracle physical design (conceptual).
-- Many student environments do not grant CREATE TABLESPACE.
-- Keep this file as documentation unless you have DBA privileges.
--
-- Expected layout (OFA-inspired):
--   SYSTEM_TS -> data dictionary / metadata (managed by Oracle)
--   DATA_TS   -> application tables
--   INDEX_TS  -> application indexes
--   UNDO_TS   -> undo segments (critical for read consistency)
--   TEMP_TS   -> sorting/temp
--   USERS_TS  -> code objects (procedures/views) (often just USERS)

PROMPT Tablespaces script is conceptual; no changes applied.

-- Example (uncomment only with DBA privileges):
-- CREATE TABLESPACE data_ts DATAFILE 'data_ts01.dbf' SIZE 200M AUTOEXTEND ON;
-- CREATE TABLESPACE index_ts DATAFILE 'index_ts01.dbf' SIZE 200M AUTOEXTEND ON;
-- CREATE UNDO TABLESPACE undo_ts DATAFILE 'undo_ts01.dbf' SIZE 200M AUTOEXTEND ON;
-- CREATE TEMPORARY TABLESPACE temp_ts TEMPFILE 'temp_ts01.dbf' SIZE 200M AUTOEXTEND ON;
