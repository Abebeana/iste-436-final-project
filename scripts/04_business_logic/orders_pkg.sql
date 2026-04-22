-- Context:
-- Smart Food Delivery Management System (ISTE-436)
-- Transaction procedure(s) for placing orders with concurrency-safe stock updates.
--
-- Concurrency control used:
-- - Atomic conditional UPDATE on MENU_ITEM.stock_qty to prevent lost updates.

CREATE OR REPLACE PACKAGE fd_orders_pkg AUTHID CURRENT_USER AS
  PROCEDURE place_single_item_order(
    p_customer_id   IN  NUMBER,
    p_restaurant_id IN  NUMBER,
    p_item_id       IN  NUMBER,
    p_quantity      IN  NUMBER,
    o_order_id      OUT NUMBER
  );
END fd_orders_pkg;
/

CREATE OR REPLACE PACKAGE BODY fd_orders_pkg AS
  PROCEDURE place_single_item_order(
    p_customer_id   IN  NUMBER,
    p_restaurant_id IN  NUMBER,
    p_item_id       IN  NUMBER,
    p_quantity      IN  NUMBER,
    o_order_id      OUT NUMBER
  ) AS
    v_unit_price   menu_item.price%TYPE;
    v_subtotal     NUMBER(10,2);
  BEGIN
    IF p_quantity IS NULL OR p_quantity <= 0 THEN
      RAISE_APPLICATION_ERROR(-20010, 'Quantity must be > 0');
    END IF;

    -- Prevent lost updates: decrement stock in a single atomic statement.
    UPDATE menu_item
       SET stock_qty = stock_qty - p_quantity
     WHERE item_id = p_item_id
       AND restaurant_id = p_restaurant_id
       AND is_available = 'Y'
       AND stock_qty >= p_quantity
     RETURNING price INTO v_unit_price;

    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20011, 'Insufficient stock or item not available');
    END IF;

    v_subtotal := ROUND(v_unit_price * p_quantity, 2);

    INSERT INTO orders(customer_id, restaurant_id, status, total_amount)
    VALUES (p_customer_id, p_restaurant_id, 'Pending', v_subtotal)
    RETURNING order_id INTO o_order_id;

    INSERT INTO order_item(order_id, item_id, quantity, unit_price, subtotal)
    VALUES (o_order_id, p_item_id, p_quantity, v_unit_price, v_subtotal);

    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END place_single_item_order;
END fd_orders_pkg;
/
