OPTIONS (SKIP=1)
LOAD DATA
INFILE 'driver.csv'
APPEND
INTO TABLE driver
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  driver_id        INTEGER EXTERNAL,
  name             CHAR,
  status           CHAR,
  total_deliveries INTEGER EXTERNAL,
  avg_rating       "CASE WHEN TRIM(REPLACE(REPLACE(:avg_rating, CHR(13), ''), CHR(10), '')) IS NULL THEN NULL ELSE TO_NUMBER(REPLACE(REPLACE(:avg_rating, CHR(13), ''), CHR(10), '')) END"
)
