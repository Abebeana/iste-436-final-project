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
  payment_time   DATE "YYYY-MM-DD HH24:MI" NULLIF payment_time=BLANKS
)
