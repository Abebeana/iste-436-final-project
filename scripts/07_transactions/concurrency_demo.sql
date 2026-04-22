-- Context:
-- ISTE-436 concurrent transactions demo (two-session)
--
-- This file is an index/guide that points to the runnable two-session scripts.
-- Open TWO SQL*Plus/SQLcl sessions and run the paired files below.

PROMPT
PROMPT ============================
PROMPT Concurrency Demo (2 sessions)
PROMPT ============================
PROMPT
PROMPT Demo A: Inventory (lost update prevention)
PROMPT   Session A: @scripts/07_transactions/inventory_session_a.sql
PROMPT   Session B: @scripts/07_transactions/inventory_session_b.sql
PROMPT
PROMPT Demo B: Driver assignment serialization (ADMIN_ROLE required)
PROMPT   Session A: @scripts/07_transactions/assign_driver_session_a.sql
PROMPT   Session B: @scripts/07_transactions/assign_driver_session_b.sql
PROMPT
PROMPT Demo C: Analytics snapshot consistency
PROMPT   Session A: @scripts/07_transactions/analytics_session_a.sql
PROMPT   Session B: @scripts/07_transactions/analytics_session_b.sql
PROMPT
PROMPT Optional: Isolation test wrapper
PROMPT   Session A: @scripts/07_transactions/isolation_tests.sql
PROMPT   Session B: place a new order and COMMIT (e.g., run inventory demo on item_id=2)
PROMPT
