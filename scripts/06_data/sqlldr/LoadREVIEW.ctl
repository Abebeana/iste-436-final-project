OPTIONS (SKIP=1)
LOAD DATA
INFILE 'review.csv'
APPEND
INTO TABLE review
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  review_id    INTEGER EXTERNAL,
  order_id     INTEGER EXTERNAL,
  rating       INTEGER EXTERNAL,
  review_comment      CHAR "TRIM(:review_comment)"
)
