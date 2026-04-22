# Scripts

Run scripts in numeric order.

## 01_db_setup
- `dbca_scripts/` — DBCA generated artifacts (not committed here)
- `init_params.sql` — placeholder for parameter notes
- `create_tablespaces.sql` — conceptual tablespace design (uncomment only with DBA privileges)

## 02_schema
- `create_tables.sql`
- `add_constraints.sql`
- `create_indexes.sql`

## 03_security
Layered RBAC (Privileges → Application Roles → User Roles → Users).
- `create_roles.sql`
- `grant_privileges.sql` (run as schema owner)
- `create_users.sql` (requires `CREATE USER`, run as admin)

## 04_business_logic
- `procedures.sql` (packages)
- `functions.sql`
- `triggers.sql`

## 05_views
- `row_level_views.sql`
- `column_level_views.sql`
- `grants_on_views.sql` (run after roles exist)

## 06_data
- `load_data.sql` (seed/demo data)
- `sample_data.csv` (CSV used by bulk load demo)
- `bulk_load_external_table.sql` (external-table bulk load demo; requires DIRECTORY privileges)

## 07_transactions
Two-session demos for concurrency/isolation.
- `concurrency_demo.sql` (index)
- `isolation_tests.sql`

## 08_analysis
Rubric query demonstrations.

## 09_admin_scripts
Admin-only helpers.

## 10_backup
Not implemented yet.
