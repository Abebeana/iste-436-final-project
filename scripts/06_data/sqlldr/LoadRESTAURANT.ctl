OPTIONS (SKIP=1)
LOAD DATA
INFILE 'restaurant.csv'
APPEND
INTO TABLE restaurant
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  restaurant_id   INTEGER EXTERNAL,
  name            CHAR,
  cuisine_type    CHAR,
  opening_time    DATE "YYYY-MM-DD HH24:MI" NULLIF opening_time=BLANKS,
  closing_time    DATE "YYYY-MM-DD HH24:MI" NULLIF closing_time=BLANKS,
  status          CHAR "SUBSTR(REPLACE(REPLACE(:status, CHR(13), ''), CHR(10), ''), 1, 1)"
)
