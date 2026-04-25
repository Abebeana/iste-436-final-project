-- Context:
-- Food Delivery System (ISTE-436 Final)
-- Oracle SQL/PLSQL implementation with concurrency-safe transactions.
--
-- Run in SQL*Plus / SQLcl from repo root:
--   @install.sql

SET DEFINE OFF
-- Disables substitution variables (e.g., &name).
-- Prevents SQL*Plus from prompting for input if '&' appears in scripts/data.

SET SERVEROUTPUT ON
-- Enables output from DBMS_OUTPUT.PUT_LINE.
-- Required to see debug/log messages from PL/SQL blocks.

WHENEVER SQLERROR EXIT SQL.SQLCODE
-- If any SQL or PL/SQL error occurs:
--   1. Stop execution immediately
--   2. Exit SQL*Plus
--   3. Return the Oracle error code (useful for automation/scripts)

PROMPT == Installing from scripts/ ==
-- Prints this message to the console.
-- Purely informational, no effect on execution.

@scripts/install.sql
-- Executes another script located at "scripts/install.sql".
-- This is the main installer