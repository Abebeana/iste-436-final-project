-- Context:
-- Bulk load demo using an external table (ORACLE_LOADER).
--
-- This avoids writing many INSERT statements for bulk data and uses a CSV file instead.
--
-- Prereqs (typically DBA/admin steps):
--   1) Create a DIRECTORY pointing to this folder on the DB server:
--        CREATE OR REPLACE DIRECTORY FD_DATA_DIR AS '<ABS_PATH_TO_repo\\scripts\\06_data>';
--   2) Grant the schema read on it:
--        GRANT READ ON DIRECTORY FD_DATA_DIR TO <YOUR_SCHEMA>;
--
-- Note:
-- - This script inserts explicit IDs (pk_id). Run on a fresh install or empty tables.
--
-- Then, connected as <YOUR_SCHEMA>, run:
--   @scripts/06_data/bulk_load_external_table.sql

SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT Creating external table over sample_data.csv...

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE ext_sample_data';
EXCEPTION
  WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE ext_sample_data (
  table_name VARCHAR2(30),
  pk_id      NUMBER,
  col1       VARCHAR2(200),
  col2       VARCHAR2(200),
  col3       VARCHAR2(200),
  col4       VARCHAR2(200),
  col5       VARCHAR2(200),
  col6       VARCHAR2(200)
)
ORGANIZATION EXTERNAL
(
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY FD_DATA_DIR
  ACCESS PARAMETERS
  (
    RECORDS DELIMITED BY NEWLINE
    SKIP 1
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    MISSING FIELD VALUES ARE NULL
    ( table_name, pk_id, col1, col2, col3, col4, col5, col6 )
  )
  LOCATION ('sample_data.csv')
)
REJECT LIMIT UNLIMITED;

PROMPT Loading CUSTOMER...
INSERT INTO customer (customer_id, name, phone, address, status)
SELECT pk_id,
       col1,
       col2,
       col3,
       col4
  FROM ext_sample_data
 WHERE table_name = 'customer';

PROMPT Loading RESTAURANT...
INSERT INTO restaurant (restaurant_id, name, cuisine_type, opening_time, closing_time, status)
SELECT pk_id,
       col1,
       col2,
       TO_DATE(NULLIF(col3, ''), 'YYYY-MM-DD HH24:MI'),
       TO_DATE(NULLIF(col4, ''), 'YYYY-MM-DD HH24:MI'),
       col6
  FROM ext_sample_data
 WHERE table_name = 'restaurant';

PROMPT Loading MENU_ITEM...
INSERT INTO menu_item (item_id, restaurant_id, name, price, category, is_available, stock_qty)
SELECT pk_id,
       TO_NUMBER(NULLIF(col1, '')),
       col2,
       TO_NUMBER(NULLIF(col3, '')),
       col4,
       col5,
       TO_NUMBER(NULLIF(col6, ''))
  FROM ext_sample_data
 WHERE table_name = 'menu_item';

PROMPT Loading DRIVER...
INSERT INTO driver (driver_id, name, status, total_deliveries, avg_rating)
SELECT pk_id,
       col1,
       col2,
       TO_NUMBER(NULLIF(col3, '')),
       TO_NUMBER(NULLIF(col4, ''))
  FROM ext_sample_data
 WHERE table_name = 'driver';

COMMIT;

PROMPT Dropping external table...
DROP TABLE ext_sample_data;

PROMPT Bulk load completed.
