OPTIONS (SKIP=1)
LOAD DATA
INFILE 'order_status_log.csv'
APPEND
INTO TABLE order_status_log
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  log_id       INTEGER EXTERNAL,
  order_id     INTEGER EXTERNAL,
  old_status   CHAR,
  new_status   CHAR,
  change_time  "CASE WHEN TRIM(REPLACE(REPLACE(:change_time, CHR(13), ''), CHR(10), '')) IS NULL THEN NULL ELSE TO_DATE(REPLACE(REPLACE(:change_time, CHR(13), ''), CHR(10), ''), 'YYYY-MM-DD HH24:MI') END"
)
