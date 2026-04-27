-- 08_analysis runner (reporting/analysis queries)
-- Run from repo root:
--   @scripts/08_analysis/install.sql

SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE

PROMPT == 08_analysis ==
@@reporting_queries.sql
@@window_functions.sql
@@performance_analysis.sql

PROMPT == Done 08_analysis ==
