-- Context:
-- ISTE-436 Security Design
-- Create sample accounts and assign job roles.
--
-- NOTE: This script requires CREATE USER privilege.
-- Run as an administrative account (e.g., SYS/DBA or provided admin).

PROMPT Creating users...

-- Customers
CREATE USER cust_1 IDENTIFIED BY "C0urseDemo#Cust1";
CREATE USER cust_2 IDENTIFIED BY "C0urseDemo#Cust2";

-- Driver
CREATE USER driver_1 IDENTIFIED BY "C0urseDemo#Driver1";

-- Restaurant
CREATE USER rest_1 IDENTIFIED BY "C0urseDemo#Rest1";

-- Admin + Developer
CREATE USER admin_1 IDENTIFIED BY "C0urseDemo#Admin1";
CREATE USER dev_1 IDENTIFIED BY "C0urseDemo#Dev1";

PROMPT Granting CREATE SESSION...
GRANT CREATE SESSION TO cust_1;
GRANT CREATE SESSION TO cust_2;
GRANT CREATE SESSION TO driver_1;
GRANT CREATE SESSION TO rest_1;
GRANT CREATE SESSION TO admin_1;
GRANT CREATE SESSION TO dev_1;

PROMPT Assigning job roles...
GRANT customer_role TO cust_1;
GRANT customer_role TO cust_2;
GRANT driver_role TO driver_1;
GRANT restaurant_role TO rest_1;
GRANT admin_role TO admin_1;
GRANT developer_role TO dev_1;

ALTER USER cust_1 DEFAULT ROLE customer_role;
ALTER USER cust_2 DEFAULT ROLE customer_role;
ALTER USER driver_1 DEFAULT ROLE driver_role;
ALTER USER rest_1 DEFAULT ROLE restaurant_role;
ALTER USER admin_1 DEFAULT ROLE admin_role;
ALTER USER dev_1 DEFAULT ROLE developer_role;

PROMPT Configuring developer tablespace/quota (DBA-only; continues on error)...
WHENEVER SQLERROR CONTINUE
ALTER USER dev_1 DEFAULT TABLESPACE USERS;
ALTER USER dev_1 TEMPORARY TABLESPACE TEMP;
ALTER USER dev_1 QUOTA UNLIMITED ON USERS;
WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT Users created.
