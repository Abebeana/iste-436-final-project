-- Context:
-- Minimal seed data for running procedures and concurrency demos.

PROMPT Seeding data...

INSERT INTO customer(customer_id, name, phone, address, status)
VALUES (1, 'Alice', '555-0001', '10 Oak St', 'A');

INSERT INTO customer(customer_id, name, phone, address, status)
VALUES (2, 'Bob', '555-0002', '20 Pine St', 'A');

INSERT INTO restaurant(restaurant_id, name, cuisine_type, opening_time, closing_time, status)
VALUES (
  1,
  'QuickBites',
  'FastFood',
  TRUNC(SYSDATE),
  TRUNC(SYSDATE) + ((23*60+59) / (24*60)),
  'A'
);

-- Item 1 stock_qty=1 for deterministic inventory concurrency demo
INSERT INTO menu_item(item_id, restaurant_id, name, price, category, is_available, stock_qty)
VALUES (1, 1, 'ChickenBowl', 12.50, 'Meal', 'Y', 1);

INSERT INTO menu_item(item_id, restaurant_id, name, price, category, is_available, stock_qty)
VALUES (2, 1, 'VeggieBowl', 10.00, 'Meal', 'Y', 10);

INSERT INTO driver(driver_id, name, status, total_deliveries, avg_rating)
VALUES (1, 'Dana', 'A', 0, 4.70);

INSERT INTO driver(driver_id, name, status, total_deliveries, avg_rating)
VALUES (2, 'Evan', 'A', 0, 4.50);

COMMIT;
