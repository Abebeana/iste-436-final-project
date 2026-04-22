-- Context:
-- Smart Food Delivery Management System (ISTE-436)
-- Triggers

PROMPT Creating triggers...

-- Trigger 1: When order status changes -> insert into Order_Status_Log
CREATE OR REPLACE TRIGGER trg_orders_status_log
AFTER UPDATE OF status ON orders
FOR EACH ROW
WHEN (NVL(:OLD.status, ' ') <> NVL(:NEW.status, ' '))
BEGIN
  INSERT INTO order_status_log(order_id, old_status, new_status, change_time)
  VALUES (:NEW.order_id, :OLD.status, :NEW.status, SYSDATE);
END;
/

-- Trigger 2: When order becomes Delivered -> update driver stats
CREATE OR REPLACE TRIGGER trg_orders_delivered_driver_stats
AFTER UPDATE OF status ON orders
FOR EACH ROW
WHEN (NVL(:OLD.status, ' ') <> NVL(:NEW.status, ' ') AND :NEW.status = 'Delivered')
DECLARE
  v_driver_id delivery.driver_id%TYPE;
BEGIN
  BEGIN
    SELECT d.driver_id
      INTO v_driver_id
      FROM delivery d
     WHERE d.order_id = :NEW.order_id;

    UPDATE driver
       SET status = 'A',
           total_deliveries = total_deliveries + 1
     WHERE driver_id = v_driver_id;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      NULL; -- Order has no delivery record.
  END;
END;
/

-- Trigger 3: Before inserting Order_Item -> check item availability and item belongs to the order's restaurant
CREATE OR REPLACE TRIGGER trg_order_item_validate
BEFORE INSERT ON order_item
FOR EACH ROW
DECLARE
  v_dummy NUMBER;
BEGIN
  SELECT 1
    INTO v_dummy
    FROM orders o
    JOIN menu_item mi
      ON mi.item_id = :NEW.item_id
     AND mi.restaurant_id = o.restaurant_id
   WHERE o.order_id = :NEW.order_id
     AND mi.is_available = 'Y';
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20040, 'Item not available or does not belong to the order''s restaurant');
END;
/

-- Trigger 4: Before placing order -> check restaurant is OPEN (and customer is active)
CREATE OR REPLACE TRIGGER trg_orders_validate_before_insert
BEFORE INSERT ON orders
FOR EACH ROW
DECLARE
  v_rest_status restaurant.status%TYPE;
  v_open_time   restaurant.opening_time%TYPE;
  v_close_time  restaurant.closing_time%TYPE;

  v_cust_status customer.status%TYPE;

  v_now   NUMBER;
  v_open  NUMBER;
  v_close NUMBER;
BEGIN
  SELECT status, opening_time, closing_time
    INTO v_rest_status, v_open_time, v_close_time
    FROM restaurant
   WHERE restaurant_id = :NEW.restaurant_id;

  IF v_rest_status <> 'A' THEN
    RAISE_APPLICATION_ERROR(-20041, 'Restaurant is not active');
  END IF;

  SELECT status
    INTO v_cust_status
    FROM customer
   WHERE customer_id = :NEW.customer_id;

  IF v_cust_status <> 'A' THEN
    RAISE_APPLICATION_ERROR(-20044, 'Customer is not active');
  END IF;

  IF v_open_time IS NOT NULL AND v_close_time IS NOT NULL THEN
    v_now := TO_NUMBER(TO_CHAR(SYSDATE, 'HH24MI'));
    v_open := TO_NUMBER(TO_CHAR(v_open_time, 'HH24MI'));
    v_close := TO_NUMBER(TO_CHAR(v_close_time, 'HH24MI'));

    IF v_open <= v_close THEN
      IF NOT (v_now BETWEEN v_open AND v_close) THEN
        RAISE_APPLICATION_ERROR(-20042, 'Restaurant is closed');
      END IF;
    ELSE
      -- Overnight window (e.g., 22:00 - 02:00)
      IF NOT (v_now >= v_open OR v_now <= v_close) THEN
        RAISE_APPLICATION_ERROR(-20042, 'Restaurant is closed');
      END IF;
    END IF;
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20043, 'Customer or restaurant not found');
END;
/
