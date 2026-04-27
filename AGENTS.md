# AGENTS.md

Instructions for AI coding agents working in this Oracle SQL/PLSQL repository.

## Scope and priorities

- Keep changes small and script-order safe.
- Prefer updating existing SQL scripts in `scripts/` over adding ad-hoc files.
- Preserve installability from the repo entry point: [install.sql](install.sql).
- Do not modify secrets or credential placeholders (for example, [secret.txt](secret.txt)) unless the user explicitly asks.

## Canonical project docs

- Project overview and architecture: [README.md](README.md)
- Script purpose and directory guide: [scripts/README.md](scripts/README.md)
- SQL*Loader usage details: [scripts/06_data/sqlldr/README.md](scripts/06_data/sqlldr/README.md)

Link to these docs instead of duplicating long instructions.

## Primary execution flow

Use SQL*Plus or SQLcl from repository root:

```sql
@install.sql
```

This delegates to [scripts/install.sql](scripts/install.sql) for the schema-owner install path.

For the full project requirements (admin + developer + end users) and specifically:

> “Use the developer role to create tablespaces and tables”

use this practical multi-user order:

1. As `SYS`: create the admin user
  - [scripts/03_security/create_admin.sql](scripts/03_security/create_admin.sql)
2. As `admin_1` (DBA): create roles/users and grant system privileges to roles
  - [scripts/03_security/create_roles.sql](scripts/03_security/create_roles.sql)
  - [scripts/03_security/create_users.sql](scripts/03_security/create_users.sql)
  - [scripts/03_security/grant_system_privileges.sql](scripts/03_security/grant_system_privileges.sql)
    - Note: `developer_role` includes `CREATE TABLESPACE` and `UNLIMITED TABLESPACE`
3. As `dev_1` (developer role enabled): create tablespaces, then create tables/constraints/indexes
  - [scripts/01_db_setup/create_tablespaces.sql](scripts/01_db_setup/create_tablespaces.sql)
  - [scripts/02_schema/install.sql](scripts/02_schema/install.sql)
4. As `dev_1`: install business logic, then grant object/execute privileges and user-role grants
  - [scripts/04_business_logic/install.sql](scripts/04_business_logic/install.sql)
  - [scripts/03_security/grant_privileges.sql](scripts/03_security/grant_privileges.sql)
5. As `dev_1`: load seed data and create views
  - [scripts/06_data/install.sql](scripts/06_data/install.sql)
  - [scripts/05_views/install.sql](scripts/05_views/install.sql)
  - Optional (after roles exist): [scripts/05_views/grants_on_views.sql](scripts/05_views/grants_on_views.sql)

## Editing conventions for this repo

- Keep DDL grouped by responsibility:
  - tables in [scripts/02_schema/create_tables.sql](scripts/02_schema/create_tables.sql)
  - constraints in [scripts/02_schema/add_constraints.sql](scripts/02_schema/add_constraints.sql)
  - indexes in [scripts/02_schema/create_indexes.sql](scripts/02_schema/create_indexes.sql)
- Keep PL/SQL logic in `scripts/04_business_logic/` and avoid mixing business logic into schema scripts.
- Keep security/RBAC changes in `scripts/03_security/` and note privilege requirements in comments.
- For views, update [scripts/05_views/row_level_views.sql](scripts/05_views/row_level_views.sql), [scripts/05_views/column_level_views.sql](scripts/05_views/column_level_views.sql), and grants separately.

## Validation workflow after SQL changes

1. Re-run installer path from [install.sql](install.sql) when feasible.
2. Run relevant two-session concurrency demos from `scripts/07_transactions/` for transaction-related edits.
3. If data loading changed, verify [scripts/06_data/load_data.sql](scripts/06_data/load_data.sql) and, when applicable, SQL*Loader control files in `scripts/06_data/sqlldr/`.
4. For reporting/analytics edits, verify scripts in `scripts/08_analysis/`.

## Known pitfalls

- Some scripts are optional or privilege-gated (notably `03_security` and tablespace setup in `01_db_setup`).
- If SQL*Plus is run from a Windows client against a Linux/AWS Oracle server, `@script.sql` reads from the client machine’s filesystem (the `.sql` must exist locally).
- Re-running SQL*Loader without clearing data can cause PK/unique violations.
- Admin startup/shutdown helpers in `scripts/09_admin_scripts/` include shell scripts intended for Unix-like environments.

## When unclear

- Ask the user whether they want schema-owner-safe changes only, or also admin-level changes.
- Prefer explicit assumptions in SQL comments when behavior affects concurrency or isolation.
