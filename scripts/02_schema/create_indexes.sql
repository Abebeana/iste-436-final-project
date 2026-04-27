-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 02_schema (step 3/3)
-- Run as: dev_1 (schema owner)
-- Purpose: Create indexes (uses INDEXES / INDEXES_2 tablespaces if present).
-- Run: @scripts/02_schema/create_indexes.sql
-- =====================================================================

PROMPT Creating indexes...

CREATE INDEX ix_menu_item_restaurant_id ON menu_item(restaurant_id)
	TABLESPACE INDEXES_2;

CREATE INDEX ix_orders_customer_id ON orders(customer_id)
	TABLESPACE INDEXES;
CREATE INDEX ix_orders_restaurant_id ON orders(restaurant_id)
	TABLESPACE INDEXES;

CREATE INDEX ix_order_item_order_id ON order_item(order_id)
	TABLESPACE INDEXES;
CREATE INDEX ix_order_item_item_id ON order_item(item_id)
	TABLESPACE INDEXES_2;
CREATE INDEX ix_delivery_driver_id ON delivery(driver_id)
	TABLESPACE INDEXES;

CREATE INDEX ix_order_status_log_order_id ON order_status_log(order_id)
	TABLESPACE INDEXES_2;
CREATE INDEX ix_order_status_log_change_time ON order_status_log(change_time)
	TABLESPACE INDEXES_2;
