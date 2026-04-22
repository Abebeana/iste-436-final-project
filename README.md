# Smart Food Delivery System (Oracle DB)

Oracle database project for a smart food delivery system with concurrent users (customers, drivers/dispatchers, admin).

This repository is organized to support:
- clean install via ordered scripts
- PL/SQL transaction procedures
- concurrency-safe behavior under multi-session execution

## Architecture (logical)

Customer → Orders → Order_Item → Menu_Item → Restaurant

Orders → Delivery → Driver

Orders → Payment

Orders → Review

Orders → Order_Status_Log

## Repo structure

- `scripts/` — all course scripts organized by step (setup, schema, security, logic, views, data, transactions, analysis)
- `tools/` — PDF text extraction helper (for aligning implementation to the provided PDFs)

## Install

From SQL*Plus / SQLcl (connected to your schema/user), run:

```sql
@install.sql
```

Optional bulk-load demo (external table + CSV; requires DIRECTORY privileges):

```sql
@scripts/06_data/bulk_load_external_table.sql
```

## Concurrency demos (two sessions)

Open **two** SQL*Plus/SQLcl sessions connected to the same schema.

- Inventory (lost update prevention):
  - Session A: `@scripts/07_transactions/inventory_session_a.sql`
  - Session B: `@scripts/07_transactions/inventory_session_b.sql`

- Driver assignment serialization:
  - Session A: `@scripts/07_transactions/assign_driver_session_a.sql`
  - Session B: `@scripts/07_transactions/assign_driver_session_b.sql`

- Analytics consistency (single snapshot for multiple queries):
  - Session A: `@scripts/07_transactions/analytics_session_a.sql`
  - Session B: `@scripts/07_transactions/analytics_session_b.sql`

## Notes

- Oracle provides read consistency via UNDO; this project additionally uses explicit row-level locking (`SELECT ... FOR UPDATE`) and atomic `UPDATE ... WHERE ...` patterns to prevent lost updates and enforce serialized outcomes where needed.
- The course project description notes you may not be allowed to use AI to write your report; keep this repo for implementation/testing and write your submission in your own words per your instructor’s policy.
- The extracted PDF text under `tools/extracted/` may contain unrelated external links; they are not used by the implementation.
