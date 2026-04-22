-- Context:
-- ISTE-436 physical design (conceptual).
-- Many student environments do not grant CREATE TABLESPACE.
-- Keep this file as documentation unless you have DBA privileges.
--
-- Weights & Percentages (from ISTE-436-FINAL.pdf):
--   DATA, DATA_2, INDEXES, INDEXES_2, UNDO, TEMP, SYSTEM, USERS
--
-- Tablespace Distribution Across Disks (from ISTE-436-FINAL.pdf):
--   Disk2: DATA
--   Disk3: INDEXES, UNDO
--   Disk4: DATA_2, TEMP
--   Disk5: USERS, INDEXES_2, SYSTEM
--
-- Notes:
-- - Target platform: Linux ("linux4"). Use forward slashes in file paths.
-- - In most student environments, SYSTEM/SYSAUX/TEMP/UNDO are created by DBCA and you are not allowed to create/move them.
-- - This file is therefore *physical design documentation* unless you have DBA privileges.
-- - You requested non-OMF examples, so the examples below use explicit file paths.
--
-- Path convention for this project (placeholder only):
--   Everything will be on ONE disk in your environment.
--   Use the literal word "path" as the base directory and fix it later.
--
--   Examples:
--     'path/fd_data01.dbf'
--     'path/fd_indexes01.dbf'

PROMPT NOTE: Requires DBA privileges and a valid Linux directory. DATAFILE paths currently use the placeholder word 'path'.

SET SERVEROUTPUT ON

PROMPT Attempting to create tablespaces (will continue on errors)...

PROMPT Creating tablespace DATA...
BEGIN
  EXECUTE IMMEDIATE q'[CREATE TABLESPACE data
    DATAFILE 'path/data01.dbf' SIZE 200M
    AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED]';
  DBMS_OUTPUT.PUT_LINE('Created tablespace DATA');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Skipping DATA: ' || SQLERRM);
END;
/

PROMPT Creating tablespace DATA_2...
BEGIN
  EXECUTE IMMEDIATE q'[CREATE TABLESPACE data_2
    DATAFILE 'path/data_201.dbf' SIZE 200M
    AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED]';
  DBMS_OUTPUT.PUT_LINE('Created tablespace DATA_2');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Skipping DATA_2: ' || SQLERRM);
END;
/

PROMPT Creating tablespace INDEXES...
BEGIN
  EXECUTE IMMEDIATE q'[CREATE TABLESPACE indexes
    DATAFILE 'path/indexes01.dbf' SIZE 200M
    AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED]';
  DBMS_OUTPUT.PUT_LINE('Created tablespace INDEXES');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Skipping INDEXES: ' || SQLERRM);
END;
/

PROMPT Creating tablespace INDEXES_2...
BEGIN
  EXECUTE IMMEDIATE q'[CREATE TABLESPACE indexes_2
    DATAFILE 'path/indexes_201.dbf' SIZE 200M
    AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED]';
  DBMS_OUTPUT.PUT_LINE('Created tablespace INDEXES_2');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Skipping INDEXES_2: ' || SQLERRM);
END;
/

PROMPT Creating tablespace USERS...
BEGIN
  EXECUTE IMMEDIATE q'[CREATE TABLESPACE users
    DATAFILE 'path/users01.dbf' SIZE 200M
    AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED]';
  DBMS_OUTPUT.PUT_LINE('Created tablespace USERS');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Skipping USERS: ' || SQLERRM);
END;
/

PROMPT Done (tablespace creates were attempted).
