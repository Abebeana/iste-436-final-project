OPTIONS (SKIP=1)
LOAD DATA
INFILE 'payment.csv'
APPEND
INTO TABLE payment
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  payment_id     INTEGER EXTERNAL,
  order_id       INTEGER EXTERNAL,
  amount         DECIMAL EXTERNAL,
  method         CHAR,
  status         CHAR,
  payment_time   "CASE WHEN TRIM(REPLACE(REPLACE(:payment_time, CHR(13), ''), CHR(10), '')) IS NULL THEN NULL ELSE TO_DATE(REPLACE(REPLACE(:payment_time, CHR(13), ''), CHR(10), ''), 'YYYY-MM-DD HH24:MI') END"
)
