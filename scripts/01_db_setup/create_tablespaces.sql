-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 01_db_setup (optional/admin)
-- Run as: dev_1 with developer_role (CREATE TABLESPACE) OR a DBA user
-- Purpose: Create DATA/DATA_2 and INDEXES/INDEXES_2 tablespaces used by schema/index scripts.
-- Run: @scripts/01_db_setup/create_tablespaces.sql
-- NOTE: Datafiles are created under /u07 and /u08 on the DB server.
-- =====================================================================
PROMPT NOTE: Requires CREATE TABLESPACE privilege. Datafiles will be created under /u07 and /u08 (smartfood).

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

WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT Done (tablespace creates were attempted).
