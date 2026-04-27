-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 04_business_logic
-- Run as: dev_1 (schema owner)
-- Run: @scripts/04_business_logic/delivery_pkg.sql
-- =====================================================================

-- Context:
-- Smart Food Delivery Management System (ISTE-436)
-- Transaction procedure(s) for assigning drivers and completing deliveries.
--
-- Concurrency control used:
-- - Row-level locking on DRIVER via SELECT ... FOR UPDATE to serialize assignment.

CREATE OR REPLACE PACKAGE fd_delivery_pkg AUTHID CURRENT_USER AS
  PROCEDURE assign_driver(
    p_order_id    IN  NUMBER,
    p_driver_id   IN  NUMBER,
    o_delivery_id OUT NUMBER
  );

  PROCEDURE complete_delivery(
    p_delivery_id IN NUMBER
  );
END fd_delivery_pkg;
/

CREATE OR REPLACE PACKAGE BODY fd_delivery_pkg AS
  PROCEDURE assign_driver(
    p_order_id    IN  NUMBER,
    p_driver_id   IN  NUMBER,
    o_delivery_id OUT NUMBER
  ) AS
    v_driver_status driver.status%TYPE;
    v_old_order_status orders.status%TYPE;
  BEGIN
    -- Authorization: only admin users should assign drivers.
    IF NOT DBMS_SESSION.IS_ROLE_ENABLED('ADMIN_ROLE') THEN
      RAISE_APPLICATION_ERROR(-20025, 'Not authorized to assign drivers');
    END IF;

    -- Lock driver row to serialize concurrent assignments.
    SELECT status
      INTO v_driver_status
      FROM driver
     WHERE driver_id = p_driver_id
     FOR UPDATE;

    -- A=Available, B=Busy
    IF v_driver_status <> 'A' THEN
      RAISE_APPLICATION_ERROR(-20020, 'Driver is not available');
    END IF;

    -- Lock order row to prevent conflicting status transitions.
    SELECT status
      INTO v_old_order_status
      FROM orders
     WHERE order_id = p_order_id
     FOR UPDATE;

    IF v_old_order_status <> 'Pending' THEN
      RAISE_APPLICATION_ERROR(-20021, 'Order is not in Pending status');
    END IF;

    INSERT INTO delivery(order_id, driver_id, pickup_time, delivery_status)
    VALUES (p_order_id, p_driver_id, SYSDATE, 'Assigned')
    RETURNING delivery_id INTO o_delivery_id;

    UPDATE driver
       SET status = 'B'
     WHERE driver_id = p_driver_id;

    UPDATE orders
       SET status = 'Preparing'
     WHERE order_id = p_order_id;

    COMMIT;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20022, 'Order or driver not found');
    WHEN DUP_VAL_ON_INDEX THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20023, 'Delivery already exists for this order');
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END assign_driver;

  PROCEDURE complete_delivery(
    p_delivery_id IN NUMBER
  ) AS
    v_driver_id delivery.driver_id%TYPE;
    v_order_id  delivery.order_id%TYPE;
    v_old_order_status orders.status%TYPE;
    v_driver_status driver.status%TYPE;
  BEGIN
    -- Authorization: drivers (or admins) can complete deliveries.
    IF NOT (DBMS_SESSION.IS_ROLE_ENABLED('DRIVER_ROLE') OR DBMS_SESSION.IS_ROLE_ENABLED('ADMIN_ROLE')) THEN
      RAISE_APPLICATION_ERROR(-20026, 'Not authorized to complete deliveries');
    END IF;

    -- Lock delivery row to prevent double completion.
    SELECT driver_id, order_id
      INTO v_driver_id, v_order_id
      FROM delivery
     WHERE delivery_id = p_delivery_id
     FOR UPDATE;

    -- Lock driver first (consistent lock ordering with assign_driver).
    SELECT status
      INTO v_driver_status
      FROM driver
     WHERE driver_id = v_driver_id
     FOR UPDATE;

    UPDATE delivery
       SET delivery_status = 'Delivered',
           delivery_time = SYSDATE
     WHERE delivery_id = p_delivery_id;

    -- Lock order to enforce consistent status transition.
    SELECT status
      INTO v_old_order_status
      FROM orders
     WHERE order_id = v_order_id
     FOR UPDATE;

    UPDATE orders
       SET status = 'Delivered'
     WHERE order_id = v_order_id;

    -- Driver stats are updated by trigger trg_orders_delivered_driver_stats.

    COMMIT;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20024, 'Delivery not found');
    WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
  END complete_delivery;
END fd_delivery_pkg;
/
