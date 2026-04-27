-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 02_schema (step 2/3)
-- Run as: dev_1 (schema owner)
-- Purpose: Add PK/FK/UK/CHECK constraints.
-- Run: @scripts/02_schema/add_constraints.sql
-- =====================================================================

PROMPT Adding constraints...

-- Customer
ALTER TABLE customer
  ADD CONSTRAINT uq_customer_phone UNIQUE (phone);

ALTER TABLE customer
  ADD CONSTRAINT ck_customer_status CHECK (status IN ('A','I'));

-- Restaurant
ALTER TABLE restaurant
  ADD CONSTRAINT uq_restaurant_name UNIQUE (name);

ALTER TABLE restaurant
  ADD CONSTRAINT ck_restaurant_cuisine
  CHECK (cuisine_type IN ('Italian','Asian','FastFood'));

ALTER TABLE restaurant
  ADD CONSTRAINT ck_restaurant_status CHECK (status IN ('A','I'));

-- Menu item
ALTER TABLE menu_item
  ADD CONSTRAINT fk_menu_item_restaurant
  FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id);

ALTER TABLE menu_item
  ADD CONSTRAINT ck_menu_item_price CHECK (price >= 0);

ALTER TABLE menu_item
  ADD CONSTRAINT ck_menu_item_category
  CHECK (category IN ('Meal','Drink','Dessert'));

ALTER TABLE menu_item
  ADD CONSTRAINT ck_menu_item_available CHECK (is_available IN ('Y','N'));

ALTER TABLE menu_item
  ADD CONSTRAINT ck_menu_item_stock CHECK (stock_qty >= 0);

-- Orders
ALTER TABLE orders
  ADD CONSTRAINT fk_orders_customer
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE orders
  ADD CONSTRAINT fk_orders_restaurant
  FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id);

ALTER TABLE orders
  ADD CONSTRAINT ck_orders_status
  CHECK (status IN ('Pending','Preparing','Delivered','Cancelled'));

ALTER TABLE orders
  ADD CONSTRAINT ck_orders_total CHECK (total_amount >= 0);

-- Order item (composite PK already defined in table)
ALTER TABLE order_item
  ADD CONSTRAINT fk_order_item_order
  FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE;

ALTER TABLE order_item
  ADD CONSTRAINT fk_order_item_menu_item
  FOREIGN KEY (item_id) REFERENCES menu_item(item_id);

ALTER TABLE order_item
  ADD CONSTRAINT ck_order_item_qty CHECK (quantity > 0);

ALTER TABLE order_item
  ADD CONSTRAINT ck_order_item_unit_price CHECK (unit_price >= 0);

ALTER TABLE order_item
  ADD CONSTRAINT ck_order_item_subtotal CHECK (subtotal >= 0);

-- Driver
ALTER TABLE driver
  ADD CONSTRAINT ck_driver_status CHECK (status IN ('A','B'));

ALTER TABLE driver
  ADD CONSTRAINT ck_driver_total_deliveries CHECK (total_deliveries >= 0);

ALTER TABLE driver
  ADD CONSTRAINT ck_driver_avg_rating CHECK (avg_rating IS NULL OR (avg_rating >= 0 AND avg_rating <= 5));

-- Delivery
ALTER TABLE delivery
  ADD CONSTRAINT fk_delivery_order
  FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE delivery
  ADD CONSTRAINT fk_delivery_driver
  FOREIGN KEY (driver_id) REFERENCES driver(driver_id);

ALTER TABLE delivery
  ADD CONSTRAINT uq_delivery_order UNIQUE (order_id);

ALTER TABLE delivery
  ADD CONSTRAINT ck_delivery_status
  CHECK (delivery_status IN ('Assigned','Delivered'));

-- Payment
ALTER TABLE payment
  ADD CONSTRAINT fk_payment_order
  FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE payment
  ADD CONSTRAINT uq_payment_order UNIQUE (order_id);

ALTER TABLE payment
  ADD CONSTRAINT ck_payment_method CHECK (method IN ('Card','Cash'));

ALTER TABLE payment
  ADD CONSTRAINT ck_payment_status CHECK (status IN ('Y','N'));

ALTER TABLE payment
  ADD CONSTRAINT ck_payment_amount CHECK (amount >= 0);

-- Review
ALTER TABLE review
  ADD CONSTRAINT fk_review_order
  FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE review
  ADD CONSTRAINT uq_review_order UNIQUE (order_id);

ALTER TABLE review
  ADD CONSTRAINT ck_review_rating CHECK (rating BETWEEN 1 AND 5);

-- Order status log
ALTER TABLE order_status_log
  ADD CONSTRAINT fk_order_status_log_order
  FOREIGN KEY (order_id) REFERENCES orders(order_id);
