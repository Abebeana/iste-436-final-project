
-- AWS VM (smartfood) layout:
--   ORACLE_BASE=/u01/app/oracle
--   ORACLE_HOME=/u01/app/oracle/product/12.2.0/db_1
--   ORACLE_SID=SFDB
--
-- Project datafile locations:
--   Base folders:
--     /u07/app/oracle/oradata/smartfood
--     /u08/app/oracle/oradata/smartfood
--   We keep app tablespaces separate from DBCA-managed SYSTEM/SYSAUX/UNDO/TEMP/USERS.

PROMPT NOTE: Requires DBA privileges. Datafiles will be created under /u07 and /u08 (smartfood).

SET SERVEROUTPUT ON

PROMPT Attempting to create tablespaces (continues on errors)...
PROMPT If you do not have CREATE TABLESPACE privilege, these will be skipped.

WHENEVER SQLERROR CONTINUE

PROMPT Creating tablespace DATA...
CREATE TABLESPACE DATA
  DATAFILE '/u07/app/oracle/oradata/smartfood/data01.dbf' SIZE 200M
  AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED;

PROMPT Creating tablespace DATA_2...
CREATE TABLESPACE DATA_2
  DATAFILE '/u07/app/oracle/oradata/smartfood/data_201.dbf' SIZE 200M
  AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED;

PROMPT Creating tablespace INDEXES...
CREATE TABLESPACE INDEXES
  DATAFILE '/u08/app/oracle/oradata/smartfood/indexes01.dbf' SIZE 200M
  AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED;

PROMPT Creating tablespace INDEXES_2...
CREATE TABLESPACE INDEXES_2
  DATAFILE '/u08/app/oracle/oradata/smartfood/indexes_201.dbf' SIZE 200M
  AUTOEXTEND ON NEXT 50M MAXSIZE UNLIMITED;

PROMPT NOTE: USERS tablespace is typically created by DBCA; not creating it here.

WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT Done (tablespace creates were attempted).
