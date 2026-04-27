-- Reset Smart Food Delivery objects (DESTRUCTIVE)
-- Run as: SYS (or SYSDBA)
-- Purpose: Drop project users, roles, and tablespaces so you can rebuild cleanly.

SET SERVEROUTPUT ON

SET DEFINE ON
ACCEPT confirm CHAR PROMPT 'Type DROP to reset this project: '
SET DEFINE OFF

BEGIN
  IF UPPER('&&confirm') <> 'DROP' THEN
    RAISE_APPLICATION_ERROR(-20000, 'Aborted');
  END IF;
END;
/

DECLARE
  PROCEDURE drop_user_if_exists(p_username IN VARCHAR2) IS
    v_cnt NUMBER;
    v_user VARCHAR2(128) := UPPER(p_username);
  BEGIN
    SELECT COUNT(*)
      INTO v_cnt
      FROM dba_users
     WHERE username = v_user;

    IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP USER ' || DBMS_ASSERT.SIMPLE_SQL_NAME(v_user) || ' CASCADE';
      DBMS_OUTPUT.PUT_LINE('Dropped user ' || v_user);
    ELSE
      DBMS_OUTPUT.PUT_LINE('User not found: ' || v_user);
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Could not drop user ' || v_user || ' -> ' || SQLERRM);
  END;

  PROCEDURE drop_role_if_exists(p_role IN VARCHAR2) IS
    v_cnt NUMBER;
    v_role VARCHAR2(128) := UPPER(p_role);
  BEGIN
    SELECT COUNT(*)
      INTO v_cnt
      FROM dba_roles
     WHERE role = v_role;

    IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP ROLE ' || DBMS_ASSERT.SIMPLE_SQL_NAME(v_role);
      DBMS_OUTPUT.PUT_LINE('Dropped role ' || v_role);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Role not found: ' || v_role);
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Could not drop role ' || v_role || ' -> ' || SQLERRM);
  END;

  PROCEDURE drop_tablespace_if_exists(p_ts IN VARCHAR2) IS
    v_cnt NUMBER;
    v_ts VARCHAR2(128) := UPPER(p_ts);
  BEGIN
    SELECT COUNT(*)
      INTO v_cnt
      FROM dba_tablespaces
     WHERE tablespace_name = v_ts;

    IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP TABLESPACE ' || DBMS_ASSERT.SIMPLE_SQL_NAME(v_ts) || ' INCLUDING CONTENTS AND DATAFILES';
      DBMS_OUTPUT.PUT_LINE('Dropped tablespace ' || v_ts);
    ELSE
      DBMS_OUTPUT.PUT_LINE('Tablespace not found: ' || v_ts);
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Could not drop tablespace ' || v_ts || ' -> ' || SQLERRM);
  END;

BEGIN
  -- Drop users (schema owner first, then all demo accounts)
  drop_user_if_exists('dev_1');
  drop_user_if_exists('cust_1');
  drop_user_if_exists('cust_2');
  drop_user_if_exists('driver_1');
  drop_user_if_exists('rest_1');
  drop_user_if_exists('admin_1');

  -- Drop roles
  drop_role_if_exists('place_order_role');
  drop_role_if_exists('manage_order_items_role');
  drop_role_if_exists('process_payment_role');
  drop_role_if_exists('deliver_order_role');
  drop_role_if_exists('update_customer_role');
  drop_role_if_exists('review_order_role');
  drop_role_if_exists('view_menu_role');

  drop_role_if_exists('customer_role');
  drop_role_if_exists('driver_role');
  drop_role_if_exists('restaurant_role');
  drop_role_if_exists('admin_role');
  drop_role_if_exists('developer_role');

  -- Drop project tablespaces (if you want a truly clean rebuild)
  drop_tablespace_if_exists('DATA');
  drop_tablespace_if_exists('DATA_2');
  drop_tablespace_if_exists('INDEXES');
  drop_tablespace_if_exists('INDEXES_2');
END;
/

PROMPT Reset attempt complete.
