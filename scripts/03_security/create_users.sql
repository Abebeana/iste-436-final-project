-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 03_security (step 4/5)
-- Run as: admin_1 (DBA)
-- Purpose: Create demo users and grant initial roles + quotas (prevents ORA-01950).
-- Run: @scripts/03_security/create_users.sql
-- =====================================================================

PROMPT Creating users...

-- Ensure admin can pass application role checks
GRANT admin_role TO admin_1;
ALTER USER admin_1 DEFAULT ROLE ALL;

-- Customers
CREATE USER cust_1 IDENTIFIED BY "Food123";
CREATE USER cust_2 IDENTIFIED BY "Food123";

-- Driver
CREATE USER driver_1 IDENTIFIED BY "Food123";

-- Restaurant
CREATE USER rest_1 IDENTIFIED BY "Food123";

-- Developer
CREATE USER dev_1 IDENTIFIED BY "Food123";

PROMPT Granting CREATE SESSION...
GRANT CREATE SESSION TO cust_1;
GRANT CREATE SESSION TO cust_2;
GRANT CREATE SESSION TO driver_1;
GRANT CREATE SESSION TO rest_1;
GRANT CREATE SESSION TO dev_1;

PROMPT Configuring default tablespaces (all users)...
-- although not strictly required for this project, we will assign a default table space for clarity and to prevent ORA-01950 
-- insufficient privileges errors if quotas are not set(for developers).
ALTER USER cust_1 DEFAULT TABLESPACE USERS;
ALTER USER cust_1 TEMPORARY TABLESPACE TEMP;

ALTER USER cust_2 DEFAULT TABLESPACE USERS;
ALTER USER cust_2 TEMPORARY TABLESPACE TEMP;

ALTER USER driver_1 DEFAULT TABLESPACE USERS;
ALTER USER driver_1 TEMPORARY TABLESPACE TEMP;

ALTER USER rest_1 DEFAULT TABLESPACE USERS;
ALTER USER rest_1 TEMPORARY TABLESPACE TEMP;

PROMPT Granting developer/admin options...
GRANT developer_role TO dev_1;
GRANT customer_role TO dev_1 WITH ADMIN OPTION;
GRANT driver_role TO dev_1 WITH ADMIN OPTION;
GRANT restaurant_role TO dev_1 WITH ADMIN OPTION;

-- Ensure developer_role privileges (e.g., CREATE TABLESPACE) are enabled at login.
ALTER USER dev_1 DEFAULT ROLE ALL;

PROMPT Configuring developer default tablespaces...
ALTER USER dev_1 DEFAULT TABLESPACE USERS;
ALTER USER dev_1 TEMPORARY TABLESPACE TEMP;

PROMPT Users created.
