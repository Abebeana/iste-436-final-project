OPTIONS (SKIP=1)
LOAD DATA
INFILE 'customer.csv'
APPEND
INTO TABLE customer
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  customer_id     INTEGER EXTERNAL,
  name            CHAR,
  phone           CHAR,
  address         CHAR,
  status          CHAR "SUBSTR(REPLACE(REPLACE(:status, CHR(13), ''), CHR(10), ''), 1, 1)"
)
