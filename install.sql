-- Context:
-- Food Delivery System (ISTE-436 Final)
-- Oracle SQL/PLSQL implementation with concurrency-safe transactions.
--
-- Run in SQL*Plus / SQLcl from repo root:
--   @install.sql
--
-- Note:
-- DDL and data types are aligned to the provided ISTE-436-FINAL.pdf entity list.

SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT == Installing from scripts/ ==
@scripts/install.sql
