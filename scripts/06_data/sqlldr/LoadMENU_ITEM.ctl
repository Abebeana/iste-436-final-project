OPTIONS (SKIP=1)
LOAD DATA
INFILE 'menu_item.csv'
APPEND
INTO TABLE menu_item
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  item_id         INTEGER EXTERNAL,
  restaurant_id   INTEGER EXTERNAL,
  name            CHAR,
  price           DECIMAL EXTERNAL,
  category        CHAR,
  is_available    CHAR,
  stock_qty       "TO_NUMBER(REPLACE(REPLACE(:stock_qty, CHR(13), ''), CHR(10), ''))"
)
