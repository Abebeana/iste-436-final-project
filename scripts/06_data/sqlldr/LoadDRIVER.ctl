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
  avg_rating       DECIMAL EXTERNAL NULLIF avg_rating=BLANKS
)
