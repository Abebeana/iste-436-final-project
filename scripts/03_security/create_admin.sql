-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 03_security (step 1/5)
-- Run as: SYS (or another DBA account that can create users)
-- Purpose: Create the admin account (admin_1) and grant DBA.
-- Run: @scripts/03_security/create_admin.sql
-- =====================================================================
PROMPT Creating admin user...

-- Demo password used across all sample accounts:
--   Food123
CREATE USER admin_1 IDENTIFIED BY "Food123";
GRANT CREATE SESSION TO admin_1;
GRANT DBA TO admin_1;
-- makes sure admin_1 has all roles enabled at login (no manual role enabling required)
ALTER USER admin_1 DEFAULT ROLE ALL;

PROMPT Admin created.
