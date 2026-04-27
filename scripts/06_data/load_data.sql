-- =====================================================================
-- Smart Food Delivery (ISTE-436)
-- Phase: 06_data (seed/demo)
-- Run as: dev_1 (schema owner)
-- Purpose: Clear and reload seed data using SQL*Loader control files.
-- Run: @scripts/06_data/load_data.sql
-- =====================================================================

-- NOTE:
-- Invalid records (data errors, wrong format, etc.) are written to the .bad file.
-- Discarded records (valid data that do not meet filtering conditions) are written to the .dsc file.

SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE
WHENEVER OSERROR EXIT 1

PROMPT Loading seed data via SQL*Loader...

PROMPT Clearing existing data 
BEGIN
	-- Children (order matters due to FKs)
	EXECUTE IMMEDIATE 'DELETE FROM order_status_log';
	EXECUTE IMMEDIATE 'DELETE FROM review';
	EXECUTE IMMEDIATE 'DELETE FROM payment';
	EXECUTE IMMEDIATE 'DELETE FROM delivery';
	EXECUTE IMMEDIATE 'DELETE FROM order_item';
	EXECUTE IMMEDIATE 'DELETE FROM orders';
	-- Parents
	EXECUTE IMMEDIATE 'DELETE FROM menu_item';
	EXECUTE IMMEDIATE 'DELETE FROM driver';
	EXECUTE IMMEDIATE 'DELETE FROM restaurant';
	EXECUTE IMMEDIATE 'DELETE FROM customer';
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
		-- If tables don't exist yet or privileges are missing, surface the error.
		RAISE;
END;
/

HOST sqlldr userid=dev_1/Food123 control=scripts/06_data/sqlldr/LoadCUSTOMER.ctl data=scripts/06_data/sqlldr/customer.csv log=scripts/06_data/LoadCUSTOMER.log bad=scripts/06_data/LoadCUSTOMER.bad discard=scripts/06_data/LoadCUSTOMER.dsc
HOST sqlldr userid=dev_1/Food123 control=scripts/06_data/sqlldr/LoadRESTAURANT.ctl data=scripts/06_data/sqlldr/restaurant.csv log=scripts/06_data/LoadRESTAURANT.log bad=scripts/06_data/LoadRESTAURANT.bad discard=scripts/06_data/LoadRESTAURANT.dsc
HOST sqlldr userid=dev_1/Food123 control=scripts/06_data/sqlldr/LoadMENU_ITEM.ctl data=scripts/06_data/sqlldr/menu_item.csv log=scripts/06_data/LoadMENU_ITEM.log bad=scripts/06_data/LoadMENU_ITEM.bad discard=scripts/06_data/LoadMENU_ITEM.dsc
HOST sqlldr userid=dev_1/Food123 control=scripts/06_data/sqlldr/LoadORDERS.ctl data=scripts/06_data/sqlldr/orders.csv log=scripts/06_data/LoadORDERS.log bad=scripts/06_data/LoadORDERS.bad discard=scripts/06_data/LoadORDERS.dsc
HOST sqlldr userid=dev_1/Food123 control=scripts/06_data/sqlldr/LoadORDER_ITEM.ctl data=scripts/06_data/sqlldr/order_item.csv log=scripts/06_data/LoadORDER_ITEM.log bad=scripts/06_data/LoadORDER_ITEM.bad discard=scripts/06_data/LoadORDER_ITEM.dsc
HOST sqlldr userid=dev_1/Food123 control=scripts/06_data/sqlldr/LoadDRIVER.ctl data=scripts/06_data/sqlldr/driver.csv log=scripts/06_data/LoadDRIVER.log bad=scripts/06_data/LoadDRIVER.bad discard=scripts/06_data/LoadDRIVER.dsc
HOST sqlldr userid=dev_1/Food123 control=scripts/06_data/sqlldr/LoadDELIVERY.ctl data=scripts/06_data/sqlldr/delivery.csv log=scripts/06_data/LoadDELIVERY.log bad=scripts/06_data/LoadDELIVERY.bad discard=scripts/06_data/LoadDELIVERY.dsc
HOST sqlldr userid=dev_1/Food123 control=scripts/06_data/sqlldr/LoadPAYMENT.ctl data=scripts/06_data/sqlldr/payment.csv log=scripts/06_data/LoadPAYMENT.log bad=scripts/06_data/LoadPAYMENT.bad discard=scripts/06_data/LoadPAYMENT.dsc
HOST sqlldr userid=dev_1/Food123 control=scripts/06_data/sqlldr/LoadREVIEW.ctl data=scripts/06_data/sqlldr/review.csv log=scripts/06_data/LoadREVIEW.log bad=scripts/06_data/LoadREVIEW.bad discard=scripts/06_data/LoadREVIEW.dsc
HOST sqlldr userid=dev_1/Food123 control=scripts/06_data/sqlldr/LoadORDER_STATUS_LOG.ctl data=scripts/06_data/sqlldr/order_status_log.csv log=scripts/06_data/LoadORDER_STATUS_LOG.log bad=scripts/06_data/LoadORDER_STATUS_LOG.bad discard=scripts/06_data/LoadORDER_STATUS_LOG.dsc

PROMPT Done loading seed data.
