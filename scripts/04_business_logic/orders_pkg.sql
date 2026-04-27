-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 04_business_logic
-- Run as: dev_1 (schema owner)
-- Run: @scripts/04_business_logic/orders_pkg.sql
-- =====================================================================

-- ============================================================
-- Smart Food Delivery Management System (ISTE-436)
-- Package: fd_orders_pkg
-- Purpose:
--   Handles placing a single-item order with safe concurrency.
--
-- Key Concept:
--   Uses an ATOMIC UPDATE to prevent race conditions and
--   overselling (lost update problem).
-- ============================================================

-- =========================
-- PACKAGE SPECIFICATION
-- =========================
CREATE OR REPLACE PACKAGE fd_orders_pkg AUTHID CURRENT_USER AS
  -- Procedure to place an order for ONE menu item
  PROCEDURE place_single_item_order(
    p_customer_id   IN  NUMBER,  -- ID of the customer placing the order
    p_restaurant_id IN  NUMBER,  -- ID of the restaurant
    p_item_id       IN  NUMBER,  -- ID of the menu item being ordered
    p_quantity      IN  NUMBER,  -- Quantity requested
    o_order_id      OUT NUMBER   -- Output: generated order ID
  );
END fd_orders_pkg;
/
-- "/" executes the package specification


-- =========================
-- PACKAGE BODY (IMPLEMENTATION)
-- =========================
CREATE OR REPLACE PACKAGE BODY fd_orders_pkg AS

  PROCEDURE place_single_item_order(
    p_customer_id   IN  NUMBER,
    p_restaurant_id IN  NUMBER,
    p_item_id       IN  NUMBER,
    p_quantity      IN  NUMBER,
    o_order_id      OUT NUMBER
  ) AS
    -- Local variable to store item price
    -- Uses %TYPE to stay consistent with table definition
    v_unit_price   menu_item.price%TYPE;

    -- Local variable to store subtotal (price × quantity)
    v_subtotal     NUMBER(10,2);

  BEGIN
    -- ==========================================
    -- INPUT VALIDATION
    -- ==========================================
    -- Ensure quantity is not NULL and greater than zero
    IF p_quantity IS NULL OR p_quantity <= 0 THEN
      RAISE_APPLICATION_ERROR(-20010, 'Quantity must be > 0');
    END IF;


    -- ==========================================
    -- CONCURRENCY-SAFE STOCK UPDATE (CRITICAL)
    -- ==========================================
    -- This single UPDATE statement:
    -- 1. Checks availability
    -- 2. Ensures enough stock exists
    -- 3. Deducts stock atomically
    --
    -- WHY THIS MATTERS:
    -- Prevents multiple users from overselling the same item
    -- (no SELECT-then-UPDATE race condition)
    UPDATE menu_item
       SET stock_qty = stock_qty - p_quantity   -- reduce stock
     WHERE item_id = p_item_id                  -- match item
       AND restaurant_id = p_restaurant_id      -- match restaurant
       AND is_available = 'Y'                   -- item must be available
       AND stock_qty >= p_quantity              -- ensure sufficient stock

     -- RETURNING clause fetches the price in the same atomic operation
     RETURNING price INTO v_unit_price;


    -- ==========================================
    -- CHECK IF UPDATE SUCCEEDED
    -- ==========================================
    -- If no row was updated, one of the conditions failed:
    -- - Not enough stock
    -- - Item not available
    -- - Invalid item/restaurant
    IF SQL%ROWCOUNT = 0 THEN
      RAISE_APPLICATION_ERROR(-20011, 'Insufficient stock or item not available');
    END IF;


    -- ==========================================
    -- CALCULATE ORDER SUBTOTAL
    -- ==========================================
    -- Multiply unit price by quantity
    -- ROUND ensures currency precision (2 decimal places)
    v_subtotal := ROUND(v_unit_price * p_quantity, 2);


    -- ==========================================
    -- INSERT INTO ORDERS TABLE
    -- ==========================================
    -- Create a new order record
    INSERT INTO orders(customer_id, restaurant_id, status, total_amount)
    VALUES (p_customer_id, p_restaurant_id, 'Pending', v_subtotal)

    -- Capture generated order_id (primary key)
    RETURNING order_id INTO o_order_id;


    -- ==========================================
    -- INSERT INTO ORDER_ITEM TABLE
    -- ==========================================
    -- Store details of the item inside the order
    INSERT INTO order_item(order_id, item_id, quantity, unit_price, subtotal)
    VALUES (o_order_id, p_item_id, p_quantity, v_unit_price, v_subtotal);


    -- ==========================================
    -- COMMIT TRANSACTION
    -- ==========================================
    -- Save all changes permanently:
    -- - Stock deduction
    -- - Order creation
    -- - Order item creation
    COMMIT;


  -- ==========================================
  -- EXCEPTION HANDLING
  -- ==========================================
  EXCEPTION
    WHEN OTHERS THEN
      -- If ANY error occurs:
      -- Undo all changes to maintain consistency
      ROLLBACK;

      -- Re-raise the error to the caller (important for debugging)
      RAISE;

  END place_single_item_order;

END fd_orders_pkg;
/
-- "/" executes the package body