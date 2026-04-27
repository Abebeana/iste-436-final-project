-- 07_transactions index (two-session demos)
-- Run from repo root:
--   @scripts/07_transactions/install.sql

SET DEFINE OFF
SET SERVEROUTPUT ON

PROMPT == 07_transactions ==
PROMPT Open two SQL*Plus/SQLcl sessions and run the paired scripts.
PROMPT Index:
PROMPT   @scripts/07_transactions/concurrency_demo.sql
PROMPT   @scripts/07_transactions/isolation_tests.sql

PROMPT == Done 07_transactions (instructions) ==
