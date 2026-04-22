-- Context:
-- Smart Food Delivery Management System (ISTE-436)
-- Indexes (especially on FK columns)

PROMPT Creating indexes...

CREATE INDEX ix_menu_item_restaurant_id ON menu_item(restaurant_id);

CREATE INDEX ix_orders_customer_id ON orders(customer_id);
CREATE INDEX ix_orders_restaurant_id ON orders(restaurant_id);

CREATE INDEX ix_order_item_order_id ON order_item(order_id);
CREATE INDEX ix_order_item_item_id ON order_item(item_id);

CREATE INDEX ix_delivery_order_id ON delivery(order_id);
CREATE INDEX ix_delivery_driver_id ON delivery(driver_id);

CREATE INDEX ix_payment_order_id ON payment(order_id);

CREATE INDEX ix_review_order_id ON review(order_id);

CREATE INDEX ix_order_status_log_order_id ON order_status_log(order_id);
CREATE INDEX ix_order_status_log_change_time ON order_status_log(change_time);
