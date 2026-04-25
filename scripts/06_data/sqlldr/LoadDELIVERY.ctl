OPTIONS (SKIP=1)
LOAD DATA
INFILE 'delivery.csv'
APPEND
INTO TABLE delivery
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  delivery_id      INTEGER EXTERNAL,
  order_id         INTEGER EXTERNAL,
  driver_id        INTEGER EXTERNAL,
  pickup_time      DATE "YYYY-MM-DD HH24:MI" NULLIF pickup_time=BLANKS,
  delivery_time    DATE "YYYY-MM-DD HH24:MI" NULLIF delivery_time=BLANKS,
  delivery_status  CHAR
)
